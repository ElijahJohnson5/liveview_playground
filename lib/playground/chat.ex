defmodule Playground.Chat do
  @moduledoc """
  The Chat context.
  """

  import Ecto.Query, warn: false
  alias Playground.Repo

  alias Playground.Room
  alias Playground.Message

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms do
    Repo.all(Room)
  end

  @doc """
  Gets a single room.

  Raises if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

  """
  def get_room!(id) do
    Repo.get(Room, id)
  end

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, ...}

  """
  def create_room(attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, ...}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, ...}

  """
  def delete_room(%Room{} = room) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Todo{...}

  """
  def change_room(%Room{} = room, _attrs \\ %{}) do
    raise "TODO"
  end

  def list_messages do
    Repo.all(Message)
  end

  def for_room(query \\ Message, room_id) do
    query
    |> where([m], m.room_id == ^room_id)
    |> order_by([m], {:desc, m.inserted_at})
    |> limit(10)
    |> subquery()
    |> order_by([m], {:asc, m.inserted_at})
  end

  def last_ten_messages_for(room_id) do
    for_room(room_id)
      |> Repo.all()
      |> Repo.preload(:user)
  end

  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
    |> publish_message_created()
  end

  def publish_message_created({:ok, message} = result) do
    PlaygroundWeb.Endpoint.broadcast("room:#{message.room_id}", "new_message", %{message: message})
    result
  end

  def publish_message_created(result), do: result
end
