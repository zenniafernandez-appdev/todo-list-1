class UsersController < ApplicationController
  #skip_before_action(:force_user_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie] })

  def index
    render({ :template => "todo_templates/index.html.erb" })
  end

  def sign_in_form

    render({ :template => "user_templates/sign_in.html.erb" })
  end

  def create_cookie
    user = User.where({ :email => params.fetch("query_email") }).first
    
    the_supplied_password = params.fetch("query_password")
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/user_sign_in", { :alert => "Incorrect password." })
      else
        session[:user_id] = user.id
      
        redirect_to("/", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/user_sign_in", { :alert => "No user with that email address." })
    end
  end

  # def authenticate
  #   form_email = params.fetch("query_email")
  #   form_password = params.fetch("query_password")
    
  #   user = User.where({ :email => form_email }).at(0)

  #   if user == nil
  #     redirect_to("/user_sign_in")
  #   else
  #     user.authenticate(form_password)
  #     session.store(:user_id, user.id)

  #     redirect_to("/")
  #   end
  # end

  def sign_up_form

    render({ :template => "user_templates/sign_up.html.erb" })
  end

  def create_user
    the_user = User.new

    the_user.email = params.fetch("query_email")
    the_user.password = params.fetch("query_password")
    the_user.password_confirmation = params.fetch("query_password_confirmation")

    if the_user.valid?
      new_session = the_user.save
      redirect_to("/")

      if new_session == true
        session[:user_id] = the_user.id
      end
    else
      redirect_to("/user_sign_up")
    end
  end

  def edit_profile_form
    
    render({ :template => "user_templates/edit_user_profile.html.erb" })
  end

  # def update_user
  #   @signedin_user = @current_user
  #   @signedin_user.email = params.fetch("query_email")
  #   @signedin_user.password = params.fetch("query_password")
  #   @signedin_user.password_confirmation = params.fetch("query_password_confirmation")
    
  #   if @signedin_user.valid?
  #     @signedin_user.save

  #     redirect_to("/")
  #   else
  #     redirect_to("/modify_user", { :alert => @signedin_user.errors.full_messages.to_sentence })
  #   end
  # end

  def update
    @user = @current_user
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    
    if @user.valid?
      @user.save

      redirect_to("/", { :notice => "User account updated successfully."})
    else
      render({ :template => "user_templates/test.html.erb" , :alert => @user.errors.full_messages.to_sentence })
    end
  end


  def sign_out
    reset_session

    redirect_to("/user_sign_in")
  end
end
