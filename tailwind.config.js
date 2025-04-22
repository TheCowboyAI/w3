/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{rs,html,js}"
  ],
  theme: {
    extend: {
      colors: {
        // Base16 Colors
        base00: 'var(--base00)',
        base01: 'var(--base01)',
        base02: 'var(--base02)',
        base03: 'var(--base03)',
        base04: 'var(--base04)',
        base05: 'var(--base05)',
        base06: 'var(--base06)',
        base07: 'var(--base07)',
        base08: 'var(--base08)',
        base09: 'var(--base09)',
        base0A: 'var(--base0A)',
        base0B: 'var(--base0B)',
        base0C: 'var(--base0C)',
        base0D: 'var(--base0D)',
        base0E: 'var(--base0E)',
        base0F: 'var(--base0F)',
      },
      fontFamily: {
        primary: ['JetBrains Mono', 'monospace'],
        secondary: ['Inter', 'sans-serif'],
        display: ['Orbitron', 'sans-serif'],
      },
      fontSize: {
        'display': ['3rem', { lineHeight: '1.1' }],
        'h1': ['2.25rem', { lineHeight: '1.2' }],
        'h2': ['1.75rem', { lineHeight: '1.2' }],
        'h3': ['1.5rem', { lineHeight: '1.3' }],
        'h4': ['1.25rem', { lineHeight: '1.4' }],
        'body': ['1rem', { lineHeight: '1.5' }],
        'small': ['0.875rem', { lineHeight: '1.5' }],
        'caption': ['0.75rem', { lineHeight: '1.5' }],
      },
      animation: {
        'float': 'float 6s ease-in-out infinite',
        'pulse': 'pulse 4s ease-in-out infinite alternate',
      },
      backdropBlur: {
        xs: '2px',
      },
      zIndex: {
        '-10': '-10',
      },
    },
  },
  plugins: [],
} 