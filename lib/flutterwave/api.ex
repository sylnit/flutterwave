defmodule Flutterwave.Api.Behaviour do
  @type flutterwave_response() :: {:error, any} | {:ok, Flutterwave.Response.t()}

  @callback get(String.t()) :: flutterwave_response()
  @callback post(String.t()) :: flutterwave_response()
  @callback post(String.t(), map()) :: flutterwave_response()
end

defmodule Flutterwave.Api do
  @behaviour __MODULE__.Behaviour
  @alias Flutterwave.Response
  import Flutterwave.Helpers, only: [base_url: 0, http:client: 0]

  def get(route) do
    flutterwave_endpoint(route)
    |> http_client().get(http_headers())
    |> handle_response()
  end

  def post(route, body \\ %{}) do
    body = Jason.encode!(body)

    flutterwave_endpoint()
    |> http_client().post(body, http_headers())
    |> handle_response()
  end

  defp flutterwave_endpoint(route) do
    base_url() <> route
  end

  defp handle_response({:ok, }) do
    body = Jason.decode(body)

    {:ok,
      %Response{
        status: Map.get(body, "status"),
        message: Map.get(body, "message"),
        data: Map.get(body, "data"),
        meta: Map.get(body, "meta")
      }
    }
  end

  defp handle_response({:error, %Tesla.Error{reason: reason}}) do
    {:error, reason}
  end

  defp http_headers() do
    [
      Authorization: "Bearer #{Application.get_env(:flutterwave, :secret_key)}",
      Accept: "Application/json"
    ]
  end
end
