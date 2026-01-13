class MatchesController < ApplicationController
  before_action :set_match, only: [:edit, :update, :destroy]
  before_action :set_players, only: [:new, :create, :edit, :update]

  def index
    @matches = Match
      .includes(:winner, :loser)
      .order(created_at: :desc)
      .page(params[:page])
      .per(10)
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    if @match.save
      redirect_to matches_path, notice: "Match recorded successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @match.update(match_params)
      redirect_to matches_path, notice: "Match updated successfully"
    else
      render :edit
    end
  end

  def destroy
    if @match.destroy
      flash[:success] = 'Match was successfully deleted.'
      redirect_to matches_url
    else
      flash[:error] = 'Something went wrong'
      redirect_to matches_url
    end
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end

  def set_players
    @players = Player.all
  end

  def match_params
    params.require(:match).permit(:winner_id, :loser_id)
  end
end
