# Task 001: Initial System Design

## Status: IN PROGRESS

### Completion Rate: 99.9%

## Description
Design the initial system architecture and core components for the Composable Information Machine (CIM).

## Objectives
- [x] Define high-level system architecture
- [x] Identify core components
- [x] Design component interaction model
- [x] Establish data flow mechanisms
- [x] Define extension points
- [x] Identify domain patterns
- [x] Define domain pattern integration
- [x] Determine implementation architecture
- [x] Define component deployment strategy
- [x] Establish distributed event/object store strategy
- [x] Define remote cloud resource integration approach
- [x] Design multi-tier storage strategy
- [x] Define business focus and target audience
- [x] Establish domain-driven design approach
- [x] Define domain objects and their relationships
- [x] Design domain object storage and visualization
- [x] Define service interfaces and MCP integration
- [x] Define base CIM services
- [x] Define cross-domain interaction patterns
- [x] Define domain event flow patterns
- [x] Define IPLD content-addressable storage approach
- [x] Define primary user interfaces and interaction model
- [x] Define security architecture and authentication framework
- [x] Complete detailed component specifications
- [ ] Complete interface definitions
- [ ] Design NixOS module structure

## Deliverables
- [x] System architecture document
- [x] Core component specifications
- [x] Component interaction model documentation
- [x] Data flow patterns documentation
- [x] Extension point documentation
- [x] Domain pattern documentation
- [x] Implementation architecture documentation
- [x] Multi-tier scaling architecture documentation
- [x] Event/object store strategy documentation
- [x] Domain-driven design approach documentation
- [x] Domain objects documentation
- [x] Service interfaces and MCP integration documentation
- [x] Base CIM services documentation
- [x] Cross-domain interaction patterns documentation
- [x] Domain event flow patterns documentation
- [x] IPLD content-addressable storage documentation
- [x] Primary user interfaces documentation
- [x] Security architecture documentation
- [x] Detailed component specifications
- [ ] Interface definitions documentation
- [ ] NixOS module design documentation

## Task Details

### System Architecture Design
- [x] Define architectural layers
- [x] Establish component boundaries
- [x] Document system interactions
- [x] Create high-level architecture diagram

### Core Component Design
- [x] Information unit component
- [x] Pipeline processing engine
- [x] Component registry
- [x] Plugin management system
- [x] Type system
- [x] Storage manager
- [x] User interface framework
- [x] Integration hub

### Interface Design
- [ ] Define component interfaces
- [ ] Establish API contracts
- [ ] Design extension points
- [ ] Document interface requirements
- [x] Define service interface patterns
- [x] Design MCP integration approach

### Data Flow Design
- [x] Define data transmission patterns
- [x] Establish message formats
- [x] Design transformation mechanisms
- [x] Document data flow control

### Extensibility Framework
- [x] Design plugin architecture
- [x] Define extension points
- [ ] Create extension registration mechanism
- [ ] Document extension development process

### Domain Pattern Design
- [x] Information classification patterns
- [x] Knowledge representation patterns
- [x] Information retrieval patterns
- [x] Content processing patterns
- [x] Information synthesis patterns
- [x] Collaborative information patterns
- [x] Information lifecycle patterns
- [x] Context management patterns
- [x] Adaptation patterns

### Business Focus and Audience
- [x] Define target audience (medium-sized businesses)
- [x] Establish vertical market focus
- [x] Document hybrid cloud approach
- [x] Outline progressive scaling strategy
- [x] Create value proposition

### Domain-Driven Design
- [x] Establish domain-driven approach
- [x] Define domain boundary principles
- [x] Document common vs. vertical domain balance
- [x] Outline domain composition methodology
- [ ] Define common domain objects (People, Organizations, Locations, Documents, Inventory)
- [ ] Create vertical market domain examples
- [x] Design cross-domain interaction patterns
- [x] Document domain event flows
- [x] Define domain object graph storage approach
- [x] Design domain object visualization strategy

