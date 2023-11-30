{{ config(materialized='view')}}

with atp as
(
    select *,
    row_number() over(partition by tourney_id, match_num) as rn
    from {{ source('staging', 'atp_tour')}}
    where tourney_id is not null
)

select
    --tourney information/identifiers
    {{ dbt_utils.surrogate_key(['tourney_id', 'match_num'])}} as match_id,
    tourney_name,
    tourney_date,
    surface,
    draw_size,
    tourney_level,
    {{ get_tourney_level_description('tourney_level') }} as tourney_level_description,
    match_num,

    --winner information
    winner_id,
    winner_seed,
    winner_entry,
    {{ get_winner_entry_description('winner_entry') }} as winner_entry_description,
    winner_name,
    winner_hand,
    winner_ht,
    winner_ioc,
    winner_age,
    winner_rank,
    winner_rank_points,

    --loser information
    loser_id,
    loser_seed,
    loser_entry,
    {{ get_loser_entry_description('loser_entry') }} as loser_entry_description,
    loser_name,
    loser_hand,
    loser_ht,
    loser_ioc,
    loser_age,
    loser_rank,
    loser_rank_points,

    --match information
    score,
    best_of,
    round,
    minutes,

    --winner stats
    w_ace,
    w_df,
    w_svpt,
    w_1stIn as w_first_in,
    w_1stWon as w_first_won,
    w_2ndWon as w_second_won,
    w_SvGms as w_service_games,
    w_bpSaved as w_bp_saved,
    w_bpFaced as w_bp_faced,

    --loser stats
    l_ace,
    l_df,
    l_svpt,
    l_1stIn as l_first_in,
    l_1stWon as l_first_won,
    l_2ndWon as l_second_won,
    l_SvGms as l_service_games,
    l_bpSaved as l_bp_saved,
    l_bpFaced as l_bp_faced

from atp
where rn = 1

-- dbt build --m <model.sql> --vars 'is_test_run: false'
{% if var('is_test_run', default = true) %}

    limit 100

{% endif %}
