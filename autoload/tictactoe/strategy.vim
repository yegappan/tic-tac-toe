vim9script

import './types.vim' as Types
import './game.vim' as GameMod

export interface Strategy
  def Move(game: GameMod.Game): Types.Position
endinterface
