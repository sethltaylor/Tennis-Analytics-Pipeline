{#
    This macro returns the description of the loser entry type
#}

{% macro get_loser_entry_description(loser_entry) -%}

    case {{ loser_entry }}
        when 'WC' then 'Wild Card'
        when 'Q' then 'Qualifier'
        when 'LL' then 'Lucky Loser'
        when 'PR' then 'Protected Ranking'
        when 'ITF' then 'ITF Entry'
        when 'ALT' then 'Alternate'
        when 'Alt' then 'Alternate'
    end

{%- endmacro %}