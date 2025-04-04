# Design Decision: Business Focus and Hybrid Cloud Approach

## Decision ID: 004

**Date**: 2023-04-05  
**Status**: Approved  
**Deciders**: Core Architecture Team  

## Context

The CIM system is being designed in a market environment where:
- Cloud solutions are becoming increasingly expensive
- Business dependency on external cloud providers is growing
- Medium-sized businesses have specialized workflow needs
- Commodity hardware offers significant cost advantages
- Organizations seek greater control over their data
- Hybrid approaches provide flexibility without full cloud dependency

To position CIM effectively, we need to clearly define our target audience and approach to cloud resources.

## Decision

We will focus CIM specifically on medium-sized businesses with these key principles:

1. **Primary Audience**: Medium-sized businesses that need:
   - Specialized software workflows
   - Solutions running on commodity hardware
   - Alternatives to increasingly expensive cloud services
   - Control over their data and processing

2. **Scaling Approach**:
   - Start with a single hyper-converged Leaf Node
   - Scale to a 3-Node Cluster when needed
   - Further scale to a Super Cluster for larger deployments
   - Progressive growth path aligned with business needs

3. **Hybrid Cloud Philosophy**:
   - Critical business information housed internally
   - Cloud resources used only as temporary additions
   - Enhanced productivity through selective cloud integration
   - Maintain independence from external providers for core functions
   - Preserve freedom of choice in technology decisions

## Architecture Implications

- Architecture must support deployment on commodity hardware
- System must be self-contained and fully functional without external dependencies
- Cloud integrations must be optional and non-critical to core functionality
- Storage hierarchy must prioritize local retention of critical data
- Scaling must be incremental with minimal disruption
- Freedom from vendor lock-in must be maintained

## Consequences

### Positive

- **Business Autonomy**: Organizations maintain control of their data and systems
- **Cost Effectiveness**: Lower TCO compared to pure cloud solutions
- **Scalable Investment**: Start small and grow as needs increase
- **Flexibility**: Hybrid approach provides best of both worlds
- **Specialized Solutions**: Focus on custom workflows for specific business needs
- **Independence**: Reduced dependency on external service providers
- **Data Sovereignty**: Clear boundaries for data location and governance

### Negative

- **Initial Setup**: More involved than "click to deploy" cloud solutions
- **Hardware Management**: Organizations need to manage physical infrastructure
- **Support Requirements**: May require more technical expertise than pure SaaS
- **Feature Competition**: Cloud services continually add new capabilities
- **Development Complexity**: Must support hybrid deployment scenarios

## Related Decisions

- [001: Multi-tier Scaling Architecture](001-multi-tier-scaling-architecture.md)
- [003: NixOS Hyper-Converged Implementation](003-nixos-hyperconverged-implementation.md)

## Notes

This business-focused decision serves as a foundational driver for our technical architecture decisions. Our hyper-converged approach with progressive scaling directly supports these business goals by allowing organizations to start small and scale incrementally.

The hybrid philosophy towards cloud resources ensures organizations maintain control over critical data while still leveraging external services when beneficial. This balanced approach addresses the growing concerns about cloud dependency, costs, and data sovereignty.

By focusing on medium-sized businesses with specialized workflow needs, CIM occupies a market position between generic cloud services and custom-developed solutions, offering the flexibility of the latter with the reliability and scalability of the former. 