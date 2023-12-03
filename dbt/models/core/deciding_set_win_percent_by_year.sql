WITH players_25_matches as(
  SELECT player_name
  FROM {{ ref('player_matches')}}
  GROUP BY player_name
  HAVING COUNT(*) > 25
),

deciding_set_matches as(
  (SELECT tourney_date, tour, player_name, score, is_winner,
CASE WHEN length(RTRIM(LTRIM(score)))- length (REPLACE(score,' ','')) = 2 AND best_of = 3 THEN 1
WHEN length(RTRIM(LTRIM(score)))-length(REPLACE(score,' ','')) = 4 THEN 1 
ELSE 0 END as is_deciding_set
FROM {{ ref('player_matches')}}
WHERE best_of <> 1 AND NOT (score LIKE '%RET'))
)

SELECT date_trunc(tourney_date, year) as year, tour, player_name, SUM(is_winner)/COUNT(is_winner) as deciding_set_win_pct
FROM deciding_set_matches
WHERE is_deciding_set = 1 AND deciding_set_matches.player_name IN (SELECT player_name FROM players_25_matches)
GROUP BY 1,2,3
HAVING COUNT(*) > 1