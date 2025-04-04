// IT Services Domain Objects in Cypher Format
// This file defines primary domain objects for the IT Services vertical market

// Define ITService domain object (base for all services)
CREATE (itService:DomainObject:VerticalObject:ITService {
  name: "ITService",
  description: "Represents a generic IT service offering",
  category: "Vertical",
  domain: "ITServices"
});

// Define ITService attributes
CREATE (serviceId:Attribute {name: "serviceId", type: "UUID", required: true, description: "Unique identifier for the service"});
CREATE (serviceName:Attribute {name: "serviceName", type: "String", required: true, description: "Name of the service offering"});
CREATE (serviceDescription:Attribute {name: "serviceDescription", type: "Text", required: true, description: "Detailed description of the service"});
CREATE (serviceLevel:Attribute {name: "serviceLevel", type: "Enum", required: true, description: "Service level tier (Basic, Standard, Premium, Enterprise)"});
CREATE (pricing:Attribute {name: "pricing", type: "PricingModel", required: true, description: "Pricing structure for the service"});
CREATE (sla:Attribute {name: "sla", type: "ServiceLevelAgreement", required: true, description: "Service level agreement details"});
CREATE (dependencies:Attribute {name: "dependencies", type: "List<UUID>", required: false, description: "Other services this service depends on"});

// Connect attributes to ITService
CREATE (itService)-[:HAS_ATTRIBUTE]->(serviceId);
CREATE (itService)-[:HAS_ATTRIBUTE]->(serviceName);
CREATE (itService)-[:HAS_ATTRIBUTE]->(serviceDescription);
CREATE (itService)-[:HAS_ATTRIBUTE]->(serviceLevel);
CREATE (itService)-[:HAS_ATTRIBUTE]->(pricing);
CREATE (itService)-[:HAS_ATTRIBUTE]->(sla);
CREATE (itService)-[:HAS_ATTRIBUTE]->(dependencies);

// Define ITService events
CREATE (serviceCreated:Event {name: "ServiceCreated", description: "Triggered when a new service is created"});
CREATE (serviceUpdated:Event {name: "ServiceUpdated", description: "Triggered when a service is updated"});
CREATE (serviceActivated:Event {name: "ServiceActivated", description: "Triggered when a service is activated for a client"});
CREATE (serviceDeactivated:Event {name: "ServiceDeactivated", description: "Triggered when a service is deactivated"});
CREATE (serviceLevelChanged:Event {name: "ServiceLevelChanged", description: "Triggered when a service level is changed"});

// Connect events to ITService
CREATE (itService)-[:PUBLISHES]->(serviceCreated);
CREATE (itService)-[:PUBLISHES]->(serviceUpdated);
CREATE (itService)-[:PUBLISHES]->(serviceActivated);
CREATE (itService)-[:PUBLISHES]->(serviceDeactivated);
CREATE (itService)-[:PUBLISHES]->(serviceLevelChanged);

// Define ITService behaviors
CREATE (serviceProvisioning:Behavior {name: "serviceProvisioning", description: "Handles service provisioning and setup"});
CREATE (serviceBilling:Behavior {name: "serviceBilling", description: "Handles service billing and invoicing"});
CREATE (serviceMonitoring:Behavior {name: "serviceMonitoring", description: "Monitors service health and performance"});

// Connect behaviors to ITService
CREATE (itService)-[:EXHIBITS]->(serviceProvisioning);
CREATE (itService)-[:EXHIBITS]->(serviceBilling);
CREATE (itService)-[:EXHIBITS]->(serviceMonitoring);

// Define ManagedCloudHosting domain object extending ITService
CREATE (managedCloudHosting:DomainObject:VerticalObject:ManagedCloudHosting {
  name: "ManagedCloudHosting",
  description: "Represents managed cloud hosting services",
  category: "Vertical",
  domain: "ITServices",
  extends: "ITService"
});

// Define ManagedCloudHosting attributes
CREATE (cloudProvider:Attribute {name: "cloudProvider", type: "Enum", required: true, description: "Cloud provider (AWS, Azure, GCP, etc.)"});
CREATE (resources:Attribute {name: "resources", type: "ComputeResources", required: true, description: "Allocated compute resources"});
CREATE (backupPolicy:Attribute {name: "backupPolicy", type: "BackupPolicy", required: true, description: "Backup frequency and retention"});
CREATE (environmentType:Attribute {name: "environmentType", type: "Enum", required: true, description: "Type of environment (Production, Staging, Development, etc.)"});
CREATE (securityMeasures:Attribute {name: "securityMeasures", type: "List<SecurityMeasure>", required: true, description: "Security measures implemented"});

