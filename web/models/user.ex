defmodule AttendanceSystem.User do
  use AttendanceSystem.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :role, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string

    has_many :psh_raw, AttendanceSystem.PshRaw, on_delete: :delete_all

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :username, :password, :role])
    |> validate_required([:name, :username, :password, :role])
    |> encrypt_password
    |> unique_constraint(:username)
    
  end

  def encrypt_password(changeset) do
    if changeset.valid? do
      put_change(changeset, :encrypted_password, Comeonin.Pbkdf2.hashpwsalt(changeset.changes[:password]))
    else
      changeset
    end
  end
end
