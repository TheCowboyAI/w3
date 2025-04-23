use leptos::*;
use leptos::prelude::*;
use crate::typography::*;
use crate::components::*;

/// Component Showcase Page - Fixed for Leptos 0.7.8
#[component]
pub fn ComponentShowcase() -> impl IntoView {
    // Simplified version using builder pattern to avoid view! macro issues
    html::div()
        .class("container mx-auto px-4 py-16 space-y-16")
        .child((
            html::section()
                .class("mb-16")
                .child((
                    html::h1()
                        .class("text-4xl font-orbitron font-bold tracking-orbitron mb-8")
                        .child("Typography"),
                    html::div()
                        .class("space-y-6")
                        .child((
                            html::div()
                                .child((
                                    html::h1()
                                        .class("text-4xl font-orbitron font-bold tracking-orbitron mb-2")
                                        .child("Heading 1"),
                                    html::p()
                                        .class("text-base font-inter text-text-secondary")
                                        .child("Used for main page titles and hero sections.")
                                )),
                            html::div()
                                .child((
                                    html::h2()
                                        .class("text-3xl font-orbitron font-bold tracking-wide mb-2")
                                        .child("Heading 2"),
                                    html::p()
                                        .class("text-base font-inter text-text-secondary")
                                        .child("Used for section titles and important content groupings.")
                                )),
                            html::div()
                                .child((
                                    html::h3()
                                        .class("text-2xl font-outfit font-semibold mb-2")
                                        .child("Heading 3"),
                                    html::p()
                                        .class("text-base font-inter text-text-secondary")
                                        .child("Used for subsection titles and feature highlights.")
                                ))
                        ))
                )),
            html::section()
                .class("mb-16")
                .child((
                    html::h1()
                        .class("text-4xl font-orbitron font-bold tracking-orbitron mb-8")
                        .child("Buttons"),
                    html::div()
                        .class("flex flex-wrap gap-4")
                        .child((
                            html::button()
                                .class("btn-primary")
                                .child("Primary Button Example"),
                            html::button()
                                .class("btn-secondary")
                                .child("Secondary Button Example"),
                            html::button()
                                .class("btn-text")
                                .child("Text Button Example")
                        ))
                ))
        ))
} 