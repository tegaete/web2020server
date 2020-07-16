class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :return_session_data, :join_game, :leave_game]

require 'securerandom'

def login
     @u = User.find_by!(username: user_params[:username])
     if(@u.password == user_params[:password])
          cookie_params = {session_cookie: SecureRandom.hex, game: Game.first }
          @u.update(cookie_params)

          render json: {data: 'ok', cookie: cookie_params[:session_cookie]}
          return;
     end
     render json: {data: 'fallo de autenticacion'}
end


def logout
     @u = User.find_by(session_cookie: user_params[:session_cookie])
     cookie_params = {session_cookie: nil, game: nil  }
     if(@u != nil)
          @u.update(cookie_params)
          render json: {data: 'ok', exp: 'sesion finalizada'}
     else
          render json: {data: '@u no existe'}
 end
end

def join_game
     join_params = {game: Game.find(user_params[:game]) }
     @user.update(join_params)
     render json: {data: 'ok', exp: 'ingresaste al tablero ' + user_params[:game] }
end

def leave_game
     leave_params = {game: nil }
     @user.update(leave_params)
     render json: {data: 'ok', exp: 'saliste del juego'}
end

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  def return_session_data
       render json: @user.session_cookie
end
  # POST /users
  def create
       g = Game.all[user_params[:game].to_i-1]
       creation_params = {game: g, session_cookie: nil, password: user_params[:password], username: user_params[:username], language: user_params[:lang], email: user_params[:email]}

    @user = User.new(creation_params)

    if @user.save
         #session[:current_user_id] = @user.id
      render json: {data: 'ok', exp: 'saliste del juego', user: @user}, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:session_cookie, :game, :password, :username, :lang, :email)
    end
end
