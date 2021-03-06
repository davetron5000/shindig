defmodule Shindig.Mixfile do
  use Mix.Project

  def project do
    [ app: :shindig,
      version: "0.0.1",
      name: "Shindig",
      elixir: "~> 0.10.1",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
    { :ex_doc,  github: "elixir-lang/ex_doc" },
    { :exredis, github: "artemeff/exredis" }
    ]
  end
end
