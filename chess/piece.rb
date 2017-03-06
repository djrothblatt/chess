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
end

class NullPiece < Piece
  include Singleton
  attr_reader :color, :symbol

  def initialize
    super(nil, nil, "orange", :X)
  end
end
