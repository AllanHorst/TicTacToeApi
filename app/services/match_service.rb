class MatchService
  include Singleton

  attr_accessor :data

  def start_game(id)
    @data = {} unless @data
    @data[id.to_sym] = Match.new
  end

  def switch(id)
    @data[id.to_sym].turn = @data[id.to_sym].turn == 'X' ? 'O' : 'X'
    @data[id.to_sym]
  end

  def make_play(id, play)
    plays = @data[id.to_sym].plays

    return if plays[play["i"]][play["j"]]
    plays[play["i"]][play["j"]] = play["symbol"]

    switch(id)
  end

end
