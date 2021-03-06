# LanguageList

An Elixir implementation of the language_list ruby gem.

This package provides simple access to iso language names and codes.

## Installation

This package can be installed
by adding `language_list` to your list of dependencies in `mix.exs`:

Hex: [https://hex.pm/packages/language_list](https://hex.pm/packages/language_list)

```elixir
def deps do
  [
    {:language_list, "~> 2.0.0"}
  ]
end
```

Documentation can be found at [https://hexdocs.pm/language_list](https://hexdocs.pm/language_list).

## Usage:

Standard requests will return a list of maps or strings.

Search requests return the data in a 2-tuple with the standard `:ok` or `:error` status.

Calls made to functions with `!` return only the result or nil.

#### `all_data`

Returns all language data.

```elixir
iex> LanguageList.all_data

[
  %{common: false, iso_639_1: "az", iso_639_3: "aze", name: "Azerbaijani"},
  %{common: false, iso_639_1: "ba", iso_639_3: "bak", name: "Bashkir"},
  ...
]
```

#### `all_common_data`

Returns all common data.

```elixir
iex> LanguageList.all_common_data

[
  %{common: true, iso_639_1: "af", iso_639_3: "afr", name: "Afrikaans"},
  %{common: true, iso_639_1: "ar", iso_639_3: "ara", name: "Arabic"},
  ...
]
```

#### `languages`

Returns list of all language names.

```elixir
iex> LanguageList.languages

["Afar", "Abkhazian", "Afrikaans", "Akan", "Amharic", "Arabic", ...]

```

#### `common_languages`

Returns list of all common languages.

```elixir
iex> LanguageList.common_languages

["Afrikaans", "Arabic", "Bengali", "Tibetan", "Bulgarian", ...]
```

#### `find(query, key)`

Allows for query of language data by attribute.

Permitted keys: `:name` , `:iso_639_3` , `:iso_639_1`

`LanguageList.find!(query, key)` can be called to return w/out tuple.

```elixir
iex> LanguageList.find("Icelandic", :name)

{:ok, %{common: true, iso_639_1: "is", iso_639_3: "isl", name: "Icelandic"}}

iex> LanguageList.find!("Icelandic", :name)

%{common: true, iso_639_1: "is", iso_639_3: "isl", name: "Icelandic"}

iex> LanguageList.find("pt", :iso_639_1) 

{:ok, %{common: true, iso_639_1: "pt", iso_639_3: "por", name: "Portuguese"}}

iex> LanguageList.find("por", :iso_639_3)

{:ok, %{common: true, iso_639_1: "pt", iso_639_3: "por", name: "Portuguese"}}

iex> LanguageList.find("non-existent-language", :name)

{:error, "No matches found"}

iex> LanguageList.find!("non-existent-language", :name)

nil

```

## TODO:

[] add native language names to json file.
