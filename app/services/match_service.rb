class MatchService
  include Singleton

  attr_accessor :data

  def start_game(id, client)
    @data = {} unless @data
    @data[id.to_sym] = Match.new unless @data[id.to_sym]
    add_player(id, client)
    @data[id.to_sym]
  end

  def add_player(id, client)
    players = @data[id.to_sym].players
    players[client.to_sym] = players.empty? ? 'X' : 'O'
    @data[id.to_sym].ready = players.count == 2
  end

  def make_play(id, play)
    plays = @data[id.to_sym].plays

    return if plays[play["i"]][play["j"]]
    plays[play["i"]][play["j"]] = play["symbol"]
    won(id)
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
    list.uniq[0] != nil && list.uniq.length == 1
  end
end

def test(bs)
  bank_slips = []
  bs.each do |bank_slip|
    occurrences = bank_slip.histories.map { |h| h.occurrence.id }
    bank_slips << bank_slip.our_number if occurrences.include?(18) && occurrences.include?(24) && bank_slip.canceled?
  end
  bank_slips
end