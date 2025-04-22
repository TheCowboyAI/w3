use leptos::*;

#[component]
pub fn Footer() -> impl IntoView {
    view! {
        <footer class="footer bg-base01 py-10 mt-20">
            <div class="container mx-auto px-4">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                    <div class="footer-col">
                        <h4 class="text-base0D text-lg font-display mb-4">
                            "W3 Project"
                        </h4>
                        <p class="text-base04 text-sm">
                            "A modern web application featuring the Crystalline Neon design system - a futuristic, minimalist aesthetic with purposeful animations and clean interfaces."
                        </p>
                    </div>
                    
                    <div class="footer-col">
                        <h4 class="text-base0C text-lg font-display mb-4">
                            "Navigation"
                        </h4>
                        <ul class="space-y-2">
                            <li>
                                <a href="/" class="text-base05 hover:text-base0D transition-colors">
                                    "Home"
                                </a>
                            </li>
                            <li>
                                <a href="/components" class="text-base05 hover:text-base0D transition-colors">
                                    "Components"
                                </a>
                            </li>
                            <li>
                                <a href="/visualizations" class="text-base05 hover:text-base0D transition-colors">
                                    "Visualizations"
                                </a>
                            </li>
                            <li>
                                <a href="/animations" class="text-base05 hover:text-base0D transition-colors">
                                    "Animations"
                                </a>
                            </li>
                        </ul>
                    </div>
                    
                    <div class="footer-col">
                        <h4 class="text-base0E text-lg font-display mb-4">
                            "Resources"
                        </h4>
                        <ul class="space-y-2">
                            <li>
                                <a 
                                    href="https://github.com/thecowboyai/w3" 
                                    class="text-base05 hover:text-base0D transition-colors"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                >
                                    "GitHub Repository"
                                </a>
                            </li>
                            <li>
                                <a 
                                    href="#" 
                                    class="text-base05 hover:text-base0D transition-colors"
                                >
                                    "Design System"
                                </a>
                            </li>
                            <li>
                                <a 
                                    href="#" 
                                    class="text-base05 hover:text-base0D transition-colors"
                                >
                                    "Documentation"
                                </a>
                            </li>
                        </ul>
                    </div>
                    
                    <div class="footer-col">
                        <h4 class="text-base0F text-lg font-display mb-4">
                            "Connect"
                        </h4>
                        <div class="social-links flex gap-4">
                            <a 
                                href="#" 
                                class="text-base05 hover:text-base0D transition-colors"
                                aria-label="GitHub"
                            >
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-github"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg>
                            </a>
                            <a 
                                href="#" 
                                class="text-base05 hover:text-base0D transition-colors"
                                aria-label="Twitter"
                            >
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-twitter"><path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"></path></svg>
                            </a>
                        </div>
                    </div>
                </div>
                
                <div class="border-t border-base03 mt-10 pt-6 text-center text-base04 text-sm">
                    <p>
                        "© 2023 W3 Project. All rights reserved."
                    </p>
                </div>
            </div>
        </footer>
    }
} 