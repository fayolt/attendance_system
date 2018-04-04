defmodule AttendanceSystem.Repo.Migrations.CreatePshRaw do
  use Ecto.Migration

  def change do
    create table(:psh_raw) do
      add :time, :naive_datetime
      add :direct, :integer
      add :type, :integer
      add :user_fk, references(:users, on_delete: :delete_all)

      timestamps()
    end
    create index(:psh_raw, [:user_fk])
  end
end
