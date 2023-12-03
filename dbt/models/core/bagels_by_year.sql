SELECT 
date_trunc(tourney_date, year) as year, 
player_name, 
SUM(CASE WHEN is_winner = 1 THEN ((length(score) - length(replace(score,'6-0','')))/ length('6-0')) ELSE 0 END) as bagels_as_winner,
SUM(CASE WHEN is_winner = 0 THEN ((length(score) - length(replace(score,'0-6','')))/ length('0-6')) ELSE 0 END) as bagels_as_loser
from {{ ref('player_matches')}}
GROUP BY 1, 2