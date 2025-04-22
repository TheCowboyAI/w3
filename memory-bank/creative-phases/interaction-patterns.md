# Interaction Patterns - Creative Phase

🎨🎨🎨 ENTERING CREATIVE PHASE: UI/UX DESIGN 🎨🎨🎨
Focus: Interaction Patterns
Objective: Define a comprehensive set of interaction patterns for a reactive system built with Leptos
Requirements:
- Must leverage Leptos's reactive capabilities
- Forms must use local model and reactive input
- Must integrate with previously defined component styles and animation patterns
- Must maintain consistency across the application
- Must follow best practices for accessibility and usability
- Must be performant and efficient

## PROBLEM STATEMENT

The project requires a consistent set of interaction patterns that leverage Leptos's reactive capabilities while providing intuitive experiences for users. These patterns must define how users interact with various components, especially forms, while ensuring all interactions are accessible and follow best practices. The interaction patterns must work cohesively with the previously established component styles and animation patterns.

## OPTIONS ANALYSIS

### Option 1: Fully Controlled Component Pattern
**Description**: Implement a fully controlled component pattern where all form state is managed through Leptos signals, with explicit handlers for every interaction.

**Pros**:
- Complete control over every aspect of the interaction
- Direct mapping between UI state and component state
- Predictable behavior in all scenarios
- Easier debugging as all state transitions are explicit
- Better testability through signal inspection

**Cons**:
- More verbose implementation
- Repetitive boilerplate for simple interactions
- More lines of code to maintain
- Potentially unnecessary signals for simple components

**Complexity**: Medium
**Implementation Time**: Medium

### Option 2: Uncontrolled Component Pattern with Refs
**Description**: Use Leptos NodeRefs to access DOM elements directly for certain interactions, minimizing the need for signals for every property.

**Pros**:
- Less code for simple interactions
- More closely resembles traditional web development
- May be more familiar to developers coming from other frameworks
- Potentially better performance for certain scenarios
- Less reactive overhead

**Cons**:
- Less predictable behavior
- Harder to test interactions
- Less integrated with Leptos's reactive model
- More difficult to ensure consistency
- State management is less centralized

**Complexity**: Low
**Implementation Time**: Low

### Option 3: Hybrid Model-Driven Pattern
**Description**: Use a hybrid approach with a local model driving the UI through signals, but with higher-level abstractions to reduce boilerplate.

**Pros**:
- Balance between control and simplicity
- Centralized state management
- Reduced boilerplate through abstraction
- Consistent patterns while remaining flexible
- Better reusability of interaction logic

**Cons**:
- Requires careful abstraction design
- Slightly more complex mental model
- May require more initial investment
- Potential for abstraction leaks

**Complexity**: Medium-High
**Implementation Time**: Medium-High

### Option 4: Action-Based Pattern
**Description**: Implement an action-based pattern where interactions trigger actions that are processed by reducers to update state.

**Pros**:
- Clear separation of concerns
- Predictable state changes
- Centralized state management
- Easier to implement complex workflows
- Better for complex form validation scenarios

**Cons**:
- More complex architecture
- Steeper learning curve
- May be overkill for simple interactions
- More indirection between interaction and state change

**Complexity**: High
**Implementation Time**: High

## DECISION

After evaluating all options, we recommend **Option 3: Hybrid Model-Driven Pattern** for the following reasons:

1. It balances reactive control with development efficiency
2. It aligns well with Leptos's signal-based reactive system
3. It supports the requirement for forms using local models and reactive inputs
4. It allows for consistent patterns while remaining flexible
5. It provides a good foundation for both simple and complex interactions
6. It scales well from simple forms to complex interactive components

This approach will allow us to create consistent, reactive interaction patterns while minimizing boilerplate and maintaining a clear separation of concerns.

## IMPLEMENTATION PLAN

### 1. Core Interaction Principles

```rust
// Core principles for interaction patterns:
//
// 1. LOCAL MODELS: Each interactive component has a local model 
//    representing its state
//
// 2. REACTIVE BINDING: All user inputs are bound to signals 
//    that automatically update the model
//
// 3. VALIDATION FEEDBACK: Validation errors are reactive and 
//    immediately reflected in the UI
//
// 4. COMPOSITION: Complex interactions are composed from 
//    simpler interaction primitives
//
// 5. CONSISTENT FEEDBACK: Visual and motion feedback follows 
//    consistent patterns defined in animation system
```

