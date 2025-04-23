use leptos::*;
use leptos::prelude::*;
use leptos::html::ElementChild;

#[derive(Clone, Debug, PartialEq)]
pub enum CardVariant {
    Basic,
    Elevated,
    Glass,
}

#[component]
pub fn Card(
    #[prop(default = false)] hoverable: bool,
    #[prop(default = CardVariant::Basic)] variant: CardVariant,
    #[prop(default = "")] class: &'static str,
    #[prop(into)] children: Children,
) -> impl IntoView {
    let mut class_list = match variant {
        CardVariant::Basic => "bg-surface rounded-lg p-6 ".to_string(),
        CardVariant::Elevated => "bg-surface-elevated rounded-lg shadow-md p-6 ".to_string(),
        CardVariant::Glass => "backdrop-blur-sm bg-surface/70 rounded-lg shadow-md p-6 ".to_string(),
    };
    
    // Add hoverable effect if requested
    if hoverable {
        class_list.push_str("transition-transform duration-200 hover:-translate-y-1 hover:shadow-lg ");
    }
    
    // Add any custom classes
    class_list.push_str(class);
    
    view! {
        <div class={class_list}>
            {children()}
        </div>
    }
} 