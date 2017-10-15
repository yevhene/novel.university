defmodule NovelWeb.Teacher.EnrollmentView do
  use NovelWeb, :view

  import NovelWeb.UserHelper

  def enrollment_group_options(groups) do
    groups
    |> Enum.map(&{&1.name, &1.id})
    |> Enum.concat([{"-", nil}])
    |> Enum.reverse
  end
end
