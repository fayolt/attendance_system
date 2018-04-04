# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AttendanceSystem.Repo.insert!(%AttendanceSystem.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will halt execution if something goes wrong.

alias AttendanceSystem.{Repo, User}

[%{name: "Fred Flintstone", username: "fred", password: "parool", role: "employee"},
%{name: "Barney Rubble", username: "barney", password: "parool", role: "employee"},
%{name: "Bilbo Baggins", username: "bilbo", password: "parool", role: "employee"},
%{name: "Frodo Baggins", username: "frodo", password: "parool", role: "manager"}]
|> Enum.map(fn user_data -> User.changeset(%User{}, user_data) end)
|> Enum.each(fn changeset -> Repo.insert!(changeset) end)

# [%{username: "bilbo", location: "Uus turu 2", status: "available"},
# %{username: "frodo", location: "Raatuse 22", status: "available"}]
# |> Enum.map(fn taxi_data -> Taxi.changeset(%Taxi{}, taxi_data) end)
# |> Enum.each(fn changeset -> Repo.insert!(changeset) end)
