defmodule One do
  def get_numbers(input) do
    input
    |> Enum.map(&Regex.scan(~r/\d/, &1) |> Enum.flat_map(fn l -> l end))
    |> Enum.map(fn nums ->
      Enum.join([hd(nums), List.last(nums)]) |> String.to_integer()
    end)
  end

end

File.read!(Path.join(__DIR__, "input"))
|> String.split("\n", trim: true)
|> One.get_numbers()
|> Enum.sum()
|> IO.inspect()
