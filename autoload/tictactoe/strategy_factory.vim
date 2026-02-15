vim9script

import './types.vim' as Types
import './strategy.vim' as StrategyMod
import './random_strategy.vim' as RandomMod
import './medium_strategy.vim' as MediumMod
import './minimax_strategy.vim' as MinimaxMod

export def BuildStrategy(level: Types.Difficulty): StrategyMod.Strategy
  if level == Types.Difficulty.Easy
    return RandomMod.RandomStrategy.new()
  elseif level == Types.Difficulty.Hard
    return MinimaxMod.MinimaxStrategy.new()
  endif
  return MediumMod.MediumStrategy.new()
enddef
