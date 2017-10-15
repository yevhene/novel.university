alias Novel.Account.User
alias Novel.University.Course
alias Novel.University.Enrollment

defimpl Canada.Can, for: User do
  def can?(%User{}, action, Enrollment)
    when action in [:new, :create], do: true
  def can?(%User{id: user_id}, action, %Enrollment{user_id: user_id})
    when action in [:show, :delete], do: true

  def can?(%User{}, :index, Course), do: true
  def can?(%User{}, :show, %Course{}), do: true
  def can?(%User{is_teacher: true}, action, Course)
    when action in [:new, :create], do: true
  def can?(%User{id: user_id}, action, %Course{head_id: user_id})
    when action in [:edit, :update, :delete], do: true

  def can?(%User{}, _, _), do: false
end

defimpl Canada.Can, for: Atom do
  def can?(nil, :index, Course), do: true
  def can?(nil, :show, %Course{}), do: true

  def can?(nil, _, _), do: false
end
