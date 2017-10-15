defmodule NovelWeb.Teacher.EnrollmentView do
  use NovelWeb, :view

  def enrollment_status(enrollment) do
    case enrollment.is_approved do
      true ->
        content_tag :span do
          [
            content_tag(:span, "Approved "),
            content_tag(:i, "", class: "fa fa-check-circle")
          ]
        end
      false ->
        content_tag :span do
          [
            content_tag(:span, "Rejected "),
            content_tag(:i, "", class: "fa fa-times-circle")
          ]
        end
      nil ->
        content_tag :span do
          [
            content_tag(:span, "Not Approved Yet "),
            content_tag(:i, "", class: "fa fa-question-circle")
          ]
        end
    end
  end

  def enrollment_group_options(groups) do
    groups
    |> Enum.map(&{&1.name, &1.id})
    |> Enum.concat([{"-", nil}])
    |> Enum.reverse
  end
end
