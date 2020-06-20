class UsersController < ApplicationController

  before_action :authenticate_user, {only: [:edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
    @users = User.all.order(created: :desc)
  end

  def show
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      password: params[:password],
      image_name: "default_user.jpg"
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "新規登録しました"
      redirect_to("/users/index")
    else
      @error_message = "ユーザー名またはパスワードを正しく入力してください"
      @name = params[:name]
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.password = params[:password]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image =params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザーを編集しました"
      redirect_to("/users/index")
    else
      @error_message = "ユーザー名またはパスワードを正しく入力してください"
      render("users/:id/edit")
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:notice] = "ユーザーを削除しました"
    redirect_to("/")
  end

  def login_form
  end

  def login
    @user = User.find_by(name: params[:name], password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/users/index")
    else
      @error_message = "ユーザー名またはパスワードが間違っています"
      @name = params[:name]
      render("login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
