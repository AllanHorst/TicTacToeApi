class MatchService
  include Singleton

  attr_accessor :data

  def initialize_game(id)
    @data = {} unless @data
    @data[id.to_sym] = Match.new
    initialize_plays(id)
  end

  def initialize_plays(id)
    @data[id.to_sym].plays = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
  end

  def add_player(id, client)
    @data[id.to_sym].players << { client: client}
  end

  def switch(id)
    @data[id.to_sym].turn = @data[id.to_sym].turn == 'X' ? 'O' : 'X'
  end

  def make_play(id, play)
    plays = @data[id.to_sym].plays
    p play[:i]
    return if plays[play[:i]][play[:j]]

    plays[play[:i]][play[:j]] = play[:symbol]
  end

end


# let { i, j, symbol } = play

# 	if(data[id].game.plays[i][j] == null) {
# 		data[id].game.plays[i][j] = symbol
# 	}