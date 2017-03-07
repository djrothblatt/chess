
require_relative 'board'
require_relative 'piece'

module SlidingPiece
  def moves
    res = []

    move_dirs.each do |dir|
      dx, dy = directions[dir]
      current_pos = nudge(pos, dx, dy)
      while valid_move?(current_pos)
        res << current_pos
        current_pos = nudge(current_pos, dx, dy)
      end
    end

    res
  end

  def nudge(pos, dx, dy)
    x, y = pos
    [x + dx, y + dy]
  end
end

class Bishop < Piece
  include SlidingPiece

  def initialize(pos, board, color)
    super(pos, board, color, :B)
  end

  def move_dirs
    diagonals
  end
end


class Rook < Piece
  include SlidingPiece

  def initialize(pos, board, color)
    super(pos, board, color, :R)
  end

  def move_dirs
    straights
  end
end

class Queen < Piece
  include SlidingPiece

  def initialize(pos, board, color)
    super(pos, board, color, :Q)
  end

  def move_dirs
    straights + diagonals
  end
end
