defmodule Shindig.EventCreator do
  @moduledoc """
  Interface for creating events based on a name, count, and optional timestamp.
  """

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
end