### 2. Form Component Architecture

```rust
// Form input component with reactive binding
#[component]
pub fn InputField<T, F>(
    #[prop(into)] label: String,
    #[prop(into)] value: Signal<T>,
    #[prop(into)] set_value: Callback<T>,
    #[prop(default = None)] validation: Option<F>,
    #[prop(default = None)] error_message: Option<Signal<Option<String>>>,
    #[prop(default = false)] required: bool,
) -> impl IntoView 
where
    T: 'static + Clone,
    F: Fn(&T) -> Option<String> + 'static,
{
    // Local error state
    let (local_error, set_local_error) = create_signal(None::<String>);
    
    // Combined error from prop or local validation
    let error = move || {
        if let Some(err_signal) = error_message {
            err_signal.get()
        } else {
            local_error.get()
        }
    };
    
    // Validate on change
    let on_change = move |new_value: T| {
        // Update local error if validation provided
        if let Some(validate) = validation.as_ref() {
            set_local_error.set(validate(&new_value));
        }
        
        // Update parent value
        set_value.call(new_value);
    };
    
    // Render input with appropriate feedback
    view! {
        <div class="form-field">
            <label class="form-label">
                {label}
                {if required { view! { <span class="required">*</span> } } else { view! {} }}
            </label>
            
            <input
                type="text"
                class=move || format!("form-input {}", if error().is_some() { "error" } else { "" })
                prop:value=move || value.get().to_string()
                on:input=move |ev| on_change(event_target_value(&ev))
            />
            
            <ErrorMessage error=error />
        </div>
    }
}
```

### 3. Model-Driven Forms

```rust
// User form example
#[derive(Clone, Debug)]
pub struct UserFormModel {
    name: String,
    email: String,
    bio: String,
}

#[component]
pub fn UserForm() -> impl IntoView {
    // Create local reactive model
    let (model, set_model) = create_signal(UserFormModel {
        name: String::new(),
        email: String::new(),
        bio: String::new(),
    });
    
    // Convenience accessors for individual fields
    let name = create_memo(move |_| model.get().name.clone());
    let email = create_memo(move |_| model.get().email.clone());
    let bio = create_memo(move |_| model.get().bio.clone());
    
    // Handle form submission
    let on_submit = move |ev: web_sys::SubmitEvent| {
        ev.prevent_default();
        
        // Use current model values for submission
        let data = model.get();
        log::info!("Submitting form data: {:?}", data);
        
        // Validation and submission logic
    };
    
    // Field-specific setters that maintain the overall model
    let set_name = move |new_name: String| {
        set_model.update(|m| m.name = new_name);
    };
    
    let set_email = move |new_email: String| {
        set_model.update(|m| m.email = new_email);
    };
    
    let set_bio = move |new_bio: String| {
        set_model.update(|m| m.bio = new_bio);
    };
    
    // Name validation
    let validate_name = |name: &String| {
        if name.trim().is_empty() {
            Some("Name is required".to_string())
        } else {
            None
        }
    };
    
    // Email validation
    let validate_email = |email: &String| {
        if !email.contains('@') {
            Some("Invalid email format".to_string())
        } else {
            None
        }
    };
    
    view! {
        <form on:submit=on_submit class="user-form">
            <InputField
                label="Name"
                value=name
                set_value=set_name
                validation=validate_name
                required=true
            />
            
            <InputField
                label="Email"
                value=email
                set_value=set_email
                validation=validate_email
                required=true
            />
            
            <TextareaField
                label="Bio"
                value=bio
                set_value=set_bio
            />
            
            <Button label="Submit" type_="submit" />
        </form>
    }
}
```

### 4. Interaction Feedback Patterns

