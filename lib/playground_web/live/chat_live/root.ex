defmodule PlaygroundWeb.ChatLive.Root do
  use PlaygroundWeb, :live_view

  use LiveSvelte.Components
  alias Playground.Chat

  def mount(_params, _session, socket) do
    socket = socket
      |> assign(:rooms, Chat.list_rooms())
      |> assign_active_room()
      |> assign(:scrolled_to_top, false)

    {:ok, socket}
  end

  def handle_params(%{ "id" => id }, _url, %{assigns: %{live_action: :show}} = socket) do
    if connected?(socket) do
      PlaygroundWeb.Endpoint.subscribe("room:#{id}")
    end


    socket = socket
      |> assign_active_room(id)
      |> assign_active_room_messages()

    {:noreply, socket}
  end

  def handle_params(_params, _uri, socket), do: {:noreply, socket}

  def assign_active_room(socket, id) do
    assign(socket, :room, Chat.get_room!(id))
  end

  def assign_active_room(socket) do
    assign(socket, :room, nil)
  end

  def assign_active_room_messages(socket) do
    messages = Chat.last_ten_messages_for(socket.assigns.room.id)

    socket
    |> stream(:messages, messages)
    |> assign(:oldest_message_id, List.first(messages, %{ id: nil }).id)
  end

  def render(assigns) do
    ~H"""
      <div class="w-full flex h-svh max-h-svh">
        <div class="h-full flex-[0.3]">
          <.RoomSidebar rooms={@rooms} />
        </div>
        <div class="h-full flex-1">
        <div
      id="messages"
      phx-update="stream"
      class="overflow-scroll"
      style="height: calc(88vh - 10rem)"
      data-scrolled-to-top={@scrolled_to_top}
    >
        <div
        :for={{dom_id, message} <- @streams.messages}
        id={dom_id}
        class="mt-2 hover:bg-gray-100 messages"
      >
        <%= message.content %>
      </div>
      </div>
          <.MessageForm />
        </div>
      </div>
    """
  end
end
