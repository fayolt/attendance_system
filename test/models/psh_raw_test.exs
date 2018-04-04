defmodule AttendanceSystem.PshRawTest do
  use AttendanceSystem.ModelCase

  alias AttendanceSystem.PshRaw

  @valid_attrs %{direct: 42, time: ~N[2010-04-17 14:00:00.000000], type: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PshRaw.changeset(%PshRaw{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PshRaw.changeset(%PshRaw{}, @invalid_attrs)
    refute changeset.valid?
  end
end