// Connect attributes to ManagedCloudHosting
CREATE (managedCloudHosting)-[:HAS_ATTRIBUTE]->(cloudProvider);
CREATE (managedCloudHosting)-[:HAS_ATTRIBUTE]->(resources);
CREATE (managedCloudHosting)-[:HAS_ATTRIBUTE]->(backupPolicy);
CREATE (managedCloudHosting)-[:HAS_ATTRIBUTE]->(environmentType);
CREATE (managedCloudHosting)-[:HAS_ATTRIBUTE]->(securityMeasures);

// Define ManagedCloudHosting specific events
CREATE (resourcesScaled:Event {name: "ResourcesScaled", description: "Triggered when compute resources are scaled"});
CREATE (backupCompleted:Event {name: "BackupCompleted", description: "Triggered when a backup is completed"});
CREATE (securityIncidentDetected:Event {name: "SecurityIncidentDetected", description: "Triggered when a security incident is detected"});

// Connect events to ManagedCloudHosting
CREATE (managedCloudHosting)-[:PUBLISHES]->(resourcesScaled);
CREATE (managedCloudHosting)-[:PUBLISHES]->(backupCompleted);
CREATE (managedCloudHosting)-[:PUBLISHES]->(securityIncidentDetected);

// Define ManagedCloudHosting specific behaviors
CREATE (resourceScaling:Behavior {name: "resourceScaling", description: "Handles automatic resource scaling"});
CREATE (backupManagement:Behavior {name: "backupManagement", description: "Manages backups and restoration"});
CREATE (securityManagement:Behavior {name: "securityManagement", description: "Manages security and compliance"});

// Connect behaviors to ManagedCloudHosting
CREATE (managedCloudHosting)-[:EXHIBITS]->(resourceScaling);
CREATE (managedCloudHosting)-[:EXHIBITS]->(backupManagement);
CREATE (managedCloudHosting)-[:EXHIBITS]->(securityManagement);

// Define inheritance relationship
CREATE (itServiceRef:DomainObject:VerticalObject:ITService {name: "ITService"});
CREATE (managedCloudHosting)-[:EXTENDS]->(itServiceRef);

// Define HardwareService domain object extending ITService
CREATE (hardwareService:DomainObject:VerticalObject:HardwareService {
  name: "HardwareService",
  description: "Represents hardware-related IT services",
  category: "Vertical",
  domain: "ITServices",
  extends: "ITService"
});

// Define HardwareService attributes
CREATE (hardwareType:Attribute {name: "hardwareType", type: "Enum", required: true, description: "Type of hardware service (Workstation, Server, Network, etc.)"});
CREATE (deviceInventory:Attribute {name: "deviceInventory", type: "List<DeviceRecord>", required: true, description: "Inventory of managed devices"});
CREATE (maintenanceSchedule:Attribute {name: "maintenanceSchedule", type: "MaintenanceSchedule", required: true, description: "Schedule for routine maintenance"});
CREATE (supportLevel:Attribute {name: "supportLevel", type: "Enum", required: true, description: "Level of support provided (Remote, Onsite, 24/7, etc.)"});
CREATE (warrantyInfo:Attribute {name: "warrantyInfo", type: "List<WarrantyRecord>", required: false, description: "Warranty information for devices"});

// Connect attributes to HardwareService
CREATE (hardwareService)-[:HAS_ATTRIBUTE]->(hardwareType);
CREATE (hardwareService)-[:HAS_ATTRIBUTE]->(deviceInventory);
CREATE (hardwareService)-[:HAS_ATTRIBUTE]->(maintenanceSchedule);
CREATE (hardwareService)-[:HAS_ATTRIBUTE]->(supportLevel);
CREATE (hardwareService)-[:HAS_ATTRIBUTE]->(warrantyInfo);

// Define inheritance relationship
CREATE (hardwareService)-[:EXTENDS]->(itServiceRef);

// Define SoftwareDevelopment domain object extending ITService
CREATE (softwareDevelopment:DomainObject:VerticalObject:SoftwareDevelopment {
  name: "SoftwareDevelopment",
  description: "Represents software development services",
  category: "Vertical",
  domain: "ITServices",
  extends: "ITService"
});

