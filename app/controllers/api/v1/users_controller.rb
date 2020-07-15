class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :return_session_data]

require 'securerandom'

def login
     @u = User.find_by(username: user_params[:username])
     if(@u.password == user_params[:password])
          cookie_params = {session_cookie: SecureRandom.hex }
          @u.update(cookie_params)

          render json: @u
          return;
     end
     render json: {data: 'fallo de autenticacion'}
end


def logout
     @u = User.find_by(session_cookie: user_params[:session_cookie])
     cookie_params = {session_cookie: '' }
     if(@u != nil)
          @u.update(cookie_params)
          render json: {data: 'sesion finalizada'}
     else
          render json: {data: '@u no existe'}
       # code
 end
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
       creation_params = {game: g, session_cookie: '', password: user_params[:password], username: user_params[:username]}

    @user = User.new(creation_params)

    if @user.save
         session[:current_user_id] = @user.id
      render json: @user, status: :created, location: @user
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
      params.permit(:session_cookie, :game, :password, :username)
    end
end
