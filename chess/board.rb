require_relative 'piece'

class Board
  def initialize
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    populate!
  end

  def populate!
    STARTING_ROWS.each do |row|
      (0...BOARD_SIZE).each { |col| self[[row, col]] = Piece.new }
    end
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

  private
  attr_accessor :grid
  BOARD_SIZE = 8
  STARTING_ROWS = [0, 1, 6, 7]

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[x][y] = value
  end

end

class NoPieceError < StandardError
end

class InvalidMoveError < StandardError
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.move_piece
end
