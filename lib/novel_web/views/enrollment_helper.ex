defmodule NovelWeb.EnrollmentHelper do
  alias Novel.University.Enrollment
  alias Novel.University.Group

  import Phoenix.HTML.Tag, only: [content_tag: 2, content_tag: 3]

  def enrollment_status(%Enrollment{} = enrollment) do
    case enrollment.group do
      nil ->
        content_tag :span do
          [
            content_tag(:span, "Not Approved Yet "),
            content_tag(:i, "", class: "fa fa-question-circle")
          ]
        end
      %Group{} ->
        content_tag :span do
          [
            content_tag(:span, "Approved "),
            content_tag(:i, "", class: "fa fa-check-circle")
          ]
        end
    end
  end
end
