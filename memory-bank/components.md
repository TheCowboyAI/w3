# Core Components Specification

## Layout Components

### MainLayout
- **Description**: Primary layout wrapper for all pages
- **Features**:
  - Header with navigation
  - Main content area
  - Footer with secondary navigation
  - Theme switcher
- **Technical Notes**: 
  - Implements responsive design with TailwindCSS
  - Maintains consistent margins and padding

### NavigationBar
- **Description**: Primary site navigation
- **Features**:
  - Frosted white background with chrome outline
  - Blue glow underline on hover
  - Mobile responsive with hamburger menu
  - Active page indication
- **Technical Notes**:
  - Fixed position with z-index management
  - Collapsible on mobile with animation

### Footer
- **Description**: Site footer with secondary navigation
- **Features**:
  - Secondary links (legal, sitemap, etc.)
  - Social media connections
  - Newsletter signup
  - Copyright information
- **Technical Notes**:
  - Grid layout for responsive column arrangement

## UI Components

### GlassCard
- **Description**: Raised glass-like container for content
- **Features**:
  - Semi-transparent background
  - Silver edge with glowing blue connections
  - Hover animation with metallic sheen
  - Optional shadow depth
- **Technical Notes**:
  - Implements backdrop blur with TailwindCSS
  - Uses CSS variables for customization

### Button
- **Description**: Interactive button elements
- **Variants**:
  - Primary: Sapphire fill with neon blue glow border
  - Secondary: Chrome outline with hover shimmer
  - Text: Minimal styling with hover underline
- **Technical Notes**:
  - Consistent padding and sizing
  - Accessible focus states
  - Loading state support

### HeroSection
- **Description**: Primary landing section for pages
- **Features**:
  - Large heading with Orbitron font
  - Animated background elements
  - Call-to-action buttons
  - Optional visualization or image
- **Technical Notes**:
  - Full viewport height option
  - Animated entrance for elements

### TabPanel
- **Description**: Content organized in tabs
- **Features**:
  - Tab navigation with active indicators
  - Content panels with smooth transitions
  - Mobile-friendly tab scrolling
- **Technical Notes**:
  - Maintains state of active tab
  - Supports keyboard navigation

## Data Visualization Components

### GraphVisualizer
- **Description**: Interactive graph visualization
- **Features**:
  - Node and edge display
  - Interactive exploration (zoom, pan, click)
  - Data binding for dynamic graphs
  - Animation capabilities
- **Technical Notes**:
  - Abstraction layer for different formats (petgraph, mermaid, cypher)
  - SVG-based rendering
  - WebAssembly performance optimization

### AnimatedDiagram
- **Description**: SVG-based animated diagrams
- **Features**:
  - Timeline-based animations
  - Interactive elements
  - Responsive scaling
- **Technical Notes**:
  - CSS animations for simple effects
  - SVG animation for complex sequences
  - Event-driven animation triggers

### DataCard
- **Description**: Data visualization card
- **Features**:
  - Metric display with labels
  - Optional chart or graph
  - Trend indicators
  - Information tooltip
- **Technical Notes**:
  - Composite component using GlassCard
  - Integrates with GraphVisualizer for small visualizations

## Form Components

### InputField
- **Description**: Text input with styling
- **Variants**:
  - Text: Standard text input
  - Email: Email validation
  - Password: Secure input with visibility toggle
  - Textarea: Multi-line input
- **Technical Notes**:
  - Form validation integration
  - Accessible labels and error states

### ContactForm
- **Description**: Complete contact form component
- **Features**:
  - Input fields with validation
  - Submit button with loading state
  - Success/error messaging
  - CAPTCHA integration
- **Technical Notes**:
  - Form submission handling
  - Client-side validation

## Media Components

### CodeBlock
- **Description**: Syntax-highlighted code display
- **Features**:
  - Language-specific syntax highlighting
  - Copy button
  - Line numbers option
  - Optional title bar
- **Technical Notes**:
  - Uses JetBrains Mono font
  - Supports multiple programming languages

### ImageGallery
- **Description**: Interactive image gallery
- **Features**:
  - Thumbnail grid layout
  - Lightbox for full-size viewing
  - Caption support
  - Navigation controls
- **Technical Notes**:
  - Lazy loading for performance
  - Responsive grid layout

## Utility Components

### ThemeSwitcher
- **Description**: Toggle between light and dark themes
- **Features**:
  - Visual indicator of current theme
  - Smooth transition between themes
  - System preference detection
- **Technical Notes**:
  - Uses local storage for persistence
  - Updates TailwindCSS classes

### LoadingSpinner
- **Description**: Loading state indicator
- **Features**:
  - Animated spinner with brand styling
  - Optional loading text
  - Size variants
- **Technical Notes**:
  - Pure CSS animation
  - Accessible aria attributes

### AlertMessage
- **Description**: User notification component
- **Variants**:
  - Success: Positive confirmation
  - Error: Error notification
  - Info: Informational message
  - Warning: Caution message
- **Technical Notes**:
  - Timed auto-dismiss option
  - Accessible ARIA roles 