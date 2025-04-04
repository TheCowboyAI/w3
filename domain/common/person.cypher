// Person Domain Object in Cypher Format
// This file defines the Person domain object and related objects for import into Neo4j

// Define Person node with properties
CREATE (person:DomainObject:Person {
  name: "Person",
  description: "Represents a person in the system",
  category: "Common",
  domain: "People"
});

// Define Person attributes
CREATE (id:Attribute {name: "id", type: "UUID", required: true, description: "Unique identifier for the person"});
CREATE (name:Attribute {name: "name", type: "String", required: true, description: "Full name of the person"});
CREATE (contactDetails:Attribute {name: "contactDetails", type: "ContactInfo", required: false, description: "Contact information for the person"});
CREATE (preferences:Attribute {name: "preferences", type: "PreferenceSet", required: false, description: "User preferences for the person"});

// Connect attributes to Person
CREATE (person)-[:HAS_ATTRIBUTE]->(id);
CREATE (person)-[:HAS_ATTRIBUTE]->(name);
CREATE (person)-[:HAS_ATTRIBUTE]->(contactDetails);
CREATE (person)-[:HAS_ATTRIBUTE]->(preferences);

// Define Person events
CREATE (personCreated:Event {name: "PersonCreated", description: "Triggered when a new person is created"});
CREATE (personUpdated:Event {name: "PersonUpdated", description: "Triggered when a person's information is updated"});
CREATE (personContactInfoChanged:Event {name: "PersonContactInfoChanged", description: "Triggered when a person's contact information changes"});
CREATE (personPreferencesUpdated:Event {name: "PersonPreferencesUpdated", description: "Triggered when a person's preferences are updated"});

// Connect events to Person
CREATE (person)-[:PUBLISHES]->(personCreated);
CREATE (person)-[:PUBLISHES]->(personUpdated);
CREATE (person)-[:PUBLISHES]->(personContactInfoChanged);
CREATE (person)-[:PUBLISHES]->(personPreferencesUpdated);

// Define Person behaviors
CREATE (identityManagement:Behavior {name: "identityManagement", description: "Manages person identity and authentication"});
CREATE (contactManagement:Behavior {name: "contactManagement", description: "Manages person contact information"});
CREATE (preferenceTracking:Behavior {name: "preferenceTracking", description: "Tracks and applies person preferences"});

// Connect behaviors to Person
CREATE (person)-[:EXHIBITS]->(identityManagement);
CREATE (person)-[:EXHIBITS]->(contactManagement);
CREATE (person)-[:EXHIBITS]->(preferenceTracking);

// Define relationships with other domain objects (to be expanded when those objects are defined)
// These serve as placeholders for future relationships
CREATE (personToOrganization:Relationship {name: "BELONGS_TO", description: "Indicates a person belongs to an organization"});
CREATE (personToRole:Relationship {name: "HAS_ROLE", description: "Indicates a person has a role"});
CREATE (personToLocation:Relationship {name: "LOCATED_AT", description: "Indicates a person's location"});

// Connect relationships to Person
CREATE (person)-[:PARTICIPATES_IN]->(personToOrganization);
CREATE (person)-[:PARTICIPATES_IN]->(personToRole);
CREATE (person)-[:PARTICIPATES_IN]->(personToLocation); 