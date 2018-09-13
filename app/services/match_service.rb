class MatchService
  include Singleton

  attr_accessor :data

  def start_game(id, client)
    @data = {} unless @data
    return restart_game(id) if @data[id.to_sym] && @data[id.to_sym].winner

    @data[id.to_sym] = Match.new if !@data[id.to_sym]
    add_player(id, client)
    @data[id.to_sym]
  end

  def restart_game(id)
    @data[id.to_sym].start_game
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
    if full?(id)
      @data[id.to_sym].winner = 'none'
      return @data[id.to_sym]
    end

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
    all_equal?(plays.each_with_index.map { |row, i| row[i] }) ||
    all_equal?(plays.each_with_index.map { |row, i| row[row.length - 1 - i] })
  end

  def all_equal?(list)
    list.uniq[0] != nil && list.uniq.length == 1
  end

  def full?(id)
    plays = @data[id.to_sym].plays
    plays.map do |line|
      line.include? nil
    end.exclude?(true)
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