```rust
// Define consistent interaction feedback patterns
#[component]
pub fn InteractionFeedback<T>(
    #[prop(into)] is_active: Signal<bool>,
    #[prop(into)] is_valid: Signal<bool>,
    #[prop(into)] is_processing: Signal<bool>,
    #[prop(into)] children: Children,
) -> impl IntoView {
    view! {
        <div
            class=move || format!("interaction-container {} {} {}",
                if is_active.get() { "active" } else { "" },
                if is_valid.get() { "valid" } else { "invalid" },
                if is_processing.get() { "processing" } else { "" }
            )
        >
            {children()}
            
            // Processing indicator
            <Show when=move || is_processing.get()>
                <div class="processing-indicator">
                    <AnimatedSpinner />
                </div>
            </Show>
            
            // Validation indicator
            <Show when=move || !is_processing.get() && is_active.get()>
                <div class=move || if is_valid.get() { "validation-success" } else { "validation-error" }>
                    <AnimatedIcon name=move || if is_valid.get() { "check" } else { "alert" } />
                </div>
            </Show>
        </div>
    }
}
```

### 5. Interactive Component Base

```rust
// Base trait for interactive components
pub trait Interactive {
    // Get current interaction state
    fn is_active(&self) -> bool;
    
    // Get current focus state
    fn is_focused(&self) -> bool;
    
    // Get current hover state
    fn is_hovered(&self) -> bool;
    
    // Get current disabled state
    fn is_disabled(&self) -> bool;
    
    // Get validation state
    fn is_valid(&self) -> bool;
    
    // Get processing state
    fn is_processing(&self) -> bool;
}

// Base component for interactive elements
#[component]
pub fn InteractiveBase<F, C>(
    #[prop(default = false)] disabled: bool,
    #[prop(default = true)] valid: bool,
    #[prop(default = false)] processing: bool,
    #[prop(into)] on_interact: Option<Callback<InteractionEvent>>,
    #[prop(into)] children: C,
) -> impl IntoView 
where
    F: Fn(InteractiveState) -> Children + 'static,
    C: FnOnce() -> View + 'static,
{
    // Local interaction state
    let (focused, set_focused) = create_signal(false);
    let (hovered, set_hovered) = create_signal(false);
    let (active, set_active) = create_signal(false);
    
    // Combined state for child rendering
    let state = create_memo(move |_| {
        InteractiveState {
            focused: focused.get(),
            hovered: hovered.get(),
            active: active.get(),
            disabled,
            valid,
            processing,
        }
    });
    
    // Event handlers
    let on_focus = move |_| {
        set_focused.set(true);
        
        if let Some(callback) = on_interact.as_ref() {
            callback.call(InteractionEvent::Focus);
        }
    };
    
    let on_blur = move |_| {
        set_focused.set(false);
        
        if let Some(callback) = on_interact.as_ref() {
            callback.call(InteractionEvent::Blur);
        }
    };
    
    let on_mouse_enter = move |_| {
        set_hovered.set(true);
        
        if let Some(callback) = on_interact.as_ref() {
            callback.call(InteractionEvent::Hover(true));
        }
    };
    
    let on_mouse_leave = move |_| {
        set_hovered.set(false);
        
        if let Some(callback) = on_interact.as_ref() {
            callback.call(InteractionEvent::Hover(false));
        }
    };
    
    let on_active_change = move |is_active: bool| {
        set_active.set(is_active);
        
        if let Some(callback) = on_interact.as_ref() {
            callback.call(InteractionEvent::Active(is_active));
        }
    };
    
    view! {
        <div
            class=move || format!("interactive-base {} {} {} {} {} {}",
                if focused.get() { "focused" } else { "" },
                if hovered.get() { "hovered" } else { "" },
                if active.get() { "active" } else { "" },
                if disabled { "disabled" } else { "" },
                if valid { "valid" } else { "invalid" },
                if processing { "processing" } else { "" }
            )
            on:focus=on_focus
            on:blur=on_blur
            on:mouseenter=on_mouse_enter
            on:mouseleave=on_mouse_leave
            on:mousedown=move |_| { if !disabled { on_active_change(true) } }
            on:mouseup=move |_| { if !disabled { on_active_change(false) } }
            tabindex=if disabled { None } else { Some(0) }
        >
            {children()}
        </div>
    }
}
```

### 6. Drag and Drop Interactions

