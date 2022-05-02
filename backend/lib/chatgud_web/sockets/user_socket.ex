defmodule ChatgudWeb.UserSocket do
  use Phoenix.Socket
  use Absinthe.Phoenix.Socket, schema: ChatgudWeb.Schema

  # alias Chatgud.{Security, Accounts}

  def connect(_params, socket) do
    {:ok, socket}
    # with {:ok, token} <- Map.fetch(params, "token"),
    #      {:ok, user_id} <- Security.verify_user_token(token),
    #      {:ok, user} <- Accounts.fetch_user_by(id: user_id) do
    #   socket =
    #     Absinthe.Phoenix.Socket.put_options(socket,
    #       context: %{
    #         current_user: user
    #       }
    #     )

    #   {:ok, socket}
    # else
    #   {:error, msg} -> {:error, msg}
    # end
  end

  def id(_socket), do: nil
end
