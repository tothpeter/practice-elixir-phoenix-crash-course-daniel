defmodule ShopWeb.Plugs.SetConsole do
  import Plug.Conn

  @valid_consoles ["pc", "ps4", "xbox", "switch"]

  def init(opts), do: opts

  def call(%Plug.Conn{:params => %{"console" => console}} = conn, _opts) when console in @valid_consoles do
    conn
    |> assign(:console, console)
    |> put_resp_cookie("console", console, max_age: :timer.hours(24) * 10)
  end

  def call(%Plug.Conn{:cookies => %{"console" => console}} = conn, _opts) when console in @valid_consoles do
    conn
    |> assign(:console, console)
  end

  def call(conn, %{:default => default}) do
    conn
    |> assign(:console, default)
    |> put_resp_cookie("console", default, max_age: :timer.hours(24) * 10)
  end
end
