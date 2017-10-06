# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Novel.Repo.insert!(%Novel.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Novel.Repo.delete_all Novel.Accounts.User

Novel.Accounts.User.changeset(%Novel.Accounts.User{}, %{
  name: "Example User",
  email: "user@example.com",
  password: "password",
  password_confirmation: "password"
})
|> Novel.Repo.insert!
