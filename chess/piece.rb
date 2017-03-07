require 'singleton'
require_relative 'stepping_pieces'
require_relative 'sliding_pieces'

class Piece
  attr_reader :pos, :board, :color, :symbol

  def initialize(pos, board, color, symbol)
    @pos = pos
    @board = board
    @color = color
    @symbol = symbol
  end

  def move
  end

  def valid_move?(pos)
    board.in_bounds?(pos) &&
    (board[pos].is_a?(NullPiece) || board[pos].color != color)
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(end_pos)
    dupped = board.deep_dup
    start_pos = pos
    dupped.move_piece(start_pos, end_pos)
    board.in_check?(color)
  end

  def straights
    [:left, :right, :up, :down]
  end

  def diagonals
    [:up_left, :up_right, :down_right, :down_left]
  end

  def knight_directions
    [:knight_up_left, :knight_up_right, :knight_left_up, :knight_left_down,
    :knight_down_left, :knight_down_right, :knight_right_up, :knight_right_down]
  end

  def directions
   {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0],
    up_left: [-1, -1],
    up_right: [-1, 1],
    down_left: [1, -1],
    down_right: [1, 1],

    knight_up_left: [-2, -1],
    knight_up_right: [-2, 1],
    knight_left_up: [-1, -2],
    knight_left_down: [1, -2],
    knight_down_left: [2, -1],
    knight_down_right: [2, 1],
    knight_right_up: [-1, 2],
    knight_right_down: [1, 2],

    # for pawns
    up_two: [-2, 0],
    down_two: [2, 0]
    }
  end
end

class NullPiece < Piece
  include Singleton
  attr_reader :color, :symbol

  def initialize
    super(nil, nil, :none, :_)
  end
end

class Pawn < Piece
  include SteppingPiece

  def initialize(pos, board, color)
    super(pos, board, color, :P)
  end

  def move_dirs
    out = []
    if color == :white
      out << :up
      forward_left = nudge(pos, -1, -1)
      forward_right = nudge(pos, -1, 1)
      out << :up_left if board[forward_left].color == :black
      out << :up_right if board[forward_right].color == :black
      out << :up_two if pos[0] == 6
    else
      out << :down
      forward_left = nudge(pos, 1, -1)
      forward_right = nudge(pos, 1, 1)
      out << :down_left if board[forward_left].color == :white
      out << :down_right if board[forward_right].color == :white
      out << :down_two if pos[0] == 1
    end

    out
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
