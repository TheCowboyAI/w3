use leptos::*;
use leptos::prelude::*;
use leptos::html::ElementChild;
use leptos::attr::global::ClassAttribute;

// Heading Components
#[component]
pub fn Heading1(
    #[prop(into)] children: Children,
    #[prop(optional)] class: Option<String>,
) -> impl IntoView {
    let class_value = format!("text-4xl font-orbitron font-bold tracking-orbitron {}", class.unwrap_or_default());
    
    view! {
        <h1 class={class_value}>
            {children()}
        </h1>
    }
}

#[component]
pub fn Heading2(
    #[prop(into)] children: Children,
    #[prop(optional)] class: Option<String>,
) -> impl IntoView {
    let class_value = format!("text-3xl font-orbitron font-bold tracking-wide {}", class.unwrap_or_default());
    
    view! {
        <h2 class={class_value}>
            {children()}
        </h2>
    }
}

#[component]
pub fn Heading3(
    #[prop(into)] children: Children,
    #[prop(optional)] class: Option<String>,
) -> impl IntoView {
    let class_value = format!("text-2xl font-outfit font-semibold {}", class.unwrap_or_default());
    
    view! {
        <h3 class={class_value}>
            {children()}
        </h3>
    }
}

#[component]
pub fn Heading4(
    #[prop(into)] children: Children,
    #[prop(optional)] class: Option<String>,
) -> impl IntoView {
    let class_value = format!("text-xl font-outfit font-semibold {}", class.unwrap_or_default());
    
    view! {
        <h4 class={class_value}>
            {children()}
        </h4>
    }
}

#[component]
pub fn Heading5(
    #[prop(into)] children: Children,
    #[prop(optional)] class: Option<String>,
) -> impl IntoView {
    let class_value = format!("text-lg font-outfit font-semibold {}", class.unwrap_or_default());
    
    view! {
        <h5 class={class_value}>
            {children()}
        </h5>
    }
}

// Body Text Components
#[component]
pub fn BodyLarge(
    #[prop(into)] children: Children,
    #[prop(optional)] class: Option<String>,
) -> impl IntoView {
    let class_value = format!("text-xl font-inter {}", class.unwrap_or_default());
    
    view! {
        <p class={class_value}>
            {children()}
        </p>
    }
}

#[component]
pub fn Body(
    #[prop(into)] children: Children,
    #[prop(optional)] class: Option<String>,
) -> impl IntoView {
    let class_value = format!("text-base font-inter {}", class.unwrap_or_default());
    
    view! {
        <p class={class_value}>
            {children()}
        </p>
    }
}

#[component]
pub fn BodySmall(
    #[prop(into)] children: Children,
    #[prop(optional)] class: Option<String>,
) -> impl IntoView {
    let class_value = format!("text-sm font-inter {}", class.unwrap_or_default());
    
    view! {
        <p class={class_value}>
            {children()}
        </p>
    }
}

#[component]
pub fn Caption(
    #[prop(into)] children: Children,
    #[prop(optional)] class: Option<String>,
) -> impl IntoView {
    let class_value = format!("text-xs font-inter text-text-secondary {}", class.unwrap_or_default());
    
    view! {
        <p class={class_value}>
            {children()}
        </p>
    }
}

// Code Display Components
#[component]
pub fn CodeBlock(
    #[prop(into)] code: String,
    #[prop(optional)] language: Option<String>,
    #[prop(optional)] class: Option<String>,
) -> impl IntoView {
    let class_value = format!("p-4 rounded-md bg-surface-elevated overflow-x-auto {}", class.unwrap_or_default());
    let code_class = format!("font-mono text-sm {}", language.unwrap_or_default());
    
    view! {
        <pre class={class_value}>
            <code class={code_class}>
                {code}
            </code>
        </pre>
    }
}

#[component]
pub fn InlineCode(
    #[prop(into)] children: Children,
    #[prop(optional)] class: Option<String>,
) -> impl IntoView {
    let class_value = format!("px-1.5 py-0.5 rounded font-mono text-sm bg-surface {}", class.unwrap_or_default());
    
    view! {
        <code class={class_value}>
            {children()}
        </code>
    }
} 