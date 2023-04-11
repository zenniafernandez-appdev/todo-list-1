class TodosController < ApplicationController

  def index
    if @current_user == nil
      redirect_to("/user_sign_in")
    else

    matching_todos = Todo.where({ :user_id => @current_user.id })

    @list_of_todos = matching_todos.order({ :created_at => :desc })

    @next_todo = @list_of_todos.where({ :status => "next" })
    @in_progress_todo = @list_of_todos.where({ :status => "in_progress" })
    @done_todo = @list_of_todos.where({ :status => "done" })

    render({ :template => "todo_templates/index.html.erb" })
    end
  end

  def create_todo_form
    current_user = User.where({ :id => session.fetch(:user_id) }).at(0)
    a_todo = Todo.new
    a_todo.user_id = session.fetch(:user_id)
    a_todo.content = params.fetch("query_content")

    if a_todo.valid?
      a_todo.save

      redirect_to("/")
    end
  end

  def destroy_todo
    a_todo = params.fetch("id")
    the_todo = Todo.where({ :id => a_todo }).at(0)

    the_todo.destroy

    redirect_to("/")
  end

  def update_todo
    a_todo = params.fetch("id")
    the_todo = Todo.where({ :id => a_todo }).at(0)

    the_todo.status = params.fetch("query_status")
    the_todo.user_id = @current_user.id

    if the_todo.valid?
      the_todo.save

      redirect_to("/")
    else
      redirect_to("/")
    end
  end






  # def index
  #   matching_todos = Todo.all

  #   @list_of_todos = matching_todos.order({ :created_at => :desc })

  #   render({ :template => "todos/index.html.erb" })
  # end

  # def show
  #   the_id = params.fetch("path_id")

  #   matching_todos = Todo.where({ :id => the_id })

  #   @the_todo = matching_todos.at(0)

  #   render({ :template => "todos/show.html.erb" })
  # end

  # def create
  #   the_todo = Todo.new
  #   the_todo.content = params.fetch("query_content")
  #   the_todo.status = params.fetch("query_status")
  #   the_todo.user_id = params.fetch("query_user_id")

  #   if the_todo.valid?
  #     the_todo.save
  #     redirect_to("/todos", { :notice => "Todo created successfully." })
  #   else
  #     redirect_to("/todos", { :alert => the_todo.errors.full_messages.to_sentence })
  #   end
  # end

  # def update
  #   the_id = params.fetch("path_id")
  #   the_todo = Todo.where({ :id => the_id }).at(0)

  #   the_todo.content = params.fetch("query_content")
  #   the_todo.status = params.fetch("query_status")
  #   the_todo.user_id = params.fetch("query_user_id")

  #   if the_todo.valid?
  #     the_todo.save
  #     redirect_to("/todos/#{the_todo.id}", { :notice => "Todo updated successfully."} )
  #   else
  #     redirect_to("/todos/#{the_todo.id}", { :alert => the_todo.errors.full_messages.to_sentence })
  #   end
  # end

  # def destroy
  #   the_id = params.fetch("path_id")
  #   the_todo = Todo.where({ :id => the_id }).at(0)

  #   the_todo.destroy

  #   redirect_to("/todos", { :notice => "Todo deleted successfully."} )
  # end
end
