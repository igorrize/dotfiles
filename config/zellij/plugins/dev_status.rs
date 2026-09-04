use std::collections::HashMap;
use zellij_utils::plugin_api::*;
use zellij_utils::data::PaletteMode;
use std::process::Command;

#[derive(Default)]
struct State {
    git_branch: Option<String>,
    git_status: Option<String>,
    node_version: Option<String>,
    go_version: Option<String>,
    ruby_version: Option<String>,
    current_dir: Option<String>,
}

impl ZellijPlugin for State {
    fn load(&mut self, _configuration: BTreeMap<String, String>) {
        // Request permission to run commands
        self.set_selectable(true);
        self.set_timeout(1.0);
    }

    fn update(&mut self, event: Event) -> bool {
        match event {
            Event::Timer => {
                self.update_info();
                self.render();
                true
            }
            Event::Message(message) => {
                // Handle messages if needed
                true
            }
            _ => false,
        }
    }

    fn render(&mut self) -> bool {
        let mut parts = Vec::new();
        
        // Current directory
        if let Some(dir) = &self.current_dir {
            parts.push(format!("📁 {}", self.truncate_path(dir)));
        }
        
        // Git info
        if let Some(branch) = &self.git_branch {
            let git_info = if let Some(status) = &self.git_status {
                format!("🌿 {} {}", branch, status)
            } else {
                format!("🌿 {}", branch)
            };
            parts.push(git_info);
        }
        
        // Node version
        if let Some(node) = &self.node_version {
            parts.push(format!("🟢 {}", node));
        }
        
        // Go version
        if let Some(go) = &self.go_version {
            parts.push(format!("🔵 {}", go));
        }
        
        // Ruby version
        if let Some(ruby) = &self.ruby_version {
            parts.push(format!("🔴 {}", ruby));
        }
        
        let status_line = parts.join(" | ");
        
        self.render_to_main(&status_line);
        true
    }
}

impl State {
    fn update_info(&mut self) {
        // Get current directory
        if let Ok(current_dir) = std::env::current_dir() {
            self.current_dir = current_dir.to_string_lossy().to_string();
        }
        
        // Get git branch
        if let Ok(output) = Command::new("git")
            .args(&["branch", "--show-current"])
            .output()
        {
            if output.status.success() {
                self.git_branch = Some(String::from_utf8_lossy(&output.stdout).trim().to_string());
            }
        }
        
        // Get git status (clean/dirty)
        if let Ok(output) = Command::new("git")
            .args(&["status", "--porcelain"])
            .output()
        {
            if output.status.success() {
                let status_output = String::from_utf8_lossy(&output.stdout);
                if status_output.trim().is_empty() {
                    self.git_status = Some("✓".to_string());
                } else {
                    self.git_status = Some("✗".to_string());
                }
            }
        }
        
        // Get Node.js version
        if let Ok(output) = Command::new("node")
            .args(&["--version"])
            .output()
        {
            if output.status.success() {
                self.node_version = Some(String::from_utf8_lossy(&output.stdout).trim().to_string());
            }
        }
        
        // Get Go version
        if let Ok(output) = Command::new("go")
            .args(&["version"])
            .output()
        {
            if output.status.success() {
                let version = String::from_utf8_lossy(&output.stdout);
                if let Some(v) = version.split_whitespace().nth(2) {
                    self.go_version = Some(v.to_string());
                }
            }
        }
        
        // Get Ruby version
        if let Ok(output) = Command::new("ruby")
            .args(&["--version"])
            .output()
        {
            if output.status.success() {
                let version = String::from_utf8_lossy(&output.stdout);
                if let Some(v) = version.split_whitespace().nth(1) {
                    self.ruby_version = Some(v.to_string());
                }
            }
        }
    }
    
    fn truncate_path(&self, path: &str) -> String {
        if path.len() > 30 {
            format!("...{}", &path[path.len()-27..])
        } else {
            path.to_string()
        }
    }
}

declare_plugin!(State);