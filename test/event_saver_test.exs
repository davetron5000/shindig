defmodule Shinding.Test.EventSaver do
  use ExUnit.Case, async: true
  import Shindig.EventSaver
  import Shindig.EventCreator
  use Exredis
  doctest Shindig.EventSaver

  setup do
    client = Exredis.start('127.0.0.1',6379,1)
    client |> Exredis.query ["DEL", key() ]
    {:ok, redis: client, query: &Exredis.query(client,&1) }
  end

  teardown meta do
    meta[:redis] |> Exredis.stop
  end

  test "writes an encoded version to redis", meta do
    event = new_event("thing",10,{12,300,500})

    store event, meta[:query]

    stored = meta[:redis] |> Exredis.query(["LPOP",key()])

    assert binary_to_term(stored) == event
  end

  test "writes multiple values", meta do
    events = [ 
      new_event("thing",10,{12,300,500}),
      new_event("other_thing",10,{12,300,500}),
      new_event("thing",10,{13,300,500})
    ]

    events |> Enum.each  fn(e) -> store e, meta[:query] end

    stored = events |> Enum.map fn(_) ->
      meta[:redis] |> Exredis.query(["RPOP",key()]) |> binary_to_term
    end

    assert stored == events
  end
end
