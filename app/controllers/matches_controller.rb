class MatchesController < ApplicationController
  def index
    @matches = Match
      .includes(:winner, :loser)
      .order(created_at: :desc)
      .page(params[:page])
      .per(10)
  end

  def new
    @match = Match.new
    @players = Player.all
  end

  def create
    @match = Match.new(match_params)
    if @match.save
      redirect_to matches_path, notice: "Match recorded successfully"
    else
      @players = Player.all
      render :new
    end
  end

  def edit
    @match = Match.find(params[:id])
    @players = Player.all
  end

  def update
    @match = Match.find(params[:id])
    if @match.update(match_params)
      redirect_to matches_path, notice: "Match updated successfully"
    else
      @players = Player.all
      render :edit
    end
  end

  def destroy
    @match = Match.find(params[:id])
    if @match.destroy
      flash[:success] = 'Match was successfully deleted.'
      redirect_to matches_url
    else
      flash[:error] = 'Something went wrong'
      redirect_to matches_url
    end
  end
  

  private

  def match_params
    params.require(:match).permit(:winner_id, :loser_id)
  end
end
