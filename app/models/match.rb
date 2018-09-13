class Match
  attr_accessor :players, :turn, :winner, :plays, :ready

  def initialize
    @players = {}
    @turn = 'X'
    @plays = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    @winner = nil
    @ready = false
  end
end
