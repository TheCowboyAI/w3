# CIM - Composable Information Machine

## Overview

The Composable Information Machine (CIM) is an architectural pattern for building systems that help users organize, process, and leverage information in a composable and modular way. It enables the creation of domain-specific information workflows through a flexible, component-based architecture.

## Project Dashboard

📊 [View Interactive Project Dashboard](./docs/dashboard.md) - Visual overview of project progress, component status, and timelines

## Purpose

The CIM pattern addresses the challenges of information overload, isolated information silos, and rigid workflows by providing a flexible framework for information management. It allows organizations to design their own information processing pipelines using modular components while adapting to specific vertical market requirements.

## Key Features

- Modular component architecture
- Domain-driven design for vertical markets
- Composable information workflows
- Event-driven communication
- Standardized information units
- Content-addressable storage
- Cross-domain integration
- Consistent user interfaces

## Project Status

We have completed the initial design phase, establishing the CIM as a generic architectural pattern that can be instantiated for different domains. The next steps involve implementing common domain objects and domain-specific extensions.

## Architecture

A CIM instance consists of seven core components:

1. **Information Unit System**: Standardized data containers
2. **Component Registry**: Service discovery and capability negotiation
3. **Pipeline Engine**: Information flow orchestration
4. **Storage Manager**: Multi-tiered content-addressable storage
5. **User Interface Framework**: Consistent UX across platforms
6. **Integration Hub**: External service connectivity
7. **Plugin System**: Functionality covered by existing components

These components communicate through standardized event, service, and command interfaces using NATS as the messaging backbone.

## Domain Approach

The CIM pattern follows a domain-driven design approach:
- Common domains provide foundation functionality (People, Organizations, Documents)
- Vertical market domains enable industry-specific features
- Clear boundaries separate business concerns
- Event-based communication maintains domain isolation

## Implementation

A CIM instance is implemented as a NixOS-based hyper-converged solution:
- Core functionality as NixOS modules
- Components deployed as nixos-containers
- NATS JetStream for messaging, event sourcing, and object storage
- Multi-tier storage with IPLD for content-addressed, immutable objects

## Documentation

Project documentation is stored in the `memory-bank` directory, which serves as the knowledge base for the CIM pattern. Key files include:

- `projectbrief.md` - Project requirements and goals
- `productContext.md` - Why this pattern exists and what problems it solves
- `systemPatterns.md` - Architecture and technical decisions
- `techContext.md` - Technology stack and development information
- `progress.md` - Current status and implementation details
- `tasks.md` - Active and planned tasks

Design decisions are documented in the `docs/notes/` directory, providing detailed context and rationale for all architectural choices.

## Next Steps

The next phase focuses on:
1. Implementing common domain objects shared across all CIM instances
2. Creating domain-specific implementations for vertical markets
3. Integrating domain-specific extensions with the common domain model

## Getting Started

Simply type `SAGE` to start the conversation in Composer using agent mode.

## Contributing

The project is transitioning from design to implementation phase. Contribution guidelines will focus on extending the pattern for specific domains.

## License

License information will be added in the future.

