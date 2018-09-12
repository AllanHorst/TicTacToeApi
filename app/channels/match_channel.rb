class MatchChannel < ApplicationCable::Channel
  def subscribed
    stream_from "match_#{params[:id]}"
  end

  def unsubscribed
    stop_all_streams
  end

  def get_game(data)
    puts '<>' * 100
    p params
    p data
    data = {
      players: [],
      game: {
        turn: 'X',
        isReadyToPlay: false,
        winner: nil,
        plays: [
          [nil, nil, nil],
          [nil, nil, nil],
          [nil, nil, nil]
        ]
      }
    }
    broadcast(data)
  end

  def make_play(data)
    puts '<>' * 100
    p params
    p data
  end

  private

  def broadcast(data)
    ActionCable.server.broadcast "match_#{params[:id]}", data
  end
end