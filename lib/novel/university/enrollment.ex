defmodule Novel.University.Enrollment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Account.User
  alias Novel.University.Group
  alias Novel.University.Enrollment

  schema "university_enrollments" do
    belongs_to :group, Group
    belongs_to :user, User

    field :invitation_code, :string, virtual: true

    timestamps()
  end

  def changeset(%Enrollment{} = enrollment, attrs) do
    enrollment
    |> cast(attrs, [:group_id, :user_id])
    |> validate_required([:group_id, :user_id])
    |> foreign_key_constraint(:group_id)
    |> foreign_key_constraint(:user_id)
    |> unique_constraint(:name, name: :enrollments_user_id_group_id_index)
  end
end
