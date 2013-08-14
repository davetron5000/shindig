defmodule Shindig.EventCreator do
  @doc "Create a new event given the name and count, using now as the date and time"
  def new_event(event_name,count), do: new_event(event_name,count,:erlang.now())

  @doc "Create a new event with the given name, count, and date in the form as returned by :erlang.now()"
  def new_event(event_name,count,date = { mega,sec,micro}) do
    Event.new name: event_name, count: count, timestamp: date
  end
end
