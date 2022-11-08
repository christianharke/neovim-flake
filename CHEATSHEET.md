# Neovim Cheat Sheet

<Leader> Key is `,`

## Global Commands
 - `:help {keyword}` - Bring up help for keyword
 - `:save {file}` - save the current file as another filename
 - `:close` - Close the current pane
 - `:terminal` - Open a terminal window
 - `<Esc>` - Return to Normal mode
 - `:x` - save and quit
 - `:w` - save
 - `:q` - quit
 - `:q!` - quit don't save
 - `:wqa` - Save and quit cloing all tabs

## Movement
 - `h (left)`, `j (down)`, `k (up)`, `l (right)` - Move around the screen
 - `gg` - Move to top of buffer
 - `G` - Move to bottom of file
 - `H` - Top of screen
 - `M` - Middle of screen
 - `L` - Bottom of the screen
 - `w` - jump forward to start of word
 - `e` - jump forward to end of word
 - `b` - jump backwards to start of word
 - `%` - Jump forward to matching paren or brace
 - `0` - Start of line
 - `$` - End of line
 - `^` - First non-blank character of line
 - `f{char}` - Move to the next occurrence of charecter
 - `F{char}` - Move ot the previous occurrence of charecter
 - `{`, `}` - Move around paragraph blocks (works in code too)
 - `CTRL-e` - Move screen down one line without moving cursor
 - `CTRL-y` - Move screen up one line without moving cursor
 - `CTRL-b` - Move back one full screen
 - `CTRL-f` - Move forward one full screen
 - `CTRL-d` - Move forward 1/2 screen
 - `CTRL-u` - Move back one full screen

## `INSERT` Mode
 - `i` - Enter insert mode before cursor
 - `I` - Enter insert mode at the start of the line
 - `a` - Enter insert mode after cursor
 - `A` - Enter insert mode at the end of the line
 - `o` - Append a line below current line
 - `O` - Append a line above current line
 - `ea` - Enter insert mode at the end of the word
 - `CTRL-r {register}` - Insert the contents of `register`

### Dictionary
 - `CTRL-x CTRL-k` - Look up dictionary for matches

Browsing matches:
 - `<Tab>`, `CTRL-n` - Search forward for next matching keyword
 - `<S-Tab>`, `CTRL-p` - Search backwards for next matching keyword

### Thesaurus
 - `CTRL-x CTRL-t` - Look up thesaurus for matches

Browsing matches:
 - `<Tab>`, `CTRL-n` - Search forward for next matching keyword
 - `<S-Tab>`, `CTRL-p` - Search backwards for next matching keyword

## Spell Checking
 - `]s` - Move to next misspelled word
 - `[s` - Move to previous misspelled word
 - `]S` - Move to next bad word
 - `[S` - Move to previous bad word
 - `zg` - Add word under the cursor as a good word to the first `spellfile`
 - `[index]zg` - Add word under the cursor as a good word to the `spellfile` with given `index`
   (starting from `1`)
 - `zG` - Add word under the cursor as a good word to the internal word list
 - `zw` - Mark word under the cursor as a wrong (bad) word
 - `zW` - Mark word under the cursor as a wrong (bad) word to the internal word list
 - `zug` - Undo adding word as a good word
 - `zuG` - Undo adding word as a good word in the internal word list
 - `zuw` - Undo marking word as a wrong (bad) word
 - `zuW` - Undo marking word as a wrong (bad) word in the internal word list
 - `z=` - Suggest correctly spelled words for the word under the cursor

## Editing
 - `r` - Replace single charecter
 - `J` - Join line below to current one
 - `g~` - Switch case up to motion
 - `gu` - Lower case up to motion
 - `gU` - Upper case up to motion
 - `cc` - Replace entire line
 - `C` or `c$` - Replace to end of line
 - `ciw` - Change entire word
 - `cw` - Replace to end of word
 - `u` - Undo
 - `U` - Redo
 - `.` - Repeat last command

## Marking Text
 - `v` - Visual mode
 - `V` - Start linewise visual mode (select lines)
 - `o` - Move to other end of marked area
 - `CTRL-v` - Visual Block mode
 - `CTRL-O` - Other corner of block
 - `aw` - Mark a word with whitespace
 - `iw` - Mark a word without whitespace
 - `ab` - Mark block with ()
 - `aB` - Mark block with {}
 - `ib` - Mark inner block with ()
 - `iB` - mark inner block with {}
 - `at` - Mark tags with <>

## Visual Commands
 - `>` - Shift text right
 - `<` - Shift text left
 - `y` - Yank marked text
 - `d` - Delete marked text
 - `~` - Switch case
 - `u` - Change case to lowercase
 - `U` - Change case to uppercase

## Registers
 - `:reg` - Show register content 
 - `"xy` - Yank into register x
 - `"xp` - Paste contents of register x
 - `"+y` - Yank into system clipboard
 - `"+p` - Paste from system clipboard

## Marks and Positions
 - `:marks` - Lists all marks
 - `ma` - Set position of mark a
 - `` `a `` - Jump back to a
 - `` `. `` - Go to position when last editing the file
 - ` `` ` - Go to position before last jump
 - `:ju` - List of jumps
 - `CTRL-i` - Newer position in jump list
 - `CTRL-o` - Older position in jump list
 - `:changes` - List changes
 - `g,` - Go to newer change
 - `g;` - Go to older change 

## Macros
 - `qa` - Record macro a
 - `q` - stop recording macro
 - `@a` - Run macro a
 - `@@` - rerun last macro