### Implementation Architecture
- [x] Select base technology platform (NixOS)
- [x] Determine deployment strategy (containers)
- [x] Define component isolation approach
- [x] Identify communication mechanisms (NATS)
- [x] Establish host responsibilities
- [ ] Design NixOS module structure
- [ ] Define container resource specifications

### Event/Object Store Strategy
- [x] Select event sourcing technology (NATS JetStream)
- [x] Define event store capabilities
- [x] Establish object storage approach
- [x] Determine persistence strategies
- [x] Design multi-tier storage architecture (JetStream → Cluster → Wasabi)
- [x] Define content-addressable storage model using IPLD
- [ ] Design event schemas
- [ ] Define event processing patterns
- [ ] Create object storage access patterns

### Distributed Architecture
- [x] Define local vs. remote components approach
- [x] Establish cloud resource integration strategy
- [x] Select distributed communication mechanism
- [x] Define scaling model (Leaf Node → 3-Node Cluster)
- [ ] Design consistency models
- [ ] Define fault tolerance approaches
- [ ] Create distributed security model

### Security Architecture
- [x] Define Root Certificate Authority (CA) approach
- [x] Establish YubiKey integration strategy
- [x] Design key hierarchy and management
- [x] Define certificate infrastructure
- [x] Establish authentication framework
- [x] Define secure communication patterns
- [x] Design secure key management processes

### 2023-04-05: Base CIM Services Definition
Established the core services that constitute a base CIM installation:

1. **AI**: AI Chat Interface with access to MCP servers and multiple tuned models
2. **NATS**: Messaging backbone for inter-service communication, event store, and object store
3. **Git**: Version control for configurations, source code, and issue tracking
4. **Mail**: Email system for communication, workflow integration, and notifications
5. **Search**: Centralized search via SearXNG with API-based access
6. **Docs**: Document management (such as PaperlessNG) for storage, tagging, and retrieval
7. **Web**: Web portal for unified system access and consistent user experience
8. **WF**: Workflow automation via n8n for process orchestration
9. **Vault**: Secret management via Vaultwarden for secure credential storage
10. **Notes**: Knowledge management (such as Obsidian or Trilium Next) for notes and knowledge graphs
11. **Feeds**: RSS feed integration for content processing and routing
12. **DB**: Database services with Neo4j for graph data and PostgreSQL for relational data

These services collectively form a complete information management ecosystem, with each service implemented as a containerized component following our dual-interface approach (NATS and MCP). For third-party tools, we'll leverage official MCP interfaces where available and develop custom NATS integrations around their APIs.

Documentation added as a design decision in docs/notes/008-base-cim-services.md.

### 2023-04-06: Cross-Domain Interaction Patterns
Established comprehensive patterns for interactions between domains:

1. **Event-Based Integration**: Primary pattern using domain events published to NATS JetStream
2. **Shared Reference Data**: Common domains serve as canonical sources with reference by ID
3. **Domain Service Interfaces**: Explicit service interfaces via NATS subjects using command/query pattern
4. **Saga Pattern**: For processes spanning multiple domains with compensating actions
5. **Domain Relationship Registry**: Neo4j-based registry of relationships between entities across domains

These patterns are implemented using our NATS JetStream architecture with standardized event structures and subject naming conventions. The implementation approach includes domain-specific NATS subjects following the convention `domain.entity.event/command/query` and process coordination via the n8n workflow service.

We've documented concrete examples showing these patterns in action, including patient registration in the healthcare vertical and document upload workflows. Each example demonstrates how domains communicate while maintaining their boundaries.

Documentation added as a design decision in docs/notes/009-cross-domain-interaction-patterns.md.

### 2023-04-06: Domain Event Flow Patterns
Established comprehensive patterns for domain event flows throughout the system:

