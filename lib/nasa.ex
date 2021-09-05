defmodule Nasa do
  @moduledoc """
  Documentation for `Nasa's` special space software which will help to calculate fuel required for the flight
  """

  defguard is_even(x) when x |> rem(2) == 0
  defguard is_even_list(list) when list |> length() |> is_even()

  @doc """
  Calculate fuel required for trip for given payload weight
  """
  @spec calculate(integer(), [tuple(), ...]) :: integer()
  def calculate(weight, trip) when is_list(trip) and is_even_list(trip) do
    trip
    |> Enum.reverse()
    |> Enum.reduce(0, fn {flight_directive, planet_g}, fuel_reserve ->
      # Calculate fuel reserve into the total weight
      new_weight = weight + fuel_reserve
      fuel = calculate_fuel(new_weight, planet_g, flight_directive)
      # New fuel reserve is old one plus the new fuel
      fuel + fuel_reserve
    end)
    |> prettify()
  end

  @spec prettify(integer()) :: String.t()
  defp prettify(weight), do: "#{weight} kg"

  @doc """
  Calculates fuel required to carry some payload into the space\n
  Takes into calculation weight of fuel
  """
  @spec calculate_fuel(integer(), integer(), atom()) :: integer()
  def calculate_fuel(m, g, :launch),
    do: calc_launch(m, g) |> calculate_fuel(g, :launch, 0)

  def calculate_fuel(m, g, :land),
    do: calc_land(m, g) |> calculate_fuel(g, :land, 0)

  @spec calculate_fuel(integer(), integer(), atom(), integer()) :: integer()
  defp calculate_fuel(m, g, :launch, sum) when m > 0,
    do: m |> calc_launch(g) |> calculate_fuel(g, :launch, sum + m)

  defp calculate_fuel(_, _, :launch, sum), do: sum

  defp calculate_fuel(m, g, :land, sum) when m > 0,
    do: m |> calc_land(g) |> calculate_fuel(g, :land, sum + m)

  defp calculate_fuel(_, _, :land, sum), do: sum

  @spec calc_launch(integer(), integer()) :: integer()
  defp calc_launch(m, g), do: (m * g * 0.042 - 33) |> floor()

  @spec calc_land(integer(), integer()) :: integer()
  defp calc_land(m, g), do: (m * g * 0.033 - 42) |> floor()
end
