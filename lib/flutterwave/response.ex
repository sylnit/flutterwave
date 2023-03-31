defmodule Flutterwave.Response do

  @type t :: %__MODULE__{
    status: String.t(),
    message: String.t(),
    data: list,
    meta: list,
  }

  defstruct status: nil, message: "", data: [], meta: nil
end
