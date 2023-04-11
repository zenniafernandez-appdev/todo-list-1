Rails.application.routes.draw do

  # Routes for the Todo resource:

  # CREATE
  # post("/insert_todo", { :controller => "todos", :action => "create" })
          
  # # READ
  # get("/todos", { :controller => "todos", :action => "index" })
  
  # get("/todos/:path_id", { :controller => "todos", :action => "show" })
  
  # # UPDATE
  
  # post("/modify_todo/:path_id", { :controller => "todos", :action => "update" })
  
  # # DELETE
  # get("/delete_todo/:path_id", { :controller => "todos", :action => "destroy" })

  get("/", { :controller => "todos", :action => "index" })

  post("/insert_todo", { :controller => "todos", :action => "create_todo_form" })

  get("delete_todo/:id", { :controller => "todos", :action => "destroy_todo" })

  get("/modify_todo/:id", { :controller => "todos", :action => "update_todo" })

  #------------------------------

  # Routes for the User resource:

  get("/user_sign_in", { :controller => "users", :action => "sign_in_form" })

  post("/user_verify_credentials", { :controller => "users", :action => "create_cookie" })

  get("/user_sign_out", { :controller => "users", :action => "sign_out" })

  get("/user_sign_up", { :controller => "users", :action => "sign_up_form" })

  post("/insert_user", { :controller => "users", :action => "create_user" })

  get("/edit_user_profile", { :controller => "users", :action => "edit_profile_form" })

  post("/modify_user", { :controller => "users", :action => "update_user" })
  
end
