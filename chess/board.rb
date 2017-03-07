require_relative 'piece'

class Board
  attr_reader :grid, :white_king, :black_king
  attr_accessor :black_team, :white_team

  BOARD_SIZE = 8
  def initialize(arr = nil)
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, NullPiece.instance) }
    @white_team = []
    @black_team = []
    populate! unless arr
    @grid = arr if arr
  end

  def populate!
    place_kings
    place_queens
    place_bishops
    place_knights
    place_rooks
    place_pawns
    nil
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos].is == NullPiece.instance
      raise NoPieceError
    end
    piece = self[start_pos]
    unless piece.valid_moves.include?(end_pos)
      raise InvalidMoveError
    end

    piece.move(end_pos)
    self[start_pos] = NullPiece.instance
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

  def dup
    arr = rows.map do |row|
      row.map do |piece|
        (piece == NullPiece.instance) ? piece : piece.dup
      end
    end

    Board.new(arr)
  end

  def in_check?(color)
    king, enemy_team = choose_opposing(color)
    enemy_team.any? do |piece|
      piece.moves.include?(king.pos)
    end
  end

  def choose_opposing(color)
    if color == :white
      [white_king, black_team]
    else
      [black_king, white_team]
    end
  end

  private

  def place_kings
    @black_king = King.new([0, 4], self, :black)
    @white_king = King.new([7, 4], self, :white)
    self[[0, 4]] = black_king
    self[[7, 4]] = white_king

    self.black_team += [black_king]
    self.white_team += [white_king]
  end

  def place_queens
    black_queen = Queen.new([0, 3], self, :white)
    white_queen = Queen.new([7, 3], self, :white)

    self[[0, 3]] = black_queen
    self[[7, 3]] = white_queen

    self.black_team += [black_queen]
    self.white_team += [white_queen]
  end

  def place_bishops
    black1 = Bishop.new([0, 2], self, :black)
    black2 = Bishop.new([0, 5], self, :black)
    white1 = Bishop.new([7, 2], self, :white)
    white2 = Bishop.new([7, 5], self, :white)

    self[[0, 2]] = black1
    self[[0, 5]] = black2
    self[[7, 2]] = white1
    self[[7, 5]] = white2

    self.black_team += [black1, black2]
    self.white_team += [white1, white2]
  end

  def place_knights
    black1 = Knight.new([0, 1], self, :black)
    black2 = Knight.new([0, 6], self, :black)
    white1 = Knight.new([7, 1], self, :white)
    white2 = Knight.new([7, 6], self, :white)

    self[[0, 1]] = black1
    self[[0, 6]] = black2
    self[[7, 1]] = white1
    self[[7, 6]] = white2

    self.black_team += [black1, black2]
    self.white_team += [white1, white2]
  end

  def place_rooks
    black1 = Rook.new([0, 0], self, :black)
    black2 = Rook.new([0, 7], self, :black)
    white1 = Rook.new([7, 0], self, :white)
    white2 = Rook.new([7, 7], self, :white)

    self[[0, 0]] = black1
    self[[0, 7]] = black2
    self[[7, 0]] = white1
    self[[7, 7]] = white2

    self.black_team += [black1, black2]
    self.white_team += [white1, white2]
  end

  def place_pawns
    place_row(1, :black)
    place_row(6, :white)
  end

  def place_row(row, color)
    @grid[row].each_index do |col|
      pawn = Pawn.new([row, col], self, color)
      self[[row, col]] = pawn
      if color == :white
        self.white_team += [pawn]
      else
        self.black_team += [pawn]
      end
    end
  end
end

class NoPieceError < StandardError
end

class InvalidMoveError < StandardError
end
