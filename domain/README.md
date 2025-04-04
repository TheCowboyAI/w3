# Domain Objects Graph

This directory contains the domain objects for the CIM system in Cypher graph format. These files can be imported into Neo4j when the system is ready for deployment.

## Directory Structure

- `/common` - Contains common business domain objects applicable across industries
- `/vertical` - Contains vertical market-specific domain objects
- `/relationships` - Contains cross-domain relationship definitions

## File Format

Each file uses Cypher query language to define:
- Domain objects as nodes with properties
- Object attributes with types and descriptions
- Events published by domain objects
- Behaviors exhibited by domain objects
- Relationships with other domain objects

## Usage

### Neo4j Import

When the Neo4j database is available, these files can be imported using:

```
neo4j-admin import --nodes=domain/common/*.cypher --nodes=domain/vertical/*.cypher --relationships=domain/relationships/*.cypher
```

### Visualization

During development, these files can be visualized using the custom graph viewer tool built with Rust and Iced. The viewer communicates with the CIM system through NATS.

## Domain Object Structure

Each domain object follows this structure:

```
(DomainObject)-[:HAS_ATTRIBUTE]->(Attribute)
(DomainObject)-[:PUBLISHES]->(Event)
(DomainObject)-[:EXHIBITS]->(Behavior)
(DomainObject)-[:PARTICIPATES_IN]->(Relationship)
```

### Vertical Domain Objects

Vertical domain objects may extend common domain objects:

```
(VerticalObject)-[:EXTENDS]->(CommonObject)
```

For example, in the Private Lending vertical, a `Borrower` extends the common `Person` domain object:

```
(Borrower:VerticalObject)-[:EXTENDS]->(Person:CommonObject)
```

This allows specialized vertical domains to build upon common business objects while adding domain-specific attributes, events, and behaviors.

## Example Vertical Markets

The CIM architecture supports various vertical markets, including:

- **Private Lending**: Extends common domains with lending-specific objects like LoanApplication, PropertyAsset, and PrivateLender
- **IT Services**: Extends common domains with service-specific objects like ManagedCloudHosting, SoftwareDevelopment, and BusinessIntegration
- **Legal**: Legal case management and document processing
- **Education**: Student records and curriculum management
- **Construction**: Project management and resource allocation

Each vertical market implementation uses the same domain patterns while addressing industry-specific requirements.

## NATS Communication

The graph viewer communicates with CIM components through NATS using these subjects:

- `domain.graph.get` - Request domain object details
- `domain.graph.list` - List available domain objects
- `domain.graph.relationships` - Get relationships between domain objects
- `domain.graph.search` - Search for domain objects matching criteria

## Development

When adding new domain objects:

1. Create a new Cypher file in the appropriate directory
2. Define the domain object structure following the patterns above
3. Run the graph viewer to visualize the relationships
4. Use NATS to test communication with other components 