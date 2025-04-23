use leptos::*;
use leptos::prelude::*;
use leptos_router::components::A;

/// Navigation component for the application
#[component]
pub fn Navigation() -> impl IntoView {
    view! {
        <nav class="flex space-x-4">
            <A 
                href="/" 
                attr:class="text-base05 hover:text-base0D px-3 py-2 rounded-md hover:bg-base01/50 transition-colors"
            >
                "Home"
            </A>
            <A 
                href="/showcase" 
                attr:class="text-base05 hover:text-base0D px-3 py-2 rounded-md hover:bg-base01/50 transition-colors"
            >
                "Component Showcase"
            </A>
        </nav>
    }
} 