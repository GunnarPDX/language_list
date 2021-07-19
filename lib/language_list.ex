defmodule LanguageList do
  @moduledoc """
  An Elixir implementation of the language_list ruby gem.
  """

  @doc """
  Returns all language data.

  ## Examples

      iex> LanguageList.all_data
      {
        :ok,
        [
          %{common: false, iso_639_1: "az", iso_639_3: "aze", name: "Azerbaijani"},
          %{common: false, iso_639_1: "ba", iso_639_3: "bak", name: "Bashkir"},
          ...
        ]
      }
  """
  def all_data do
    file_path = Application.app_dir(:language_list, "priv/languages.json")

    with {:ok, file} <- File.read(file_path),
         {:ok, languages} <- Poison.decode(file, keys: :atoms)
      do
        languages
      else
        _ -> raise "Could not read internal languages.json file!"
    end
  end

  @doc false
  def all_data!, do: all_data()

  @doc """
  Returns all common data.

  ## Examples

      iex> LanguageList.all_common_data
      {
        :ok,
        [
          %{common: true, iso_639_1: "af", iso_639_3: "afr", name: "Afrikaans"},
          %{common: true, iso_639_1: "ar", iso_639_3: "ara", name: "Arabic"},
          ...
        ]
      }
  """
  def all_common_data do
    data = all_data()

    Enum.filter(data, fn l -> l.common end)
  end

  @doc false
  def all_common_data!, do: all_common_data()

  @doc"""
  Returns list of all language names.

  ## Examples

      iex> LanguageList.languages
      {:ok, ["Afar", "Abkhazian", "Afrikaans", "Akan", "Amharic", "Arabic", ...]}
  """
  def languages do
    data = all_data()

    Enum.map(data, fn l -> l.name end)
  end

  @doc false
  def languages!, do: languages()

  @doc """
  Returns list of all common languages.

  ## Examples

      iex> LanguageList.common_languages
      {:ok, ["Afrikaans", "Arabic", "Bengali", "Tibetan", "Bulgarian", ...]}
  """
  def common_languages do
    data = all_data()

    data
    |> Enum.filter(fn l -> l.common end)
    |> Enum.map(fn l -> l.name end)
  end

  @doc false
  def common_languages!, do: common_languages()

  @doc """
  Allows for query of language data by attribute.

  Permitted keys: `:name` , `:iso_639_3` , `:iso_639_1`

  ## Examples

      iex> LanguageList.find("Icelandic", :name)
      {:ok, %{common: true, iso_639_1: "is", iso_639_3: "isl", name: "Icelandic"}}

      iex> LanguageList.find("pt", :iso_639_1)
      {:ok, %{common: true, iso_639_1: "pt", iso_639_3: "por", name: "Portuguese"}}

      iex> LanguageList.find("por", :iso_639_3)
      {:ok, %{common: true, iso_639_1: "pt", iso_639_3: "por", name: "Portuguese"}}

      iex> LanguageList.find("non-existent-language", :name)
      {:error, "No matches found"}
  """
  def find(query, :name), do: search(query, :name)
  def find(query, :iso_639_1), do: search(query, :iso_639_1)
  def find(query, :iso_639_3), do: search(query, :iso_639_3)
  def find(_, _), do: {:error, "Invalid key!"}

  def find!(query, :name), do: search!(query, :name)
  def find!(query, :iso_639_1), do: search!(query, :iso_639_1)
  def find!(query, :iso_639_3), do: search!(query, :iso_639_3)
  def find!(_, _), do: nil

  defp search!(query, key) do
    data = all_data()

    Enum.find(data, fn l -> l[key] == query end)
  end

  defp search(query, key) do
    case search!(query, key) do
      nil ->
        {:error, "No matches found"}

      result ->
        {:ok, result}
    end
  end

end
