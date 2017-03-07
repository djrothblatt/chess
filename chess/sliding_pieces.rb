require_relative 'board'

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
