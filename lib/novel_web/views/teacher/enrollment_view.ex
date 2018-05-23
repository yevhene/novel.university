defmodule NovelWeb.Teacher.EnrollmentView do
  use NovelWeb, :view

  import NovelWeb.UserHelpers
  import NovelWeb.FormatHelpers

  def enrollment_group_options(groups) do
    groups
    |> Enum.map(&{&1.name, &1.id})
    |> Enum.concat([{"-", nil}])
    |> Enum.reverse
  end

  def render("index.csv", %{enrollments: enrollments}) do
    enrollments
    |> Enum.map(fn enrollment ->
      [
        full_name(enrollment.user),
        enrollment.group && enrollment.group.name,
        format_results_string(enrollment.assignment_results),
        format_results_string(enrollment.exam_results)
      ]
    end)
    |> List.insert_at(0, [
      gettext("Student"),
      gettext("Group"),
      gettext("Labs"),
      gettext("Quizzes")
    ])
    |> CSV.encode
    |> Enum.to_list
    |> to_string
  end
end
