# Design Decision: Cross-Domain Interaction Patterns

## Decision ID: 009

**Date**: 2023-04-06  
**Status**: Approved  
**Deciders**: Core Architecture Team  

## Context

Our domain-driven design approach separates functionality into clear domain boundaries (common domains and vertical-specific domains). While this separation provides many benefits, it creates the challenge of defining how domains will interact with each other. We need to establish consistent patterns for:

- Cross-domain communication
- Shared data access
- Process flows that span multiple domains
- Maintaining domain integrity while enabling integration
- Ensuring loose coupling between domains

## Decision

We will implement the following cross-domain interaction patterns:

### 1. Event-Based Integration

The primary pattern for cross-domain communication will be event-based integration:

- **Domain Events**: Each domain publishes events that represent significant state changes
- **Event Subscriptions**: Other domains can subscribe to these events to react accordingly
- **Event Store**: NATS JetStream serves as the central event store for all domains
- **Event Schemas**: Standardized event schemas ensure consistent interpretation

This approach maintains domain boundaries while enabling communication through a well-defined contract (the event).

### 2. Shared Reference Data

For data that must be consistent across domains:

- **Canonical Data Sources**: Common domains (e.g., People, Organizations) serve as the source of truth for shared entities
- **Reference IDs**: Domains reference entities from other domains by ID rather than duplicating data
- **Read Models**: Domains can maintain read-optimized projections of data from other domains
- **Eventual Consistency**: Updates propagate through events and are eventually consistent

### 3. Domain Service Interfaces

For direct inter-domain operations:

- **NATS Service Interfaces**: Domains expose explicit service interfaces via NATS subjects
- **Command/Query Pattern**: Interfaces support explicit commands and queries
- **Service Contracts**: Well-defined contracts specify the available operations
- **Authorization Context**: Service calls include the context needed for authorization
- **Rate Limiting**: Services implement appropriate throttling to protect resources

### 4. Saga Pattern for Cross-Domain Processes

For processes that span multiple domains:

- **Process Coordinators**: Specialized components orchestrate multi-domain processes
- **Compensating Actions**: Each step includes a defined compensation action for rollback
- **State Tracking**: Process state is tracked in the event store
- **Idempotent Operations**: All operations are designed to be safely retriable

### 5. Domain Relationship Registry

To make cross-domain relationships explicit:

- **Graph-Based Registry**: Neo4j stores relationships between entities across domains
- **Relationship Types**: Standardized relationship types with clear semantics
- **Bidirectional References**: Relationships can be traversed in either direction
- **Access Control**: Domains control access to their entities and relationships

## Implementation Approach

These patterns will be implemented using our established architecture:

1. **NATS JetStream**: Serves as the event store and message bus for all domain communication
2. **Neo4j**: Stores domain objects and their cross-domain relationships
3. **Domain-Specific NATS Subjects**: Following convention `domain.entity.event/command/query`
4. **Standardized Event Structure**:
   ```json
   {
     "id": "unique-event-id",
     "type": "DomainEntityEvent",
     "source": "domain-name",
     "time": "ISO timestamp",
     "data": {},
     "metadata": {}
   }
   ```
5. **Process Coordination via Workflow Service**: n8n workflow service orchestrates cross-domain processes

## Architecture Implications

- All domains must follow the event sourcing pattern
- Domains must publish events for any state changes relevant to other domains
- Direct database access across domain boundaries is prohibited
- Domains must implement proper access controls for their service interfaces
- Process flows spanning multiple domains require explicit coordination

## Consequences

### Positive

- **Domain Integrity**: Each domain maintains control over its data and logic
- **Loose Coupling**: Domains interact through well-defined contracts
- **Evolutionary Design**: Domains can evolve independently as long as they maintain their contracts
- **Audit Trail**: Event-based communication provides a complete history of interactions
- **Resilience**: Asynchronous communication improves system resilience
- **Extensibility**: New domains can integrate with existing ones through established patterns
- **Scalability**: Domains can be scaled independently based on their specific needs

### Negative

- **Eventual Consistency**: Cross-domain data may not be immediately consistent
- **Complexity**: Asynchronous event-based integration is more complex than direct calls
- **Learning Curve**: Teams need to understand event sourcing and message-based systems
- **Debugging Challenges**: Tracing issues across domain boundaries requires specialized tools
- **Performance Overhead**: Message-based communication adds some latency compared to direct calls
- **Transaction Boundaries**: ACID transactions cannot span domain boundaries

## Related Decisions

- [002: NATS JetStream Dual Role](002-nats-jetstream-dual-role.md)
- [005: Domain-Driven Design for Vertical Markets](005-domain-driven-vertical-markets.md)
- [006: Domain Objects as Graph Storage](006-domain-objects-graph-storage.md)
- [007: Service Interfaces and MCP Integration](007-service-interfaces-and-mcp-integration.md)
- [008: Base CIM Services](008-base-cim-services.md)

## Examples

### Example 1: Patient Registration in Healthcare Vertical

1. User registers a new patient through the UI
2. Healthcare domain creates a Patient record and publishes `healthcare.patient.created` event
3. People domain receives the event and creates/updates the Person record
4. People domain publishes `people.person.updated` event
5. Other interested domains (e.g., Appointments, Billing) react to these events
6. The domain relationship registry records the link between Patient and Person entities

### Example 2: Document Upload Workflow

1. User uploads a document to the Documents domain
2. Documents domain processes the document and publishes `documents.document.uploaded` event
3. Classification service categorizes the document and publishes `classification.document.categorized`
4. Relevant vertical domains (e.g., Healthcare for medical records) consume these events
5. Workflow service orchestrates the process and tracks progress
6. Each domain maintains read models of the document metadata relevant to its function

## Notes

These cross-domain interaction patterns are essential for maintaining the benefits of our domain-driven design approach while enabling the overall system to function cohesively. By relying primarily on event-based integration, we maintain loose coupling while providing the necessary communication channels.

The patterns defined here align with our NATS JetStream architecture and support our goals of flexibility, extensibility, and vertical market specialization. They provide a foundation for implementing complex business processes that span multiple domains without sacrificing domain integrity. 