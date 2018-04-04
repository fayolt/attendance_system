defmodule AttendanceSystem.PshRaw do
  use AttendanceSystem.Web, :model

  schema "psh_raw" do
    field :time, :naive_datetime
    field :direct, :integer
    field :type, :integer
    
    belongs_to :user, AttendanceSystem.User, foreign_key: :user_fk

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:time, :direct, :type])
    |> validate_required([:time, :direct, :type])
  end
end
