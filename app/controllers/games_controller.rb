class GamesController < ApplicationController
  before_action :set_game, only: [:show, :update, :destroy]

  # GET /games
  def index
    @games = Game.all

    render json: @games
  end

@active_user  = "";
@turn = 0;

def get_first_user
     @users = @game.users;
     @active_user = @users.first;
end

def get_active_user
     render json: @active_user;
end

def set_active_user(turn)
     users = @game.users;
     c_users = @users.count();
     @active_user = users[turn%c_users];
end

def next_turn
     @turn++
     set_active_user(@turn);
end

  # GET /games/1
  def show
    render json: @game
  end

  # POST /games
  def create
    @game = Game.new(game_params)

    if @game.save
      render json: @game, status: :created, location: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      render json: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_params
     params.require(:game).permit(:game_desc)
    end
end
