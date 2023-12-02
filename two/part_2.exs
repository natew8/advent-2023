defmodule GameParser do
  def parse(input) do
    Enum.reduce(input, %{}, fn line, acc ->
      [game, pulls] = String.split(line, ": ", trim: true)
      game_num = String.split(game, " ", trim: true) |> Enum.at(1) |> String.to_integer()
      pulls_map = parse_pulls(pulls)
      Map.put(acc, game_num, pulls_map)
    end)
  end

  defp parse_pulls(pulls) do
    String.split(pulls, "; ") |> Enum.join(", ")
    |> String.split(", ", trim: true)
    |> Enum.reduce(%{}, fn pull, acc ->
      [num, color] = String.split(pull, " ")
      num = String.to_integer(num)
      Map.update(acc, color, [num], fn nums -> [num | nums] end)
    end)
    |> get_max()
    |> get_power()
  end

  defp get_max(pulls_map) do
    Enum.reduce(pulls_map, %{}, fn {color, nums}, acc ->
      max = Enum.max(nums)
      Map.put(acc, color, max)
    end)
  end

  defp get_power(pulls_map) do
    Map.values(pulls_map) |> Enum.reduce(1, &*/2)
  end
end

File.read!(Path.join(__DIR__, "input"))
|> String.split("\n", trim: true)
|> GameParser.parse()
|> Map.values() |> Enum.sum() |> IO.inspect(label: "the total is")
