vim9script

import './types.vim' as Types
import './util.vim' as Util
import './game.vim' as GameMod
import './strategy.vim' as StrategyMod
import './strategy_factory.vim' as StrategyFactory

export class PopupUI
  var winid: number
  var game: GameMod.Game
  var cursor: Types.Position
  var ai: StrategyMod.Strategy
  var difficulty: Types.Difficulty
  var message: string
  var score: Types.Score
  var game_over: bool
  var match_ids: list<number>
  var next_human_start: bool

  def new()
    this.winid = 0
    this.game = GameMod.Game.new()
    this.cursor = [0, 0]
    this.difficulty = Util.DifficultyFromSetting()
    this.ai = StrategyFactory.BuildStrategy(this.difficulty)
    this.score = [0, 0, 0]
    this.game_over = false
    this.match_ids = []
    this.next_human_start = true
    this.StartNewGame()
  enddef

  def Close(): void
    if this.winid != 0
      popup_close(this.winid)
      this.winid = 0
    endif
  enddef

  def StartNewGame(): void
    this.game.Reset()
    this.cursor = [0, 0]
    this.game_over = false
    this.message = "Move: arrows/hjkl, Enter=place\nr=reset, d=AI, c=clear, q=quit."

    if !this.next_human_start
      var aiPos = this.ai.Move(this.game)
      this.game.Place(Types.Cell.O, aiPos)
      this.message = "Your move: arrows/hjkl, Enter=place\nr=reset, d=AI, c=clear, q=quit."
    endif

    this.next_human_start = !this.next_human_start
    this.Render()
  enddef

  def Reset(): void
    this.StartNewGame()
  enddef

  def ClearScore(): void
    this.score = [0, 0, 0]
    this.message = 'Scores cleared.'
    this.Render()
  enddef

  def CycleDifficulty(): void
    this.difficulty = Util.NextDifficulty(this.difficulty)
    g:tictactoe_difficulty = tolower(Util.DifficultyName(this.difficulty))
    this.ai = StrategyFactory.BuildStrategy(this.difficulty)
    this.message = 'AI set to ' .. Util.DifficultyName(this.difficulty) .. '.'
    this.Render()
  enddef

  def Render(): void
    var lines = this.game.RenderLines(this.cursor, this.message, this.score, this.difficulty)
    if this.winid == 0
      this.winid = popup_create(lines, {
        pos: 'center',
        minwidth: Types.POPUP_WIDTH,
        maxwidth: Types.POPUP_WIDTH,
        border: [],
        padding: [0, 1, 0, 1],
        mapping: 0,
        zindex: 200,
        filter: function('PopupFilter'),
      })
    else
      popup_settext(this.winid, lines)
    endif
    this.ApplyHighlights()
  enddef

  def ApplyHighlights(): void
    if this.winid == 0
      return
    endif

    for id in this.match_ids
      silent! call matchdelete(id, this.winid)
    endfor
    this.match_ids = []

    var [cr, cc] = this.cursor
    var cursorPos = [4 + cr * 2, 2 + cc * 4, 3]
    var cursorId = matchaddpos('TicTacToeCursor', [cursorPos], 10, -1, {window: this.winid})
    this.match_ids->add(cursorId)

    var winline = this.game.WinningLine()
    if winline->len() == 0
      return
    endif

    var group = this.game.Winner() == Types.Cell.X ? 'TicTacToeWinX' : 'TicTacToeWinO'
    var winpos: list<list<number>> = []
    for pos in winline
      var [r, c] = pos
      winpos->add([4 + r * 2, 2 + c * 4, 3])
    endfor
    var winId = matchaddpos(group, winpos, 11, -1, {window: this.winid})
    this.match_ids->add(winId)
  enddef

  def PlaceHuman(): void
    if this.game_over
      this.message = 'Game over. Press r to play again.'
      this.Render()
      return
    endif

    if !this.game.Place(Types.Cell.X, this.cursor)
      this.message = 'Cell is occupied. Try another.'
      this.Render()
      return
    endif

    var winner = this.game.Winner()
    if winner == Types.Cell.X
      this.score = [this.score[0] + 1, this.score[1], this.score[2]]
      this.game_over = true
      this.message = 'You win! Press r to play again.'
      this.Render()
      return
    elseif this.game.IsDraw()
      this.score = [this.score[0], this.score[1], this.score[2] + 1]
      this.game_over = true
      this.message = 'Draw. Press r to play again.'
      this.Render()
      return
    endif

    var aiPos = this.ai.Move(this.game)
    this.game.Place(Types.Cell.O, aiPos)

    winner = this.game.Winner()
    if winner == Types.Cell.O
      this.score = [this.score[0], this.score[1] + 1, this.score[2]]
      this.game_over = true
      this.message = 'Computer wins. Press r to play again.'
    elseif this.game.IsDraw()
      this.score = [this.score[0], this.score[1], this.score[2] + 1]
      this.game_over = true
      this.message = 'Draw. Press r to play again.'
    else
      this.message = "Your move: arrows/hjkl, Enter=place\nr=reset, d=AI, c=clear, q=quit."
    endif

    this.Render()
  enddef

  def MoveCursor(delta: Types.Position): void
    var [dr, dc] = delta
    var [r, c] = this.cursor
    r = (r + dr + 3) % 3
    c = (c + dc + 3) % 3
    this.cursor = [r, c]
    this.Render()
  enddef

  def MoveCursorTo(pos: Types.Position): void
    this.cursor = pos
    this.Render()
  enddef

  def HandleKey(key: string): bool
    if key ==# 'q' || key ==# 'Q' || key ==# "\<Esc>"
      this.Close()
      return true
    endif

    if key ==# 'r' || key ==# 'R'
      this.Reset()
      return true
    endif

    if key ==# 'c' || key ==# 'C'
      this.ClearScore()
      return true
    endif

    if key ==# 'd' || key ==# 'D'
      this.CycleDifficulty()
      return true
    endif

    if key ==# "\<CR>" || key ==# "\<Space>"
      this.PlaceHuman()
      return true
    endif

    if key ==# 'h' || key ==# "\<Left>"
      this.MoveCursor([0, -1])
      return true
    elseif key ==# 'l' || key ==# "\<Right>"
      this.MoveCursor([0, 1])
      return true
    elseif key ==# 'k' || key ==# "\<Up>"
      this.MoveCursor([-1, 0])
      return true
    elseif key ==# 'j' || key ==# "\<Down>"
      this.MoveCursor([1, 0])
      return true
    endif

    if key =~# '^[1-9]$'
      var n = str2nr(key) - 1
      var row = 2 - (n / 3)
      var col = n % 3
      this.MoveCursorTo([row, col])
      return true
    endif

    return true
  enddef
endclass

var ui: PopupUI = null_object

def PopupFilter(id: number, key: string): bool
  if ui isnot null_object
    return ui.HandleKey(key)
  endif
  return true
enddef

export def Start(): void
  Util.DefineHighlights()
  if ui isnot null_object
    ui.Close()
  endif
  ui = PopupUI.new()
enddef
