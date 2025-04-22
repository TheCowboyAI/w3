# W3 Project

A modern web application featuring the Crystalline Neon design system - a futuristic, minimalist aesthetic with purposeful animations and clean interfaces.

## Overview

W3 is a web-based application that showcases a sophisticated design system while providing an intuitive, engaging user experience. The project implements a cohesive visual language across all components with crystal clarity, neon accents, responsive fluidity, and systematic consistency.

## Key Features

- **Modern Design System**: Crystalline Neon aesthetic with clean interfaces and purposeful negative space
- **Responsive Layout**: Fully adaptive across all device sizes and orientations
- **Interactive Visualizations**: Graph-based data visualization with intuitive interaction patterns
- **Fluid Animations**: Purposeful motion that enhances user experience without distraction
- **Accessibility**: WCAG compliant with strong focus on usability for all users
- **Dark/Light Themes**: Full support for theme switching with Base16 color standardization

## Design System

The W3 design system, documented in `memory-bank/design-system-documentation.md`, includes:

- **Component Style Specifications**: Clean geometric shapes with subtle neon accents
- **Animation Patterns**: Fluid, purposeful motion enhancing the user experience
- **Graph Visualization Styles**: Complex relationships represented with clarity
- **Interaction Patterns**: Intuitive, responsive experiences with clear feedback
- **Color Scheme**: Base16 implementation with systematic application
- **Typography System**: Balancing readability with futuristic aesthetics
- **Icon and Image System**: Consistent visual elements extending the aesthetic

## Technology Stack

- **Frontend Framework**: Rust with Leptos
- **Styling**: Tailwind CSS with custom components
- **Visualization**: Custom graph visualization system
- **Deployment**: GitHub Pages

## Getting Started

### Prerequisites

- Rust toolchain (latest stable)
- Node.js (for asset processing)
- Nix (for development environment)

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/thecowboyai/w3.git
   cd w3
   ```

2. Set up the development environment:
   ```
   nix develop
   ```

3. Build the project:
   ```
   cargo build
   ```

4. Start the development server:
   ```
   cargo run
   ```

## Usage

Once running, the application will be available at `http://localhost:3000`.

Navigate through the various sections to explore:
- The component library and design system in action
- Interactive graph visualizations
- Animation demonstrations
- Responsive layout capabilities

## Project Structure

```
w3/
├── src/                 # Rust source code
├── assets/              # Static assets
├── memory-bank/         # Project documentation
│   ├── creative-phases/ # Design system component docs
│   └── ...
├── styles/              # CSS/Tailwind styles
└── ...
```

## Documentation

Comprehensive documentation is available in the `memory-bank` directory:

- Design system documentation
- Task tracking
- Project progress
- Implementation plans

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- [Base16](https://github.com/chriskempson/base16) for color scheme standardization
- [Tailwind CSS](https://tailwindcss.com/) for utility-first CSS framework
- [Leptos](https://github.com/leptos-rs/leptos) for the reactive Rust web framework 