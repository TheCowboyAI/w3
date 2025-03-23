pub use async_nats;
use iced::futures;
use iced::subscription::{self, Subscription};
use iced::widget::text;

use futures::channel::mpsc;
use futures::sink::SinkExt;
use futures::stream::StreamExt;
use std::fmt;

pub fn connect() -> Subscription<Event> {
    struct Connect;

    subscription::channel(
        std::any::TypeId::of::<Connect>(),
        100,
        |mut output| async move {
            loop {
                const NATS_SERVER: &str = "nats://localhost:4222";

                match async_nats::connect(NATS_SERVER).await {
                    Ok(client) => {
                        let (sender, mut receiver) = mpsc::channel(100);
                        output
                            .send(Event::Connected(Connection(sender, client.clone())))
                            .await
                            .unwrap();

                        // Subscribe to messages
                        let mut subscription = client.subscribe("chat").await.unwrap().fuse();

                        loop {
                            futures::select! {
                                message = subscription.next() => {
                                    match message {
                                        Some(msg) => {
                                            if let Ok(text) = String::from_utf8(msg.payload.to_vec()) {
                                                output.send(Event::MessageReceived(ChatMessage::User(text))).await.unwrap();
                                            }
                                        }
                                        _none => {
                                            output.send(Event::Disconnected).await.unwrap();
                                            break;
                                        }
                                    }
                                }
                                message = receiver.select_next_some() => {
                                    match client.publish("chat", message.to_string().into()).await {
                                        Ok(_) => {},
                                        Err(_) => {
                                            output.send(Event::Disconnected).await.unwrap();
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Err(_) => {
                        tokio::time::sleep(tokio::time::Duration::from_secs(1)).await;
                        output.send(Event::Disconnected).await.unwrap();
                        continue;
                    }
                }
            }
        },
    )
}

#[derive(Debug, Clone)]
pub enum Event {
    Connected(Connection),
    Disconnected,
    MessageReceived(ChatMessage),
}

#[derive(Debug, Clone)]
pub struct Connection(
    mpsc::Sender<ChatMessage>,
    #[allow(dead_code)] async_nats::Client,
);

impl Connection {
    pub fn send(&mut self, message: ChatMessage) {
        self.0
            .try_send(message)
            .expect("Send message to NATS server");
    }
}

#[derive(Debug, Clone)]
pub enum ChatMessage {
    Connected,
    Disconnected,
    User(String),
}

impl ChatMessage {
    pub fn new(message: &str) -> Option<Self> {
        if message.is_empty() {
            None
        } else {
            Some(Self::User(message.to_string()))
        }
    }

    pub fn connected() -> Self {
        ChatMessage::Connected
    }

    pub fn disconnected() -> Self {
        ChatMessage::Disconnected
    }

    pub fn as_str(&self) -> &str {
        match self {
            ChatMessage::Connected => "Connected to NATS server!",
            ChatMessage::Disconnected => "Connection to NATS lost... Retrying...",
            ChatMessage::User(message) => message.as_str(),
        }
    }
}

impl fmt::Display for ChatMessage {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(self.as_str())
    }
}

impl<'a> From<&'a ChatMessage> for text::Text<'a> {
    fn from(message: &'a ChatMessage) -> Self {
        text::Text::new(message.as_str())
    }
}
