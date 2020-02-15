class UsersController < ApplicationController
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
  end
  
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password])
    if @user.save
      flash[:notice] = "新規登録できました"
      redirect_to("/posts/index")
    else
      render("users/new")
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    @usr.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    if @user.save
      flash[:notice] = "変更しました"
      redirect_to("/users/index")
    else
      render("users/edit")
    end
  end


end
