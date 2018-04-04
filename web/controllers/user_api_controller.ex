defmodule AttendanceSystem.UserApiController do
	use AttendanceSystem.Web, :controller
	alias AttendanceSystem.{User}


	def index(conn, _params) do
		users = Repo.all(User) 
		|> Enum.map(fn user -> %{ id: user.id, username: user.username, name: user.name, role: user.role } end)
		
		conn
    	|> put_status(200)
    	|> json(users)
  	end

	def create(conn, user_params) do
		changeset = User.changeset(%User{}, user_params)
    	case Repo.insert(changeset) do
			{:ok, _user} ->
            	conn
            	|> put_status(201)
            	|> json(%{msg: "User successfully created"}) #Created
          	{:error, changeset} ->
            	conn
            	|> put_status(500)
				|> json(Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} -> 
						Enum.reduce(opts, msg, fn {key, value}, acc -> 
							String.replace(acc, "%{#{key}}", to_string(value))end) end))
    	end
	end
	  
  	# def update(conn, user_params) do
    # 	user = Repo.get!(User, user_params["id"])
    # 	changeset = User.update_changeset(user, user_params)
    # 	update_user(conn, changeset, "User successfully updated")
  	# end

  	def show(conn, %{"id" => id}) do
    	user = Repo.get!(User, id)
    	conn
    	|> put_status(200)
    	|> json(%{ id: user.id, username: user.username, name: user.name, role: user.role  })
  	end

  	def delete(conn, %{"id" => id}) do
    	user = Repo.get!(User, id) 
    	Repo.delete!(user)
    	conn
    	|> put_status(200) #Need to check
    	|> json(%{msg: "User successfully deleted"})
  	end

end
