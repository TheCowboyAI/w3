## Cursor IDE Web UI Style Guide  
**For: Cowboy AI Homepage**  
**Tech: Leptos (Rust) + TailwindCSS**  
**Version: V13 (Web UI Adaptation)**

---

### **Visual Theme**

- **Aesthetic:** Futuristic minimalism meets cybernetic orchestration; high-contrast, luminous, and sharp.
- **Mood:** Clean, immersive, radiant, and commanding.
- **Layout:** 3D glass panels, modular structure, metallic/silver accents, interconnected with glowing lines.

---

### **Color Palette**
scheme: Crystalline Neon
author: CowboyAI
base00: "FDFEFF" # Crystalline White (background)
base01: "F6FAFB" # Off-White Highlight
base02: "E6E9EA" # Chrome Mist
base03: "B0B0B0" # Silver Veil (structural lines, metallic detail)
base04: "D0D8DF" # Pale Steel
base05: "0A0A0A" # Onyx Black (primary text)
base06: "002D60" # Deep Sapphire Shadow (edge depth)
base07: "FFFFFF" # Pure White (highest highlight)
base08: "009CFF" # Neon Blue Accent (accent glow)
base09: "0033CC" # Sapphire Glow (action highlight)
base0A: "00B0FF" # Electric Steel Blue (structural lines)
base0B: "00E1FF" # Aqua Edge (success, positive)
base0C: "B0F6FF" # Chrome Reflection (info, metallic highlight)
base0D: "4FC3FF" # Blue Glint (secondary accent)
base0E: "6C63FF" # Neon Violet (alternate accent)
base0F: "1A2633" # Deep Steel (shadow, code blocks)


scheme: Crystalline Neon Dark
author: CowboyAI
base00: "0A1220" # Deep Sapphire Black (background)
base01: "121A28" # Onyx Shadow (panels)
base02: "002D60" # Sapphire Steel (cards, code)
base03: "4A5A6A" # Gunmetal Chrome (lines, muted)
base04: "B0B0B0" # Refined Chrome Silver (borders, metallic)
base05: "FDFEFF" # Crystalline White (text)
base06: "00B0FF" # Electric Steel Blue (accent, links)
base07: "009CFF" # Neon Blue Accent (interactive)
base08: "0033CC" # Sapphire Glow (action)
base09: "00E1FF" # Aqua Edge (positive)
base0A: "B0F6FF" # Chrome Reflection (info)
base0B: "4FC3FF" # Blue Glint (hover)
base0C: "6C63FF" # Neon Violet (alt accent)
base0D: "FFFFFF" # Pure White (highlight)
base0E: "D0D8DF" # Steel Mist (disabled)
base0F: "1A2633" # Deep Steel (shadow)

