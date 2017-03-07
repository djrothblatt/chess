require_relative 'board'

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
