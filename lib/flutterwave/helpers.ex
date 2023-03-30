defmodule Flutterwave.Helpers do
  @spec flutterwave() :: Flutterwave.Api.Behaviour
  def flutterwave(), do: Application.get_env(:flutterwave, :flutterwave_api, Flutterwave.Api)

  @spec http_client() :: String.t() | nil
  def http_client(), do: Application.get_env(:flutterwave, :http_client, Tesla)

  @spec base_url() :: String.t() | nil
  def base_url(), do: Application.get_env(:flutterwave, :base_url, "https://api.flutterwave.com")
end
