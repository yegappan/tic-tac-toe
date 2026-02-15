vim9script

export type Position = list<number>
export type Score = list<number>

export const POPUP_WIDTH = 49

export enum Cell
  Empty,
  X,
  O
endenum

export enum Difficulty
  Easy,
  Medium,
  Hard
endenum
