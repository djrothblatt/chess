require 'byebug'
require_relative 'board'
require_relative 'piece'

module SlidingPiece
  def moves
    res = []
    debugger

    move_dirs.each do |dir|
      dx, dy = DIRECTIONS[dir]
      current_pos = nudge(pos, dx, dy)
      while board.in_bounds?(current_pos) && board[current_pos].is_a?(NullPiece)
        res << current_pos
        current_pos = nudge(current_pos, dx, dy)
      end
    end

    debugger
    res
  end

  def nudge(pos, dx, dy)
    x, y = pos
    [x + dx, y + dy]
  end

  DIRECTIONS = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0],
    up_left: [-1, -1],
    up_right: [-1, 1],
    down_left: [1, -1],
    down_right: [1, 1]
  }
end

class Bishop < Piece
  include SlidingPiece

  def initialize(pos, board, color)
    super(pos, board, color, :B)
  end

  def move_dirs
    [:up_left, :up_right, :down_right, :down_left]
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  bishop = Bishop.new([1, 2], board, "green")
  puts bishop.move_dirs
  puts bishop.moves
end
