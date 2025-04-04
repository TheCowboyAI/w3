// Patient Domain Object in Cypher Format (Healthcare Vertical)
// This file defines the Patient domain object which extends Person for the Healthcare vertical

// Define Patient node with properties
CREATE (patient:DomainObject:VerticalObject:Patient {
  name: "Patient",
  description: "Represents a patient in a healthcare context",
  category: "Vertical",
  domain: "Healthcare",
  extends: "Person"
});

// Define Patient attributes beyond those inherited from Person
CREATE (medicalId:Attribute {name: "medicalId", type: "String", required: true, description: "Medical record identifier"});
CREATE (conditions:Attribute {name: "conditions", type: "List<MedicalCondition>", required: false, description: "Medical conditions"});
CREATE (treatments:Attribute {name: "treatments", type: "List<Treatment>", required: false, description: "Current and past treatments"});
CREATE (allergies:Attribute {name: "allergies", type: "List<Allergy>", required: false, description: "Known allergies"});

// Connect attributes to Patient
CREATE (patient)-[:HAS_ATTRIBUTE]->(medicalId);
CREATE (patient)-[:HAS_ATTRIBUTE]->(conditions);
CREATE (patient)-[:HAS_ATTRIBUTE]->(treatments);
CREATE (patient)-[:HAS_ATTRIBUTE]->(allergies);

// Define Patient events
CREATE (patientRegistered:Event {name: "PatientRegistered", description: "Triggered when a new patient is registered"});
CREATE (patientUpdated:Event {name: "PatientUpdated", description: "Triggered when a patient's information is updated"});
CREATE (patientConditionRecorded:Event {name: "PatientConditionRecorded", description: "Triggered when a medical condition is recorded"});
CREATE (patientTreatmentAssigned:Event {name: "PatientTreatmentAssigned", description: "Triggered when a treatment is assigned"});

// Connect events to Patient
CREATE (patient)-[:PUBLISHES]->(patientRegistered);
CREATE (patient)-[:PUBLISHES]->(patientUpdated);
CREATE (patient)-[:PUBLISHES]->(patientConditionRecorded);
CREATE (patient)-[:PUBLISHES]->(patientTreatmentAssigned);

// Define Patient behaviors
CREATE (patientRecordManagement:Behavior {name: "patientRecordManagement", description: "Manages patient medical records"});
CREATE (medicalHistoryTracking:Behavior {name: "medicalHistoryTracking", description: "Tracks and manages medical history"});

// Connect behaviors to Patient
CREATE (patient)-[:EXHIBITS]->(patientRecordManagement);
CREATE (patient)-[:EXHIBITS]->(medicalHistoryTracking);

// Define relationships with other domain objects
CREATE (patientToProvider:Relationship {name: "TREATED_BY", description: "Indicates a patient is treated by a medical provider"});
CREATE (patientToAppointment:Relationship {name: "HAS_APPOINTMENT", description: "Indicates a patient has a medical appointment"});
CREATE (patientToFacility:Relationship {name: "ADMITTED_TO", description: "Indicates a patient is admitted to a healthcare facility"});

// Connect relationships to Patient
CREATE (patient)-[:PARTICIPATES_IN]->(patientToProvider);
CREATE (patient)-[:PARTICIPATES_IN]->(patientToAppointment);
CREATE (patient)-[:PARTICIPATES_IN]->(patientToFacility);

// Define inheritance relationship from Person (assuming Person exists)
// We would typically have a reference to the Person domain object here
CREATE (personRef:DomainObject:Person {name: "Person"});
CREATE (patient)-[:EXTENDS]->(personRef); 