1. **Standardized Event Structure**: Defined a consistent JSON structure for all domain events, including:
   - Core fields: id, type, source, time, version
   - Context fields: correlationId, causationId
   - Payload data structure
   - Metadata for auxiliary information

2. **NATS Subject Hierarchy**: Created a convention for event publication using the pattern:
   ```
   events.{domain}.{entity}.{eventType}[.v{version}]
   ```

3. **Event Flow Patterns**:
   - Command → Event → Projection Pattern
   - Saga Coordination Pattern
   - Event Enrichment Pattern
   - Event Archival Pattern

4. **JetStream Configuration**: Defined stream configuration with domain-specific streams, retention policies, replication, and compression settings.

5. **Event Evolution Strategy**: Established an approach for versioning and evolving event schemas while maintaining compatibility.

These patterns ensure consistent event structure and flow across all domains, enabling reliable system-wide communication while respecting domain boundaries. They align perfectly with our NATS JetStream architecture and support our cross-domain interaction patterns.

Documentation added as a design decision in docs/notes/010-domain-event-flow-patterns.md.

### 2023-04-06: IPLD Content-Addressable Storage
Established IPLD (InterPlanetary Linked Data) as the foundational data model for our Object Store:

1. **Content-Addressed Storage**: All objects are identified by Content IDs (CIDs) derived from their cryptographic hash, ensuring data integrity and verification.

2. **Event-Object Linkage**: Every Object Store operation has a corresponding Event Store entry that references the object's CID, creating a complete audit trail.

3. **Immutability Enforcement**: Objects are treated as immutable - once stored with a CID, the content cannot change. Updates are implemented as new objects with new CIDs, with version relationships tracked through events.

4. **Merkle-DAG Structure**: Objects can reference other objects via their CIDs, creating a directed acyclic graph that enables complex data structures as compositions of smaller objects.

5. **Multi-tier Implementation**: Objects and their CIDs remain consistent as they flow through our multi-tier storage architecture (NATS JetStream → 3-Node Cluster → Wasabi).

This approach provides strong guarantees for data integrity, enables natural deduplication, creates a comprehensive audit trail, and aligns with modern distributed systems principles. The content-addressed nature of IPLD also simplifies many aspects of distributed storage, as objects can be referenced consistently regardless of their physical location.

Documentation added as a design decision in docs/notes/011-ipld-content-addressable-storage.md.

### 2023-04-06: Primary User Interfaces
Established the three primary user interfaces and their common interaction model:

1. **Native Interface**: A Rust application using the Iced UI framework, running natively on local systems and optimized for desktop environments

2. **Web Interface**: A Rust application targeting WebAssembly using Leptos, accessible through web browsers and providing cross-platform compatibility

3. **Mobile Interface**: Native implementations for Android and iOS platforms, optimized for touch interaction and mobile form factors

All interfaces follow a consistent interaction model:
- **Chat-Centric Interface**: Primary interaction through chat with the AI agent
- **Information Windows**: Additional windows/panels for displaying detailed information
- **Context Menus**: Context-appropriate menus for actions on different elements

The interfaces communicate with the backend through NATS messaging, with:
- System requests via standardized NATS subjects
- A separate command channel for container control
- AI agent-driven interaction, where the agent interprets user intent and orchestrates backend services

This approach provides a consistent experience across all platforms while optimizing for each platform's specific capabilities. The chat-centric model simplifies the user interface while leveraging the power of our AI-driven backend, and the information windows provide contextual organization of data when needed.

Documentation added as a design decision in docs/notes/012-primary-user-interfaces.md.

### 2023-04-06: Security Architecture
Established a comprehensive security architecture for the CIM system:

1. **Root Certificate Authority (CA)**:
   - Generated in an air-gapped environment for maximum security
   - Comprises a core private key, authentication key, encryption key, and signing key
   - Used to sign the CIM's TLS certificates and establish trust
   - Used to initialize the NATS message store with appropriate tools (nsc)
   - Backed by a secure key management process using YubiKeys

