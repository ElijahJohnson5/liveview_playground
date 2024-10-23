defmodule Playground.Message do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, except: [:__meta__, :room]}

  alias Playground.Account.User
  alias Playground.Room

  schema "messages" do
    field :content, :string
    belongs_to :room, Room
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :room_id, :user_id])
    |> assoc_constraint(:room)
    |> assoc_constraint(:user)
    |> validate_required([:content, :room_id, :user_id])
  end
end
