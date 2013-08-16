defmodule Shinding.Test.CLI do
  use ExUnit.Case, async: true
  import Shindig.CLI, only: [ parse_args: 1]

  test ":help returned by option parsing with -h and --help options" do 
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "event name and count returned if both given" do
    assert parse_args(["something", "10"]) == { "something", 10 }
  end

  test "event name and count of 1 returned if only event name given" do
    assert parse_args(["something"]) == { "something", 1 }
  end

  
end