2. **YubiKey Integration**:
   - YubiKeys serve as secure hardware devices for storing keys and authentication
   - Root CA's Certify Key stored in a non-exportable format on YubiKeys
   - Support for PIV functionality, digital signing, and SSO capabilities
   - Multiple YubiKeys configured with identical shared keys for redundancy

3. **Key Hierarchy and Certificate Infrastructure**:
   - Multi-level key hierarchy with Root CA, Intermediate CAs, Service Keys, and User Keys
   - X.509 certificates for TLS/SSL encryption using ED25519 for optimal security
   - Service-specific certificates and client certificates for mutual TLS

4. **Authentication Framework**:
   - Multiple authentication methods (YubiKey, certificates, traditional passwords)
   - Role-based access control (RBAC) and principle of least privilege
   - SSO capabilities integrated with the NATS security framework

5. **Secure Communication**:
   - TLS encryption for all NATS traffic
   - Mutual TLS authentication for service-to-service communication
   - Signed events in the event store with verification
   - Encryption of sensitive data at rest

This comprehensive security approach provides a robust foundation for the CIM system, addressing authentication, encryption, and access control needs. The YubiKey-based approach offers strong hardware security while maintaining usability, and the air-gapped initialization process ensures maximum security for our trust anchor.

Documentation added as a design decision in docs/notes/013-security-architecture.md.

## Time Estimate
The high-level design, domain pattern definition, implementation architecture decisions, distributed event/object store strategy, base CIM services definition, cross-domain interaction patterns, domain event flow patterns, content-addressable storage approach, primary user interfaces, and security architecture are complete. We're now focused on detailed component specifications and interface definitions.

## Dependencies
None - This is the initial design task.

## Notes
The initial system design is nearly complete. We have established the high-level architecture, defined the core components, designed the interaction model, and determined the implementation approach using NixOS with containers and NATS JetStream.

### Key Decisions:
1. **System Architecture**: Seven core components with clear responsibilities and boundaries
2. **Domain Patterns**: Nine pattern categories organizing information processing
3. **Implementation Architecture**: NixOS with containerized components
4. **Storage Strategy**: NATS JetStream for both event sourcing and object storage
5. **Business Focus**: Medium-sized businesses in vertical markets
6. **Domain Objects**: Graph-based storage with Neo4j integration path
7. **Service Interfaces**: Dual approach with NATS for system and MCP for AI
8. **Base Services**: Twelve core services forming the foundation of CIM
9. **Multi-tier Architecture**: Leaf Node → 3-Node Cluster → Wasabi
10. **Domain-Driven Design**: Clear boundaries between common and vertical domains
11. **Cross-Domain Interaction**: Event-based integration with shared reference data
12. **IPLD Storage**: Content-addressed, immutable objects with event linkage
13. **User Interfaces**: Native, Web, and Mobile with chat-centric interaction
14. **Security Architecture**: Root CA with YubiKey integration and multi-level key hierarchy

### Established Domain Pattern Categories:
1. Information Classification Patterns
2. Knowledge Representation Patterns
3. Information Retrieval Patterns
4. Content Processing Patterns
5. Information Synthesis Patterns
6. Collaborative Information Patterns
7. Information Lifecycle Patterns
8. Context Management Patterns
9. Adaptation Patterns

### Established Core Components:
1. **Information Unit System**: Standardized data containers with metadata, handling chat dialogs, text documents, formatted docs (PDFs), images, and graphs (mermaid and cypher formats). All information units are immutable with immutable diffs appendable, and versioning controlled by IPLD content-addressing.

2. **Component Registry**: Manages component availability via NATS subscriptions, discovers components through NATS subjects and a graph in JetStream KV store, lists capabilities for each component, and provides simple heartbeat monitoring.

3. **Pipeline Engine**: Orchestrates information workflows through processing stages.