// Define SoftwareDevelopment attributes
CREATE (developmentType:Attribute {name: "developmentType", type: "Enum", required: true, description: "Type of development (Web, Mobile, Desktop, etc.)"});
CREATE (technologies:Attribute {name: "technologies", type: "List<Technology>", required: true, description: "Technologies used in development"});
CREATE (methodology:Attribute {name: "methodology", type: "Enum", required: true, description: "Development methodology (Agile, Waterfall, etc.)"});
CREATE (projectPlan:Attribute {name: "projectPlan", type: "ProjectPlan", required: true, description: "Development project plan"});
CREATE (codeRepository:Attribute {name: "codeRepository", type: "RepositoryInfo", required: true, description: "Code repository information"});
CREATE (testingStrategy:Attribute {name: "testingStrategy", type: "TestingStrategy", required: true, description: "Strategy for testing the software"});

// Connect attributes to SoftwareDevelopment
CREATE (softwareDevelopment)-[:HAS_ATTRIBUTE]->(developmentType);
CREATE (softwareDevelopment)-[:HAS_ATTRIBUTE]->(technologies);
CREATE (softwareDevelopment)-[:HAS_ATTRIBUTE]->(methodology);
CREATE (softwareDevelopment)-[:HAS_ATTRIBUTE]->(projectPlan);
CREATE (softwareDevelopment)-[:HAS_ATTRIBUTE]->(codeRepository);
CREATE (softwareDevelopment)-[:HAS_ATTRIBUTE]->(testingStrategy);

// Define SoftwareDevelopment specific events
CREATE (codeCommitted:Event {name: "CodeCommitted", description: "Triggered when code is committed"});
CREATE (buildCompleted:Event {name: "BuildCompleted", description: "Triggered when a build is completed"});
CREATE (testsPassed:Event {name: "TestsPassed", description: "Triggered when tests pass"});
CREATE (deploymentCompleted:Event {name: "DeploymentCompleted", description: "Triggered when deployment is completed"});

// Connect events to SoftwareDevelopment
CREATE (softwareDevelopment)-[:PUBLISHES]->(codeCommitted);
CREATE (softwareDevelopment)-[:PUBLISHES]->(buildCompleted);
CREATE (softwareDevelopment)-[:PUBLISHES]->(testsPassed);
CREATE (softwareDevelopment)-[:PUBLISHES]->(deploymentCompleted);

// Define inheritance relationship
CREATE (softwareDevelopment)-[:EXTENDS]->(itServiceRef);

// Define InfrastructureDevelopment domain object extending ITService
CREATE (infrastructureDevelopment:DomainObject:VerticalObject:InfrastructureDevelopment {
  name: "InfrastructureDevelopment",
  description: "Represents infrastructure development services",
  category: "Vertical",
  domain: "ITServices",
  extends: "ITService"
});

// Define InfrastructureDevelopment attributes
CREATE (infrastructureType:Attribute {name: "infrastructureType", type: "Enum", required: true, description: "Type of infrastructure (Network, Server, Cloud, Hybrid, etc.)"});
CREATE (deploymentModel:Attribute {name: "deploymentModel", type: "Enum", required: true, description: "Deployment model (IaaS, PaaS, SaaS, etc.)"});
CREATE (automationLevel:Attribute {name: "automationLevel", type: "Enum", required: true, description: "Level of automation in infrastructure"});
CREATE (infrastructureAsCode:Attribute {name: "infrastructureAsCode", type: "Boolean", required: true, description: "Whether infrastructure is managed as code"});
CREATE (scalabilityPlan:Attribute {name: "scalabilityPlan", type: "ScalabilityPlan", required: true, description: "Plan for scaling infrastructure"});

// Connect attributes to InfrastructureDevelopment
CREATE (infrastructureDevelopment)-[:HAS_ATTRIBUTE]->(infrastructureType);
CREATE (infrastructureDevelopment)-[:HAS_ATTRIBUTE]->(deploymentModel);
CREATE (infrastructureDevelopment)-[:HAS_ATTRIBUTE]->(automationLevel);
CREATE (infrastructureDevelopment)-[:HAS_ATTRIBUTE]->(infrastructureAsCode);
CREATE (infrastructureDevelopment)-[:HAS_ATTRIBUTE]->(scalabilityPlan);

// Define inheritance relationship
CREATE (infrastructureDevelopment)-[:EXTENDS]->(itServiceRef);

