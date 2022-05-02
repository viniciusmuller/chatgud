defmodule Chatgud.Security do
  @moduledoc """
  Wrapper module that deals with security-related functions
  """

  @user_salt "user auth"

  alias Chatgud.Accounts.User

  def add_hash(password) do
    Argon2.add_hash(password)
  end

  def check_pass(user = %User{}, password) do
    Argon2.check_pass(user, password)
  end

  def sign_user_token(id) do
    Phoenix.Token.sign(ChatgudWeb.Endpoint, @user_salt, id)
  end

  def verify_user_token(token) do
    Phoenix.Token.verify(ChatgudWeb.Endpoint, @user_salt, token, max_age: 86_400)
  end
end
