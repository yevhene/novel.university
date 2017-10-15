defmodule NovelWeb.Guardian do
  use Guardian, otp_app: :novel

  alias Novel.Repo
  alias Novel.Account.User

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}
  def subject_for_token(_, _), do: {:error, :cannot_serialize_resource}

  def resource_from_claims(%{"sub" => id}), do: {:ok, Repo.get(User, id)}
  def resource_from_claims(_), do: {:error, :not_found}
end
