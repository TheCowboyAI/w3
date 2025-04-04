# Design Decision: Primary User Interfaces

## Decision ID: 012

**Date**: 2023-04-06  
**Status**: Approved  
**Deciders**: Core Architecture Team  

## Context

The CIM system requires consistent, user-friendly interfaces across different platforms and devices. We need a clear approach that:
- Provides unified access to the system across different devices and contexts
- Maintains consistency in user experience
- Leverages our AI-driven, NATS-based architecture
- Balances platform-specific capabilities with consistency across devices
- Supports both chat-based interaction and structured information display

## Decision

We will implement three primary user interfaces for CIM, all following a common interaction model:

1. **Native Interface**:
   - Implemented as a Rust application using the Iced UI framework
   - Runs natively on local systems
   - Optimized for desktop/laptop environments
   - Full access to local system capabilities

2. **Web Interface**:
   - Implemented as a Rust application targeting WebAssembly using Leptos
   - Accessible through web browsers
   - Cross-platform compatibility
   - Progressive web application capabilities

3. **Mobile Interface**:
   - Native implementations for Android and iOS platforms
   - Optimized for touch interaction and mobile form factors
   - Platform-specific capabilities while maintaining consistent experience
   - Technical implementation approach to be determined

### Common Interaction Model

All interfaces will follow a consistent interaction model:

1. **Chat-Centric Interface**: 
   - Primary interaction through a chat interface with the AI agent
   - Natural language as the main input method
   - Rich message formatting for responses

2. **Information Windows**:
   - Ability to open additional windows/panels to display detailed information
   - Contextual relationship between chat and information displays
   - Consistent window management across platforms

3. **Context Menus**:
   - Context-appropriate menus for actions on different elements
   - Consistent menu organization across platforms
   - Shortcut access to common operations

### Backend Communication

The user interfaces will communicate with the CIM backend through:

1. **NATS Messaging**:
   - System requests via standardized NATS subjects
   - Separate command channel for container control
   - Event-based updates for real-time information

2. **AI Agent-Driven Model**:
   - Interfaces primarily interact with the AI agent
   - Agent interprets user intent and orchestrates backend services
   - Creates a unified, intelligent interaction experience

## Architecture Implications

- All interfaces share a common interaction model despite platform differences
- The NATS infrastructure serves as the communication backbone
- Interfaces focus on presentation while backend services handle business logic
- The AI agent acts as the primary mediator between users and system functionality
- Information is contextualized and presented through dedicated windows/panels as needed
- Container management is available through a separate command channel

## Implementation Approach

1. **Native Interface (Iced)**:
   - Structured as a Rust application using Iced for UI rendering
   - Direct NATS client integration for backend communication
   - Local system integration for file access and services
   - Custom window management for information displays

2. **Web Interface (Leptos + WASM)**:
   - Rust code compiled to WebAssembly
   - Leptos for reactive UI components
   - WebSocket-based NATS connection
   - Browser APIs for additional capabilities
   - Tab/iframe-based information windows

3. **Mobile Interface**:
   - Platform-specific implementations with shared core
   - Native UI components for optimal performance
   - Mobile-optimized NATS connectivity
   - Adaptation of the interaction model for touch and smaller screens

## Consequences

### Positive

- **Consistent Experience**: Users have a familiar experience across devices
- **Platform Optimization**: Each interface leverages platform-specific capabilities
- **Modern Technology Stack**: Rust provides performance, safety, and modern capabilities
- **Chat-Centric Simplicity**: Natural language interaction reduces UI complexity
- **Information Contextualization**: Dedicated windows provide organized information views
- **AI-Driven Interaction**: Agent-based approach provides intelligent assistance
- **Cross-Platform Reach**: Full coverage across desktop, web, and mobile environments
- **NATS Integration**: Consistent backend communication across all interfaces

### Negative

- **Development Complexity**: Maintaining three separate interfaces increases development effort
- **Consistency Challenges**: Ensuring consistent behavior across different platforms
- **Platform Limitations**: Some capabilities may not be available on all platforms
- **Learning Curve**: Rust-based UI frameworks have a steeper learning curve
- **Chat Limitations**: Some operations may be less efficient through chat than direct UI
- **Window Management Complexity**: Multiple information windows require careful management

## Related Decisions

- [002: NATS JetStream Dual Role](002-nats-jetstream-dual-role.md)
- [007: Service Interfaces and MCP Integration](007-service-interfaces-and-mcp-integration.md)
- [008: Base CIM Services](008-base-cim-services.md)

## Notes

The chat-centric approach with contextual information windows provides a clean, consistent user experience while leveraging the power of our AI agent. This approach aligns well with our NATS-based architecture and MCP integration strategy, creating a cohesive system where the interface acts primarily as a view into the AI-driven backend.

By implementing native, web, and mobile interfaces, we ensure that users can access the system from any device while maintaining a consistent interaction model. The use of Rust across all platforms (where possible) provides performance benefits and code sharing opportunities while reducing the technology fragmentation that often occurs in cross-platform development.

The separate command channel for container control provides administrators with powerful system management capabilities while keeping the primary user experience focused on information management tasks. 