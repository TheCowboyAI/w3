use leptos::*;
use leptos_meta::*;
use leptos_router::*;

mod components;
mod styles;

use crate::components::{
    header::Header,
    footer::Footer,
    floating_logo::FloatingLogo,
};

#[component]
fn App() -> impl IntoView {
    // Set up metadata
    provide_meta_context();

    view! {
        <Stylesheet id="leptos" href="/styles/output.css"/>
        <Title text="W3 - Crystalline Neon"/>
        <Meta name="description" content="W3 Project with Crystalline Neon design system"/>
        
        <Router>
            <div class="app-container bg-base00 min-h-screen text-base05 font-primary">
                <Header />
                
                <main class="container mx-auto px-4 py-8">
                    <Routes>
                        <Route path="/" view=HomePage />
                        <Route path="/components" view=ComponentsPage />
                        <Route path="/visualizations" view=VisualizationsPage />
                        <Route path="/animations" view=AnimationsPage />
                        <Route path="/*" view=NotFoundPage />
                    </Routes>
                </main>
                
                <Footer />
            </div>
        </Router>
    }
}

#[component]
fn HomePage() -> impl IntoView {
    view! {
        <section class="hero py-20 flex flex-col items-center justify-center text-center">
            <FloatingLogo size="w-64" />
            
            <h1 class="text-display font-display mt-8 mb-4 text-base0D glow-text-subtle">
                "Crystalline Neon"
            </h1>
            
            <p class="text-base06 max-w-lg mb-12">
                "A modern web application featuring a futuristic, minimalist aesthetic with purposeful animations and clean interfaces."
            </p>
            
            <div class="flex gap-4">
                <a href="/components" class="btn-primary">
                    "Explore Components"
                </a>
                <a href="/visualizations" class="btn-secondary">
                    "View Visualizations"
                </a>
            </div>
        </section>
        
        <section class="features py-16 grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="feature-card">
                <h3 class="font-display text-base0C mb-2">
                    "Modern Design System"
                </h3>
                <p class="text-base04">
                    "Clean interfaces with strategic use of vibrant highlights against neutral backgrounds."
                </p>
            </div>
            
            <div class="feature-card">
                <h3 class="font-display text-base0D mb-2">
                    "Interactive Visualizations"
                </h3>
                <p class="text-base04">
                    "Graph-based data visualization with intuitive interaction patterns."
                </p>
            </div>
            
            <div class="feature-card">
                <h3 class="font-display text-base0E mb-2">
                    "Fluid Animations"
                </h3>
                <p class="text-base04">
                    "Purposeful motion that enhances user experience without distraction."
                </p>
            </div>
        </section>
    }
}

#[component]
fn ComponentsPage() -> impl IntoView {
    view! {
        <h1 class="page-title">
            "Component Library"
        </h1>
        <p class="page-description">
            "Explore the Crystalline Neon design system components"
        </p>
        
        <div class="component-grid">
            <p>"Components will be implemented in the next phase."</p>
        </div>
    }
}

#[component]
fn VisualizationsPage() -> impl IntoView {
    view! {
        <h1 class="page-title">
            "Graph Visualizations"
        </h1>
        <p class="page-description">
            "Interactive data visualization with the Crystalline Neon aesthetic"
        </p>
        
        <div class="visualization-container">
            <p>"Visualizations will be implemented in the next phase."</p>
        </div>
    }
}

#[component]
fn AnimationsPage() -> impl IntoView {
    view! {
        <h1 class="page-title">
            "Animation System"
        </h1>
        <p class="page-description">
            "Fluid, purposeful motion that enhances the user experience"
        </p>
        
        <div class="animation-showcase">
            <p>"Animations will be implemented in the next phase."</p>
        </div>
    }
}

#[component]
fn NotFoundPage() -> impl IntoView {
    view! {
        <div class="not-found">
            <h1 class="text-display font-display text-base08 glow-text">
                "404"
            </h1>
            <p class="text-base06 mb-8">
                "The page you're looking for doesn't exist."
            </p>
            <a href="/" class="btn-primary">
                "Return Home"
            </a>
        </div>
    }
}

fn main() {
    console_error_panic_hook::set_once();
    wasm_logger::init(wasm_logger::Config::default());
    
    mount_to_body(|| view! { <App /> });
} 