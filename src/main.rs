pub mod nats;
mod styles;

use crate::nats::{connect, ChatMessage, Connection, Event};
use crate::styles::*;
use iced::widget::{self, button, column, container, row, scrollable, text, text_input};
use iced::{alignment, Application, Command, Element, Length, Subscription, Theme};
use std::sync::LazyLock;

pub fn main() -> iced::Result {
    NatsChat::run(iced::Settings {
        antialiasing: true,
        default_text_size: iced::Pixels(16.0),
        window: iced::window::Settings {
            size: iced::Size {
                width: 800.0,
                height: 600.0,
            },
            ..Default::default()
        },
        default_font: iced::Font::with_name("Noto Sans"),
        ..Default::default()
    })
}

struct NatsChat {
    messages: Vec<ChatMessage>,
    new_message: String,
    state: State,
}

#[derive(Debug, Clone)]
enum Message {
    NewMessageChanged(String),
    Send(ChatMessage),
    Nats(Event),
}

impl NatsChat {
    fn new() -> (Self, Command<Message>) {
        (
            Self {
                messages: Vec::new(),
                new_message: String::new(),
                state: State::Disconnected,
            },
            widget::focus_next(),
        )
    }

    fn update(&mut self, message: Message) -> Command<Message> {
        match message {
            Message::NewMessageChanged(new_message) => {
                self.new_message = new_message;
                Command::none()
            }
            Message::Send(message) => match &mut self.state {
                State::Connected(connection) => {
                    self.new_message.clear();
                    connection.send(message);
                    Command::none()
                }
                State::Disconnected => Command::none(),
            },
            Message::Nats(event) => match event {
                Event::Connected(connection) => {
                    self.state = State::Connected(connection);
                    self.messages.push(ChatMessage::connected());
                    Command::none()
                }
                Event::Disconnected => {
                    self.state = State::Disconnected;
                    self.messages.push(ChatMessage::disconnected());
                    Command::none()
                }
                Event::MessageReceived(message) => {
                    self.messages.push(message);
                    scrollable::snap_to(MESSAGE_LOG.clone(), scrollable::RelativeOffset::END)
                }
            },
        }
    }

    fn subscription(&self) -> Subscription<Message> {
        connect().map(Message::Nats)
    }

    fn view(&self) -> Element<Message> {
        let message_log: Element<_> = if self.messages.is_empty() {
            container(
                text("Your messages will appear here...")
                    .style(TEXT_MUTED)
                    .size(24),
            )
            .width(Length::Fill)
            .height(Length::Fill)
            .center_x()
            .center_y()
            .style(iced::theme::Container::Custom(Box::new(DarkContainer)))
            .into()
        } else {
            scrollable(
                column(
                    self.messages
                        .iter()
                        .map(|msg| text(msg.to_string()).size(20).style(TEXT_BRIGHT).into())
                        .collect::<Vec<_>>(),
                )
                .spacing(15),
            )
            .id(MESSAGE_LOG.clone())
            .height(Length::Fill)
            .style(iced::theme::Scrollable::Custom(Box::new(DarkScrollable)))
            .into()
        };

        let new_message_input = {
            let mut input = text_input("Type a message...", &self.new_message)
                .on_input(Message::NewMessageChanged)
                .size(20)
                .padding(12)
                .style(iced::theme::TextInput::Custom(Box::new(HighContrastInput)));

            let mut button = button(
                text("Send")
                    .size(20)
                    .height(Length::Fixed(44.0))
                    .vertical_alignment(alignment::Vertical::Center)
                    .style(TEXT_BRIGHT),
            )
            .style(iced::theme::Button::Custom(Box::new(HighContrastButton)))
            .padding([0, 24]);

            if matches!(self.state, State::Connected(_)) {
                if let Some(message) = ChatMessage::new(&self.new_message) {
                    input = input.on_submit(Message::Send(message.clone()));
                    button = button.on_press(Message::Send(message));
                }
            }

            row![input, button]
                .spacing(10)
                .align_items(alignment::Alignment::Center)
        };

        container(
            column![message_log, new_message_input]
                .height(Length::Fill)
                .padding(20)
                .spacing(10),
        )
        .style(iced::theme::Container::Custom(Box::new(DarkContainer)))
        .width(Length::Fill)
        .height(Length::Fill)
        .into()
    }
}

impl Application for NatsChat {
    type Message = Message;
    type Theme = Theme;
    type Executor = iced::executor::Default;
    type Flags = ();

    fn new(_flags: Self::Flags) -> (Self, Command<Message>) {
        Self::new()
    }

    fn title(&self) -> String {
        String::from("NATS Chat - Iced")
    }

    fn update(&mut self, message: Message) -> Command<Message> {
        Self::update(self, message)
    }

    fn view(&self) -> Element<Message> {
        Self::view(self)
    }

    fn subscription(&self) -> Subscription<Message> {
        Self::subscription(self)
    }
}

enum State {
    Disconnected,
    Connected(Connection),
}

static MESSAGE_LOG: LazyLock<scrollable::Id> = LazyLock::new(scrollable::Id::unique);
