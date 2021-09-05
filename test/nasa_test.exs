defmodule NasaTest do
  use ExUnit.Case
  doctest Nasa

  def fixture_apolo do
    mission_payload = 28_801
    earth_g = 9.807
    moon_g = 1.62
    trip = [{:launch, earth_g}, {:land, moon_g}, {:launch, moon_g}, {:land, earth_g}]

    {mission_payload, trip}
  end

  def fixture_mars do
    mission_payload = 14_606
    earth_g = 9.807
    mars_g = 3.711
    trip = [{:launch, earth_g}, {:land, mars_g}, {:launch, mars_g}, {:land, earth_g}]

    {mission_payload, trip}
  end

  def fixture_passenger do
    mission_payload = 75_432
    earth_g = 9.807
    mars_g = 3.711
    moon_g = 1.62

    trip = [
      {:launch, earth_g},
      {:land, moon_g},
      {:launch, moon_g},
      {:land, mars_g},
      {:launch, mars_g},
      {:land, earth_g}
    ]

    {mission_payload, trip}
  end

  test "calculate/2 returns fuel for Apollo 11" do
    {m, t} = fixture_apolo()
    assert "51898 kg" = Nasa.calculate(m, t)
  end

  test "calculate/2 returns fuel for Mars mission" do
    {m, t} = fixture_mars()
    assert "33388 kg" = Nasa.calculate(m, t)
  end

  test "calculate/2 returns fuel for Passenger mission" do
    {m, t} = fixture_passenger()
    assert "212161 kg" = Nasa.calculate(m, t)
  end
end
