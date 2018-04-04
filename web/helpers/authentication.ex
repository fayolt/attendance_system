defmodule AttendanceSystem.Authentication do
    def check_credentials(user, password) do
        Comeonin.Pbkdf2.check_pass(user, password)
    end
end