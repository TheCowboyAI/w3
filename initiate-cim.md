## 🚀 Overview

This document guides the creation of a Composable Information Machine (CIM) Leaf Node - a NixOS-based system that:

1. Tracks and manages its own hardware as configurable inputs/outputs
2. Uses NixOS for deterministic hardware configuration
3. Uses Facter to gather remote hardware facts
4. Defines a Flake Configuration for the system
5. Functions as a host for nixos-containers
6. Uses NATS Jetstream for communication between components
7. Uses Object Store and Event Store for Domain Events
8. Scales by communicating with other Domain nats servers

## 📋 Project Initialization Steps

### Step 1: Project Structure Setup

Add the following directory structure:

```
cim-leaf/
├── flake.nix
├── README.md
├── hosts/
│   ├── <servicetag>
│   └── default.nix
├── modules/
│   ├── hm
│   |   └── default.nix
│   ├── configuration.nix
│   ├── hardware-configuration.nix
│   ├── system.nix
│   ├── packages.nix
│   ├── gui.nix
│   ├── services.nix
│   ├── containers.nix
│   └── networking.nix
├── containers/
│   └── nats/
│       ├── default.nix
│       ├── security.nix
│       └── jetstream.nix
├── docs/
├── secrets/
├── src/
|   └── <code>
├── tests/
├── features/
|   ├── steps/
|   └── support/
└── users/
    ├── root/
    └── cim/
```

### Step 1: NixOS Configuration

1. Create a flake.nix with:
   - NixOS modules for hardware detection and management
   - nix-topology, nixos-facter, nixos-anywhere, extra-container, nix-inspect, disko
   - nixos-container management
   - NATS integration
   - Developer Shell

2. Set up hardware autodiscovery to:
   - Scan and catalog available hardware on remote system
   - Generate hardware configuration
   - Store hardware state persistently
   - Provide interfaces for hardware reconfiguration

3. Implement container infrastructure:
   - Define container management API
   - use nixos-containers
   - Ensure container networking is isolated and secure using only nats as a connector
   - Setup resource limits and monitoring

### Step 3: Communication Layer

1. Implement NATS Jetstream:
   - Configure NATS server for component communication
   - Set up authentication and authorization
   - Define message schemas and validation
   - Create persistent streams for state preservation

2. Develop communication patterns:
   - Request/reply patterns for commands
   - Pub/sub for events and notifications
   - Queue groups for load balancing

### Step 4: Hardware Management

1. Create interfaces for:
   - Hardware discovery
   - Hardware state tracking
   - Configuration validation
   - State change application

2. Implement hardware abstraction to:
   - Normalize hardware interfaces
   - Provide consistent API for varied hardware
   - Support hardware hot-swapping where possible

### Step 5: Container Orchestration

1. Develop tools for:
   - Container lifecycle management
   - Container networking configuration
   - Service discovery
   - Health monitoring

2. Create container templates for common services

## 🛠️ Implementation Guidelines

### NixOS Configuration Best Practices

1. Use `config.lib.mkIf` for conditional configuration
2. Organize options by functional area
3. Provide defaults that are secure by design
4. Document all options thoroughly

### Hardware Management

1. Use udev rules for dynamic hardware changes
2. Implement persistent tracking with device identifiers
3. Create hardware profiles for common configurations
4. Support declarative hardware configuration

### Communication Layer

1. Use NATS JetStream for message persistence
2. Implement message versioning
3. Define schemas for all message types
4. Use subject hierarchies for routing

### Container Management

1. Use network namespaces for isolation
2. Implement resource limits with cgroups
3. Provide automatic DNS resolution for containers
4. Support for container migration

## 🧪 Testing Strategy

1. Hardware detection tests with varied hardware profiles
2. Communication reliability tests with network partition simulation
3. Container lifecycle tests with rapid creation/destruction
4. System recovery tests simulating hardware failures
5. Acceptance Tests for expected features

## 📚 Documentation Requirements

1. System architecture overview
2. Hardware compatibility list
3. Container management API documentation
4. Message format specifications
5. Troubleshooting guides

## 🔄 Iteration Plan

1. Build minimum viable system with basic hardware detection at a fixed IP
2. Implement NATS communication layer
3. Add container framework with simple containers
4. Expand hardware management capabilities
5. Enhance container orchestration features

## 🎯 Success Criteria

1. System automatically detects and configures hardware as inputs/outputs
2. Containers can be created, destroyed, and managed via API over nats
3. Components can communicate via NATS Jetstream
4. System state is persistent across reboots
5. Security through tls and gpg/ssh keys and jwts over nats
6. Hardware changes are detected and handled automatically 
7. Event Store holds sequential list of changes