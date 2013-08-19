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

  test "can create an event based on the graphite plaintext protocol" do
    {:ok, event} = new_event_from_plaintext("foo 20 1376865680")
    assert event.name  == "foo"
    assert event.count == 20
    assert event.timestamp  == { 1376, 865680, 0000 }
  end

  test "can create an event based on the graphite plaintext protocol with newlines" do
    {:ok, event} = new_event_from_plaintext("foo 20 1376865680\n\n\n")
    assert event.name  == "foo"
    assert event.count == 20
    assert event.timestamp  == { 1376, 865680, 0000 }
  end

  test "can create an event based on the graphite plaintext protocol with a lot of spaces" do
    {:ok, event} = new_event_from_plaintext("foo    20     1376865680    \n\n\n")
    assert event.name  == "foo"
    assert event.count == 20
    assert event.timestamp  == { 1376, 865680, 0000 }
  end
end
