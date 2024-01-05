defmodule Day01.Part1 do
  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&extract_numbers/1)
    |> Enum.sum()
  end

  defp extract_numbers(line) do
    numbers =
      line
      |> String.graphemes()
      |> Enum.map(&parse_integer/1)
      |> Enum.reject(&is_nil/1)

      first = List.first(numbers)
      last = List.last(numbers)
      first * 10 + last
  end

  defp parse_integer(char) do
    try do
      String.to_integer(char)
    rescue
      ArgumentError -> nil
    end
  end
end

defmodule Day01.Part2 do
  @numbers %{
    "one" => "1", "two" => "2", "three" => "3", "four" => "4",
    "five" => "5", "six" => "6", "seven" => "7", "eight" => "8", "nine" => "9"
  }
  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Task.async_stream(fn {line, _index} ->
      left =
        line
        |> String.trim()
        |> recurse_from_left()

      right =
        line
        |> String.trim()
        |> String.reverse()
        |> recurse_from_right()

      [to_string(left), to_string(right)]
      |> Enum.join()
      |> String.to_integer()
    end)
    |> Enum.map(fn {:ok, num} -> num end)
    |> Enum.sum()
  end

  defp recurse_from_left(line) do
    case line do
      "1" <> _ -> 1
      "2" <> _ -> 2
      "3" <> _ -> 3
      "4" <> _ -> 4
      "5" <> _ -> 5
      "6" <> _ -> 6
      "7" <> _ -> 7
      "8" <> _ -> 8
      "9" <> _ -> 9
      "one" <> _ -> 1
      "two" <> _ -> 2
      "three" <> _ -> 3
      "four" <> _ -> 4
      "five" <> _ -> 5
      "six" <> _ -> 6
      "seven" <> _ -> 7
      "eight" <> _ -> 8
      "nine" <> _ -> 9
      <<_::size(8), rest::binary>> ->
        recurse_from_left(rest)
    end
  end

  defp recurse_from_right(line) do
    case line do
      "1" <> _ -> 1
      "2" <> _ -> 2
      "3" <> _ -> 3
      "4" <> _ -> 4
      "5" <> _ -> 5
      "6" <> _ -> 6
      "7" <> _ -> 7
      "8" <> _ -> 8
      "9" <> _ -> 9
      "eno" <> _ -> 1
      "owt" <> _ -> 2
      "eerht" <> _ -> 3
      "ruof" <> _ -> 4
      "evif" <> _ -> 5
      "xis" <> _ -> 6
      "neves" <> _ -> 7
      "thgie" <> _ -> 8
      "enin" <> _ -> 9
      <<_::size(8), rest::binary>> ->
        recurse_from_right(rest)
    end
  end

end

defmodule Mix.Tasks.Day01 do
  use Mix.Task

  def run(_) do
    {:ok, input} = File.read("inputs/day1.txt")
    IO.puts("Part 1: #{Day01.Part1.solve(input)}")
    IO.puts("Part 2: #{Day01.Part2.solve(input)}")
  end
end