```rust
// Draggable component
#[component]
pub fn Draggable<T: 'static + Clone + Serialize>(
    #[prop(into)] id: String,
    #[prop(into)] data: T,
    #[prop(into)] children: Children,
) -> impl IntoView {
    // Create signals for drag state
    let (dragging, set_dragging) = create_signal(false);
    
    // Serialize data for transfer
    let data_str = match serde_json::to_string(&data) {
        Ok(s) => s,
        Err(_) => "{}".to_string(),
    };
    
    view! {
        <div
            class=move || format!("draggable {}", if dragging.get() { "dragging" } else { "" })
            draggable="true"
            on:dragstart=move |ev| {
                // Set drag data
                if let Some(dt) = ev.data_transfer() {
                    dt.set_data("application/json", &data_str).unwrap_or_default();
                    dt.set_data("text/plain", &id).unwrap_or_default();
                }
                
                set_dragging.set(true);
            }
            on:dragend=move |_| {
                set_dragging.set(false);
            }
        >
            {children()}
        </div>
    }
}

// Droppable area component
#[component]
pub fn DropZone<T: 'static + Clone + DeserializeOwned, F: Fn(T) -> () + 'static>(
    #[prop(into)] on_drop: F,
    #[prop(into)] children: Children,
) -> impl IntoView {
    // Create signals for drop target state
    let (drag_over, set_drag_over) = create_signal(false);
    
    // Process drop event
    let handle_drop = move |ev: web_sys::DragEvent| {
        ev.prevent_default();
        
        if let Some(dt) = ev.data_transfer() {
            if let Ok(json_data) = dt.get_data("application/json") {
                if let Ok(data) = serde_json::from_str::<T>(&json_data) {
                    on_drop(data);
                }
            }
        }
        
        set_drag_over.set(false);
    };
    
    view! {
        <div
            class=move || format!("drop-zone {}", if drag_over.get() { "drag-over" } else { "" })
            on:dragover=move |ev| {
                ev.prevent_default();
                set_drag_over.set(true);
            }
            on:dragleave=move |_| {
                set_drag_over.set(false);
            }
            on:drop=handle_drop
        >
            {children()}
        </div>
    }
}
```

### 7. Complex Interaction Abstractions

```rust
// Multi-step form component
#[component]
pub fn MultiStepForm<T, V, S>(
    #[prop(into)] steps: Vec<FormStep<T>>,
    #[prop(into)] initial_data: T,
    #[prop(into)] on_complete: Callback<T>,
    #[prop(into)] validate_step: V,
    #[prop(into)] step_rendered: S,
) -> impl IntoView 
where
    T: 'static + Clone,
    V: Fn(usize, &T) -> Option<String> + 'static,
    S: Fn(usize, &T, WriteSignal<T>) -> View + 'static,
{
    // Current form state
    let (data, set_data) = create_signal(initial_data);
    let (current_step, set_current_step) = create_signal(0);
    let (error, set_error) = create_signal(None::<String>);
    
    // Total number of steps
    let total_steps = steps.len();
    
    // Navigation functions
    let can_go_next = create_memo(move |_| {
        let step = current_step.get();
        validate_step(step, &data.get()).is_none() && step < total_steps - 1
    });
    
    let can_go_back = create_memo(move |_| current_step.get() > 0);
    
    let next_step = move |_| {
        let step = current_step.get();
        
        // Validate current step
        if let Some(err) = validate_step(step, &data.get()) {
            set_error.set(Some(err));
            return;
        }
        
        // Clear error and advance
        set_error.set(None);
        if step < total_steps - 1 {
            set_current_step.set(step + 1);
        } else {
            on_complete.call(data.get());
        }
    };
    
    let prev_step = move |_| {
        let step = current_step.get();
        if step > 0 {
            set_current_step.set(step - 1);
        }
    };
    
    // Determine if we're on the final step
    let is_final_step = create_memo(move |_| current_step.get() == total_steps - 1);
    
    view! {
        <div class="multi-step-form">
            // Progress indicator
            <div class="step-progress">
                <For
                    each=move || 0..total_steps
                    key=|step| *step
                    children=move |step| {
                        let is_active = move || current_step.get() == step;
                        let is_completed = move || current_step.get() > step;
                        
                        view! {
                            <div class=move || format!("step-indicator {} {}",
                                if is_active() { "active" } else { "" },
                                if is_completed() { "completed" } else { "" }
                            )>
                                {step + 1}
                            </div>
                        }
                    }
                />
            </div>
            
            // Error message
            <Show when=move || error.get().is_some()>
                <div class="form-error">
                    {move || error.get().unwrap_or_default()}
                </div>
            </Show>
            
            // Current step content
            <div class="step-content">
                {move || step_rendered(current_step.get(), &data.get(), set_data)}
            </div>
            
            // Navigation buttons
            <div class="step-navigation">
                <Show when=move || can_go_back.get()>
                    <Button
                        label="Previous"
                        on_click=prev_step
                        variant="secondary"
                    />
                </Show>
                
                <Button
                    label=move || if is_final_step.get() { "Complete" } else { "Next" }
                    on_click=next_step
                    variant="primary"
                    disabled=move || !can_go_next.get() && !is_final_step.get()
                />
            </div>
        </div>
    }
}
```

