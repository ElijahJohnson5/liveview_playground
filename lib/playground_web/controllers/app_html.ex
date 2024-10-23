defmodule PlaygroundWeb.AppHTML do
  use PlaygroundWeb, :html

  use LiveSvelte.Components

  def index(assigns) do
    ~H"""
    <!-- Svelte App -->
    <.App currentUserEmail={@current_user.email} />
    """
  end
end
