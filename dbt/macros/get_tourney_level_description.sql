{#
    This macro returns the description of the tourney_level
#}

{% macro get_tourney_level_description(tourney_level) -%}

    case {{ tourney_level}}
        when 'G' then 'Grand Slam'
        when 'M' then 'Masters'
        when 'A' then 'Tour-Level Event'
        when 'C' then 'Challengers'
        when 'S' then 'Satellites'
        when 'F' then 'Tour Finals'
        when 'D' then 'Davis Cup'
    end

{%- endmacro %}