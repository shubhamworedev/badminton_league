class PlayersController < ApplicationController
  def index
    @players = Player
      .left_joins(:wins)
      .group("players.id")
      .order("COUNT(matches.id) DESC")
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
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update(player_params)
      redirect_to players_path, notice: "Player updated successfully"
    else
      render :edit
    end
  end

  def destroy
    Player.find(params[:id]).destroy
    redirect_to players_path, notice: "Player removed"
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end
