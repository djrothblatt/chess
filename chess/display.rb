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
      colored_row = row.map.with_index do |piece, j|
        colorized = color_piece(piece)
        color_background(colorized, i, j)
      end
      puts colored_row.join('')
    end
  end

  def color_piece(piece)
    color = piece.color
    symbol = piece.symbol
    symbol = " " if symbol == :_
    if color == :white
      symbol.to_s.yellow
    else
      symbol.to_s.red
    end
  end

  def color_background(colorized, i, j)
    if cursor.cursor_pos == [i, j]
      colorized.on_green
    elsif same_parity?(i, j)
      colorized.on_white
    else
      colorized.on_black
    end
  end

  def same_parity?(num1, num2)
    (num1 % 2) == (num2 % 2)
  end
end
