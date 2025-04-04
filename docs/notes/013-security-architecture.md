# Design Decision: Security Architecture

## Decision ID: 013

**Date**: 2023-04-06  
**Status**: Approved  
**Deciders**: Core Architecture Team  

## Context

The CIM system requires a robust security architecture that addresses authentication, encryption, signing, and access control. As a system handling potentially sensitive information across distributed components, we need a comprehensive security model that:

- Ensures secure communication between all system components
- Provides strong authentication mechanisms for users and services
- Enables secure signing of events and documents
- Implements proper access controls for system resources
- Secures the NATS messaging infrastructure that underpins our system
- Supports air-gapped key generation for maximum security
- Allows for key rotation while maintaining system integrity

## Decision

We will implement a multi-layered security architecture based on a Root Certificate Authority (CA) with hardware-based key management using YubiKeys. The architecture will have the following key components:

### 1. Root Certificate Authority

We will establish a Root CA with the following characteristics:
- Generated in an air-gapped environment for maximum security
- Comprises a core private key, authentication key, encryption key, and signing key
- Used to sign the CIM's TLS certificates and establish trust
- Used to initialize the NATS message store with appropriate tools (nsc)
- Backed by a secure key management process using YubiKeys

### 2. YubiKey Integration

YubiKeys will serve as secure hardware devices for:
- Storing the Root CA's Certify Key in a non-exportable format
- Providing authentication (via PIV functionality)
- Enabling digital signing operations
- Supporting Single Sign-On (SSO) capabilities
- Ensuring the physical security of cryptographic material

### 3. Key Hierarchy

Our key hierarchy will consist of:
1. **Root CA Key**: The ultimate trust anchor, kept secure and used minimally
2. **Intermediate CA Keys**: For signing service certificates, allowing for segmentation and rotation
3. **Service Keys**: For individual services to authenticate and communicate
4. **User Keys**: For authentication and authorization of system users

### 4. Certificate Infrastructure

The certificate infrastructure will include:
- X.509 certificates for TLS/SSL encryption
- ED25519-based certificates for optimal security and performance
- Service-specific certificates for individual CIM services
- Client certificates for mutual TLS authentication where appropriate

### 5. Authentication Framework

The authentication framework will:
- Support multiple authentication methods (YubiKey, certificates, traditional passwords)
- Implement role-based access control (RBAC)
- Enforce the principle of least privilege
- Enable Single Sign-On (SSO) capabilities
- Integrate with the NATS security framework

### 6. Secure Communication

All communication in the CIM system will be secured through:
- TLS encryption for all NATS traffic
- Mutual TLS authentication for service-to-service communication
- Signed events in the event store with verification
- Encryption of sensitive data at rest

### 7. Key Management Processes

We will establish secure processes for:
- Air-gapped generation of the Root CA
- Secure backup and recovery procedures
- Key rotation and revocation procedures
- YubiKey initialization in controlled environments
- Secure storage of backup materials

## Implementation Approach

### YubiKey Initialization Process

The secure initialization of YubiKeys will follow these steps:

1. **Secure Environment Setup**:
   - Use a Nix Flake configuration to create a bootable USB or SD card
   - Establish an air-gapped environment with minimal, necessary tools
   - Disable or remove all network functions

2. **Identity Configuration**:
   - Configure identity information (name, email, organization details)
   - Include SSL, TLS, and CSR requirements

3. **Key Generation**:
   - Use ED25519 cryptographic standard
   - Create a non-revocable, non-expiring Certify Key on the YubiKey
   - Generate dependent keys for certification, encryption, authorization, and signing
   - Create SSH keypairs for secure shell access
   - Generate SSL/TLS certificates (Root CA, X.509)

4. **Multi-YubiKey Setup**:
   - Configure multiple YubiKeys with identical shared keys
   - Uniquely identify each device by serial number
   - Ensure continuity if a YubiKey is lost or damaged

### NATS Security Configuration

The NATS messaging system will be secured with:

1. **TLS Encryption**:
   - All NATS traffic encrypted using TLS
   - Certificates signed by our Root CA

2. **Authentication**:
   - User authentication via credentials or certificates
   - Service authentication via certificates

3. **Authorization**:
   - Fine-grained permissions on NATS subjects
   - Account-based isolation for different system components

4. **Secure JetStream**:
   - Encrypted streams for the event store
   - Signed events with verification
   - Access controls on object store operations

### User and Service Authentication

1. **User Authentication**:
   - Primary method: YubiKey-based authentication
   - Alternative: Certificate-based authentication
   - Fallback: Username/password with multi-factor authentication

2. **Service Authentication**:
   - Certificate-based mutual TLS authentication
   - Service-specific credentials with limited permissions
   - Automated certificate rotation

## Architecture Implications

- All components must support TLS/SSL encryption
- Services must validate certificates against our CA chain
- NATS configuration must enforce security constraints
- User interfaces must support YubiKey-based authentication
- Event signing and verification must be implemented throughout the system
- Secure key management processes must be established and followed
- Air-gapped environment must be available for initial key generation

## Consequences

### Positive

- **Enhanced Security**: Hardware-based security provides strong protection
- **Non-Repudiation**: Signed events provide audit trail and accountability
- **Defense in Depth**: Multiple security layers provide robust protection
- **Scalable Security**: Security model scales with system growth
- **Future-Proof**: ED25519 offers long-term security advantages
- **Compliance**: Addresses requirements for regulated industries
- **Simplified Authentication**: YubiKey provides streamlined user experience
- **Secure Messaging**: NATS with proper security ensures safe communication
- **Key Rotation**: Structured approach to key rotation maintains security over time

### Negative

- **Implementation Complexity**: Security infrastructure adds complexity
- **Administrative Overhead**: Key management requires careful processes
- **Hardware Dependency**: Reliance on YubiKeys requires physical hardware
- **Cost Considerations**: Hardware security devices add cost
- **Usability Challenges**: More secure systems can be less convenient
- **Recovery Procedures**: Need robust recovery procedures for lost keys
- **Learning Curve**: Team needs understanding of cryptographic principles

## Related Decisions

- [002: NATS JetStream Dual Role](002-nats-jetstream-dual-role.md)
- [003: NixOS Hyper-Converged Implementation](003-nixos-hyperconverged-implementation.md)
- [011: IPLD Content-Addressable Storage](011-ipld-content-addressable-storage.md)
- [012: Primary User Interfaces](012-primary-user-interfaces.md)

## Notes

This security architecture provides a robust foundation for the CIM system, addressing authentication, encryption, and access control needs. The YubiKey-based approach offers strong hardware security while maintaining usability.

The air-gapped initialization process for the Root CA ensures maximum security for our trust anchor. By maintaining a clear separation between the Root CA (used minimally) and Intermediate CAs (used for day-to-day operations), we follow security best practices for certificate authorities.

The integration with NATS security features ensures that our messaging backbone—which is central to the CIM architecture—is properly secured with encryption, authentication, and authorization. This is particularly important for the event store and object store functionality provided by JetStream.

For our primary user interfaces (Native, Web, and Mobile), the YubiKey-based authentication provides a consistent and secure authentication mechanism across platforms. The Web interface will require WebAuthn support, which is now widely available in modern browsers.

The processes outlined for YubiKey initialization, including the air-gapped environment and backup procedures, ensure that our cryptographic foundations are secure while also providing disaster recovery options if hardware is lost or damaged. 