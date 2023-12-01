{{ config(materialized='table') }}

with matches as (
    select *
    from {{ ref('fact_matches')}}
)

select 
---Winner tournament info
    match_id,
    tourney_name,
    tourney_date,
    surface,
    draw_size,
    tourney_level,
    tourney_level_description,
    tour,
    match_num,
    score,
    best_of,
    round,
    minutes,
    winner_id as player_id,
    winner_name as player_name,
    winner_seed as player_seed,
    winner_entry as player_entry,
    winner_entry_description as player_entry_description,
    winner_hand as player_hand,
    winner_ht as player_ht,
    winner_ioc as player_ioc,
    winner_country as player_country,
    winner_age as player_age,
    winner_rank as player_rank,
    winner_rank_points as player_rank_points,
    w_ace as ace,
    w_df as df,
    w_svpt as serve_points,
    w_first_in as first_in,
    w_first_won as first_won,
    w_second_won as second_won,
    w_service_games as service_games,
    w_bp_saved as bp_saved,
    w_bp_faced as bp_faced,
    1 as is_winner
from matches
union all
select
--- loser info
    match_id,
    tourney_name,
    tourney_date,
    surface,
    draw_size,
    tourney_level,
    tourney_level_description,
    tour,
    match_num,
    score,
    best_of,
    round,
    minutes,
    loser_id as player_id,
    loser_name as player_name,
    loser_seed as player_seed,
    loser_entry as player_entry,
    loser_entry_description as player_entry_description,
    loser_hand as player_hand,
    loser_ht as player_ht,
    loser_ioc as player_ioc,
    loser_country as player_country,
    loser_age as player_age,
    loser_rank as player_rank,
    loser_rank_points as player_rank_points,
    l_ace as ace,
    l_df as df,
    l_svpt as serve_points,
    l_first_in as first_in,
    l_first_won as first_won,
    l_second_won as second_won,
    l_service_games as service_games,
    l_bp_saved as bp_saved,
    l_bp_faced as bp_faced,
    0 as is_winner
from matches

