use leptos::*;
use leptos::prelude::*;
use leptos::html::ElementChild;
use crate::components::*;

/// Design System Page - Fixed for Leptos 0.7.8
#[component]
pub fn DesignSystem() -> impl IntoView {
    html::div()
        .class("min-h-screen bg-background")
        .child((
            html::header()
                .class("bg-surface border-b border-border sticky top-0 z-10 backdrop-blur-md")
                .child(
                    html::div()
                        .class("container mx-auto px-4 py-4 flex justify-between items-center")
                        .child((
                            html::a()
                                .attr("href", "/")
                                .class("text-2xl font-orbitron font-bold tracking-wider text-text-primary")
                                .child("W3"),
                            html::div()
                                .class("flex items-center space-x-4")
                                .child((
                                    html::a()
                                        .attr("href", "/")
                                        .class("text-base font-inter text-text-secondary hover:text-primary")
                                        .child("Home"),
                                    ThemeToggle()
                                ))
                        ))
                ),
            html::main()
                .class("container mx-auto px-4 py-8")
                .child(
                    html::div()
                        .class("max-w-4xl mx-auto")
                        .child((
                            html::h1()
                                .class("text-4xl font-orbitron font-bold tracking-orbitron mb-6")
                                .child("Crystalline Neon Design System"),
                            html::p()
                                .class("text-base font-inter mb-8")
                                .child("This page showcases the components and design patterns of the Crystalline Neon design system, featuring a futuristic aesthetic with glass morphism, neon accents, and dark mode support."),
                            html::div()
                                .class("space-y-16")
                                .child((
                                    html::section()
                                        .attr("id", "typography")
                                        .child((
                                            html::h2()
                                                .class("text-3xl font-orbitron font-bold tracking-wide mb-8")
                                                .child("Typography"),
                                            "Typography Showcase (Builder-based implementation)"
                                        )),
                                    html::section()
                                        .attr("id", "buttons")
                                        .child((
                                            html::h2()
                                                .class("text-3xl font-orbitron font-bold tracking-wide mb-8")
                                                .child("Buttons"),
                                            "Button Showcase (Builder-based implementation)"
                                        )),
                                    html::section()
                                        .attr("id", "cards")
                                        .child((
                                            html::h2()
                                                .class("text-3xl font-orbitron font-bold tracking-wide mb-8")
                                                .child("Cards"),
                                            "Card Showcase (Builder-based implementation)"
                                        )),
                                    html::section()
                                        .attr("id", "colors")
                                        .child((
                                            html::h2()
                                                .class("text-3xl font-orbitron font-bold tracking-wide mb-8")
                                                .child("Colors"),
                                            ColorShowcaseSimple()
                                        ))
                                ))
                        ))
                ),
            html::footer()
                .class("border-t border-border py-8 mt-16")
                .child(
                    html::div()
                        .class("container mx-auto px-4 text-center text-text-secondary")
                        .child(
                            html::p()
                                .class("font-inter text-sm")
                                .child("Crystalline Neon Design System - Built with Leptos and Rust")
                        )
                )
        ))
}

/// Simplified color showcase that doesn't rely on our custom components
#[component]
fn ColorShowcaseSimple() -> impl IntoView {
    html::div()
        .class("p-8")
        .child((
            html::h3()
                .class("text-2xl font-outfit font-semibold")
                .child("Color System"),
            html::p()
                .class("text-base font-inter mb-8")
                .child("The Crystalline Neon color system is built on a modified Base16 palette with semantic variable names for consistent application across the interface."),
            html::div()
                .class("grid grid-cols-2 md:grid-cols-4 gap-6")
                .child((
                    ColorSwatchSimple("bg-primary".to_string(), "Primary".to_string(), "#00B0FF".to_string(), false),
                    ColorSwatchSimple("bg-secondary".to_string(), "Secondary".to_string(), "#B388FF".to_string(), false),
                    ColorSwatchSimple("bg-accent".to_string(), "Accent".to_string(), "#00E5FF".to_string(), false),
                    ColorSwatchSimple("bg-error".to_string(), "Error".to_string(), "#FF5252".to_string(), false),
                    ColorSwatchSimple("bg-surface".to_string(), "Surface".to_string(), "#0A1220".to_string(), false),
                    ColorSwatchSimple("bg-surface-elevated".to_string(), "Surface Elevated".to_string(), "#111B2A".to_string(), false),
                    ColorSwatchSimple("bg-background".to_string(), "Background".to_string(), "#050A12".to_string(), false),
                    ColorSwatchSimple("bg-border".to_string(), "Border".to_string(), "#1A2535".to_string(), false),
                    ColorSwatchSimple("text-text-primary".to_string(), "Text Primary".to_string(), "#FDFEFF".to_string(), true),
                    ColorSwatchSimple("text-text-secondary".to_string(), "Text Secondary".to_string(), "#A3B8CC".to_string(), true),
                    ColorSwatchSimple("text-text-tertiary".to_string(), "Text Tertiary".to_string(), "#6A7A8C".to_string(), true),
                    ColorSwatchSimple("bg-muted".to_string(), "Muted".to_string(), "#172334".to_string(), false)
                ))
        ))
}

/// Simple function to create a color swatch without using the component macro
fn ColorSwatchSimple(color: String, label: String, hex: String, white_text: bool) -> impl IntoView {
    let text_color = if white_text {
        "text-white"
    } else {
        "text-text-primary"
    };

    html::div()
        .class("flex flex-col")
        .child((
            html::div()
                .class(format!("{} h-20 rounded-md shadow-md", color))
                .child(
                    html::div()
                        .class(format!("h-full flex items-center justify-center {}", text_color))
                        .child(label)
                ),
            html::p()
                .class("text-sm font-mono mt-2 text-text-secondary text-center")
                .child(hex)
        ))
} 