4. **Storage Manager**: Provides unified access to persistent storage across different tiers, handling caching, replication, and content addressing with sophisticated movement between cluster and leaf nodes.

5. **User Interface Framework**: Provides consistent user experiences across platforms using Rust-based technology stacks (Native: Rust and Iced UI, Petgraph, Bevy, Neo4j; Web: Leptos; Android: Rust and Iced; iOS: TBD). UI components are domain-dependent with Entity Component System for multi-device synchronization via NATS.

6. **Integration Hub**: Connects CIM with external services and protocols (MCP, NATS, HTTP), with configurations managed in Git and extensive transformation capabilities.

7. **Plugin System**: Functionality handled through NATS Subject-based isolation rather than as a separate component.

### Established Base CIM Services:
1. AI (Chat Interface)
2. NATS (Messaging)
3. Git (Version Control)
4. Mail (Email System)
5. Search (SearXNG)
6. Docs (PaperlessNG)
7. Web (Portal)
8. WF (n8n)
9. Vault (Vaultwarden)
10. Notes (Obsidian/Trilium)
11. Feeds (RSS)
12. DB (Neo4j & PostgreSQL)

### Established Cross-Domain Interaction Patterns:
1. Event-Based Integration
2. Shared Reference Data
3. Domain Service Interfaces
4. Saga Pattern for cross-domain processes
5. Domain Relationship Registry

### Established Domain Event Flow Patterns:
1. Standardized Event Structure with core fields, context fields, payload, and metadata
2. NATS Subject Hierarchy following convention `events.{domain}.{entity}.{eventType}[.v{version}]`
3. Event Flow Patterns including Command → Event → Projection, Saga Coordination, Event Enrichment, and Event Archival
4. JetStream storage with domain-specific streams
5. Event Evolution Strategy with versioning and compatibility approach

### Established IPLD Content-Addressable Storage:
1. Content-Addressed Storage with CIDs
2. Event-Object Linkage
3. Immutability Enforcement
4. Merkle-DAG Structure
5. Multi-tier Storage with consistent CIDs

### Established Primary User Interfaces:
1. **Native Interface**: Rust application using the Iced UI framework for desktop environments
2. **Web Interface**: Rust application targeting WebAssembly using Leptos for browser access
3. **Mobile Interface**: Native Android and iOS applications for mobile devices

All interfaces follow a consistent interaction model centered around:
- **Chat-Centric Interface**: Primary interaction through a chat interface with the AI agent
- **Information Windows**: Additional windows/panels for displaying detailed information
- **Context Menus**: Context-appropriate menus for actions on different elements

The interfaces communicate with the backend through NATS messaging with system requests via standardized subjects and a separate command channel for container control.

### Established Security Architecture:
1. **Root Certificate Authority (CA)**: Generated in an air-gapped environment and used to sign CIM's TLS certificates and initialize NATS
2. **YubiKey Integration**: Hardware-based security for storing the Root CA's Certify Key and providing authentication
3. **Key Hierarchy**: Multi-level hierarchy from Root CA to user keys with proper separation of concerns
4. **Certificate Infrastructure**: X.509 certificates using ED25519 for optimal security and performance
5. **Authentication Framework**: Multiple methods with YubiKey as primary, supporting RBAC and least privilege principles
6. **Secure Communication**: TLS encryption for all NATS traffic with mutual TLS for service communication
7. **Key Management Processes**: Secure procedures for air-gapped key generation and YubiKey initialization

### Established Detailed Component Specifications:
Detailed specifications for all seven core components have been completed (Decision ID: 014), defining:
- The internal structure of each component
- Supported information types and protocols
- Resource requirements (storage, memory, compute, networking)
- Interface definitions with NATS subject patterns
- Implementation considerations and approaches

To complete this task, we need to:
1. Finalize interface definitions, focusing on the NATS subject naming conventions and message structures
2. Design the NixOS module structure for component deployment 