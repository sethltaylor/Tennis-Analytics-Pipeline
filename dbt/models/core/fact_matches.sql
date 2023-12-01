{{ config(materialized='table') }}

with atp_matches as (
    select *, 
        'ATP' as tour
    from {{ ref('stg_atp_tour')}}
),

challengers_matches as (
    select *,
        'Challengers' as tour
    from {{ ref('stg_challengers')}}
),

matches as (
    select * from atp_matches
    union all
    select * from challengers_matches
),

dim_countries as(
    select * from {{ ref('dim_countries')}}
)

select 
    matches.match_id,
    matches.tourney_name,
    matches.tourney_date,
    matches.surface,
    matches.draw_size,
    matches.tourney_level,
    matches.tourney_level_description,
    matches.tour,
    matches.match_num,
    matches.score,
    matches.best_of,
    matches.round,
    matches.minutes,
    matches.winner_id,
    matches.winner_name,
    matches.winner_seed,
    matches.winner_entry,
    matches.winner_entry_description,
    matches.winner_hand,
    matches.winner_ht,
    matches.winner_ioc,
    winner_code.country as winner_country,
    matches.winner_age,
    matches.winner_rank,
    matches.winner_rank_points,
    matches.loser_id,
    matches.loser_seed,
    matches.loser_entry,
    matches.loser_entry_description,
    matches.loser_name,
    matches.loser_hand,
    matches.loser_ht,
    matches.loser_ioc,
    loser_code.country as loser_country,
    matches.loser_age,
    matches.loser_rank,
    matches.loser_rank_points,
    matches.w_ace,
    matches.w_df,
    matches.w_svpt,
    matches.w_first_in,
    matches.w_first_won,
    matches.w_second_won,
    matches.w_service_games,
    matches.w_bp_saved,
    matches.w_bp_faced,
    matches.l_ace,
    matches.l_df,
    matches.l_svpt,
    matches.l_first_in,
    matches.l_first_won,
    matches.l_second_won,
    matches.l_service_games,
    matches.l_bp_saved,
    matches.l_bp_faced
from matches
inner join dim_countries as winner_code
on matches.winner_ioc = winner_code.ioc
inner join dim_countries as loser_code
on matches.loser_ioc = loser_code.ioc
