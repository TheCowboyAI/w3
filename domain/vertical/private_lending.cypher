// Private Lending Domain Objects in Cypher Format
// This file defines primary domain objects for the Private Lending vertical market

// Define LoanApplication domain object
CREATE (loanApplication:DomainObject:VerticalObject:LoanApplication {
  name: "LoanApplication",
  description: "Represents a private loan application in the lending domain",
  category: "Vertical",
  domain: "PrivateLending"
});

// Define LoanApplication attributes
CREATE (loanId:Attribute {name: "loanId", type: "UUID", required: true, description: "Unique identifier for the loan application"});
CREATE (borrowerId:Attribute {name: "borrowerId", type: "UUID", required: true, description: "Reference to the person or organization borrowing"});
CREATE (lenderIds:Attribute {name: "lenderIds", type: "List<UUID>", required: false, description: "References to potential or actual lenders"});
CREATE (loanAmount:Attribute {name: "loanAmount", type: "Currency", required: true, description: "Requested loan amount"});
CREATE (interestRate:Attribute {name: "interestRate", type: "Percentage", required: false, description: "Interest rate for the loan"});
CREATE (loanTerm:Attribute {name: "loanTerm", type: "Duration", required: true, description: "Duration of the loan (typically 6-12 months)"});
CREATE (collateral:Attribute {name: "collateral", type: "PropertyAsset", required: true, description: "Property being used as collateral"});
CREATE (loanType:Attribute {name: "loanType", type: "Enum", required: true, description: "Type of private loan (mortgage, business, personal, etc.)"});
CREATE (loanPurpose:Attribute {name: "loanPurpose", type: "String", required: true, description: "Intended use of the loan funds"});
CREATE (applicationStatus:Attribute {name: "applicationStatus", type: "Enum", required: true, description: "Current status of the application"});

// Connect attributes to LoanApplication
CREATE (loanApplication)-[:HAS_ATTRIBUTE]->(loanId);
CREATE (loanApplication)-[:HAS_ATTRIBUTE]->(borrowerId);
CREATE (loanApplication)-[:HAS_ATTRIBUTE]->(lenderIds);
CREATE (loanApplication)-[:HAS_ATTRIBUTE]->(loanAmount);
CREATE (loanApplication)-[:HAS_ATTRIBUTE]->(interestRate);
CREATE (loanApplication)-[:HAS_ATTRIBUTE]->(loanTerm);
CREATE (loanApplication)-[:HAS_ATTRIBUTE]->(collateral);
CREATE (loanApplication)-[:HAS_ATTRIBUTE]->(loanType);
CREATE (loanApplication)-[:HAS_ATTRIBUTE]->(loanPurpose);
CREATE (loanApplication)-[:HAS_ATTRIBUTE]->(applicationStatus);

// Define LoanApplication events
CREATE (loanApplicationCreated:Event {name: "LoanApplicationCreated", description: "Triggered when a new loan application is created"});
CREATE (loanApplicationUpdated:Event {name: "LoanApplicationUpdated", description: "Triggered when a loan application is updated"});
CREATE (loanApplicationApproved:Event {name: "LoanApplicationApproved", description: "Triggered when a loan application is approved"});
CREATE (loanApplicationRejected:Event {name: "LoanApplicationRejected", description: "Triggered when a loan application is rejected"});
CREATE (loanFunded:Event {name: "LoanFunded", description: "Triggered when a loan is funded"});

// Connect events to LoanApplication
CREATE (loanApplication)-[:PUBLISHES]->(loanApplicationCreated);
CREATE (loanApplication)-[:PUBLISHES]->(loanApplicationUpdated);
CREATE (loanApplication)-[:PUBLISHES]->(loanApplicationApproved);
CREATE (loanApplication)-[:PUBLISHES]->(loanApplicationRejected);
CREATE (loanApplication)-[:PUBLISHES]->(loanFunded);

// Define LoanApplication behaviors
CREATE (applicationProcessing:Behavior {name: "applicationProcessing", description: "Processes loan applications through approval workflow"});
CREATE (riskAssessment:Behavior {name: "riskAssessment", description: "Evaluates loan risk based on collateral and terms"});
CREATE (lenderMatching:Behavior {name: "lenderMatching", description: "Matches loans with appropriate lenders based on criteria"});

// Connect behaviors to LoanApplication
CREATE (loanApplication)-[:EXHIBITS]->(applicationProcessing);
CREATE (loanApplication)-[:EXHIBITS]->(riskAssessment);
CREATE (loanApplication)-[:EXHIBITS]->(lenderMatching);

// Define relationships with other domain objects
CREATE (applicationToBorrower:Relationship {name: "SUBMITTED_BY", description: "Indicates which borrower submitted the application"});
CREATE (applicationToLender:Relationship {name: "FUNDED_BY", description: "Indicates which lender funded the loan"});
CREATE (applicationToProperty:Relationship {name: "SECURED_BY", description: "Indicates the property securing the loan"});

// Connect relationships to LoanApplication
CREATE (loanApplication)-[:PARTICIPATES_IN]->(applicationToBorrower);
CREATE (loanApplication)-[:PARTICIPATES_IN]->(applicationToLender);
CREATE (loanApplication)-[:PARTICIPATES_IN]->(applicationToProperty);

// Define PropertyAsset domain object
CREATE (propertyAsset:DomainObject:VerticalObject:PropertyAsset {
  name: "PropertyAsset",
  description: "Represents a property asset used as collateral in private lending",
  category: "Vertical",
  domain: "PrivateLending"
});