// Define BusinessIntegration domain object extending ITService
CREATE (businessIntegration:DomainObject:VerticalObject:BusinessIntegration {
  name: "BusinessIntegration",
  description: "Represents business integration services",
  category: "Vertical",
  domain: "ITServices",
  extends: "ITService"
});

// Define BusinessIntegration attributes
CREATE (integrationType:Attribute {name: "integrationType", type: "Enum", required: true, description: "Type of integration (API, Data, Process, etc.)"});
CREATE (systemsIntegrated:Attribute {name: "systemsIntegrated", type: "List<SystemReference>", required: true, description: "Systems being integrated"});
CREATE (dataFlowMaps:Attribute {name: "dataFlowMaps", type: "List<DataFlowMap>", required: true, description: "Maps of data flows between systems"});
CREATE (transformationRules:Attribute {name: "transformationRules", type: "List<TransformationRule>", required: true, description: "Data transformation rules"});
CREATE (integrationPlatform:Attribute {name: "integrationPlatform", type: "Enum", required: false, description: "Platform used for integration"});

// Connect attributes to BusinessIntegration
CREATE (businessIntegration)-[:HAS_ATTRIBUTE]->(integrationType);
CREATE (businessIntegration)-[:HAS_ATTRIBUTE]->(systemsIntegrated);
CREATE (businessIntegration)-[:HAS_ATTRIBUTE]->(dataFlowMaps);
CREATE (businessIntegration)-[:HAS_ATTRIBUTE]->(transformationRules);
CREATE (businessIntegration)-[:HAS_ATTRIBUTE]->(integrationPlatform);

// Define BusinessIntegration specific events
CREATE (integrationCompleted:Event {name: "IntegrationCompleted", description: "Triggered when an integration is completed"});
CREATE (dataTransferred:Event {name: "DataTransferred", description: "Triggered when data is transferred between systems"});
CREATE (transformationApplied:Event {name: "TransformationApplied", description: "Triggered when a data transformation is applied"});

// Connect events to BusinessIntegration
CREATE (businessIntegration)-[:PUBLISHES]->(integrationCompleted);
CREATE (businessIntegration)-[:PUBLISHES]->(dataTransferred);
CREATE (businessIntegration)-[:PUBLISHES]->(transformationApplied);

// Define inheritance relationship
CREATE (businessIntegration)-[:EXTENDS]->(itServiceRef);

// Define Client domain object (extends Organization)
CREATE (client:DomainObject:VerticalObject:Client {
  name: "Client",
  description: "Represents a client of IT services",
  category: "Vertical",
  domain: "ITServices",
  extends: "Organization"
});

// Define Client attributes
CREATE (clientId:Attribute {name: "clientId", type: "UUID", required: true, description: "Unique identifier for the client"});
CREATE (serviceAgreements:Attribute {name: "serviceAgreements", type: "List<ServiceAgreement>", required: true, description: "Service agreements with the client"});
CREATE (activeServices:Attribute {name: "activeServices", type: "List<ServiceReference>", required: true, description: "Currently active services for the client"});
CREATE (technicalContacts:Attribute {name: "technicalContacts", type: "List<ContactInfo>", required: true, description: "Technical contacts at the client organization"});
CREATE (billingInfo:Attribute {name: "billingInfo", type: "BillingInfo", required: true, description: "Billing information for the client"});

// Connect attributes to Client
CREATE (client)-[:HAS_ATTRIBUTE]->(clientId);
CREATE (client)-[:HAS_ATTRIBUTE]->(serviceAgreements);
CREATE (client)-[:HAS_ATTRIBUTE]->(activeServices);
CREATE (client)-[:HAS_ATTRIBUTE]->(technicalContacts);
CREATE (client)-[:HAS_ATTRIBUTE]->(billingInfo);

// Define inheritance relationship from Organization
CREATE (organizationRef:DomainObject:Organization {name: "Organization"});
CREATE (client)-[:EXTENDS]->(organizationRef);

// Define relationships between objects
CREATE (clientToService:Relationship {name: "SUBSCRIBES_TO", description: "Indicates a client subscribes to a service"});
CREATE (serviceToClient:Relationship {name: "PROVIDED_TO", description: "Indicates a service is provided to a client"});

// Connect relationships
CREATE (client)-[:PARTICIPATES_IN]->(clientToService);
CREATE (itService)-[:PARTICIPATES_IN]->(serviceToClient); 