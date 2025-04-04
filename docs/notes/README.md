# Design Decision Notes

This directory contains documented design decisions for the CIM project. Each decision is recorded with context, consequences, and relationships to other decisions.

## Decision Index

| ID | Title | Date | Description |
|----|-------|------|-------------|
| [001](001-multi-tier-scaling-architecture.md) | Multi-tier Scaling Architecture | 2023-04-05 | Defines the three-tier architecture: Leaf Node → 3-Node Cluster → Wasabi |
| [002](002-nats-jetstream-dual-role.md) | NATS JetStream Dual Role | 2023-04-04 | Establishes NATS JetStream as both Event Store and Object Store |
| [003](003-nixos-hyperconverged-implementation.md) | NixOS Hyper-Converged Implementation | 2023-04-04 | Details the NixOS-based deployment with containerized components |

## Decision Relationships

```
┌────────────────────────┐
│                        │
│ 003: NixOS             │
│ Hyper-Converged        │◄────────┐
│ Implementation         │         │
│                        │         │
└───────────┬────────────┘         │
            │                      │
            │                      │
            ▼                      │
┌────────────────────────┐         │
│                        │         │
│ 002: NATS JetStream    │─────────┘
│ Dual Role              │
│                        │◄────────┐
└───────────┬────────────┘         │
            │                      │
            │                      │
            ▼                      │
┌────────────────────────┐         │
│                        │         │
│ 001: Multi-tier        │─────────┘
│ Scaling Architecture   │
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