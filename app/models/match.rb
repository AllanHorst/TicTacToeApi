class Match
  attr_accessor :players, :turn, :winner, :plays, :ready

  def initialize
    @players = {}
    @turn = 'X'
    @ready = false
    start_game
  end

  def start_game
    @plays = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    @winner = nil
    self
  end
end
