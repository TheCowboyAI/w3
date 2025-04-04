# Design Decision: Component Interface Definitions

## Decision ID: 015

**Date**: 2023-04-07  
**Status**: Approved  
**Deciders**: Core Architecture Team  

## Context

With the core components of the CIM system defined and specified in detail, we now need to establish clear interface definitions that govern how these components communicate with each other. Well-defined interfaces are essential for:

- Ensuring loose coupling between components
- Enabling independent development and testing
- Facilitating component replacement and evolution
- Maintaining system stability during changes
- Supporting our distributed, event-driven architecture

Our interface definitions must align with our established architectural patterns, including NATS-based messaging, event sourcing, and domain-driven design.

## Decision

We will implement a standardized interface approach for all core components with the following characteristics:

### 1. Interface Types

Each component will expose three types of interfaces:

- **Event Interfaces**: Asynchronous, broadcast-style communication
- **Service Interfaces**: Request-response style direct operations
- **Command Interfaces**: Directive-based operations for component control

### 2. NATS Subject Naming Conventions

All component interfaces will follow a consistent NATS subject naming pattern:

- **Events**: `cim.event.[component].[resource].[action]`
- **Services**: `cim.service.[component].[resource].[operation]`
- **Commands**: `cim.cmd.[component].[operation]`

### 3. Message Schema Standards

All messages will follow a standardized envelope structure:

```json
{
  "metadata": {
    "id": "uuid",
    "timestamp": "ISO-8601 timestamp",
    "correlation_id": "uuid for tracing related messages",
    "source_component": "originating component identifier",
    "schema_version": "semantic version"
  },
  "payload": {
    // Component-specific payload schema
  }
}
```

### 4. Component-Specific Interface Definitions

#### Information Unit System Interfaces

- **Events**:
  - `cim.event.iu.unit.created`
  - `cim.event.iu.unit.updated`
  - `cim.event.iu.unit.linked`
  - `cim.event.iu.type.registered`

- **Services**:
  - `cim.service.iu.unit.create`
  - `cim.service.iu.unit.get`
  - `cim.service.iu.unit.update`
  - `cim.service.iu.unit.link`
  - `cim.service.iu.type.register`
  - `cim.service.iu.type.validate`

- **Commands**:
  - `cim.cmd.iu.reload_types`
  - `cim.cmd.iu.flush_cache`

#### Component Registry Interfaces

- **Events**:
  - `cim.event.registry.component.registered`
  - `cim.event.registry.component.unregistered`
  - `cim.event.registry.capability.added`
  - `cim.event.registry.capability.removed`

- **Services**:
  - `cim.service.registry.component.register`
  - `cim.service.registry.component.unregister`
  - `cim.service.registry.component.get`
  - `cim.service.registry.component.list`
  - `cim.service.registry.capability.query`

- **Commands**:
  - `cim.cmd.registry.refresh`
  - `cim.cmd.registry.purge_inactive`

#### Pipeline Engine Interfaces

- **Events**:
  - `cim.event.pipeline.execution.started`
  - `cim.event.pipeline.execution.completed`
  - `cim.event.pipeline.execution.failed`
  - `cim.event.pipeline.stage.completed`

- **Services**:
  - `cim.service.pipeline.definition.create`
  - `cim.service.pipeline.definition.update`
  - `cim.service.pipeline.definition.get`
  - `cim.service.pipeline.definition.list`
  - `cim.service.pipeline.execution.start`
  - `cim.service.pipeline.execution.stop`
  - `cim.service.pipeline.execution.status`

- **Commands**:
  - `cim.cmd.pipeline.reload_definitions`
  - `cim.cmd.pipeline.abort_all`

#### Storage Manager Interfaces

- **Events**:
  - `cim.event.storage.object.stored`
  - `cim.event.storage.object.retrieved`
  - `cim.event.storage.object.deleted`
  - `cim.event.storage.tier.migrated`

- **Services**:
  - `cim.service.storage.object.store`
  - `cim.service.storage.object.retrieve`
  - `cim.service.storage.object.delete`
  - `cim.service.storage.object.exists`
  - `cim.service.storage.object.list`
  - `cim.service.storage.collection.create`
  - `cim.service.storage.collection.list`

- **Commands**:
  - `cim.cmd.storage.trigger_gc`
  - `cim.cmd.storage.migrate_tier`
  - `cim.cmd.storage.verify_integrity`

