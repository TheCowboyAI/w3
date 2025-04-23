use leptos::*;
use leptos::prelude::*;
use leptos::html::ElementChild;

#[derive(Clone, Debug, PartialEq)]
pub enum ButtonVariant {
    Primary,
    Secondary,
    Text,
}

#[component]
pub fn Button(
    #[prop(into, optional)] label: MaybeSignal<String>,
    #[prop(optional)] variant: Option<ButtonVariant>,
    #[prop(optional)] class: Option<String>,
    #[prop(optional)] on_click: Option<Box<dyn Fn(ev::MouseEvent) + 'static>>,
    #[prop(optional)] disabled: Option<bool>,
    #[prop(optional)] children: Option<Children>,
) -> impl IntoView {
    let variant = variant.unwrap_or(ButtonVariant::Primary);
    let disabled = disabled.unwrap_or(false);

    let base_class = move || {
        let variant_class = match variant {
            ButtonVariant::Primary => "btn-primary",
            ButtonVariant::Secondary => "btn-secondary",
            ButtonVariant::Text => "btn-text",
        };
        
        let disabled_class = if disabled { " opacity-50 cursor-not-allowed" } else { "" };
        
        format!("{}{} {}", variant_class, disabled_class, class.clone().unwrap_or_default())
    };

    view! {
        <button 
            class=base_class
            on:click=move |evt| {
                if !disabled {
                    if let Some(on_click) = on_click.as_ref() {
                        on_click(evt)
                    }
                }
            }
            disabled=disabled
        >
            {move || label.get()}
            {children.map(|children| children())}
        </button>
    }
}

// Usage example component that shows both button variants
#[component]
pub fn ButtonShowcase() -> impl IntoView {
    let (count, set_count) = create_signal(0);
    let increment = move |evt: ev::MouseEvent| set_count.update(|n| *n += 1);

    view! {
        <div>
            <h2>"Button Showcase"</h2>
            <div class="flex gap-2 items-center">
                <Button on_click=Box::new(increment) variant=ButtonVariant::Primary>
                    "Primary Button"
                </Button>
                <Button on_click=Box::new(increment) variant=ButtonVariant::Secondary>
                    "Secondary Button"
                </Button>
                <Button on_click=Box::new(increment) variant=ButtonVariant::Text>
                    "Text Button"
                </Button>
                <Button on_click=Box::new(increment) disabled=true>
                    "Disabled Button"
                </Button>
                <div>"Count: " {count}</div>
            </div>
        </div>
    }
} 