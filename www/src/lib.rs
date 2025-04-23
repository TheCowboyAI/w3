use leptos::*;
use leptos::prelude::*;
use leptos_router::components::{A, Route, Router, Routes};
use leptos_router::path;

// Modules
mod components;
mod pages;

// Import components and pages
use crate::components::*;
use crate::pages::home::Home;
use crate::pages::component_showcase::ComponentShowcase;
use crate::pages::not_found::NotFound;

/// Main app component
#[component]
pub fn App() -> impl IntoView {
    view! {
        <ThemeProvider>
            <Router>
                <div class="min-h-screen flex flex-col">
                    <header class="bg-base0D/10 shadow-sm border-b border-base03/20">
                        <div class="container mx-auto p-4 flex justify-between items-center">
                            <h1 class="text-2xl font-bold text-base0D">
                                <A href="/">"W3 Memory Bank"</A>
                            </h1>
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
                                    "Components"
                                </A>
                            </nav>
                        </div>
                    </header>
                    
                    <main class="flex-grow container mx-auto p-6">
                        <Routes fallback=|| view! { <NotFound/> }>
                            <Route path=path!("/") view=|| view! { <Home/> }/>
                            <Route path=path!("/showcase") view=|| view! { <ComponentShowcase/> }/>
                        </Routes>
                    </main>
                    
                    <footer class="bg-base01 text-base05">
                        <div class="container mx-auto p-4 text-center">
                            <p>"W3 Memory Bank © 2023"</p>
                        </div>
                    </footer>
                </div>
            </Router>
        </ThemeProvider>
    }
}
