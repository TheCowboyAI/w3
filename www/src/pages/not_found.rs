use leptos::*;
use leptos::prelude::*;
use leptos::html::ElementChild;
use crate::components::*;

/// 404 Page Not Found component - Fixed for Leptos 0.7.8
#[component]
pub fn NotFound() -> impl IntoView {
    html::div()
        .class("min-h-screen bg-background flex items-center justify-center px-4")
        .child(
            html::div()
                .class("max-w-md w-full text-center space-y-6")
                .child(
                    html::div()
                        .class("relative")
                        .child((
                            html::div()
                                .class("absolute inset-0 flex items-center justify-center opacity-10")
                                .child(
                                    html::div()
                                        .class("text-9xl font-bold text-base08")
                                        .child("404")
                                ),
                            html::div()
                                .class("relative z-10 py-16")
                                .child((
                                    html::h1()
                                        .class("text-4xl font-orbitron font-bold tracking-orbitron mb-6 text-base08")
                                        .child("Page Not Found"),
                                    html::p()
                                        .class("text-base font-inter")
                                        .child("The page you are looking for does not exist or has been moved."),
                                    html::div()
                                        .class("mt-8")
                                        .child(
                                            html::a()
                                                .attr("href", "/")
                                                .class("inline-flex items-center justify-center px-5 py-2.5 rounded-md bg-base0D hover:bg-base0D/80 text-white transition-colors")
                                                .child((
                                                    html::span()
                                                        .class("mr-2")
                                                        .child("<"),
                                                    html::span()
                                                        .child("Return Home")
                                                ))
                                        )
                                ))
                        ))
                )
        )
}
