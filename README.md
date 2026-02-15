# Tic-Tac-Toe for Vim

A popup-window Tic-Tac-Toe game written in Vim9 script. You play as X, the
computer plays as O. The game includes multiple AI difficulties, score
tracking, and alternating first moves between you and the computer.

## Installation

### Vim packages (built-in)

1. Create a package directory if you do not already have one:
   - Windows: `%USERPROFILE%\vimfiles\pack\downloads\opt\`
   - Unix: `~/.vim/pack/downloads/opt/`
2. Clone this repository into that directory:

   ```sh
   git clone https://github.com/yegappan/tic-tac-toe.git
   ```

3. Add the following line to the ~/.vimrc file:
   ```vim
   packadd tic-tac-toe
   ```

### Plugin managers

Use your preferred plugin manager. Example with vim-plug:

```vim
Plug 'yourname/tic-tac-toe-vim'
```

Then run `:PlugInstall`.

## Usage

Start the game:

```vim
:TicTacToe
```

## Controls

Movement:
- `h` `j` `k` `l` or arrow keys: move the cursor

Actions:
- `<Enter>` or `<Space>`: place your mark (X)
- `r`: reset and start a new round
- `d`: cycle AI difficulty
- `c`: clear score
- `q` or `<Esc>`: quit the popup

## Settings

- `g:tictactoe_difficulty` (default: `"medium"`)
  - Values: `"easy"`, `"medium"`, `"hard"`

## Notes

- The popup is fixed width and centered.
- Scores are shown as X (you), O (computer), and D (draws).
- Each new round alternates who takes the first move.
