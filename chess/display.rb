require 'colorize'
require_relative 'cursor'

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    board.rows.each_with_index do |row, i|
      colored_row = row.map.with_index do |square, j|
        if cursor.cursor_pos == [i, j]
          " ".on_red
        else
          " ".on_white
        end
      end
      puts colored_row.join('')
    end
  end

  def test_render
    loop do
      render
      cursor.get_input
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  require_relative 'board'
  board = Board.new
  disp = Display.new(board)
  disp.test_render
end
