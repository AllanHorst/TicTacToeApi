class Match
  attr_accessor :players, :turn, :winner, :plays

  def initialize
    @players = []
    @turn = 'X'
    @isReadyToPlay = false
    @winner = nil
  end
end
