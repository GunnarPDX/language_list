defmodule LanguageListTest do
  use ExUnit.Case
  # doctest LanguageList

  test "get all data" do
    assert {:ok, values} = LanguageList.all_data
    assert Enum.count(values) > 0
  end

  test "get all data without :ok/:error" do
    assert LanguageList.all_data! |> Enum.count() > 0
  end

  test "test get all common data" do
    assert {:ok, values} = LanguageList.all_common_data
    assert Enum.count(values) > 0
  end

  test "test get all common data without :ok/:error" do
    assert LanguageList.all_common_data! |> Enum.count() > 0
  end

  test "make sure all_common_data returns only common data" do
    {:ok, values} = LanguageList.all_common_data
    assert Enum.find(values, fn x -> x.common != true end) == nil
  end

  test "get language names" do
    assert {:ok, values} = LanguageList.languages
    assert Enum.count(values) > 0
  end

  test "get language names without :ok/:error" do
    assert LanguageList.languages! |> Enum.count() > 0
  end

  test "get common language names" do
    assert {:ok, values} = LanguageList.common_languages
    assert Enum.count(values) > 0
  end

  test "get common language names without :ok/:error" do
    assert LanguageList.common_languages! |> Enum.count() > 0
  end

  test "common languages only" do
    values = LanguageList.common_languages!
    assert Enum.find(values, fn x -> x == "Corsican" end) == nil
    assert Enum.find(values, fn x -> x == "Aragonese" end) == nil
    assert Enum.find(values, fn x -> x == "Guarani" end) == nil
    assert Enum.find(values, fn x -> x == "Fulah" end) == nil
    assert Enum.find(values, fn x -> x == "Ewe" end) == nil
  end

  test "find by language name" do
    assert LanguageList.find("Icelandic", :name) == {:ok, %{common: true, iso_639_1: "is", iso_639_3: "isl", name: "Icelandic"}}
    assert LanguageList.find("name does not exist", :name) == {:error, "No matches found"}
  end

  test "find by name without :ok/:error" do
    assert LanguageList.find!("Icelandic", :name) == %{common: true, iso_639_1: "is", iso_639_3: "isl", name: "Icelandic"}
    assert LanguageList.find!("name does not exist", :name) == nil
  end

  test "find by iso-1" do
    assert LanguageList.find("pt", :iso_639_1) == {:ok, %{common: true, iso_639_1: "pt", iso_639_3: "por", name: "Portuguese"}}
    assert LanguageList.find("iso code does not exist", :iso_639_1) ==  {:error, "No matches found"}
  end

  test "find by iso-1  without :ok/:error" do
    assert LanguageList.find!("pt", :iso_639_1) == %{common: true, iso_639_1: "pt", iso_639_3: "por", name: "Portuguese"}
    assert LanguageList.find!("iso code does not exist", :iso_639_1) == nil
  end

  test "find by iso-3" do
    assert LanguageList.find("pt", :iso_639_1) == {:ok, %{common: true, iso_639_1: "pt", iso_639_3: "por", name: "Portuguese"}}
    assert LanguageList.find("iso code does not exist", :iso_639_1) ==  {:error, "No matches found"}
  end

  test "find by iso-3  without :ok/:error" do
    assert LanguageList.find!("por", :iso_639_3) == %{common: true, iso_639_1: "pt", iso_639_3: "por", name: "Portuguese"}
    assert LanguageList.find!("iso code does not exist", :iso_639_3) == nil
  end

end
