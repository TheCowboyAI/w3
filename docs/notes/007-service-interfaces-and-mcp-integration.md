# Design Decision: Service Interfaces and MCP Integration

## Decision ID: 007

**Date**: 2023-04-05  
**Status**: Approved  
**Deciders**: Core Architecture Team  

## Context

The CIM system requires a consistent approach for exposing backend services and integrating with various tools. We need to:

- Provide uniform access to diverse backend resources
- Enable AI-driven interactions with system services
- Integrate with third-party tools efficiently
- Support both standard and specialized service needs
- Maintain alignment with our overall architecture

As we develop the system, we'll be creating many backend resources that need to be accessible in a consistent manner while also allowing for specialized functionality.

## Decision

We will implement a dual-interface approach for backend services:

1. **Primary Interface: NATS Subject-Based Messaging**
   - All backend services will be accessible via NATS
   - Services will use standardized subject patterns
   - Message payloads will follow consistent formats
   - This enables uniform access across the system
   - Aligns with our event-driven architecture

2. **AI Integration: MCP (Mission Control Protocol) Servers**
   - Services will provide AI interfaces through MCP
   - This enables AI components to interact with services
   - Provides structured ways for AI to request operations

3. **Integration Strategy for Third-Party Tools**
   - For tools with official MCP interfaces (e.g., paperlessng):
     - Utilize the vendor-provided MCP interface
     - Only extend if absolutely necessary
   - For tools without MCP interfaces or with special needs:
     - Develop custom MCP servers as adaptors
     - Implement specialized processes as needed

## Architecture Implications

- Backend services will have dual interfaces (NATS and MCP)
- Services will publish on NATS subjects following consistent patterns
- AI components will interact with services via MCP interfaces
- Third-party tools will be integrated via vendor-supplied MCP where available
- Custom MCP servers will bridge the gap for specialized tools and processes
- Overall architecture remains consistent with NATS as the messaging backbone

## Consequences

### Positive

- **Consistency**: Uniform access pattern to all backend services
- **Flexibility**: Ability to support both standard and specialized needs
- **AI Integration**: Structured interaction between AI and services
- **Vendor Alignment**: Leveraging official interfaces where available
- **Specialization**: Custom solutions for unique requirements
- **Architectural Coherence**: Maintains alignment with event-driven approach
- **Loose Coupling**: Services can evolve independently while maintaining stable interfaces

### Negative

- **Interface Maintenance**: Dual interfaces (NATS and MCP) require maintenance
- **Integration Complexity**: Custom MCP servers add development overhead
- **Standard Enforcement**: Need to ensure consistency across many services
- **Documentation Requirements**: Both interfaces need thorough documentation
- **Learning Curve**: Team members need to understand both NATS and MCP patterns

## Related Decisions

- [002: NATS JetStream Dual Role](002-nats-jetstream-dual-role.md)
- [003: NixOS Hyper-Converged Implementation](003-nixos-hyperconverged-implementation.md)
- [006: Domain Objects as Graph Storage](006-domain-objects-graph-storage.md)

## Notes

This approach builds on our existing NATS-based architecture while adding structured AI integration through MCP. It provides a consistent way to expose backend services while also allowing for specialized functionality.

For NATS subjects, we'll establish a standard naming convention (e.g., `service.resource.action`) to ensure consistency across the system. For MCP interfaces, we'll document the available commands and their parameters.

The decision to use vendor-provided MCP interfaces where available (like for paperlessng) helps leverage expertise from the tool creators, while custom MCP servers give us the flexibility to handle specialized requirements for tools without official MCP support.

As our system evolves, we'll maintain a registry of services, their NATS subjects, and MCP interfaces to ensure discovery and consistent usage. 