require_relative 'board'
require_relative 'piece'

module SteppingPiece
  def moves
    possible_positions = move_dirs.map do |dir|
      dx, dy = directions[dir]
      nudge(pos, dx, dy)
    end

    possible_positions.select { |pos| valid_move?(pos) }
  end

  def nudge(pos, dx, dy)
    x, y = pos
    [x + dx, y + dy]
  end
end

class Knight < Piece
  include SteppingPiece

  def initialize(pos, board, color)
    super(pos, board, color, :H)
  end

  def move_dirs
    knight_directions
  end
end

class King < Piece
  include SteppingPiece

  def initialize(pos, board, color)
    super(pos, board, color, :K)
  end

  def move_dirs
    straights + diagonals
  end
end
