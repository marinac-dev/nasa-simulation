# Nasa

## NASA is calling!

This program is used by NASA to calculate their mission fuel expense. As such it is thoroughly tested and documented!

## How to use??

Lets start by running `iex -S mix`

```elixir
# First is mission payload weight (weight is in kg)
# Let's say our payload is 28801 kg
iex> payload_weight = 28801
# After that we will define our trip
# Let's say you want to go to the Moon and back
# Our trip would look like this:

# -> LAUNCH from Earth
# -> LAND on Moon
# *do your space stuff|take few pics|jump around|play golf*
# -> LAUNCH from Moon
# -> LAND on Earth

# In order to LAUNCH and LAND we need to know
# gravitational acceleration of the planet or g
# Earth's g is = 9,807 m/s²
# Moon's g is = 1,62 m/s²
iex> earth_g = 9.807
iex> moon_g = 1.62
# Now lets define our trip by creating a list of launch-land cycles
# To do so we create a list with launch/land and planets g
# So if we want to launch from Earth we write [:launch, earth_g]
iex> trip = [{:launch, earth_g}, {:land, moon_g}, {:launch, moon_g}, {:land, earth_g}]
# And now we calculate the fuel required
iex> Nasa.calculate(payload_weight, trip)
"51898 kg"
# Now lets try a couple more
# Trip to the Mars and back
iex> payload_weight2 = 14606
iex> trip2 = [{:launch, 9.807}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}]
iex> Nasa.calculate(payload_weight2, trip2)
"33388 kg"
# Passenger mission
# Earth -> Moon -> Mars -> Earth
iex> payload_weight3 = 75432
iex> trip3 = [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}]
iex> Nasa.calculate(payload_weight3, trip3)
"212161 kg"
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `nasa` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:nasa, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/nasa](https://hexdocs.pm/nasa).
