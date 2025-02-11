defmodule Playground.ChatFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Playground.Chat` context.
  """

  @doc """
  Generate a room.
  """
  def room_fixture(attrs \\ %{}) do
    {:ok, room} =
      attrs
      |> Enum.into(%{

      })
      |> Playground.Chat.create_room()

    room
  end
end
