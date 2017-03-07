require 'singleton'

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
    board.in_bounds?(pos) && board[pos].is_a?(NullPiece)
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
    knight_right_down: [1, 2]
    }
  end
end

class NullPiece < Piece
  include Singleton
  attr_reader :color, :symbol

  def initialize
    super(nil, nil, "orange", :X)
  end
end
