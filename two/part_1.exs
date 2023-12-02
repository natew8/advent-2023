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
  end
end

defmodule GameChecker do
  def check(games, available_colors_map) do
    Enum.reduce(games, 0, fn {game_num, pulls_map}, acc ->
      if Enum.any?(pulls_map, fn {color, nums} ->
        available_colors = Map.get(available_colors_map, color)
        Enum.any?(nums, fn num -> num > available_colors end)
      end) do
        acc
      else
        acc + game_num
      end
    end)
  end
end

available_colors_map = %{
  "red" => 12,
  "green" => 13,
  "blue" => 14
}
File.read!(Path.join(__DIR__, "input"))
|> String.split("\n", trim: true)
|> GameParser.parse()
|> GameChecker.check(available_colors_map)
|> IO.inspect(label: "the total is")
