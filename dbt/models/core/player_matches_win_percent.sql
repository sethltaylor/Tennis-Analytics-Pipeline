{{ config(materialized='table') }}

with matches as (
    select *
    from {{ ref('player_matches')}}
)

select {{ dbt_utils.surrogate_key(['match_id', 'player_id'])}} as player_match_id,
*,
COUNT(*) OVER (PARTITION BY player_name ORDER BY tourney_date, match_num) AS total_matches,
SUM(is_winner) OVER (PARTITION BY player_name ORDER BY tourney_date, match_num) AS total_wins,
SUM(is_winner) OVER (PARTITION BY player_name ORDER BY tourney_date, match_num) * 100.0 / COUNT(*) OVER (PARTITION BY player_name ORDER BY tourney_date, match_num) AS win_percentage
from matches
