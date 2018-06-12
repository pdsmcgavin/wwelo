import gql from "graphql-tag";

export const GET_WRESTLERS_ELOS = gql`
  query getWrestlersElos {
    wrestlerStats(min_matches: 50) {
      wrestlerStat {
        name
        currentElo {
          elo
          date
        }
        maxElo {
          elo
          date
        }
        minElo {
          elo
          date
        }
      }
    }
  }
`;

export const GET_WRESTLERS_ELOS_BY_HEIGHT = gql`
  query getWrestlersElosByHeight {
    wrestlerStats(min_matches: 50) {
      wrestlerStat {
        height
        currentElo {
          elo
        }
        maxElo {
          elo
        }
        minElo {
          elo
        }
      }
    }
  }
`;