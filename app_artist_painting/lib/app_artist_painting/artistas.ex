defmodule AppArtistPainting.Artistas do
  @moduledoc """
  The Artistas context.
  """

  import Ecto.Query, warn: false
  alias AppArtistPainting.Repo

  alias AppArtistPainting.Artistas.Artista

  @doc """
  Returns the list of artistas.

  ## Examples

      iex> list_artistas()
      [%Artista{}, ...]

  """
  def list_artistas do
    Repo.all(Artista) |> Repo.preload(:pinturas)
  end

  @doc """
  Gets a single artista.

  Raises `Ecto.NoResultsError` if the Artista does not exist.

  ## Examples

      iex> get_artista!(123)
      %Artista{}

      iex> get_artista!(456)
      ** (Ecto.NoResultsError)

  """
  def get_artista!(id), do: Repo.get!(Artista, id) |> Repo.preload(:pinturas)

  @doc """
  Creates a artista.

  ## Examples

      iex> create_artista(%{field: value})
      {:ok, %Artista{}}

      iex> create_artista(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_artista(attrs \\ %{}) do
    %Artista{}
    |> Repo.preload(:pinturas)
    |> Artista.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a artista.

  ## Examples

      iex> update_artista(artista, %{field: new_value})
      {:ok, %Artista{}}

      iex> update_artista(artista, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_artista(%Artista{} = artista, attrs) do
    artista
    |> Artista.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a artista.

  ## Examples

      iex> delete_artista(artista)
      {:ok, %Artista{}}

      iex> delete_artista(artista)
      {:error, %Ecto.Changeset{}}

  """
  def delete_artista(%Artista{} = artista) do
    Repo.delete(artista)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking artista changes.

  ## Examples

      iex> change_artista(artista)
      %Ecto.Changeset{data: %Artista{}}

  """
  def change_artista(%Artista{} = artista, attrs \\ %{}) do
    Artista.changeset(artista, attrs)
  end
end
