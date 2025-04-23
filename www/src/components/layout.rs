use leptos::*;
use leptos::prelude::*;
use crate::components::theme::{Theme, ThemeContext};
use crate::components::Navigation;
use leptos_router::components::Outlet;

/// Main layout component for the application
#[component]
pub fn MainLayout(
    #[prop(default = None)] class: Option<&'static str>,
) -> impl IntoView {
    let combined_class = format!(
        "min-h-screen flex flex-col transition-colors {}",
        class.unwrap_or("")
    );

    // Simple theme class
    let theme_class = "light";

    view! {
        <div class={combined_class} data-theme={theme_class}>
            <header class="bg-base0D/10 shadow-sm border-b border-base03/20">
                <div class="container mx-auto p-4 flex justify-between items-center">
                    <h1 class="text-2xl font-bold text-base0D">
                        <a href="/">"W3 Memory Bank"</a>
                    </h1>
                    <Navigation />
                </div>
            </header>
            
            <main class="flex-grow container mx-auto p-6">
                <Outlet/>
            </main>
            
            <footer class="bg-base01 text-base05">
                <div class="container mx-auto p-4 text-center">
                    <p>"W3 Memory Bank © 2023"</p>
                </div>
            </footer>
        </div>
    }
} 