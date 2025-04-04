# Design Decision: Base CIM Services

## Decision ID: 008

**Date**: 2023-04-05  
**Status**: Approved  
**Deciders**: Core Architecture Team  

## Context

A CIM (Composable Information Machine) is fundamentally a collection of integrated tools designed to communicate with each other via NATS. To establish a cohesive system, we need to:

- Define the core services that constitute a base CIM installation
- Ensure each service aligns with our NATS and MCP integration approach
- Maintain clarity about the purpose and scope of each service
- Understand how these services interoperate through our messaging infrastructure

## Decision

We will establish the following services as part of the base CIM installation:

1. **AI**: AI Chat Interface for system-wide interaction
   - Access to various MCP Servers
   - Multiple tuned models for different purposes
   - Unified interface to the entire system

2. **NATS**: Messaging backbone for inter-service communication
   - All cross-process communications NATS-enabled
   - Subject-based routing for service operations
   - Event store and object store (JetStream)

3. **Git**: Version control and issue tracking
   - Stores all configurations and source code
   - Manages issue tracking
   - Provides change history and collaboration

4. **Mail**: Email system
   - Handles email communication
   - Integrates with workflows and notifications
   - Provides email-based interactions

5. **Search**: Centralized search capabilities
   - Implemented via SearXNG
   - API-based access for all services
   - Unified search across multiple sources

6. **Docs**: Document management system
   - Such as PaperlessNG
   - Manages document storage, tagging, and retrieval
   - Integrates with workflows and AI

7. **Web**: Web portal for system access
   - Provides user interface to the system
   - Integrates the various services
   - Offers consistent user experience

8. **WF**: Workflow automation
   - Interface to n8n
   - Orchestrates processes across services
   - Enables automation and integration

9. **Vault**: Secret management
   - Implemented via Vaultwarden
   - Stores and manages secrets
   - Ensures secure access to credentials

10. **Notes**: Knowledge management
    - Such as Obsidian or Trilium Next
    - Stores and organizes notes and knowledge
    - Supports knowledge graphs and linking

11. **Feeds**: RSS feed integration
    - Manages incoming RSS feeds
    - Processes and routes feed content
    - Integrates with other services for content handling

12. **DB**: Database services
    - Neo4j for graph database (domain objects)
    - PostgreSQL for relational data
    - Provides structured data storage and query capabilities

## Architecture Implications

- Each service will be implemented as a containerized component
- All services will communicate via NATS using our subject-based messaging patterns
- Services will provide MCP interfaces for AI interaction
- The collective services form a complete information management ecosystem
- Each service can be deployed independently but operates as part of the cohesive whole
- The services are composed to create a comprehensive system tailored to specific vertical markets

## Integration Approach

- Each service will follow our dual-interface approach:
  - NATS subject-based messaging for inter-service communication
  - MCP interfaces for AI interaction

- For third-party tools (like PaperlessNG, n8n, Vaultwarden):
  - We'll leverage official MCP interfaces where available
  - We'll develop custom MCP servers where necessary
  - We'll wrap NATS interfaces around their APIs

- All services will be deployed as NixOS containers as defined in our implementation architecture
- Domain objects will be stored in Neo4j following our graph storage approach
- Configuration and customization will be stored in Git

## Consequences

### Positive

- **Comprehensive System**: The combined services create a complete information management solution
- **Consistent Integration**: All services follow the same integration patterns
- **Flexible Composition**: Services can be composed in different ways for different needs
- **Specialist Capabilities**: Each service provides specialized functionality in its domain
- **Unified Access**: AI provides a unified interface to all services
- **Version Controlled**: All configurations and customizations tracked in Git
- **Automation Ready**: Workflow capabilities enable process automation across services

### Negative

- **System Complexity**: Managing multiple integrated services increases complexity
- **Resource Requirements**: Full deployment requires significant resources
- **Learning Curve**: Users and administrators need to understand multiple tools
- **Integration Maintenance**: Each service integration requires ongoing maintenance
- **Consistency Challenges**: Ensuring consistent UX across different tools
- **Version Compatibility**: Managing compatible versions across services

## Related Decisions

- [002: NATS JetStream Dual Role](002-nats-jetstream-dual-role.md)
- [003: NixOS Hyper-Converged Implementation](003-nixos-hyperconverged-implementation.md)
- [006: Domain Objects as Graph Storage](006-domain-objects-graph-storage.md)
- [007: Service Interfaces and MCP Integration](007-service-interfaces-and-mcp-integration.md)

## Notes

The base CIM services collectively form a powerful information management system that addresses the needs identified in our project brief and product context. The combination of specialized tools, unified through our NATS messaging infrastructure and MCP interfaces, enables the flexible and composable system we're aiming to create.

Each service contributes specific capabilities to the overall system, while our integration approach ensures they work together seamlessly. The NATS-based communication allows services to evolve independently while maintaining interoperability, and the MCP interfaces enable AI-driven interactions across the entire system.

As we implement these services, we'll develop specific NATS subject patterns and MCP interface definitions for each, ensuring consistency and discoverability across the system. We'll also create deployment configurations that allow users to start with a minimal set of services and expand as needed, aligned with our progressive scaling approach. 