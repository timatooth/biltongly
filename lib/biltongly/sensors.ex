defmodule Biltongly.Sensors do
  @moduledoc """
  The Sensors context.
  """

  import Ecto.Query, warn: false
  alias Biltongly.Repo

  alias Biltongly.Sensors.SoilReading

  @doc """
  Returns the list of soil_readings.

  ## Examples

      iex> list_soil_readings()
      [%SoilReading{}, ...]

  """
  def list_soil_readings do
    Repo.all(SoilReading)
  end

  @doc """
  Gets a single soil_reading.

  Raises `Ecto.NoResultsError` if the Soil reading does not exist.

  ## Examples

      iex> get_soil_reading!(123)
      %SoilReading{}

      iex> get_soil_reading!(456)
      ** (Ecto.NoResultsError)

  """
  def get_soil_reading!(id), do: Repo.get!(SoilReading, id)

  @doc """
  Creates a soil_reading.

  ## Examples

      iex> create_soil_reading(%{field: value})
      {:ok, %SoilReading{}}

      iex> create_soil_reading(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_soil_reading(attrs \\ %{}) do
    %SoilReading{}
    |> SoilReading.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a soil_reading.

  ## Examples

      iex> update_soil_reading(soil_reading, %{field: new_value})
      {:ok, %SoilReading{}}

      iex> update_soil_reading(soil_reading, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_soil_reading(%SoilReading{} = soil_reading, attrs) do
    soil_reading
    |> SoilReading.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a soil_reading.

  ## Examples

      iex> delete_soil_reading(soil_reading)
      {:ok, %SoilReading{}}

      iex> delete_soil_reading(soil_reading)
      {:error, %Ecto.Changeset{}}

  """
  def delete_soil_reading(%SoilReading{} = soil_reading) do
    Repo.delete(soil_reading)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking soil_reading changes.

  ## Examples

      iex> change_soil_reading(soil_reading)
      %Ecto.Changeset{data: %SoilReading{}}

  """
  def change_soil_reading(%SoilReading{} = soil_reading, attrs \\ %{}) do
    SoilReading.changeset(soil_reading, attrs)
  end
end
