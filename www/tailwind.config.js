/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["*.html", "./src/**/*.rs"],
  darkMode: ['class', '[data-theme="dark"]'],
  theme: {
    extend: {
      colors: {
        // Base16 color palette - Light theme defaults
        base00: "var(--base00, #FDFEFF)", // Crystalline - Default Background
        base01: "var(--base01, #F6FAFB)", // Lighter Background
        base02: "var(--base02, rgba(0, 156, 255, 0.2))", // Selection Background
        base03: "var(--base03, #4A5A6A)", // Comments, Line Highlighting
        base04: "var(--base04, #B0B0B0)", // Chrome - Dark Foreground
        base05: "var(--base05, #0A0A0A)", // Onyx - Default Foreground
        base06: "var(--base06, #1A2633)", // Deep Steel - Light Foreground
        base07: "var(--base07, #FFFFFF)", // Light Background
        base08: "var(--base08, #FF5252)", // Error - Red
        base09: "var(--base09, #FFB74D)", // Warning - Orange
        base0A: "var(--base0A, #FFD740)", // Yellow
        base0B: "var(--base0B, #00E1FF)", // Aqua Edge - Success - Green
        base0C: "var(--base0C, #B0F6FF)", // Chrome Reflection - Cyan
        base0D: "var(--base0D, #009CFF)", // Neon Blue - Blue
        base0E: "var(--base0E, #6C63FF)", // Neon Violet - Purple
        base0F: "var(--base0F, #002D60)", // Sapphire - Brown
        
        // Semantic color mappings
        background: "var(--color-background, var(--base00))",
        surface: "var(--color-surface, var(--base01))",
        "surface-elevated": "var(--color-surface-elevated, var(--base07))",
        "text-primary": "var(--color-text-primary, var(--base05))",
        "text-secondary": "var(--color-text-secondary, var(--base0F))",
        "text-muted": "var(--color-text-muted, var(--base03))",
        border: "var(--color-border, var(--base04))",
        accent: "var(--color-accent, var(--base0D))",
        "accent-hover": "var(--color-accent-hover, var(--base0E))",
        success: "var(--color-success, var(--base0B))",
        info: "var(--color-info, var(--base0C))",
        warning: "var(--color-warning, var(--base09))",
        error: "var(--color-error, var(--base08))",
        glow: "var(--color-glow, var(--base0D))",
      },
      fontFamily: {
        orbitron: ['Orbitron', 'sans-serif'],
        outfit: ['Outfit', 'sans-serif'],
        inter: ['Inter', 'sans-serif'],
        mono: ['"JetBrains Mono"', 'monospace'],
      },
      fontSize: {
        'xs': ['0.64rem', { lineHeight: '1rem' }],
        'sm': ['0.8rem', { lineHeight: '1.25rem' }],
        'base': ['1rem', { lineHeight: '1.5rem' }],
        'lg': ['1.25rem', { lineHeight: '1.75rem' }],
        'xl': ['1.563rem', { lineHeight: '2rem' }],
        '2xl': ['1.953rem', { lineHeight: '2.25rem' }],
        '3xl': ['2.441rem', { lineHeight: '2.5rem' }],
        '4xl': ['3.052rem', { lineHeight: '1' }],
        '5xl': ['3.815rem', { lineHeight: '1' }],
      },
      letterSpacing: {
        tighter: '-0.05em',
        tight: '-0.025em',
        normal: '0em',
        wide: '0.025em',
        wider: '0.05em',
        widest: '0.1em',
        'orbitron': '0.05em', // Custom spacing for Orbitron
      },
      lineHeight: {
        none: '1',
        tight: '1.25',
        snug: '1.375',
        normal: '1.5',
        relaxed: '1.625',
        loose: '2',
        'heading': '1.2', // Custom line height for headings
      },
      backgroundColor: {
        DEFAULT: "var(--color-background)",
      },
      textColor: {
        DEFAULT: "var(--color-text-primary)",
      },
      borderColor: {
        DEFAULT: "var(--color-border)",
      },
      ringColor: {
        DEFAULT: "var(--color-accent)",
      },
      boxShadowColor: {
        glow: "var(--color-glow)",
      },
    },
  },
  plugins: [],
} 