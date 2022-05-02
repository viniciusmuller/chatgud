defmodule ChatgudWeb.Helpers.HelperMacros do
  @moduledoc false

  defmacro creation_date() do
    quote do
      field :creation_date, non_null(:naive_datetime) do
        resolve(fn parent, _, _ ->
          {:ok, parent.inserted_at}
        end)
      end
    end
  end

  defmacro update_date() do
    quote do
      field :update_date, :naive_datetime do
        resolve(fn parent, _, _ ->
          {:ok, parent.updated_at}
        end)
      end
    end
  end
end
