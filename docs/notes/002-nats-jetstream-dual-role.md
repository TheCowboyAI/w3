# Design Decision: NATS JetStream Dual Role as Event Store and Object Store

## Decision ID: 002

**Date**: 2023-04-04  
**Status**: Approved  
**Deciders**: Core Architecture Team  

## Context

The CIM system requires a reliable mechanism for:
- Event-driven communication between components
- Persistent event sourcing for state management and recovery
- Object storage for binary data and shared resources
- Cross-component data sharing with controlled access
- Efficient message delivery with ordering guarantees

We need a storage solution that supports both event-based communication and object persistence while maintaining high performance and reliability.

## Decision

We will use NATS JetStream to serve dual critical roles:

1. **Event Store**:
   - Persistent event sourcing
   - Event streaming for component communication
   - Event replay for system recovery
   - Distributed event log
   - Ordered message delivery
   - Consumer groups for event processing

2. **Object Store**:
   - Persistent data storage
   - Binary object storage
   - Cross-component data sharing
   - Distributed access to shared resources
   - Versioned object storage
   - Metadata management

This approach enables both local and distributed components to share a common event and data infrastructure, enhancing resilience and scalability.

## Architecture Implications

- All components will communicate primarily through events stored in JetStream
- State can be reconstructed via event replay when needed
- Binary objects will be stored and retrieved via JetStream's object store
- Components will access shared data through a controlled object store interface
- The event log provides an audit trail of all system activities
- System recovery leverages event sourcing patterns

## Consequences

### Positive

- **Unified Infrastructure**: Single system for both event and object storage
- **Simplified Architecture**: Consistent patterns for communication and storage
- **Enhanced Reliability**: Event sourcing enables robust state recovery
- **Improved Auditability**: Complete event history for tracking and debugging
- **Efficient Integration**: Streamlined interface for component communication
- **Scalability**: JetStream scales well for both events and objects

### Negative

- **Learning Curve**: Team needs to understand JetStream's dual capabilities
- **Performance Tuning**: May require optimization for different workloads
- **Resource Management**: Careful resource allocation needed for dual roles
- **Schema Evolution**: Changes to event schemas must be managed carefully
- **Storage Size Limitations**: Large binary objects require special handling

## Related Decisions

- Multi-tier scaling architecture (Leaf Node → 3-Node Cluster → Wasabi)
- NixOS chosen as the implementation platform
- Component isolation through nixos-containers

## Notes

NATS JetStream provides a compelling combination of features that address our needs for both event-driven communication and persistent storage. The decision to use JetStream for both roles simplifies our architecture while providing robust capabilities.

In our multi-tier architecture, JetStream operates at the Leaf Node level for immediate performance, while data is replicated to the cluster and eventually archived to Wasabi for long-term storage. 