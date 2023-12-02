defmodule Day02.Part1 do
  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_game/1)
    |> Enum.filter(&possible_game?(&1, %{red: 12, green: 13, blue: 14}))
    |> Enum.map(fn {id, _} -> id end)
    |> Enum.sum()
  end

  defp parse_game(game) do
    [id_string | rounds] = String.split(game, ": ")
    id =
      id_string
      |> String.trim_leading("Game ")
      |> String.to_integer()

    cubes =
      rounds
      |> List.first()
      |> String.split("; ")
      |> Enum.map(&parse_round/1)

    {id, cubes}
  end

  defp parse_round(round) do
    round
    |> String.split(", ")
    |> Enum.map(fn cube_count ->
      [count, color] = String.split(cube_count, " ")
      {String.to_atom(color), String.to_integer(count)}
    end)
    |> Enum.reduce(%{red: 0, green: 0, blue: 0}, fn {color, count}, acc ->
      Map.update!(acc, color, &(&1 + count))
    end)
    end

    defp possible_game?({_, rounds}, max_cubes) do
      Enum.all?(rounds, fn round ->
        Enum.all?(round, fn {color, count} ->
          count <= Map.get(max_cubes, color)
        end)
      end)
    end
  end

  defmodule Mix.Tasks.Day02 do
    use Mix.Task

    def run(_) do
      {:ok, input} = File.read("inputs/day2.txt")
      IO.puts("Part 1: #{Day02.Part1.solve(input)}")
      #IO.puts("Part 2: #{Day02.Part2.solve(input)}")
    end
  end
