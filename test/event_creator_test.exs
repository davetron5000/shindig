defmodule Shinding.Test.EventCreator do
  use ExUnit.Case, async: true
  import Shindig.EventCreator
  doctest Shindig.EventCreator

  test "events created get a date assigned" do
    event = new_event("foo",20)

    assert event.name == "foo"
    assert event.count == 20
    assert event.timestamp != nil
    {mega,seconds,micro} = event.timestamp
    assert mega != nil
    assert seconds != nil
    assert micro != nil
  end

  test "can create an event with an explicit date" do
    event = new_event("foo",20,{ 100, 3000, 4000})
    assert event.name  == "foo"
    assert event.count == 20
    assert event.timestamp  == { 100, 3000, 4000 }
  end
  
end
