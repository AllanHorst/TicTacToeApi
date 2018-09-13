class MatchChannel < ApplicationCable::Channel
  def subscribed
    stream_from "match_#{params[:id]}"
  end

  def unsubscribed
    stop_all_streams
  end

  def get_game(data)
    match = MatchService.instance.start_game(params[:id])
    broadcast(match.as_json)
  end

  def make_play(data)
    match = MatchService.instance.make_play(params[:id], data["play"])
    broadcast(match.as_json)
  end

  private

  def broadcast(data)
    ActionCable.server.broadcast "match_#{params[:id]}", data
  end
end