#### User Interface Framework Interfaces

- **Events**:
  - `cim.event.ui.session.started`
  - `cim.event.ui.session.ended`
  - `cim.event.ui.notification.created`

- **Services**:
  - `cim.service.ui.view.render`
  - `cim.service.ui.notification.send`
  - `cim.service.ui.state.update`
  - `cim.service.ui.action.execute`
  - `cim.service.ui.session.authenticate`

- **Commands**:
  - `cim.cmd.ui.invalidate_caches`
  - `cim.cmd.ui.refresh_clients`
  - `cim.cmd.ui.broadcast_message`

#### Integration Hub Interfaces

- **Events**:
  - `cim.event.integration.connector.status_changed`
  - `cim.event.integration.data.received`
  - `cim.event.integration.data.sent`
  - `cim.event.integration.sync.completed`

- **Services**:
  - `cim.service.integration.connector.register`
  - `cim.service.integration.connector.config`
  - `cim.service.integration.connector.status`
  - `cim.service.integration.data.transform`
  - `cim.service.integration.data.validate`
  - `cim.service.integration.data.send`
  - `cim.service.integration.sync.start`

- **Commands**:
  - `cim.cmd.integration.reload_connectors`
  - `cim.cmd.integration.reset_connector`
  - `cim.cmd.integration.pause_all`
  - `cim.cmd.integration.resume_all`

### 5. Cross-Component Interface Patterns

Components will interact following these patterns:

1. **Publisher-Subscriber**: Components publish events and subscribe to events from other components
2. **Request-Reply**: Components issue requests to services and await responses
3. **Command-Acknowledgment**: Components issue commands and receive acknowledgments

### 6. Interface Documentation Format

All interfaces will be documented using OpenAPI 3.0 for service interfaces and AsyncAPI 2.0 for event interfaces, with the following information:

- Subject name and pattern
- Message schema (request and response for services)
- Authentication and authorization requirements
- Error responses and codes
- Example messages
- Rate limiting and performance characteristics

## Architecture Implications

- Components must implement all defined interfaces to ensure system compatibility
- NATS serves as the communication backbone for all interfaces
- Message schemas provide a contract that components must adhere to
- Event sourcing relies on the event interfaces for state propagation
- Service interfaces enable direct component interaction when needed
- Command interfaces provide administrative control over components

## Consequences

### Positive

- **Clear Boundaries**: Well-defined interfaces establish clear component boundaries
- **Independent Development**: Teams can develop components independently against interface contracts
- **Testability**: Interfaces can be mocked for isolated component testing
- **Evolvability**: Components can evolve internally without affecting other components
- **Consistency**: Standardized patterns ensure consistent communication
- **Discoverability**: Naming conventions make interfaces easily discoverable
- **Documentation**: Structured interface documentation improves developer experience
- **Versioning**: Schema versioning supports gradual system evolution

### Negative

- **Interface Overhead**: Formal interfaces add some development overhead
- **Message Serialization**: Standard message formats require serialization/deserialization
- **Versioning Complexity**: Managing interface versions across components can be challenging
- **Contract Enforcement**: Ensuring components adhere to interface contracts requires diligence
- **Documentation Maintenance**: Interface documentation must be kept up-to-date

## Related Decisions

- [002: NATS JetStream Dual Role](002-nats-jetstream-dual-role.md)
- [009: Cross-Domain Interaction Patterns](009-cross-domain-interaction-patterns.md)
- [010: Domain Event Flow Patterns](010-domain-event-flow-patterns.md)
- [014: Component Specifications](014-component-specifications.md)

## Notes

These interface definitions provide a comprehensive communication framework for CIM components. The standardized approach to naming, message structures, and interaction patterns ensures that all components can interoperate effectively while maintaining loose coupling.

The distinction between event, service, and command interfaces supports different communication needs:
- Events for asynchronous state propagation
- Services for direct operations requiring responses
- Commands for administrative control

By establishing these interface definitions, we complete a critical aspect of the system design. Components can now be implemented with clear contracts governing their interactions, enabling independent development and testing while ensuring system cohesion.

Integration with our existing NATS infrastructure is seamless, as all interfaces leverage NATS subjects for message routing. The event interfaces align with our event sourcing approach, enabling reliable state propagation and historical tracking.

These interfaces will be implemented by the respective components as defined in our component specifications, creating a complete and cohesive system architecture. 