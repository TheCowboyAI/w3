# Design Decision Notes

This directory contains documented design decisions for the CIM project. Each decision is recorded with context, consequences, and relationships to other decisions.

## Decision Index

| ID | Title | Date | Description |
|----|-------|------|-------------|
| [001](001-multi-tier-scaling-architecture.md) | Multi-tier Scaling Architecture | 2023-04-05 | Defines the three-tier architecture: Leaf Node → 3-Node Cluster → Wasabi |
| [002](002-nats-jetstream-dual-role.md) | NATS JetStream Dual Role | 2023-04-04 | Establishes NATS JetStream as both Event Store and Object Store |
| [003](003-nixos-hyperconverged-implementation.md) | NixOS Hyper-Converged Implementation | 2023-04-04 | Details the NixOS-based deployment with containerized components |
| [004](004-business-focus-and-audience.md) | Business Focus and Hybrid Cloud Approach | 2023-04-05 | Defines the target audience as medium-sized businesses and outlines the hybrid approach to cloud resources |
| [005](005-domain-driven-vertical-markets.md) | Domain-Driven Design for Vertical Markets | 2023-04-05 | Describes how domain boundaries enable addressing specialized vertical market requirements while leveraging common business domains |
| [006](006-domain-objects-graph-storage.md) | Domain Objects as Graph Storage | 2023-04-05 | Outlines the phased approach to storing domain objects as graphs using Cypher files and a custom Rust/Iced viewer before Neo4j integration |
| [007](007-service-interfaces-and-mcp-integration.md) | Service Interfaces and MCP Integration | 2023-04-05 | Defines the dual-interface approach with NATS for primary communication and MCP for AI integration |
| [008](008-base-cim-services.md) | Base CIM Services | 2023-04-05 | Establishes the core services that constitute a base CIM installation and their integration patterns |
| [009](009-cross-domain-interaction-patterns.md) | Cross-Domain Interaction Patterns | 2023-04-06 | Defines the patterns for communication and data sharing between domains while maintaining domain boundaries |

## Decision Relationships

```
┌─────────────────────────┐            ┌─────────────────────────┐            ┌─────────────────────────┐
│                         │            │                         │            │                         │
│ 004: Business Focus &   │◄───────────┤ 005: Domain-Driven      │────────────► 006: Domain Objects     │
│ Hybrid Cloud Approach   │    Aligns  │ Design for Vertical     │  Implements│ as Graph Storage        │
│                         │    with    │ Markets                 │            │                         │
└─────────┬───────────────┘            └───────────┬─────────────┘            └───────────┬─────────────┘
          │                                        │                                      │
          │ Drives                                 │ Influences                           │ Uses
          │                                        │                                      ▼
          ▼                                        ▼                              ┌────────────────────────┐
┌────────────────────────┐                 ┌────────────────────────┐            │                        │
│                        │                 │                        │            │ 002: NATS JetStream    │
│ 003: NixOS             │                 │ 002: NATS JetStream    │◄───────────┤ Dual Role              │
│ Hyper-Converged        │◄────────┐      │ Dual Role              │            │                        │
│ Implementation         │         │      │                        │            └────────────┬───────────┘
│                        │         │      └───────────┬────────────┘                        │
└───────────┬────────────┘         │                  │                                     │
            │                      │                  │                                     │
            │                      │                  │                                     │
            ▼                      │                  ▼                                     ▼
┌────────────────────────┐         │      ┌────────────────────────┐            ┌────────────────────────┐
│                        │         │      │                        │            │                        │
│ 002: NATS JetStream    │─────────┘      │ 001: Multi-tier        │            │ 007: Service Interfaces│
│ Dual Role              │                │ Scaling Architecture   │            │ and MCP Integration    │
│                        │◄────────┐      │                        │            │                        │
└───────────┬────────────┘         │      └────────────────────────┘            └────────────┬───────────┘
            │                      │                                                         │
            │                      │                                                         │
            ▼                      │                                                         │
┌────────────────────────┐         │                                            ┌────────────▼───────────┐
│                        │         │                                            │                        │
│ 001: Multi-tier        │─────────┘                                            │ 008: Base CIM Services │
│ Scaling Architecture   │                                                      │                        │
│                        │                                                      └────────────┬───────────┘
└────────────────────────┘                                                                   │
                                                                                             │
                                                                                             ▼
                                                                              ┌────────────────────────┐
                                                                              │                        │
                                                                              │ 009: Cross-Domain      │
                                                                              │ Interaction Patterns   │
                                                                              │                        │
                                                                              └────────────────────────┘
```

## Using These Notes

These design decision notes should be referenced when:
- Making new architectural decisions
- Implementing components that interact with these systems
- Onboarding new team members to understand the architecture
- Evaluating potential changes to the system

Each decision note includes:
- Context explaining why the decision was needed
- The decision details
- Architecture implications
- Positive and negative consequences
- Related decisions
- Implementation notes

## Adding New Decisions

When adding a new decision:
1. Create a file named `XXX-descriptive-name.md` (where XXX is the next available number)
2. Follow the established template
3. Update this README to include the new decision
4. Update the relationship diagram if applicable 