// Define PropertyAsset attributes
CREATE (propertyId:Attribute {name: "propertyId", type: "UUID", required: true, description: "Unique identifier for the property"});
CREATE (propertyAddress:Attribute {name: "propertyAddress", type: "Address", required: true, description: "Physical address of the property"});
CREATE (propertyType:Attribute {name: "propertyType", type: "Enum", required: true, description: "Type of property (residential, commercial, industrial, etc.)"});
CREATE (propertyValue:Attribute {name: "propertyValue", type: "Currency", required: true, description: "Appraised value of the property"});
CREATE (condition:Attribute {name: "condition", type: "Enum", required: true, description: "Current condition of the property"});
CREATE (lienStatus:Attribute {name: "lienStatus", type: "String", required: true, description: "Information about existing liens on the property"});

// Connect attributes to PropertyAsset
CREATE (propertyAsset)-[:HAS_ATTRIBUTE]->(propertyId);
CREATE (propertyAsset)-[:HAS_ATTRIBUTE]->(propertyAddress);
CREATE (propertyAsset)-[:HAS_ATTRIBUTE]->(propertyType);
CREATE (propertyAsset)-[:HAS_ATTRIBUTE]->(propertyValue);
CREATE (propertyAsset)-[:HAS_ATTRIBUTE]->(condition);
CREATE (propertyAsset)-[:HAS_ATTRIBUTE]->(lienStatus);

// Define PrivateLender domain object extending Organization
CREATE (privateLender:DomainObject:VerticalObject:PrivateLender {
  name: "PrivateLender",
  description: "Represents a private lending entity that provides asset-backed financing",
  category: "Vertical",
  domain: "PrivateLending",
  extends: "Organization"
});

// Define PrivateLender attributes beyond those inherited from Organization
CREATE (lenderLicense:Attribute {name: "lenderLicense", type: "String", required: false, description: "Lending license identifier if applicable"});
CREATE (lendingCriteria:Attribute {name: "lendingCriteria", type: "LendingCriteria", required: true, description: "Criteria for evaluating loan applications"});
CREATE (availableFunds:Attribute {name: "availableFunds", type: "Currency", required: true, description: "Funds available for lending"});
CREATE (activeLoanCount:Attribute {name: "activeLoanCount", type: "Integer", required: true, description: "Number of active loans in portfolio"});
CREATE (loanPortfolioValue:Attribute {name: "loanPortfolioValue", type: "Currency", required: true, description: "Total value of loan portfolio"});

// Connect attributes to PrivateLender
CREATE (privateLender)-[:HAS_ATTRIBUTE]->(lenderLicense);
CREATE (privateLender)-[:HAS_ATTRIBUTE]->(lendingCriteria);
CREATE (privateLender)-[:HAS_ATTRIBUTE]->(availableFunds);
CREATE (privateLender)-[:HAS_ATTRIBUTE]->(activeLoanCount);
CREATE (privateLender)-[:HAS_ATTRIBUTE]->(loanPortfolioValue);

// Define PrivateLender events
CREATE (lenderRegistered:Event {name: "LenderRegistered", description: "Triggered when a new private lender is registered"});
CREATE (lenderUpdated:Event {name: "LenderUpdated", description: "Triggered when a lender's information is updated"});
CREATE (loanFunded:Event {name: "LoanFunded", description: "Triggered when a lender funds a loan"});

// Connect events to PrivateLender
CREATE (privateLender)-[:PUBLISHES]->(lenderRegistered);
CREATE (privateLender)-[:PUBLISHES]->(lenderUpdated);
CREATE (privateLender)-[:PUBLISHES]->(loanFunded);

// Define inheritance relationship from Organization
CREATE (organizationRef:DomainObject:Organization {name: "Organization"});
CREATE (privateLender)-[:EXTENDS]->(organizationRef);

// Define Borrower domain object extending Person
CREATE (borrower:DomainObject:VerticalObject:Borrower {
  name: "Borrower",
  description: "Represents a borrower in the private lending context",
  category: "Vertical",
  domain: "PrivateLending",
  extends: "Person"
});

// Define Borrower attributes beyond those inherited from Person
CREATE (creditScore:Attribute {name: "creditScore", type: "Integer", required: false, description: "Borrower's credit score"});
CREATE (incomeVerification:Attribute {name: "incomeVerification", type: "Document", required: false, description: "Income verification documents"});
CREATE (borrowingHistory:Attribute {name: "borrowingHistory", type: "List<LoanReference>", required: false, description: "History of previous loans"});
CREATE (activeLoans:Attribute {name: "activeLoans", type: "List<LoanReference>", required: true, description: "Currently active loans"});

// Connect attributes to Borrower
CREATE (borrower)-[:HAS_ATTRIBUTE]->(creditScore);
CREATE (borrower)-[:HAS_ATTRIBUTE]->(incomeVerification);
CREATE (borrower)-[:HAS_ATTRIBUTE]->(borrowingHistory);
CREATE (borrower)-[:HAS_ATTRIBUTE]->(activeLoans);

// Define Borrower events
CREATE (borrowerRegistered:Event {name: "BorrowerRegistered", description: "Triggered when a new borrower is registered"});
CREATE (borrowerProfileUpdated:Event {name: "BorrowerProfileUpdated", description: "Triggered when a borrower's profile is updated"});
CREATE (loanRequested:Event {name: "LoanRequested", description: "Triggered when a borrower requests a loan"});

// Connect events to Borrower
CREATE (borrower)-[:PUBLISHES]->(borrowerRegistered);
CREATE (borrower)-[:PUBLISHES]->(borrowerProfileUpdated);
CREATE (borrower)-[:PUBLISHES]->(loanRequested);

// Define inheritance relationship from Person
CREATE (personRef:DomainObject:Person {name: "Person"});
CREATE (borrower)-[:EXTENDS]->(personRef); 