# W3 Memory Bank Tasks

## Current Focus: Phase 1 - Component Organization and Styling

### Completed

- [x] Address showcase component issues:
  - [x] Remove `TypographyShowcase` component from `typography.rs`
  - [x] Remove `CardShowcase` component from `card.rs`
  - [x] Create a new component showcase page instead
- [x] Created a basic page navigation system
- [x] Fixed Button component:
  - [x] Added `Text` variant to `ButtonVariant` enum
  - [x] Updated `ButtonShowcase` to display all variants
  - [x] Fixed component rendering in showcase
- [x] Implement basic routing with leptos_router

### In Progress

- [ ] Address remaining type issues in components:
  - [ ] Fix class name styles (converted .to_string() for now)
  - [ ] Address apostrophe and comment syntax in JSX templates
  - [ ] Fix component usage on Home page with proper types
- [ ] Improve component organization:
  - [ ] Create consistent API for similar components
  - [ ] Standardize props and naming conventions

### Next Steps
- [ ] Create main layout component with proper styling
- [ ] Improve navigation component with active state indicators
- [ ] Create memory item component for displaying memory entries
- [ ] Add proper form components for data input

### Issues Encountered
- Fixed previous issues with apostrophes in strings by avoiding them
- Class handling needs standardization (currently using .to_string() for &str to String conversion)
- JSX comment syntax issues in view! macro - using {/* comment */} format
- Still need to standardize String vs &str usage in component props

## Implementation Plan Reference
See [implementation-plan.md](implementation-plan.md) for the full implementation roadmap. 