defmodule Shinding.Test.Net.PacketProcessor do
  use ExUnit.Case, async: true
  import Shindig.Net.PacketProcessor
  doctest Shindig.Net.PacketProcessor

  test "can turn a chunky stream into events" do
    chunks = [ "foo 99",
               "0 10000200\n",
               "blah 10 100",
               "00210\n" ]

    event_creator = &Shindig.EventCreator.new_event_from_plaintext/1
    {all_events, unparsed} = Enum.reduce(
      chunks,
      {[],""},
      fn(chunk,{events,unparsed}) ->
        {:ok, parsed_events, rest } = process_packet(unparsed <> chunk,event_creator)
        { events ++ parsed_events,rest }
      end)

    assert all_events == [
      {:ok, Shindig.Event[name: "foo",  count: 990, timestamp: { 10, 200, 0 }]},
      {:ok, Shindig.Event[name: "blah", count: 10,  timestamp: { 10, 210, 0 }]}
    ]
    assert unparsed == ""
  end

end
