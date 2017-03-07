require_relative 'piece'

class Board
  def initialize
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, NullPiece.instance) }
    populate!
  end

  def populate!
    STARTING_ROWS.each do |row|
      (0...BOARD_SIZE).each { |col| self[[row, col]] = Piece.new([row,col], self, "blue", :P) }
    end

    nil
  end

  def move_piece(start_pos, end_pos)
    unless self[start_pos]
      raise NoPieceError
    end
    piece = self[start_pos]
    unless piece.can_move?(end_pos)
      raise InvalidMoveError
    end

    piece.move(end_pos)
    self[start_pos] = nil
    self[end_pos] = piece
  end

  def in_bounds?(pos)
    x, y = pos
    x.between?(0, BOARD_SIZE - 1) && y.between?(0, BOARD_SIZE - 1)
  end

  def rows
    @grid
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[x][y] = value
  end

  private
  attr_accessor :grid
  BOARD_SIZE = 8
  STARTING_ROWS = [0, 1, 6, 7]
end

class NoPieceError < StandardError
end

class InvalidMoveError < StandardError
end
