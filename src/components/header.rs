use leptos::*;

use crate::components::floating_logo::FloatingLogo;

#[component]
pub fn Header() -> impl IntoView {
    let (is_menu_open, set_is_menu_open) = create_signal(false);
    
    let toggle_menu = move |_| {
        set_is_menu_open.update(|open| *open = !*open);
    };
    
    view! {
        <header class="header bg-base01 backdrop-blur-sm bg-opacity-90 fixed top-0 left-0 right-0 z-50">
            <div class="container mx-auto px-4 py-3 flex items-center justify-between">
                <a href="/" class="header-logo flex items-center gap-3">
                    <FloatingLogo size="w-10" />
                    <span class="font-display text-base0D text-lg tracking-wider">
                        "W3"
                    </span>
                </a>
                
                <nav class="hidden md:flex items-center gap-8">
                    <NavLink href="/" active_class="active">
                        "Home"
                    </NavLink>
                    <NavLink href="/components" active_class="active">
                        "Components"
                    </NavLink>
                    <NavLink href="/visualizations" active_class="active">
                        "Visualizations"
                    </NavLink>
                    <NavLink href="/animations" active_class="active">
                        "Animations"
                    </NavLink>
                </nav>
                
                <button 
                    class="md:hidden nav-toggle" 
                    aria-label="Toggle menu"
                    on:click=toggle_menu
                >
                    <div class="icon-menu h-6 w-6 flex flex-col justify-around">
                        <span class="block w-full h-0.5 bg-base0D transition-all"></span>
                        <span class="block w-full h-0.5 bg-base0D transition-all"></span>
                        <span class="block w-full h-0.5 bg-base0D transition-all"></span>
                    </div>
                </button>
            </div>
            
            // Mobile menu
            <div 
                class="mobile-menu md:hidden overflow-hidden transition-all duration-300 bg-base01 bg-opacity-95 backdrop-blur-md"
                class:h-0=move || !is_menu_open()
                class:h-64=is_menu_open
            >
                <nav class="container mx-auto px-4 py-4 flex flex-col gap-4">
                    <NavLink 
                        href="/" 
                        active_class="active"
                        on:click=move |_| set_is_menu_open.set(false)
                    >
                        "Home"
                    </NavLink>
                    <NavLink 
                        href="/components" 
                        active_class="active"
                        on:click=move |_| set_is_menu_open.set(false)
                    >
                        "Components"
                    </NavLink>
                    <NavLink 
                        href="/visualizations" 
                        active_class="active"
                        on:click=move |_| set_is_menu_open.set(false)
                    >
                        "Visualizations"
                    </NavLink>
                    <NavLink 
                        href="/animations" 
                        active_class="active"
                        on:click=move |_| set_is_menu_open.set(false)
                    >
                        "Animations"
                    </NavLink>
                </nav>
            </div>
        </header>
        
        // Spacer to compensate for fixed header
        <div class="h-16"></div>
    }
}

#[component]
fn NavLink(
    href: &'static str, 
    active_class: &'static str,
    children: Children,
    #[prop(optional)] class: Option<&'static str>,
) -> impl IntoView {
    let location = use_location();
    
    let is_active = move || {
        let path = location.pathname.get();
        if href == "/" {
            path == href
        } else {
            path.starts_with(href)
        }
    };
    
    view! {
        <a 
            href=href
            class=format!(
                "nav-link text-base05 hover:text-base0D transition-all duration-300 {} {}",
                class.unwrap_or(""),
                if is_active() { active_class } else { "" }
            )
        >
            {children()}
        </a>
    }
} 