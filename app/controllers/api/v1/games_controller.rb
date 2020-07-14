class Api::V1::GamesController < ApplicationController
  before_action :set_game, only: [:show, :update, :destroy, :get_first_user, :next_turn, :get_active_user]

$drawings = [];

  def draw
       #params[:userid, :xcoord, :xdist, :ycoord, :ydist, :color]
     #  if ($active_user.id == params[:uid].to_i)
     if ($active_user.cookie == params[:cookie] || 1==1)
          line = [params[:xcoord], params[:ycoord], params[ :color]]
            $drawings.append("line": line)

           render json: {data: 'ok' }#, 'drawings': $drawings}
     else
          render json: {data: 'not allowed', active_user_id: $active_user.id, your_cookie: params[:cookie]}
     end
  end

def get_request_read_drawings
      render json: $drawings
end

def clear
     #if ($active_user.id == params[:uid].to_i)
          $drawings = []
     #end
end

  # GET /games
  def index
    @games = Game.all

    render json: @games
  end

$active_user  = User.first;
$turn = 0;

def get_first_user
     @users = @game.users;
     $active_user = @users.first;
      render json: $active_user
      $turn = 0
end

def get_active_user
     users = @game.users;
     $active_user = users[($turn.to_i + 0 )%@game.users.count()];
     render json: $active_user;
end

def set_active_user(turn)
     users = @game.users;
     c_users = users.count();
     $active_user = users[(turn.to_i + 0 )%c_users];
end

def next_turn
     $turn= $turn.to_i + 1;
     set_active_user($turn);
      render json: $active_user
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
