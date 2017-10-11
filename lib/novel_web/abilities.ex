alias Novel.Accounts.User
alias Novel.Education.Course

defimpl Canada.Can, for: User do
  def can?(%User{}, :index, Course), do: true
  def can?(%User{}, :show, %Course{}), do: true
  def can?(%User{ is_teacher: true }, :create, Course), do: true
  def can?(%User{ id: user_id }, action, %Course{ user_id: user_id })
    when action in [:update, :delete], do: true

  def can?(%User{}, _, _), do: false
end

defimpl Canada.Can, for: Atom do
  def can?(nil, :index, Course), do: true
  def can?(nil, :show, %Course{}), do: true

  def can?(nil, _, _), do: false
end
