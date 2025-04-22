use leptos::*;

#[component]
pub fn Card(
    #[prop(optional)] class: Option<String>,
    #[prop(optional)] variant: Option<String>,
    children: Children,
) -> impl IntoView {
    let variant_class = match variant.unwrap_or_default().as_str() {
        "elevated" => "card-elevated bg-base01 shadow-md hover:shadow-lg",
        "outlined" => "card-outlined border border-base02",
        "glowing" => "card-glowing border border-base0D shadow-glow-sm hover:shadow-glow-md",
        _ => "card-default bg-base01 bg-opacity-50 backdrop-blur-sm"
    };
    
    view! {
        <div class={format!("card rounded-lg p-6 transition-all duration-300 {} {}", 
            variant_class, 
            class.unwrap_or_default()
        )}>
            {children()}
        </div>
    }
}

#[component]
pub fn CardHeader(
    #[prop(optional)] class: Option<String>,
    children: Children,
) -> impl IntoView {
    view! {
        <div class={format!("card-header mb-4 pb-2 border-b border-base02 {} ", 
            class.unwrap_or_default()
        )}>
            {children()}
        </div>
    }
}

#[component]
pub fn CardTitle(
    #[prop(optional)] class: Option<String>,
    children: Children,
) -> impl IntoView {
    view! {
        <h3 class={format!("card-title text-xl font-display text-base0D {} ", 
            class.unwrap_or_default()
        )}>
            {children()}
        </h3>
    }
}

#[component]
pub fn CardBody(
    #[prop(optional)] class: Option<String>,
    children: Children,
) -> impl IntoView {
    view! {
        <div class={format!("card-body {} ", 
            class.unwrap_or_default()
        )}>
            {children()}
        </div>
    }
}

#[component]
pub fn CardFooter(
    #[prop(optional)] class: Option<String>,
    children: Children,
) -> impl IntoView {
    view! {
        <div class={format!("card-footer mt-4 pt-2 border-t border-base02 {} ", 
            class.unwrap_or_default()
        )}>
            {children()}
        </div>
    }
} 