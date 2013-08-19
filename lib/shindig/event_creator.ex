defmodule Shindig.EventCreator do
  import String, only: [ strip: 1, split: 2 ]
  @moduledoc """
  Interface for creating events based on a name, count, and optional timestamp.
  """

  @doc """
  Create a new event from a graphite-like string.

  ## Example
 
      iex> new_event_from_plaintext("foo 99 10000200")
      {:ok, Shindig.Event[name: "foo", count: 99, timestamp: { 10, 200, 0 }] }

      iex> new_event_from_plaintext("blah")
      {:error, :missing, "No count or timestamp"}

      iex> new_event_from_plaintext("blah 99")
      {:error, :missing, "No timestamp"}

      iex> new_event_from_plaintext("blah blah 10000200")
      {:error, :format, "Bad format"}

      iex> new_event_from_plaintext("blah 99 blah")
      {:error, :format, "Bad format"}
  """
  def new_event_from_plaintext(string) do
    case string |> strip |> split(%r/\s+/) |> convert_types do
      [event_name,count,timestamp] ->
        {:ok, new_event(event_name,
                        count,
                        {div(timestamp,1_000_000),rem(timestamp,1_000_000),0})}
      x -> x
    end
  end

  @doc """
  Create a new event given the name and count, using now as the date and time
  """
  def new_event(event_name,count), do: new_event(event_name,count,:erlang.now())

  @doc """
  Create a new event with the given name, count, and date in the form as returned by :erlang.now()

  ## Example
 
      iex> new_event("foo",99,{10,200,300})
      Shindig.Event[name: "foo", count: 99, timestamp: { 10, 200, 300 }]
  """
  def new_event(event_name,count,date = { _mega,_sec,_micro}) do
    Shindig.Event.new name: event_name, count: count, timestamp: date
  end

  defp convert_types(list) do
    try do
      case list do
        [event_name,count,timestamp] -> 
          [event_name,binary_to_integer(count),binary_to_integer(timestamp)]
        [event_name,count] -> { :error, :missing, "No timestamp" }
        [event_name]       -> { :error, :missing, "No count or timestamp" }
        _ -> list
      end
    rescue
      ex -> {:error,:format,"Bad format"}
    end
  end

end
