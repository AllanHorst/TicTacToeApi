class MatchChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'match'
  end

  def unsubscribed
    stop_all_streams
  end

  def receive(data)
    ActionCable.server.broadcast("match", data)
  end
end