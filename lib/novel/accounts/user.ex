defmodule Novel.Accounts.User do
  use Ecto.Schema
  use Coherence.Schema

  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string

    coherence_schema()

    timestamps(type: :utc_datetime)
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name, :email] ++ coherence_fields())
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_coherence(params)
  end

  def changeset(model, params, :password) do
    model
    |> cast(params, ~w(
      password
      password_confirmation
      reset_password_token
      reset_password_sent_at
    ))
    |> validate_coherence_password_reset(params)
  end
end
