{#
    This macro returns the description of the winner entry type
#}

{% macro get_winner_entry_description(winner_entry) -%}

    case {{ winner_entry }}
        when 'WC' then 'Wild Card'
        when 'Q' then 'Qualifier'
        when 'LL' then 'Lucky Loser'
        when 'PR' then 'Protected Ranking'
        when 'ITF' then 'ITF Entry'
        when 'ALT' then 'Alternate'
        when 'Alt' then 'Alternate'
    end

{%- endmacro %}