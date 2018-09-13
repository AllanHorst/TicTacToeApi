class MatchService
  include Singleton

  attr_accessor :data

  def start_game(id)
    @data = {} unless @data
    @data[id.to_sym] = Match.new
  end

  def make_play(id, play)
    plays = @data[id.to_sym].plays

    return if plays[play["i"]][play["j"]]
    plays[play["i"]][play["j"]] = play["symbol"]

    if won(id)
      @data[id.to_sym].winner = play["symbol"]
      return @data[id.to_sym]
    end

    switch(id)
  end

  private

  def switch(id)
    @data[id.to_sym].turn = @data[id.to_sym].turn == 'X' ? 'O' : 'X'
    @data[id.to_sym]
  end

  def won(id)
    won_vertically(id) || won_horizontally(id) || won_diagonally(id)
  end

  def won_vertically(id)
    plays = @data[id.to_sym].plays
    [0, 1, 2].map do |index|
      all_equal? plays.map {|play| play[index]}
    end.include?(true)
  end

  def won_horizontally(id)
    plays = @data[id.to_sym].plays
    plays.map do |line|
      all_equal? line
    end.include?(true)
  end

  def won_diagonally(id)
    plays = @data[id.to_sym].plays
    all_equal?([0, 1, 2].map {|index| plays[index][index]}) ||
    all_equal?([2, 1, 0].map {|index| plays[index][index]})
  end

  def all_equal?(list)
    list.uniq.length == 1
  end
end


# const wonHorizontally = plays => {
# 	return plays.map((row, i) => areAllEqual(row)).includes(true)
# }

# const wonVertically = plays => {
# 	return plays.map((row, i) =>
# 		areAllEqual(row.map((item, j) => plays[j] [i]))
# 	).includes(true)
# }

# const wonDiagonally = plays => {
# 	return (
# 		areAllEqual(plays.map((row, i) => row[i])) ||
# 		areAllEqual(plays.map((row, i) => row[row.length - 1 - i]))
# 	)
# }

# v = [[1, 2, 3], [1, 4, 5], [1, 6, 7]]
# h = [[1, 1, 1], [2, 4, 5], [3, 6, 7]]
# d = [[1, 1, 2], [2, 1, 5], [3, 1, 1]]