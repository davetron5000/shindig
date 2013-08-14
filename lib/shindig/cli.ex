defmodule Shindig.CLI do
  import Shindig.EventCreator
  def run(argv) do
    case parse_args(argv) do
      :help                 -> IO.puts "usage: shindig [-h|--help] event_name [count]"
      { event_name, count } -> IO.inspect new_event(event_name,count)
    end
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ],
                                     aliases: [ h: :help])
    case parse do
      { [ help: true ] , _ }       -> :help
      { _, [ event_name, count ] } -> { event_name, binary_to_integer(count) }
      { _, [ event_name ] }        -> { event_name, 1 }
      _                            -> :help
    end
  end

end