## Cut and Paste
 - `yy` - yank line
 - `yw` - yank word
 - `y$` - yank to end of line
 - `p` - Paste clipboard after cursor
 - `P` - Paste clipboard before cursor
 - `dd` - delete line
 - `dw` - Delete word (from current cursor to next start of word)
 - `d$` - Delete till end of line
 - `x` - delete character

## Indent text
 - `<<` - Move line left
 - `>>` - Move line right
 - `>%` - Indent block (when on brace or paren)
 - `=%` - Re-indent block

## Searching and patterns
 - `/pattern` - Search for pattern
 - `?pattern` - Search backwards for pattern
 - `n` - Repeat search in same direction
 - `N` - Repeat search in opposite direction
 - `:%s/old/new/g` - Replace all old with new throughout the file
 - `:%s/old/new/gc` - Replace all old with new throughout the file with confirmations
 - `:nohlsearch` - Remove highlighting of search matches
 - `:vimgrep /pattern/ **/*` - Search for pattern in all files
 - `:cn` - next match
 - `:cp` - prev match
 - `:cope` - List of all matches found
 - `:ccl` - Close list of all matches

## Tabs
 - `:tabnew {file}` - Open file in new tab
 - `CTRL-w T` - Move current split window into its own tab
 - `gt` - Go to next tab
 - `gT` - Go to prev tab
 - `#gt` - Go to tab number
 - `:tabclose` - Close current tab
 - `:tabonly` - Close other tabs but this one

## Buffers
 - `:e {file}` - Edit file in a new buffer
 - `:bn` - Next buffer
 - `:bp` - Prev buffer
 - `:bd` - Close buffer
 - `:ls` - List open buffers

## Splits
 - `:sp {file}` - Open file in new buffer and split
 - `:vs {file}` - Open file in new buffer and split (verticle)
 - `:tab ba` - Open all buffers as tabs
 - `CTRL-w s` - split window
 - `CTRL-w v` - split window verticle
 - `CTRL-w w` - switch window
 - `CTRL-w q` - Quit window
 - `CTRL-w x` - Exchange window with next one
 - `CTRL-w =` - Make all windows equal height and width
 - `CTRL-w h` - Move to left window
 - `CTRL-w l` - Move to right window
 - `CTRL-w j` - Move to below window
 - `CTRL-w k` - Move to above window

## Dashboard
 - `<Leader> ss` - Display dashboard

## File Explorer
 - `<Leader> fn` - Toggle file tree
 - `a` - Add new file (or folder if you leave a / at end)
 - `r` - Rename file
 - `d` - Delete file or folder
 - `D` - Trash file or folder
 - `y` - Copy file name to system clipboard
 - `Y` - Copy relative path to system clipboard
 - `gy` - Copy absolute path to system clipboard
 - `x` - Cut file
 - `c` - Copy file
 - `p` - Paste file from clipboard
 - `-` - Navigate to the parent directory of current file
 - `CTRL-]` - Cd into directory
 - `CTRL-v` - Open in vert split
 - `CTRL-x` - Open in horizontal split
 - `CTRL-t` - Open in new tab
 - `tab` - Open file but stay in tree (preview)
 - `s` - Open file or folder in system's default application
 - `R` - Refresh tree
 - `I` - Toggle hidden folders visability
 - `H` - Toggle dot files visability
 - `W` - Collapse whole tree
 - `S` - Prompt path to expand
 - `.` - Vim command mode
 - `CTRL-k` - Show file infos

## Telescope
 - `<Leader> ff` - Find file
 - `<Leader> fg` - Live grep
 - `<Leader> fb` - Buffers
 - `<Leader> fh` - Help tags

## LSP
 - `<F2>` - Rename
 - `<Leader> R` - Rename
 - `<Leader> r` - References
 - `<Leader> D` - Go to definition
 - `<Leader> I` - Go to implimentation
 - `<Leader> e` - Show document diag
 - `<Leader> E` - Show workspace diag
 - `<Leader> f` - Format buffer
 - `<Leader> k` - Signature help
 - `<Leader> K` - Hover text
 - `<Leader> a` - Do code action

## Debug
 - `<F5>` - Run
 - `<F10>` - Step over
 - `<F11>` - Step into
 - `<F12>` - Step out
 - `<Leader> b` - Set break point
 - `<F9>` - Open debug repl
 - `<Leader> d` - All dap commands
 - `<Leader> B` - List break points
 - `<Leader> dv` - List variables
 - `<Leader> df` - List frames

## Test runner
 - `<Leader> t` - Run whole test suite
 - `<Leader> tn` 

## Terminal Windows
 - `<Leader> ~` - Open new floating terminal
 - `<Leader> ~j` - next floating terminal
 - `<Leader> ~k` - prev floating terminal
 - `<Esc>` - Close terminal

## Git
 - `<Leader> gs` - Open magit fullscreen
 - `<CR>` - Expand hunks
 - `R` - Refresh magit buffer
 - `q` - Quit magit buffer
 - `S` - Stage or unstage hunk
 - `F` - Stage or unstage the whole file
 - `DDD` - Discard changes to hunk
 - `L` - Stage the line under cursor
 - `E` - Edit file that is selected
 - `CA` - Set commit mode to amend
 - `CU` - Go back to stage mode
 - `I` - Add file under cursor to `.gitignore`
 - `CC` - Commit changes or move to commit mode.

? How to do snippets

