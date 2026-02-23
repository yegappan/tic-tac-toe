# Tic-Tac-Toe Game in Vim9script

A classic Tic-Tac-Toe game with AI opponents of varying difficulty. You play as X against the computer playing as O. Written in Vim9script to showcase game AI, board logic, and state management.

## Features

- **Multiple AI Difficulties**: Play against Easy, Medium, or Hard opponents
- **Score Tracking**: Tracks wins, losses, and draws across games
- **Alternating First Move**: First player alternates between human and computer each round
- **Popup Window UI**: Clean, centered game interface
- **Difficulty Cycling**: Toggle AI difficulty between rounds
- **Modern Vim9script**: Demonstrates minimax algorithm and game logic

## Requirements

- Vim 9.0 or later with Vim9script support
- **NOT compatible with Neovim** (requires Vim9-specific features)

## Installation

### Using Git

**Unix/Linux/macOS:**
```bash
git clone https://github.com/yegappan/tic-tac-toe.git ~/.vim/pack/downloads/opt/tic-tac-toe
```

**Windows (cmd.exe):**
```cmd
git clone https://github.com/yegappan/tic-tac-toe.git %USERPROFILE%\vimfiles\pack\downloads\opt\tic-tac-toe
```

### Using a ZIP file

**Unix/Linux/macOS:**
```bash
mkdir -p ~/.vim/pack/downloads/opt/
```
Download the ZIP file from GitHub and extract it into the directory above. Rename the extracted folder (usually tic-tac-toe-main) to `tic-tac-toe` so the final path matches:

```plaintext
~/.vim/pack/downloads/opt/tic-tac-toe/
├── plugin/
├── autoload/
└── doc/
```

**Windows (cmd.exe):**
```cmd
if not exist "%USERPROFILE%\vimfiles\pack\downloads\opt" mkdir "%USERPROFILE%\vimfiles\pack\downloads\opt"
```
Download the ZIP file from GitHub and extract it into the directory above. Rename the extracted folder (usually tic-tac-toe-main) to `tic-tac-toe` so the final path matches:

```plaintext
%USERPROFILE%\vimfiles\pack\downloads\opt\tic-tac-toe\
├── plugin/
├── autoload/
└── doc/
```

### Finalizing Setup

Since the plugin is in the `opt` directory, add this to your `.vimrc` (Unix) or `_vimrc` (Windows):
```viml
packadd tic-tac-toe
```

Then restart Vim and run:
```viml
:helptags ALL
```

### Plugin Manager Installation

If using vim-plug, add to your config:
```viml
Plug 'path/to/tic-tac-toe'
```
Then run `:PlugInstall` and `:helptags ALL`.

For other plugin managers, follow their standard procedure for local plugins.

## Usage

### Starting the Game

```vim
:TicTacToe
```

### Controls

| Key | Action |
|-----|--------|
| `h` / `←` | Move cursor left |
| `j` / `↓` | Move cursor down |
| `k` / `↑` | Move cursor up |
| `l` / `→` | Move cursor right |
| `Enter` or `Space` | Place your mark (X) |
| `r` | Reset and start new round |
| `d` | Cycle AI difficulty (Easy → Medium → Hard) |
| `c` | Clear score |
| `q` or `Esc` | Quit game |

### Game Rules

- **3×3 Grid**: Standard Tic-Tac-Toe board
- **Players**: You are X, computer is O
- **Turns**: Alternate placing marks on empty cells
- **Winning**: Get three marks in a row (horizontal, vertical, or diagonal)
- **Drawing**: All cells filled with no winner
- **First Move**: Alternates between player and computer each round

### Configuration

Set in your vimrc:
```vim
let g:tictactoe_difficulty = "medium"  " Options: "easy", "medium", "hard"
```

### Game Difficulty

- **Easy**: Computer makes random valid moves
- **Medium**: Computer blocks obvious threats and takes opportunities
- **Hard**: Computer uses minimax algorithm for optimal play

### Scoring

The game tracks:
- X (Your wins)
- O (Computer wins)
- D (Draws)

Press `c` to clear all scores and start fresh.

## Vim9 Language Features Demonstrated

- **Game AI**: Minimax algorithm implementation for intelligent computer moves
- **State Management**: Board state representation and game logic
- **Type Checking**: Full type annotations throughout
- **Classes**: Board and game state management with encapsulation
- **Modular Design**: Separation between AI logic, UI, and game rules
- **Popup Windows**: Modern Vim UI with floating game window
- **Game Loop**: Turn-based game execution with input handling

## License

This plugin is licensed under the MIT License. See the LICENSE file in the repository for details.

