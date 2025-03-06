To implement local-first we use a three-tiered event-driven architecture (Context, Leaf, Cluster) with NATS as the backbone for communication, you can design the system to respect the hierarchical flow of events while maintaining clear separation of concerns between bounded contexts, sub-domains, and domains.

## **Event Hierarchy Design**

### 1. Context-Level Events

- **Scope:** Events local to a container (bounded context). These are specific to the microservices or components running within the container.
- **Usage:**
  - Context events are processed internally within the container.
  - They may be escalated to the Leaf level if they are relevant beyond the container's scope.

### 2. Leaf-Level Events

- **Scope:** Events local to a leaf node (sub-domain). These are shared across containers within a single leaf node.
- **Usage:**
  - Leaf events aggregate or react to context-level events from its containers.
  - They may be escalated to the Cluster level for broader distribution.

### 3. Cluster-Level Events

- **Scope:** Events shared across all leaf nodes in a cluster (domain-level).
- **Usage:**
  - Cluster events represent domain-wide changes or notifications.
  - They can broadcast updates back to leaves, which in turn propagate them to their respective contexts.

## **Event Flow Rules**

1. **Escalation:**

   - Context → Leaf: A container publishes an event to its leaf node if it has broader implications.
   - Leaf → Cluster: A leaf node escalates events to the cluster when they affect the entire domain.
2. **Broadcasting:**

   - Cluster → Leaves: The cluster broadcasts domain-wide events to all connected leaf nodes.
   - Leaf → Contexts: A leaf node distributes relevant events back down to its containers.
3. **Isolation:**Events at each level should be scoped appropriately:

   - Context events should not directly interact with other contexts or leaves.
   - Leaf nodes should handle cross-container communication but avoid direct interaction with other leaves unless mediated by the cluster.

## **Implementation Strategy**

### 1. NATS Subject Hierarchy

Use NATS subjects to organize and route events across levels:

- `context..`: For context-level events.
- `leaf..`: For leaf-level events.
- `cluster..`: For cluster-level events.

For example:

- A user action in a UI component might publish `context.ui.button.clicked`.
- The container could escalate this as `leaf.analytics.user.action` if it is relevant at the sub-domain level.
- Finally, the leaf might escalate it as `cluster.domain.user.activity` for domain-wide processing.

### 2. Event Escalation and Broadcasting

Implement escalation and broadcasting using NATS publish/subscribe patterns:

- **Escalation:**Containers publish context events to a specific subject that their leaf node subscribes to. The leaf node processes these and decides whether to escalate them further.
- **Broadcasting:**
  The cluster publishes domain-wide events on a subject that all leaves subscribe to. Each leaf then broadcasts these events down to its containers.

### 3. Event Processing Pipeline

Each level processes incoming events independently:

- **Context Level:**Use an in-memory event bus (e.g., Reactive Extensions or similar) within the container for local event handling. Publish relevant events to NATS for escalation.
- **Leaf Level:**Subscribe to context event subjects from all containers within the leaf. Aggregate or process these events, then decide whether they need escalation or broadcasting.
- **Cluster Level:**
  Aggregate events from all leaves and handle domain-wide logic. Broadcast results back down as needed.

## **Iced UI Integration with NATS**

The Iced UI will act as a producer and consumer of context-level events while indirectly interacting with higher levels through escalations and broadcasts.

### Key Steps:

1. **Connect Iced UI to Context-Level NATS Subjects**:

   - Establish a connection to `nats://localhost:4222` within your Iced application.
   - Publish user interactions (e.g., button clicks) as context-level events (`context.ui.`).
   - Subscribe to relevant context-level subjects for updates (e.g., `context.ui.notifications`).
2. **Escalate Relevant Events**:

   - When an event needs propagation beyond the container, publish it on a subject that the leaf node listens to (e.g., `leaf.analytics.ui.action`).
3. **React to Broadcasts**:

   - Subscribe to leaf-level subjects (`leaf..ui.update`) for updates propagated from other containers in the same leaf.
   - Similarly, subscribe to cluster-level subjects (`cluster..domain.update`) for domain-wide broadcasts.

## Summary

This architecture ensures that your system respects hierarchical boundaries while maintaining flexibility and scalability:

1. Contexts operate independently but can escalate significant events upward.

- Applications and Users within Contexts have a Subject as well. This escalates up to the cluster for IAM.

2. Leaf nodes act as intermediaries between contexts and clusters.
3. Clusters manage domain-wide coordination and broadcast updates downward.

By integrating this sort of hierarchy into the Iced UI (TEA) using NATS, you achieve a cohesive event-driven system that aligns with distributed architecture principles.
