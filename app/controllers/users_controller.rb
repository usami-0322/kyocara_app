class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbit_login_user, {only: [:login_form, :login, :create, :new]}
 # before_action :ensure_correct_user, {only: [:edit, :update]}
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end 
  
  def edit 
    @user = User.find_by(id: params[:id])
  end
  
  def login_form
  end
  
  def login
    #ユーザーの特定をする
   @user = User.find_by(
     email: params[:email],
     password: params[:password]
     )
     #ユーザが一致したとき,そうじゃないとき
     if @user
       session[:user_id] = @user.id
       flash[:notice] = "ログインしました"
       redirect_to("/posts/index")
     else
       @error_message = "メールアドレスまたはパスワードが違います"
       @email = params[:email]
       @password = params[:password]
       render("users/login_form")
     end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    render("home/top")
  end
  
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "default.jpeg",
      password: params[:password]
      )
    if @user.save
      #新規登録でログイン状態にする
      session[:user_id] = @user.id
      flash[:notice] = "新規登録できました"
      redirect_to("/posts/index}")
    else
      render("users/new")
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    
    if params[:image]
     @user.image_name = "#{@user.id}.jpg"
     image = params[:image]
     File.binwrite("public/#{@user.image_name}", image.read)
    end
    
    if @user.save
      flash[:notice] = "変更しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end
  
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
end
