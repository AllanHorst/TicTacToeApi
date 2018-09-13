class Match
  attr_accessor :players, :turn, :winner, :plays

  def initialize
    @turn = 'X'
    @plays = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    @winner = nil
  end
end
