class MatchChannel < ApplicationCable::Channel
  def subscribed
    stream_from "match_#{params[:id]}"
  end

  def unsubscribed
    data = MatchService.instance.data[params[:id].to_sym]
    data.players.delete(params[:client].to_sym)
    data.ready = false
    broadcast(game: data.as_json)
    stop_all_streams
  end

  def start_game(data)
    match = MatchService.instance.start_game(params[:id], params[:client])
    broadcast(game: match.as_json)
  end

  def restart_game(data)
    match = MatchService.instance.start_game(params[:id])
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