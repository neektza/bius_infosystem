class UserController < ApplicationController
  before_filter :authorize, :except => [:login, :logout, :new, :create, :generate_admin]

  #before_filter :check_if_supervisory_board, :only => [:index]
  #before_filter :check_if_administrative_board, :only => [:rights, :destroy]
  #before_filter :check_if_destroy_self, :only => [:destroy]
  #prepend_before_filter :check_if_administrative_board, :check_if_destroy_self

  # Authenticate and store user data in session hash
  def login
    session[:user_id] = nil
    if request.post?
      user = Member.authenticate(params[:username], params[:password])
      if user
        session[:user_id] = user.id
        session[:user_username] = user.username
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to uri || members_url
      else
        flash.now[:notice] = "error.login" #t(errors.login)
      end
    end
  end

  # Clear user data from session hash
  def logout
    session[:user_id] = nil
    session[:user_username] = nil
    flash[:notice] = "message.logout" #t(messages.logout)
    redirect_to login_user_url
  end

  # Show user
  def show
    @user = Member.find(session[:user_id])
  end

  # New user (form)
  def new
    @user = Member.new
  end

  # Create new user (create registration)
  def create
    @user = Member.new(params[:user])
    @user.auth_level = Member::ROLE[:applicant]
    if @user.save
      flash[:notice] = "message.user.create" # t(messages.registration)
      redirect_to login_user_url
    else
      render "new"
    end
  end

  # Edit user (form)
  def edit
    @user = Member.find(session[:user_id])
  end

  # Update user profile
  def update
    @user = Member.find(session[:user_id])
    if @user.update_attributes(params[:user])
      flash.now[:notice] = "message.user.update" # t(messages.profile.update)
      redirect_to user_url
    else
      render "edit"
    end
  end

  # FIXME Generate first user
  def generate_admin
    unless Member.find_by_username('admin')
      admin = Member.new({:username => 'admin' , :first_name => 'admin' , :last_name => 'admin' , :email => 'neektza@kset.org' , :password => 'admin', :auth_level => Member::ROLE[:admin]})
      admin.save
    end
    redirect_to login_user_url
  end

end
