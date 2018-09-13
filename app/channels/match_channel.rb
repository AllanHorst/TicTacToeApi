class MatchChannel < ApplicationCable::Channel
  def subscribed
    stream_from "match_#{params[:id]}"
  end

  def unsubscribed
    stop_all_streams
  end

  def start_game(data)
    match = MatchService.instance.start_game(params[:id], data["client"])
    broadcast(game: match.as_json)
  end

  def restart_game(data)
    match = MatchService.instance.restart_game(params[:id], data["client"])
    broadcast(game: match.as_json)
  end

  def make_play(data)
    match = MatchService.instance.make_play(params[:id], data["play"])
    broadcast(game: match.as_json)
  end

  private

  def broadcast(data)
    ActionCable.server.broadcast "match_#{params[:id]}", data
  end
end