# Design Decision: Multi-tier Scaling Architecture

## Decision ID: 001

**Date**: 2023-04-05  
**Status**: Approved  
**Deciders**: Core Architecture Team  

## Context

The CIM system needs a robust storage and scaling architecture that supports:
- Local operations with high performance
- High availability for customer-facing services
- Compute-intensive task handling
- Long-term data durability
- Progressive scaling from small to large deployments

## Decision

We will implement a three-tier scaling architecture:

1. **Leaf Node (Primary Tier)**
   - Single hyper-converged node for local operations
   - NATS JetStream for event and object storage
   - Complete functionality in a self-contained system
   - Optimized for local connections and processing

2. **3-Node Cluster (Secondary Tier)**
   - Replica of the leaf node in clustered configuration
   - Provides high availability for customer-facing services
   - Handles compute-intensive tasks offloaded from leaf nodes
   - Distributes load across multiple nodes
   - Ensures system availability during maintenance or failures

3. **Wasabi Cloud Storage (Tertiary Tier)**
   - Cluster replicates data to Wasabi
   - Provides long-term archival storage
   - Ensures data durability beyond local infrastructure
   - Cost-effective solution for cold storage and disaster recovery

The data flow follows: **Leaf Node → 3-Node Cluster → Wasabi**

## Architecture Diagram

```
┌──────────────────┐     
│   "Leaf Node"    │     Local System: Optimized for local operations
│ Hyper-converged  │     
└────────┬─────────┘     
         │ Data Replication
┌────────▼─────────┐     
│                  │     
│   3-Node Cluster │     High Availability System: Customer-facing 
│                  │     and compute-intensive processing
└────────┬─────────┘     
         │ Data Archival
┌────────▼─────────┐     
│     Wasabi       │     Tertiary Storage: Long-term archival
│     Storage      │     
└──────────────────┘     
```

## Consequences

### Positive

- **Operational Division of Responsibilities**: Each tier serves a specific purpose
- **Progressive Scaling Path**: Start small and grow as needed
- **Enhanced Resilience**: Multiple independent storage layers
- **Performance Optimization**: Intensive tasks offloaded to cluster
- **Consistent Architecture**: Common patterns throughout scaling

### Negative

- **Increased Complexity**: More components to manage and monitor
- **Replication Overhead**: Data synchronization between tiers
- **Eventual Consistency Challenges**: Managing consistency across distributed components
- **Cost Considerations**: Multiple tiers increase infrastructure costs

## Related Decisions

- NATS JetStream selected as Event Store and Object Store
- NixOS chosen as the implementation platform
- Component isolation through nixos-containers

## Notes

The scaling architecture is designed to grow with operational demands while maintaining the fundamental architecture patterns. Leaf Nodes focus on local operations, the Cluster handles high availability and intensive processing, and Wasabi provides long-term storage.

This architecture supports both small deployments (single Leaf Node) and larger deployments (multiple Leaf Nodes connected to a shared Cluster), with consistent patterns throughout. 