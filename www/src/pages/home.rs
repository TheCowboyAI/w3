use leptos::*;
use leptos::prelude::*;
use leptos::html::ElementChild;
use crate::components::{ThemeToggle};

/// Home Page - Simplified for building
#[component]
pub fn Home() -> impl IntoView {
    let _hello = "Hello World"; // Prefixed with underscore to avoid unused warning
    
    html::div()
        .class("min-h-screen bg-background")
        .child((
            html::header()
                .class("bg-surface/70 backdrop-blur-md border-b border-border sticky top-0 z-10")
                .child(
                    html::div()
                        .class("container mx-auto px-4 py-4 flex justify-between items-center")
                        .child((
                            html::div()
                                .class("flex items-center space-x-2")
                                .child((
                                    html::span()
                                        .class("text-2xl font-orbitron font-bold tracking-wider text-text-primary")
                                        .child("W3"),
                                    html::span()
                                        .class("text-base font-inter text-text-secondary")
                                        .child("Memory Bank")
                                )),
                            html::nav()
                                .child(
                                    html::ul()
                                        .class("flex space-x-4")
                                        .child((
                                            html::li()
                                                .child(
                                                    html::a()
                                                        .attr("href", "/")
                                                        .class("text-base font-inter font-medium text-text-primary hover:text-primary")
                                                        .child("Home")
                                                ),
                                            html::li()
                                                .child(
                                                    html::a()
                                                        .attr("href", "/design-system")
                                                        .class("text-base font-inter font-medium text-text-secondary hover:text-primary")
                                                        .child("Design System")
                                                ),
                                            html::li()
                                                .child(ThemeToggle())
                                        ))
                                )
                        ))
                ),
            html::main()
                .child(
                    html::section()
                        .class("py-16 md:py-24 container mx-auto px-4")
                        .child(
                            html::div()
                                .class("max-w-4xl mx-auto text-center space-y-8")
                                .child((
                                    html::h1()
                                        .class("text-4xl md:text-5xl font-orbitron font-bold tracking-wider leading-tight text-text-primary")
                                        .child((
                                            html::span()
                                                .class("bg-clip-text text-transparent bg-gradient-to-r from-primary to-accent")
                                                .child("Crystalline Neon"),
                                            html::br(),
                                            "Memory Bank"
                                        )),
                                    html::p()
                                        .class("text-xl font-inter text-text-secondary leading-relaxed")
                                        .child("A futuristic web interface built with Leptos, Rust, and WebAssembly. Featuring a comprehensive design system with a Crystalline Neon aesthetic.")
                                ))
                        )
                )
        ))
}
