vim9script

import './types.vim' as Types
import './util.vim' as Util

export class Game
  var board: list<list<Types.Cell>>

  def new()
    this.Reset()
  enddef

  def Reset(): void
    this.board = [
      [Types.Cell.Empty, Types.Cell.Empty, Types.Cell.Empty],
      [Types.Cell.Empty, Types.Cell.Empty, Types.Cell.Empty],
      [Types.Cell.Empty, Types.Cell.Empty, Types.Cell.Empty],
    ]
  enddef

  def Clone(): Game
    var g = Game.new()
    g.board = deepcopy(this.board)
    return g
  enddef

  def Place(cell: Types.Cell, pos: Types.Position): bool
    var [row, col] = pos
    if row < 0 || row > 2 || col < 0 || col > 2
      return false
    endif
    if this.board[row][col] != Types.Cell.Empty
      return false
    endif
    this.board[row][col] = cell
    return true
  enddef

  def Winner(): Types.Cell
    var lines = [
      [[0, 0], [0, 1], [0, 2]],
      [[1, 0], [1, 1], [1, 2]],
      [[2, 0], [2, 1], [2, 2]],
      [[0, 0], [1, 0], [2, 0]],
      [[0, 1], [1, 1], [2, 1]],
      [[0, 2], [1, 2], [2, 2]],
      [[0, 0], [1, 1], [2, 2]],
      [[0, 2], [1, 1], [2, 0]],
    ]

    for line in lines
      var [a, b, c] = line
      var [ar, ac] = a
      var [br, bc] = b
      var [cr, cc] = c
      var cell = this.board[ar][ac]
      if cell != Types.Cell.Empty && cell == this.board[br][bc] && cell == this.board[cr][cc]
        return cell
      endif
    endfor

    return Types.Cell.Empty
  enddef

  def WinningLine(): list<Types.Position>
    var lines = [
      [[0, 0], [0, 1], [0, 2]],
      [[1, 0], [1, 1], [1, 2]],
      [[2, 0], [2, 1], [2, 2]],
      [[0, 0], [1, 0], [2, 0]],
      [[0, 1], [1, 1], [2, 1]],
      [[0, 2], [1, 2], [2, 2]],
      [[0, 0], [1, 1], [2, 2]],
      [[0, 2], [1, 1], [2, 0]],
    ]

    for line in lines
      var [a, b, c] = line
      var [ar, ac] = a
      var [br, bc] = b
      var [cr, cc] = c
      var cell = this.board[ar][ac]
      if cell != Types.Cell.Empty && cell == this.board[br][bc] && cell == this.board[cr][cc]
        return [a, b, c]
      endif
    endfor

    return []
  enddef

  def IsDraw(): bool
    for row in this.board
      for cell in row
        if cell == Types.Cell.Empty
          return false
        endif
      endfor
    endfor
    return this.Winner() == Types.Cell.Empty
  enddef

  def AvailableMoves(): list<Types.Position>
    var moves: list<Types.Position> = []
    for row in range(0, 2)
      for col in range(0, 2)
        if this.board[row][col] == Types.Cell.Empty
          moves->add([row, col])
        endif
      endfor
    endfor
    return moves
  enddef

  def FindWinningMove(cell: Types.Cell): Types.Position
    for move in this.AvailableMoves()
      var clone = this.Clone()
      clone.Place(cell, move)
      if clone.Winner() == cell
        return move
      endif
    endfor
    return [-1, -1]
  enddef

  def CellChar(cell: Types.Cell): string
    if cell == Types.Cell.X
      return 'X'
    elseif cell == Types.Cell.O
      return 'O'
    endif
    return ' '
  enddef

  def FormatCell(cell: Types.Cell, isCursor: bool): string
    var ch = this.CellChar(cell)
    if isCursor
      return '[' .. ch .. ']'
    endif
    return ' ' .. ch .. ' '
  enddef

  def CenterLine(text: string): string
    var pad = (Types.POPUP_WIDTH - strdisplaywidth(text)) / 2
    var s = repeat(' ', pad)
    return s .. text .. s
  enddef

  def RenderLines(cursor: Types.Position, message: string, score: Types.Score, level: Types.Difficulty): list<string>
    var [cr, cc] = cursor
    var [sx, so, sd] = score
    var lines: list<string> = []
    var border_top = '┌───────────┐'
    var border_mid = '├───┼───┼───┤'
    var border_bot = '└───────────┘'
    lines->add(this.CenterLine(printf('Tic-Tac-Toe  X:%d O:%d D:%d  AI:%s', sx, so, sd, Util.DifficultyName(level))))
    lines->add(this.CenterLine(''))
    lines->add(this.CenterLine(border_top))
    for row in range(0, 2)
      var parts: list<string> = []
      for col in range(0, 2)
        parts->add(this.FormatCell(this.board[row][col], row == cr && col == cc))
      endfor
      lines->add(this.CenterLine('│' .. parts->join('│') .. '│'))
      if row < 2
        lines->add(this.CenterLine(border_mid))
      endif
    endfor
    lines->add(this.CenterLine(border_bot))
    lines->add(this.CenterLine(''))
    if message->stridx("\n") >= 0
      for line in split(message, "\n")
        lines->add(this.CenterLine(line))
      endfor
    else
      lines->add(this.CenterLine(message))
    endif
    return lines
  enddef
endclass
