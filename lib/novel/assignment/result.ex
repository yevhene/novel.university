defmodule Novel.Assignment.Result do
  use Ecto.Schema

  alias Novel.Assignment.Lab
  alias Novel.University.Enrollment

  @primary_key false
  schema "assignment_results" do
    field :status, :string

    belongs_to :lab, Lab
    belongs_to :enrollment, Enrollment
  end
end
