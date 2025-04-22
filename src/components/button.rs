use leptos::*;

#[component]
pub fn Button(
    #[prop(optional)] button_type: Option<String>,
    #[prop(optional)] class: Option<String>,
    #[prop(optional)] disabled: Option<bool>,
    #[prop(optional)] on_click: Option<Callback<MouseEvent>>,
    children: Children,
) -> impl IntoView {
    let button_type = button_type.unwrap_or_else(|| "button".to_string());
    let disabled = disabled.unwrap_or(false);
    
    let base_class = "inline-flex items-center justify-center px-4 py-2 rounded font-medium transition-all duration-300 focus:outline-none focus:ring-2 focus:ring-base0D focus:ring-opacity-50";
    
    view! {
        <button
            type=button_type
            class={format!("{} {}", base_class, class.unwrap_or_default())}
            disabled=disabled
            on:click=move |e| {
                if let Some(cb) = on_click {
                    cb.call(e);
                }
            }
        >
            {children()}
        </button>
    }
}

#[component]
pub fn PrimaryButton(
    #[prop(optional)] button_type: Option<String>,
    #[prop(optional)] class: Option<String>,
    #[prop(optional)] disabled: Option<bool>,
    #[prop(optional)] on_click: Option<Callback<MouseEvent>>,
    children: Children,
) -> impl IntoView {
    let custom_class = format!(
        "btn-primary bg-base0D hover:bg-opacity-80 text-base07 hover:shadow-glow-sm {}",
        class.unwrap_or_default()
    );
    
    view! {
        <Button
            button_type=button_type
            class=custom_class
            disabled=disabled
            on_click=on_click
        >
            {children()}
        </Button>
    }
}

#[component]
pub fn SecondaryButton(
    #[prop(optional)] button_type: Option<String>,
    #[prop(optional)] class: Option<String>,
    #[prop(optional)] disabled: Option<bool>,
    #[prop(optional)] on_click: Option<Callback<MouseEvent>>,
    children: Children,
) -> impl IntoView {
    let custom_class = format!(
        "btn-secondary border border-base0D text-base0D hover:bg-base0D hover:bg-opacity-10 {}",
        class.unwrap_or_default()
    );
    
    view! {
        <Button
            button_type=button_type
            class=custom_class
            disabled=disabled
            on_click=on_click
        >
            {children()}
        </Button>
    }
}

#[component]
pub fn GhostButton(
    #[prop(optional)] button_type: Option<String>,
    #[prop(optional)] class: Option<String>,
    #[prop(optional)] disabled: Option<bool>,
    #[prop(optional)] on_click: Option<Callback<MouseEvent>>,
    children: Children,
) -> impl IntoView {
    let custom_class = format!(
        "btn-ghost text-base05 hover:text-base0D hover:bg-base02 {}",
        class.unwrap_or_default()
    );
    
    view! {
        <Button
            button_type=button_type
            class=custom_class
            disabled=disabled
            on_click=on_click
        >
            {children()}
        </Button>
    }
}

#[component]
pub fn DangerButton(
    #[prop(optional)] button_type: Option<String>,
    #[prop(optional)] class: Option<String>,
    #[prop(optional)] disabled: Option<bool>,
    #[prop(optional)] on_click: Option<Callback<MouseEvent>>,
    children: Children,
) -> impl IntoView {
    let custom_class = format!(
        "btn-danger bg-base08 hover:bg-opacity-80 text-base07 {}",
        class.unwrap_or_default()
    );
    
    view! {
        <Button
            button_type=button_type
            class=custom_class
            disabled=disabled
            on_click=on_click
        >
            {children()}
        </Button>
    }
} 