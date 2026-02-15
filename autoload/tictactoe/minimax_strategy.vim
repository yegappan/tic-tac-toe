vim9script

import './types.vim' as Types
import './game.vim' as GameMod
import './strategy.vim' as StrategyMod

def Minimax(game: GameMod.Game, isMax: bool, depth: number): number
  var winner = game.Winner()
  if winner == Types.Cell.O
    return 10 - depth
  elseif winner == Types.Cell.X
    return depth - 10
  elseif game.IsDraw()
    return 0
  endif

  if isMax
    var best = -999
    for move in game.AvailableMoves()
      var clone = game.Clone()
      clone.Place(Types.Cell.O, move)
      best = max([best, Minimax(clone, false, depth + 1)])
    endfor
    return best
  endif

  var worst = 999
  for move in game.AvailableMoves()
    var clone = game.Clone()
    clone.Place(Types.Cell.X, move)
    worst = min([worst, Minimax(clone, true, depth + 1)])
  endfor
  return worst
enddef

export class MinimaxStrategy implements StrategyMod.Strategy
  def Move(game: GameMod.Game): Types.Position
    var bestScore = -999
    var bestMove: Types.Position = [0, 0]
    for move in game.AvailableMoves()
      var clone = game.Clone()
      clone.Place(Types.Cell.O, move)
      var score = Minimax(clone, false, 0)
      if score > bestScore
        bestScore = score
        bestMove = move
      endif
    endfor
    return bestMove
  enddef
endclass
