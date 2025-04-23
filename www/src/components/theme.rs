use leptos::*;
use leptos::prelude::*;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Theme {
    Light,
    Dark,
    HighContrast,
}

impl Theme {
    pub fn as_str(&self) -> &'static str {
        match self {
            Theme::Light => "light",
            Theme::Dark => "dark",
            Theme::HighContrast => "high-contrast",
        }
    }
}

#[derive(Clone, Debug)]
pub struct ThemeContext {
    pub theme: RwSignal<Theme>,
}

impl ThemeContext {
    pub fn new() -> Self {
        // Check if the user prefers dark mode
        let prefers_dark = window().match_media("(prefers-color-scheme: dark)")
            .ok()
            .flatten()
            .map(|media| media.matches())
            .unwrap_or(false);

        let default_theme = if prefers_dark { Theme::Dark } else { Theme::Light };
        let theme = create_rw_signal(default_theme);

        // Apply the theme to the document
        create_effect(move |_| {
            let theme_value = theme.get();
            let document = document();
            let html = document.document_element().expect("No document element");
            html.set_attribute("data-theme", theme_value.as_str()).expect("Failed to set theme attribute");
        });

        Self { theme }
    }

    pub fn toggle(&self) {
        self.theme.update(|current| {
            match *current {
                Theme::Light => *current = Theme::Dark,
                Theme::Dark => *current = Theme::Light,
                Theme::HighContrast => *current = Theme::Light,
            }
        });
    }

    pub fn set(&self, theme: Theme) {
        self.theme.set(theme);
    }
}

#[component]
pub fn ThemeProvider(children: Children) -> impl IntoView {
    let theme_context = ThemeContext::new();
    provide_context(theme_context.clone());

    view! {
        {children()}
    }
}

#[component]
pub fn ThemeToggle() -> impl IntoView {
    let theme_ctx = use_context::<ThemeContext>().expect("ThemeContext not found");
    let current_theme = theme_ctx.theme;

    let toggle_theme = move |_| {
        theme_ctx.toggle();
    };

    let theme_label = move || match current_theme.get() {
        Theme::Light => "🌙 Dark Mode",
        Theme::Dark => "☀️ Light Mode",
        Theme::HighContrast => "☀️ Light Mode",
    };

    view! {
        <button
            class="px-3 py-2 rounded-md bg-surface border border-border flex items-center space-x-2 transition-colors hover:bg-surface-elevated"
            aria-label="Toggle theme"
            on:click=toggle_theme
        >
            <span class="text-text-primary">{theme_label}</span>
        </button>
    }
}

// Use browser's window object to detect preferences
fn window() -> web_sys::Window {
    web_sys::window().expect("No window object")
}

fn document() -> web_sys::Document {
    window().document().expect("No document object")
} 