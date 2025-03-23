use iced::{Background, Color};

// Color palette
pub const BACKGROUND_DARK: Color = Color::from_rgb(0.15, 0.15, 0.15); // #262626
pub const INPUT_BG: Color = Color::from_rgb(0.2, 0.2, 0.2); // #333333
pub const INPUT_BG_FOCUSED: Color = Color::from_rgb(0.25, 0.25, 0.25); // #404040
pub const TEXT_MUTED: Color = Color::from_rgb(0.8, 0.8, 0.8); // #CCCCCC
pub const TEXT_BRIGHT: Color = Color::from_rgb(0.9, 0.9, 0.9); // #E6E6E6
pub const BUTTON_PRIMARY: Color = Color::from_rgb(0.2, 0.4, 0.8); // #3366CC
pub const BUTTON_HOVER: Color = Color::from_rgb(0.25, 0.45, 0.85); // #3973D9
pub const BUTTON_PRESSED: Color = Color::from_rgb(0.15, 0.35, 0.75); // #2659BF
pub const BORDER_LIGHT: Color = Color::from_rgb(0.4, 0.4, 0.4); // #666666
pub const BORDER_FOCUS: Color = Color::from_rgb(0.5, 0.5, 0.5); // #808080
pub const SCROLLBAR: Color = Color::from_rgb(0.4, 0.4, 0.4); // #666666
pub const SCROLLBAR_HOVER: Color = Color::from_rgb(0.5, 0.5, 0.5); // #808080

pub struct DarkContainer;

impl iced::widget::container::StyleSheet for DarkContainer {
    type Style = iced::Theme;

    fn appearance(&self, _style: &Self::Style) -> iced::widget::container::Appearance {
        iced::widget::container::Appearance {
            background: Some(Background::Color(BACKGROUND_DARK)),
            text_color: Some(Color::WHITE),
            ..Default::default()
        }
    }
}

pub struct DarkScrollable;

impl iced::widget::scrollable::StyleSheet for DarkScrollable {
    type Style = iced::Theme;

    fn active(&self, _style: &Self::Style) -> iced::widget::scrollable::Appearance {
        iced::widget::scrollable::Appearance {
            container: iced::widget::container::Appearance {
                background: Some(Background::Color(BORDER_LIGHT)),
                border: iced::Border {
                    radius: 0.0.into(),
                    width: 0.0,
                    color: Color::TRANSPARENT,
                },
                ..Default::default()
            },
            scrollbar: iced::widget::scrollable::Scrollbar {
                background: Some(Background::Color(SCROLLBAR)),
                border: iced::Border {
                    radius: 2.0.into(),
                    width: 0.0,
                    color: Color::TRANSPARENT,
                },
                scroller: iced::widget::scrollable::Scroller {
                    color: SCROLLBAR,
                    border: iced::Border {
                        radius: 2.0.into(),
                        width: 0.0,
                        color: Color::TRANSPARENT,
                    },
                },
            },
            gap: None,
        }
    }

    fn hovered(
        &self,
        style: &Self::Style,
        is_mouse_over_scrollbar: bool,
    ) -> iced::widget::scrollable::Appearance {
        let mut appearance = self.active(style);
        if is_mouse_over_scrollbar {
            appearance.scrollbar.scroller.color = SCROLLBAR_HOVER;
        }
        appearance
    }
}

pub struct HighContrastInput;

impl iced::widget::text_input::StyleSheet for HighContrastInput {
    type Style = iced::Theme;

    fn active(&self, _style: &Self::Style) -> iced::widget::text_input::Appearance {
        iced::widget::text_input::Appearance {
            background: Background::Color(INPUT_BG),
            border: iced::Border {
                radius: 4.0.into(),
                width: 1.0,
                color: BORDER_LIGHT,
            },
            icon_color: Color::WHITE,
        }
    }

    fn focused(&self, _style: &Self::Style) -> iced::widget::text_input::Appearance {
        iced::widget::text_input::Appearance {
            background: Background::Color(INPUT_BG_FOCUSED),
            border: iced::Border {
                radius: 4.0.into(),
                width: 2.0,
                color: BORDER_FOCUS,
            },
            icon_color: Color::WHITE,
        }
    }

    fn placeholder_color(&self, _style: &Self::Style) -> Color {
        TEXT_MUTED
    }

    fn value_color(&self, _style: &Self::Style) -> Color {
        TEXT_BRIGHT
    }

    fn selection_color(&self, _style: &Self::Style) -> Color {
        Color::from_rgb(0.3, 0.5, 0.8)
    }

    fn disabled_color(&self, _style: &Self::Style) -> Color {
        Color::from_rgb(0.5, 0.5, 0.5)
    }

    fn disabled(&self, style: &Self::Style) -> iced::widget::text_input::Appearance {
        let active = self.active(style);
        iced::widget::text_input::Appearance {
            background: Background::Color(BACKGROUND_DARK),
            ..active
        }
    }
}

pub struct HighContrastButton;

impl iced::widget::button::StyleSheet for HighContrastButton {
    type Style = iced::Theme;

    fn active(&self, _style: &Self::Style) -> iced::widget::button::Appearance {
        iced::widget::button::Appearance {
            background: Some(Background::Color(BUTTON_PRIMARY)),
            border: iced::Border {
                radius: 4.0.into(),
                width: 1.0,
                color: BUTTON_PRIMARY,
            },
            text_color: Color::WHITE,
            shadow_offset: iced::Vector::default(),
            shadow: iced::Shadow::default(),
        }
    }

    fn hovered(&self, _style: &Self::Style) -> iced::widget::button::Appearance {
        iced::widget::button::Appearance {
            background: Some(Background::Color(BUTTON_HOVER)),
            border: iced::Border {
                radius: 4.0.into(),
                width: 1.0,
                color: BUTTON_PRIMARY,
            },
            text_color: Color::WHITE,
            shadow_offset: iced::Vector::default(),
            shadow: iced::Shadow::default(),
        }
    }

    fn pressed(&self, _style: &Self::Style) -> iced::widget::button::Appearance {
        iced::widget::button::Appearance {
            background: Some(Background::Color(BUTTON_PRESSED)),
            border: iced::Border {
                radius: 4.0.into(),
                width: 1.0,
                color: BUTTON_PRIMARY,
            },
            text_color: Color::WHITE,
            shadow_offset: iced::Vector::default(),
            shadow: iced::Shadow::default(),
        }
    }

    fn disabled(&self, style: &Self::Style) -> iced::widget::button::Appearance {
        let active = self.active(style);
        iced::widget::button::Appearance {
            background: Some(Background::Color(BACKGROUND_DARK)),
            text_color: Color::from_rgb(0.5, 0.5, 0.5),
            ..active
        }
    }
}
