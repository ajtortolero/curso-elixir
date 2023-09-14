defmodule AppArtistPainting.Pinturas do
  @moduledoc """
  The Pinturas context.
  """

  import Ecto.Query, warn: false
  alias AppArtistPainting.Repo

  alias AppArtistPainting.Pinturas.Pintura

  @doc """
  Returns the list of pinturas.

  ## Examples

      iex> list_pinturas()
      [%Pintura{}, ...]

  """
  def list_pinturas do
    Repo.all(Pintura) |> Repo.preload(:artista)
  end

  @doc """
  Gets a single pintura.

  Raises `Ecto.NoResultsError` if the Pintura does not exist.

  ## Examples

      iex> get_pintura!(123)
      %Pintura{}

      iex> get_pintura!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pintura!(id), do: Repo.get!(Pintura, id) |> Repo.preload(:artista)

  @doc """
  Creates a pintura.

  ## Examples

      iex> create_pintura(%{field: value})
      {:ok, %Pintura{}}

      iex> create_pintura(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pintura(attrs \\ %{}) do
    %Pintura{}
    |> Repo.preload(:artista)
    |> Pintura.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pintura.

  ## Examples

      iex> update_pintura(pintura, %{field: new_value})
      {:ok, %Pintura{}}

      iex> update_pintura(pintura, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pintura(%Pintura{} = pintura, attrs) do
    pintura
    |> Pintura.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pintura.

  ## Examples

      iex> delete_pintura(pintura)
      {:ok, %Pintura{}}

      iex> delete_pintura(pintura)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pintura(%Pintura{} = pintura) do
    Repo.delete(pintura)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pintura changes.

  ## Examples

      iex> change_pintura(pintura)
      %Ecto.Changeset{data: %Pintura{}}

  """
  def change_pintura(%Pintura{} = pintura, attrs \\ %{}) do
    Pintura.changeset(pintura, attrs)
  end
end
