defmodule WweloApi.SiteScraper.Matches do
  alias WweloApi.Repo
  alias WweloApi.Stats
  alias WweloApi.Stats.Match

  def save_matches_of_event(%{event_id: event_id, event_matches: matches}) do
    matches = matches |> filter_out_non_televised_matches

    matches |> Enum.map(fn match -> get_match_stipulation(match) end)
  end

  #   def save_match_to_database(match_info) do
  #     match_query =
  #       from(
  #         m in Match,
  #         where:
  #           m.event_id == ^match_info.event_id and
  #             m.card_position == ^match_info.card_position,
  #         select: m
  #       )

  #     match_result = Repo.one(match_query)

  #     case match_result do
  #       nil -> Stats.create_match(match_info) |> elem(1)
  #       _ -> match_result
  #     end
  #     |> Map.get(:id)
  #   end

  def filter_out_non_televised_matches(matches) do
    Enum.filter(matches, fn match ->
      case match do
        {_, [{"class", "Match"}], _} ->
          true

        _ ->
          IO.inspect(match)
          false
      end
    end)
  end

  def get_match_stipulation(match) do
    match_type = match |> Floki.find(".MatchType")

    case match_type do
      [{_, [{"class", "MatchType"}], [{_, _, [title]}, stipulation]}] ->
        title <> stipulation

      [{_, [{"class", "MatchType"}], [stipulation]}] ->
        stipulation

      _ ->
        IO.inspect(match_type)
        "No stipulation found"
    end
  end
end