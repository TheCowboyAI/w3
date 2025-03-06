use iced::{Application, Element, Settings, Subscription};
use iced::widget::{Button, Column, Text};
use async_nats::*;

const NATS_HOST: String = "nats://localhost:4222".to_string();

#[derive(Debug, Clone)]
enum Message {
    ContextEvent(String),
    ButtonClicked,
}

enum Cim {
    Initializing,
    Mapping,
    Ready,
    Degraded,
    Stopped
}

struct Porter {
    connection: Connection,
    last_event: Option,
}

impl Application for Porter {
    type Executor = iced::executor::Default;
    type Message = Message;
    type Flags = ();

    fn new(_flags: ()) -> (Porter, Command) {
        let conn = async_nats::connect(NATS_HOST).ok();

        (
            Cim {
                nats_conn: conn,
                last_event: None,
            },
            Command::none(),
        )
    }

    fn title(&self) -> String {
        String::from("Iced + NATS Event Hierarchy")
    }

    fn update(&mut self, message: Message) -> Command {
        match message {
            Message::ButtonClicked => {
                if let Some(conn) = &self.nats_conn {
                    conn.publish("context.ui.button.clicked", "Button clicked").unwrap();
                }
                Command::none()
            }
            Message::ContextEvent(payload) => {
                self.last_event = Some(payload);
                Command::none()
            }
        }
    }

    fn subscription(&self) -> Subscription {
        // Subscribe to context-level updates
        iced::Subscription::from_recipe(NatsSubscription {
            subject: "context.ui.notifications".to_string(),
        })
    }

    fn view(&self) -> Element {
        let content = Column::new()
            .push(Button::new(Text::new("Click Me")).on_press(Message::ButtonClicked))
            .push(Text::new(
                self.last_event
                    .as_deref()
                    .unwrap_or("No notifications yet"),
            ));
        
        content.into()
    }
}

struct NatsSubscription {
    subject: String,
}

impl iced_native::subscription::Recipe for NatsSubscription
where
    H: std::hash::Hasher,
{
    type Output = Message;

    fn hash(&self, state: &mut H) {
        self.subject.hash(state);
    }

    fn stream(self: Box, _input: I) -> futures::stream::BoxStream {
        // Implement subscription logic here
        futures::stream::empty().boxed()
    }
}

fn main() {
    MyApp::run(Settings::default());
}
