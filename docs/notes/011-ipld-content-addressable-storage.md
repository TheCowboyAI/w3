# Design Decision: IPLD Content-Addressable Storage

## Decision ID: 011

**Date**: 2023-04-06  
**Status**: Approved  
**Deciders**: Core Architecture Team  

## Context

The CIM system requires a robust Object Store that provides:
- Data integrity verification
- Content-based addressing independent of location
- Immutability guarantees for stored objects
- Consistent representation of data across the system
- Compatibility with modern distributed storage approaches

While our NATS JetStream serves as both an Event Store and Object Store, we need a specific data model for content addressing and verification within this store.

## Decision

We will implement InterPlanetary Linked Data (IPLD) as the foundational data model for the CIM Object Store. Specifically:

1. **Content-Addressed Storage**:
   - All objects stored in the system will be content-addressed using IPLD's CID (Content Identifier)
   - CIDs will be calculated based on the data's cryptographic hash plus metadata about how to interpret the data
   - CIDs serve as the primary reference to objects throughout the system

2. **Event-Object Linkage**:
   - Every Object Store operation will have a corresponding Event Store entry
   - Events will contain the CIDs of affected objects, creating an audit trail
   - This linkage enables event sourcing for object lifecycle management

3. **Immutability Enforcement**:
   - Objects are treated as immutable - once stored with a CID, the content cannot change
   - Updates are implemented as new objects with new CIDs
   - Version relationships between objects are tracked through events and metadata

4. **Merkle-DAG Structure**:
   - Objects can reference other objects via their CIDs
   - This creates a Merkle-DAG (Directed Acyclic Graph) of content
   - Complex data structures can be built as compositions of smaller objects

5. **Multi-tier Storage Implementation**:
   - Objects will flow through our existing multi-tier architecture:
     - NATS JetStream (primary storage)
     - 3-Node Cluster (distributed replica)
     - Wasabi (long-term archival)
   - CIDs remain consistent across all storage tiers

## Architecture Implications

- Object identification is based on content rather than location or naming conventions
- The Event Store maintains the history of all Object Store operations with CID references
- Object storage systems (NATS JetStream, Wasabi) need IPLD-compatible interfaces
- Content verification is intrinsic to the addressing mechanism
- Complex data structures can be composed from smaller immutable objects
- Objects can be deduplicated based on their CIDs

## Implementation Approach

We will implement IPLD within our NATS JetStream Object Store as follows:

1. **CID Generation**:
   - Objects submitted for storage will be processed through IPLD libraries
   - Their content will be hashed using appropriate algorithms (SHA-256 by default)
   - CIDs will be generated following the IPLD specification

2. **Storage Format**:
   - Objects will be stored in DAG-CBOR format (CBOR with IPLD extensions)
   - This provides efficient binary encoding with IPLD link support

3. **Event Generation**:
   - When objects are stored, corresponding events will be published
   - Events will contain:
     - Operation type (create, delete, reference)
     - CID(s) involved
     - Metadata about the object
     - Authorization information

4. **Retrieval Process**:
   - Objects are retrieved by their CID
   - Upon retrieval, CIDs are recalculated and verified against the stored CID
   - Mismatches indicate data corruption and trigger recovery procedures

## Consequences

### Positive

- **Data Integrity**: Content-addressing provides built-in verification
- **Deduplication**: Identical content naturally deduplicates via identical CIDs
- **Immutability**: Clear semantics for immutable data storage
- **Audit Trail**: Event-Object linkage creates comprehensive history
- **Composability**: Complex structures can be built from simple components
- **Future Compatibility**: Alignment with modern distributed storage principles
- **Protocol Interoperability**: IPLD works across different protocols/systems
- **Simplified References**: Content-based references don't depend on location

### Negative

- **Implementation Complexity**: IPLD adds complexity to object handling
- **Performance Overhead**: CID calculation adds processing overhead
- **Storage Overhead**: Immutability may increase storage requirements
- **Migration Challenges**: Existing data needs conversion to IPLD format
- **Tooling Requirements**: Need for IPLD-compatible tools and libraries

## Related Decisions

- [001: Multi-tier Scaling Architecture](001-multi-tier-scaling-architecture.md)
- [002: NATS JetStream Dual Role](002-nats-jetstream-dual-role.md)
- [010: Domain Event Flow Patterns](010-domain-event-flow-patterns.md)

## Notes

IPLD provides a robust foundation for our content-addressable storage needs. By implementing this as our Object Store data model, we gain strong guarantees around data integrity, immutability, and verifiability.

The event-object linkage ensures that all operations are traceable and auditable, which is crucial for regulatory compliance and system reliability. The content-addressed nature of IPLD also simplifies many aspects of distributed storage, as objects can be referenced consistently regardless of their physical location across our multi-tier storage architecture.

By adopting IPLD, we also align with modern distributed systems principles and create opportunities for future integration with other content-addressed systems and protocols. 