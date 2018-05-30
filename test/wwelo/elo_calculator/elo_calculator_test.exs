defmodule Wwelo.SiteScraper.EloCalculatorTest do
  use Wwelo.DataCase
  alias Wwelo.EloCalculator.EloCalculator

  describe "Assuming all participants have equal elo" do
    singles_participants = [
      [
        %{
          match_outcome: "win",
          match_team: 0,
          name: "Braun Strowman",
          previous_elo: 1200
        }
      ],
      [
        %{
          match_outcome: "loss",
          match_team: 1,
          name: "Roman Reigns",
          previous_elo: 1200
        }
      ]
    ]

    [[singles_winner], [singles_loser]] =
      EloCalculator.elo_change_for_match(singles_participants)

    @singles_winner singles_winner
    @singles_loser singles_loser

    triple_threat_participants = [
      [
        %{
          match_outcome: "win",
          match_team: 0,
          name: "Braun Strowman",
          previous_elo: 1200
        }
      ],
      [
        %{
          match_outcome: "loss",
          match_team: 1,
          name: "Roman Reigns",
          previous_elo: 1200
        }
      ],
      [
        %{
          match_outcome: "loss",
          match_team: 2,
          name: "John Cena",
          previous_elo: 1200
        }
      ]
    ]

    [[triple_threat_winner], [triple_threat_loser], _] =
      EloCalculator.elo_change_for_match(triple_threat_participants)

    @triple_threat_winner triple_threat_winner
    @triple_threat_loser triple_threat_loser

    tag_participants = [
      [
        %{
          match_outcome: "win",
          match_team: 0,
          name: "Braun Strowman",
          previous_elo: 1200
        },
        %{
          match_outcome: "win",
          match_team: 0,
          name: "Baron Corbin",
          previous_elo: 1200
        }
      ],
      [
        %{
          match_outcome: "loss",
          match_team: 1,
          name: "Roman Reigns",
          previous_elo: 1200
        },
        %{
          match_outcome: "loss",
          match_team: 1,
          name: "John Cena",
          previous_elo: 1200
        }
      ]
    ]

    [[tag_winner, _], [tag_loser, _]] =
      EloCalculator.elo_change_for_match(tag_participants)

    @tag_winner tag_winner
    @tag_loser tag_loser

    test "Triple threat winners gain more elo than singles winners" do
      assert @triple_threat_winner.elo > @singles_winner.elo
    end

    test "Triple threat losers lose less elo than singles loser" do
      assert @triple_threat_loser.elo > @singles_loser.elo
    end

    test "Tag match winners and losers' elo changes should be less than or equal to a singles match's" do
      assert @tag_winner.elo <= @singles_winner.elo
      assert @tag_loser.elo >= @singles_loser.elo
    end
  end
end
