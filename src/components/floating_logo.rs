use leptos::*;

#[component]
pub fn FloatingLogo(
    #[prop(optional)] class: Option<String>,
    #[prop(optional)] size: Option<String>,
) -> impl IntoView {
    let size_class = size.unwrap_or_else(|| "w-48".to_string());
    
    view! {
        <div class={format!("floating-logo {} {}", size_class, class.unwrap_or_default())}>
            <img src="/assets/cowboyai-logo.svg" alt="CowboyAI Logo" />
        </div>
    }
} 