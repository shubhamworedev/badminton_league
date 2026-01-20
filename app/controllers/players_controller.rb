class PlayersController < ApplicationController
  before_action :set_player, only: [:edit, :update, :destroy]

  def index
    @players = Player
      .left_joins(:wins, :losses)
      .select(
        "players.*,
        COUNT(DISTINCT matches.id) FILTER (WHERE matches.winner_id = players.id) AS wins_count,
        COUNT(DISTINCT matches.id) FILTER (WHERE matches.loser_id = players.id) AS losses_count"
      )
      .group("players.id")
      .order("wins_count DESC")
      .page(params[:page])
      .per(10)
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to players_path, notice: "Player added successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @player.update(player_params)
      redirect_to players_path, notice: "Player updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @player.destroy
    redirect_to players_path, notice: "Player removed"
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name)
  end
end
