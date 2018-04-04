defmodule AttendanceSystem.SessionApiController do
  use AttendanceSystem.Web, :controller
  alias AttendanceSystem.{Repo,User,Authentication}

	def create(conn, %{"username" => username, "password" => password}) do
		user = Repo.get_by!(User, username: username)   
		IO.inspect user
    	case Authentication.check_credentials(user, password) do
		{:ok, _conn} ->
			{:ok, jwt, _full_claims} = Guardian.encode_and_sign(user, :token)
			conn
			|> put_status(201)
			|> json(%{token: jwt, role: user.role})
			
		{:error, _conn} ->
			conn
			|> put_status(400)
			|> json(%{message: "Bad credentials"})
    	end
  	end

  	def delete(conn, _params) do
		{:ok, claims} = Guardian.Plug.claims(conn)
    	conn
    	|> Guardian.Plug.current_token
    	|> Guardian.revoke!(claims)

    	conn
    	|> json(%{msg: "Good bye"})
	end
	def unauthenticated(conn, _params) do
		conn
		|> put_status(401)
		|> json(%{msg: "Unauthenticated"}) #Unauthorized
		|> halt
	end
end
