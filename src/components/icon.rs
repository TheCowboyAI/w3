use leptos::*;

#[component]
pub fn Icon(
    #[prop(into)] name: String,
    #[prop(optional)] class: Option<String>,
    #[prop(optional)] variant: Option<String>,
) -> impl IntoView {
    let variant_class = match variant.unwrap_or_default().as_str() {
        "nav" => "nav-icon",
        "action" => "action-icon",
        "success" => "status-icon-success",
        "warning" => "status-icon-warning",
        "error" => "status-icon-error",
        "info" => "status-icon-info",
        "branded" => "branded-icon",
        _ => ""
    };
    
    create_effect(move |_| {
        // This assumes we're using feather icons which is loaded in index.html
        let window = web_sys::window().expect("window not available");
        let document = window.document().expect("document not available");
        
        // This is a simplistic approach - in a real app, you'd want to handle this more robustly
        let _ = document.query_selector_all("[data-feather]").expect("query failed");
        
        // Call feather.replace() via JS
        let _ = js_sys::eval("if (typeof feather !== 'undefined') feather.replace();");
    });
    
    view! {
        <i 
            data-feather=name 
            class={format!("icon {} {}", 
                variant_class, 
                class.unwrap_or_default()
            )}
        ></i>
    }
} 