## Usage Notes:

    Background: base00 (#FDFEFF) is the main background, radiant and bright.
    Text: base05 (#0A0A0A) ensures maximum legibility.
    Accents: base08, base09, and base0A provide neon and metallic blue highlights for UI elements, links, and interactive states.
    Structural: base03, base06, and base0F offer chrome and steel depth for lines, borders, and shadows.
    Highlights: base07 and base0C are for selections, cursor, or info messages with a crystalline, reflective touch.

---

### **Typography**

- **Hero Titles:** Orbitron (angular, futuristic, cyber-formal)
- **Subheaders:** Outfit (structured, digital sans-serif)
- **Body Copy:** Inter (screen-optimized)
- **Special/Code:** JetBrains Mono (identifiers, code, model IDs)
- **Effects:**  
  - Neon blue glow hover for links  
  - Deep shadow lift for titles on scroll

**Tailwind Setup:**  
- Add custom fonts via `@import` in your Tailwind CSS or configure in `tailwind.config.js`  
- Use Tailwind's `font-` utilities for font family and weight  
- Use `text-shadow` and `hover:` for glow/shadow effects (extend Tailwind if needed)

---

### **UI Components**

**Navigation Bar**
- Frosted white (`bg-white/80`), chrome (`border-[#B0B0B0]`) outline
- Blue glow underline on hover (`after:border-b-2 after:border-[#009CFF]`)

**Buttons**
- **Primary:**  
  - Sapphire fill (`bg-[#0033CC]`), neon blue glow border (`shadow-[0_0_8px_2px_#009CFF]`), cry
- **Secondary:**  
  - Chrome outline (`border-[#B0B0B0]`), metallic shimmer (`hover:bg-gradient-to-r from-[#FDFEFF] to-[#B0B0B0]`)
- **Hover:**  
  - Raised glow (`shadow-lg`), silver highlight pulse (`animate-pulse` on hover)

**Hero CTA**
- Text: "ORCHESTRATE INTELLIGENCE"
- Sharp black text (`text-[#0A0A0A]`) on blue-glow base (`bg-[#009CFF]`), metallic ring animation (use Tailwind `animate-spin` or custom keyframes)

**Cards / Modules**
- Raised glass tiles (`bg-white/30 backdrop-blur-md shadow-xl`)
- Silver edge (`border-[#B0B0B0]`), glowing blue connections (`border-l-4 border-[#00B0FF]`)
- Hover: Subtle metallic sheen (`hover:bg-gradient-to-t from-[#FDFEFF] to-[#B0B0B0]/40`)

**Cursor**
- Custom metallic pointer (CSS override), blue glow trail (`shadow-[0_0_8px_2px_#009CFF]`)
- Electric spark on actionable hover (CSS animation, Tailwind `group-hover` utilities)

---

### **Imagery and Icons**

- **Icons:** Blueprint wireframes, chrome & electric blue details
- **Visuals:** Floating node graphs, 3D agent models, radial grid overlays, digital blueprint motifs
- **Motion:**  
  - Glow lines pulse (`animate-pulse`), agent nodes blink (`animate-blink`), silver-beam transitions (`transition-all duration-500`)

---

### **TailwindCSS Integration (Leptos)**

- Use [cargo-leptos](https://github.com/TheCowboyAI/csr-start)[6][8] and configure Tailwind to scan `.rs` files for class usage.
- Add custom colors and fonts in `tailwind.config.js`:
    ```js
    module.exports = {
      content: ["*.html", "./src/**/*.rs"],
      theme: {
        extend: {
          colors: {
            crystalline: "#FDFEFF",
            onyx: "#0A0A0A",
            neonblue: "#009CFF",
            sapphire: "#002D60",
            steelblue: "#00B0FF",
            chrome: "#B0B0B0",
            sapphireglow: "#0033CC",
          },
          fontFamily: {
            orbitron: ['Orbitron', 'sans-serif'],
            outfit: ['Outfit', 'sans-serif'],
            inter: ['Inter', 'sans-serif'],
            jetbrains: ['JetBrains Mono', 'monospace'],
          },
        },
      },
      plugins: [],
    }
    ```
- Use Tailwind utility classes in Leptos components for all layout, color, and effects[6][8][10][14][16][17].

---

### **Motion & Effects**

- Use Tailwind's `transition`, `animate`, and custom keyframes for UI motion.
- For advanced effects (e.g., cursor trails, electric sparks), extend Tailwind with custom CSS or use inline `` blocks.

---

### **Experience Description**

> The Cowboy AI interface is sharp and polished—glowing from beneath like a digital command panel. Deep neon blues provide structure, metallic details accentuate precision, and the spatial UI feels built for intelligent orchestration at scale.

---

### **Implementation Notes**

- **Adhere to this guide for all new components and pages.**
- **Use only Leptos and TailwindCSS for all UI logic and styling.**
- **Iterate with Cursor's AI features for rapid prototyping and refinement[7][11].**
- **Maintain consistency by sharing this guide (or a `.cursorrules` equivalent) with your team[4].**

---

**End of Style Guide**

Citations:
[1] https://www.builder.io/blog/cursor-tips
[2] https://docs.cursor.com/get-started/welcome
[3] https://www.reddit.com/r/ChatGPTCoding/comments/1guy4sz/cursor_ai_to_build_web_application_from_scratch/
[4] https://apidog.com/blog/awesome-cursor-rules/
[5] https://www.datacamp.com/tutorial/cursor-ai-code-editor
[6] https://github.com/TheCowboyAI/csr-start-trunk
[7] https://uxplanet.org/vibe-coding-for-web-with-cursor-ai-0059aa5e5803
[8] https://github.com/KCaverly/leptos-tailwind
[9] https://www.cursor.com
[10] https://kivalm.com/blog/dev/rustle/tailwind-leptos
[11] https://www.reddit.com/r/cursor/comments/1ivvi5q/how_do_you_handle_uxdesign_with_ai/
[12] https://www.reddit.com/r/rust/comments/1hz7829/leptos_tailwind_good_idea/
[13] https://www.youtube.com/watch?v=8MPElOdNjtk
[14] https://www.linkedin.com/learning/full-stack-web-applications-with-rust-and-leptos/integrating-tailwind-css
[15] https://forums.meteor.com/t/cursor-ide-rules/62897
[16] https://book.leptos.dev/interlude_styling.html
[17] https://8vi.cat/full-stack-with-rust-axum-leptos-tailwind-css/
[18] https://www.youtube.com/watch?v=jARisYp49JE
[19] https://akarras.com/blog/a-simple-blog-for-a-simple-man
