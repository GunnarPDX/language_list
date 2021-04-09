defmodule LanguageList do
  @moduledoc """
  Documentation for `LanguageList`.
  """

  @doc """
  All data.

  ## Examples

      iex> LanguageList.all_data()
      [
        %{
          "common" => false,
          "iso_639_1" => "az",
          "iso_639_3" => "aze",
          "name" => "Azerbaijani"
        },
        %{
          "common" => false,
          "iso_639_1" => "ba",
          "iso_639_3" => "bak",
          "name" => "Bashkir"
        },
        ...
      ]

  """

  def all_data do
    with {:ok, file} <- File.read('lib/languages.json'),
         {:ok, languages} <- Poison.decode(file, keys: :atoms)
      do
        {:ok, languages}
      else
        err -> {:error, "Could not read internal languages.json file!"}
    end
  end

  def all_common_data do
    case all_data do
      {:ok, results} -> Enum.filter(results, fn l -> l.common end)
      err -> err
    end
  end

  def languages do
    case all_data do
      {:ok, results} ->
        Enum.map(results, fn l -> l.name end)
      err -> err
    end
  end

  def common_languages do
    case all_data do
      {:ok, results} ->
        results
        |> Enum.filter(fn l -> l.common end)
        |> Enum.map(fn l -> l.name end)

      err ->
        err
    end
  end

  def find(query, :name), do: search(query, :name)
  def find(query, :iso_639_1), do: search(query, :iso_639_1)
  def find(query, :iso_639_1), do: search(query, :iso_639_3)
  def find(_, _), do: {:error, "Invalid key!"}

  defp search(query, key) do
    case all_data do
      {:ok, results} ->
        case Enum.find(results, fn l -> l[key] == query end) do
          nil -> {:error, "No matches found"}
          result -> {:ok, result}
        end
      err -> err
    end
  end

end