## ACCESSIBILITY CONSIDERATIONS

To ensure our interaction patterns are accessible:

1. **Keyboard Navigation**
   - All interactive elements must be focusable
   - Tab order follows logical flow
   - Support keyboard shortcuts for common actions
   - Implement focus management for complex widgets

2. **Screen Reader Support**
   - Use appropriate ARIA roles and attributes
   - Ensure dynamic content changes are announced
   - Provide context for interactive elements
   - Implement proper labeling for all inputs

3. **Reduced Motion Sensitivity**
   - Honor `prefers-reduced-motion` settings
   - Provide alternatives to motion-based feedback
   - Ensure critical interactions don't rely solely on animation

4. **Error Handling**
   - Present errors in context
   - Use both color and text for error states
   - Provide clear instructions for resolution
   - Maintain focus on elements needing attention

## VISUAL FEEDBACK CONSISTENCY

To maintain consistent visual feedback across interactions:

1. **State Transitions**
   - Use consistent animation timings from our animation patterns
   - Apply the same visual treatment for similar state changes
   - Maintain consistent focus indicators

2. **Loading States**
   - Implement consistent loading indicators
   - Use the same pattern for all asynchronous operations
   - Disable interactions appropriately during loading

3. **Success/Error States**
   - Apply consistent color coding for success/error
   - Use the same animation patterns for confirmation
   - Position feedback messages consistently

4. **Interactive Element States**
   - All interactive elements should handle the same states:
     - Default
     - Hover
     - Focus
     - Active/Pressed
     - Disabled
     - Loading
     - Error
     - Success

🎨 CREATIVE CHECKPOINT: Interaction Patterns System Design

The interaction patterns design establishes:
- A reactive approach using Leptos signals
- Consistent patterns for form inputs
- A model-driven approach to data binding
- Reusable interaction components and abstractions
- Consistent visual feedback aligned with our animation patterns
- Robust accessibility considerations

## INTEGRATION WITH EXISTING SYSTEMS

The interaction patterns integrate with previously defined systems:

1. **Component Style Integration**
   - Interaction states map to visual states defined in component styles
   - Focus, hover, and active states follow the established design language
   - Form elements align with the glass-card aesthetic

2. **Animation Pattern Integration**
   - State transitions use the defined animation timing system
   - Feedback animations follow established patterns
   - Interaction animations respect motion preferences

3. **Graph Visualization Integration**
   - Apply the same interaction patterns to graph elements
   - Maintain consistent feedback for selection and navigation
   - Use the same model-driven approach for graph interactivity

🎨🎨🎨 EXITING CREATIVE PHASE - DECISION MADE 🎨🎨🎨

Summary: We've designed a comprehensive interaction pattern system using a hybrid model-driven approach that leverages Leptos's reactive capabilities while maintaining consistency, accessibility, and integration with our existing systems.

Key Decisions:
1. Adopt a hybrid model-driven interaction pattern
2. Use Leptos signals for reactive data binding
3. Create reusable abstractions for common interaction patterns
4. Implement consistent visual feedback aligned with animation patterns
5. Prioritize accessibility across all interactions
6. Design sophisticated components for complex interactions

Next Steps:
1. Implement the core interaction models
2. Create the form component system
3. Develop the interaction feedback patterns
4. Build reusable interaction abstractions
5. Integrate with the animation and styling systems
6. Create examples for developer reference
7. Document integration with the component and animation systems 