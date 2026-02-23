# Tic-Tac-Toe for Vim

A popup-window Tic-Tac-Toe game written in Vim9 script. You play as X, the
computer plays as O. The game includes multiple AI difficulties, score
tracking, and alternating first moves between you and the computer.

## Installation

### Using Git
If you have git installed, run the following command in your terminal:

**Unix/Linux/macOS:**

```bash
git clone https://github.com/yegappan/tic-tac-toe.git ~/.vim/pack/downloads/opt/tic-tac-toe
```
**Windows (cmd.exe):**

```cmd
git clone https://github.com/yegappan/tic-tac-toe.git %USERPROFILE%\vimfiles\pack\downloads\opt\tic-tac-toe
```

### Using a ZIP file
If you prefer not to use Git:

**Unix/Linux/macOS:**

Create the destination directory:

```bash
mkdir -p ~/.vim/pack/downloads/opt/
```

Download the plugin ZIP file from GitHub and extract its contents into the directory created above.

*Note:* GitHub usually names the extracted folder tic-tac-toe-main. Rename it to tic-tac-toe so the final path looks like this:

```plaintext
~/.vim/pack/downloads/opt/tic-tac-toe/
├── plugin/
├── autoload/
└── doc/
```

**Windows (cmd.exe):**

Create the destination directory:

```cmd
if not exist "%USERPROFILE%\vimfiles\pack\downloads\opt" mkdir "%USERPROFILE%\vimfiles\pack\downloads\opt"
```

Download the plugin ZIP file from GitHub and extract its contents into that directory.

*Note:* Rename the extracted folder (usually tic-tac-toe-main) to tic-tac-toe so the path matches:

```plaintext
%USERPROFILE%\vimfiles\pack\downloads\opt\tic-tac-toe\
├── plugin/
├── autoload/
└── doc/
```

**Finalizing Setup**
Since this plugin is installed in the opt (optional) directory, it will not load automatically. Add the following line to your .vimrc (Unix) or _vimrc (Windows):

```viml
packadd tic-tac-toe
```

After adding the line, restart Vim and run the following command to enable the help documentation:

```viml
:helptags ALL
```

### Plugin Manager Installation

If using a plugin manager like vim-plug, add to your .vimrc or init.vim:

   ```viml
   Plug 'path/to/tic-tac-toe'
   ```

Then run `:PlugInstall` and `:helptags ALL`

For other plugin managers (Vundle, Pathogen, etc.), follow their standard
installation procedures for local plugins.

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
