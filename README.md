# ezs

**EaZy Sessions**: A lightweight and standalone session/display manager that supports both **X11** and **Wayland**.

Designed with simplicity and efficiency in mind, **ezs** is written in **Lua**. The current release focuses on minimalism and functionality, providing a straightforward experience without any customizations. It embodies the essence of what a session/display manager should be.

### Availability

**ezs** is designed to seamlessly operate on any Linux distribution that uses **systemd**, requiring no user intervention for setup. While it is possible for **ezs** to run on other systems, please note that user intervention will be necessary for configurations and setup if the distribution does not utilize **systemd**.

## Features

- Supports both X11 and Wayland
- Lightweight and efficient
- Minimalistic design for a straightforward user experience

## Dependencies

- **Lua 5.2** or newer

## Installation

To install **ezs**, follow these steps:

1. **Clone the repository**:

   ```bash
   git clone https://github.com/yourusername/ezs.git
   cd ezs

2. **Run the install script**:

    ```bash
    ./install.sh

## Usage

Once installed, you can start using ezs as your session/display manager. It should pop up as your display manager after logging in if there're no conflicts. 