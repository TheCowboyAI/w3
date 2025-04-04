# Design Decision: Domain Event Flow Patterns

## Decision ID: 010

**Date**: 2023-04-06  
**Status**: Approved  
**Deciders**: Core Architecture Team  

## Context

Our domain-driven design approach with event-based integration requires a clear definition of how domain events flow through the system. We need to establish:

- Standardized event structure and metadata
- Consistent flow patterns for domain events
- Event storage and retrieval mechanisms
- Event processing and handling guidelines
- Event versioning and evolution approach

Effective event flow patterns are essential for maintaining the integrity of our event-driven architecture while enabling system-wide communication.

## Decision

We will implement the following domain event flow patterns:

### 1. Standardized Event Structure

All domain events will follow a consistent structure:

```json
{
  "id": "unique-event-id",                // UUID v4
  "type": "DomainName.EntityName.Event",   // Fully qualified event name
  "source": "domain-name",                // Source domain
  "time": "2023-04-06T12:34:56.789Z",     // ISO timestamp
  "correlationId": "workflow-id",         // Optional: for tracking related events
  "causationId": "causing-event-id",      // Optional: ID of event that caused this one
  "version": 1,                           // Schema version
  "data": {                               // Event payload
    "entityId": "entity-id",
    "propertyName": "value",
    // ...additional properties
  },
  "metadata": {                           // Additional contextual information
    "userId": "user-id",                  // Who triggered the event
    "clientIp": "127.0.0.1",              // Where it originated
    "tags": ["tag1", "tag2"]              // For categorization
    // ...additional metadata
  }
}
```

### 2. NATS Subject Hierarchy

Events will be published to NATS subjects following this convention:

```
events.{domain}.{entity}.{eventType}[.v{version}]
```

Examples:
- `events.people.person.created`
- `events.documents.document.uploaded.v2`
- `events.healthcare.patient.registered`

This hierarchical structure enables flexible subscription patterns.

### 3. Event Flow Patterns

Events will flow through the system according to these patterns:

#### **Command → Event → Projection Pattern**
1. Command arrives at domain service
2. Domain validates command and applies business logic
3. Domain publishes events to NATS JetStream
4. Projectors subscribe to events and update read models
5. Other domains react to events as needed

#### **Saga Coordination Pattern**
1. Coordinator initiates saga by publishing an initial event
2. Domains react to events by performing their part of the process
3. Each domain publishes subsequent events indicating success/failure
4. Coordinator tracks process state through events
5. Compensating actions triggered on failures

#### **Event Enrichment Pattern**
1. Domain publishes initial event
2. Enrichment services subscribe to events
3. Enrichment services add additional information
4. Enriched events published to derived subjects (`events.enriched.{domain}...`)
5. Consumers subscribe to enriched events when needed

#### **Event Archival Pattern**
1. Events published to NATS JetStream
2. Events retained based on retention policy
3. Events archived to Wasabi for long-term storage
4. Historical events retrievable through archive service

### 4. Event Storage in JetStream

We will configure NATS JetStream for optimized event storage:

- **Streams**: One stream per domain (`DOMAIN_EVENTS`)
- **Subjects**: Events published to subject hierarchy
- **Retention**: Time-based and size-based policies
- **Replication**: Events replicated to cluster
- **Compression**: Enabled for efficiency

### 5. Event Evolution Strategy

To manage event schema evolution:

- **Versioned Schemas**: Major changes introduce new event versions
- **Backward Compatibility**: New versions maintain backward compatibility where possible
- **Version Indicators**: Version included in event metadata and optionally in subject
- **Event Transformers**: Services to transform between versions when needed
- **Schema Registry**: Central registry of event schemas and versions

## Implementation Approach

These patterns will be implemented using our established architecture:

1. **Domain Services**: Publish events following standardized structure
2. **NATS JetStream**: Stores and streams events to subscribers
3. **Event Handlers**: Domain-specific components that react to events
4. **Read Model Projectors**: Build and maintain query-optimized views
5. **Schema Registry**: Central repository of event schemas
6. **Event Archive Service**: Manages long-term storage and retrieval

## Architecture Implications

- All domains must follow the standardized event structure
- Event handlers must be idempotent (able to process the same event multiple times safely)
- Services must handle event versioning and evolution
- Read models are eventually consistent with event streams
- Event schemas must be maintained in a central registry
- NATS JetStream configuration must be optimized for event volume and retention

## Consequences

### Positive

- **Consistency**: Standardized event structure across all domains
- **Flexibility**: Hierarchical subject structure enables targeted subscriptions
- **Traceability**: Correlation and causation IDs enable tracking related events
- **Evolvability**: Clear versioning strategy supports system evolution
- **Reliability**: Event storage in JetStream ensures durability
- **Scalability**: Event-driven architecture supports independent scaling
- **Auditability**: Complete event history provides robust audit trail
- **Recoverability**: System state can be rebuilt from event streams

### Negative

- **Complexity**: Event-driven systems have more moving parts
- **Learning Curve**: Teams need to understand event patterns
- **Eventual Consistency**: Read models are not immediately consistent
- **Schema Management**: Requires careful tracking of event schemas
- **Performance Tuning**: JetStream requires configuration for optimal performance
- **Storage Growth**: Event streams grow continuously and require management

## Related Decisions

- [002: NATS JetStream Dual Role](002-nats-jetstream-dual-role.md)
- [005: Domain-Driven Design for Vertical Markets](005-domain-driven-vertical-markets.md)
- [009: Cross-Domain Interaction Patterns](009-cross-domain-interaction-patterns.md)

## Examples

### Example 1: Person Creation Event

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "type": "People.Person.Created",
  "source": "people",
  "time": "2023-04-06T12:34:56.789Z",
  "correlationId": "workflow-123",
  "version": 1,
  "data": {
    "personId": "123456",
    "name": "Jane Doe",
    "contactInfo": {
      "email": "jane.doe@example.com"
    }
  },
  "metadata": {
    "userId": "admin-user",
    "clientIp": "192.168.1.1",
    "tags": ["new-user", "onboarding"]
  }
}
```

Published to: `events.people.person.created`

### Example 2: Document Processing Saga

1. Document Upload: `events.documents.document.uploaded`
2. Classification Started: `events.classification.document.started`
3. Classification Completed: `events.classification.document.completed`
4. Processing Started: `events.documents.document.processing.started`
5. Processing Completed: `events.documents.document.processing.completed`
6. Workflow Completed: `events.workflows.document-processing.completed`

Each event includes correlation ID to track the entire process.

## Notes

These domain event flow patterns provide a foundation for our event-driven architecture. They ensure consistency across domains while enabling the flexible and extensible system we're building. The patterns align with our NATS JetStream architecture and support our cross-domain interaction approach.

As the system evolves, we will maintain a catalog of standard events for each domain, ensuring that events are well-documented and consistently structured. This provides a clear contract between domains and supports our overall goals of maintainability and adaptability. 