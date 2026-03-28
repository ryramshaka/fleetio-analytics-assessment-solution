{% macro clean_col(column_name, type_suffix, name_override=none, prefix=none) -%}

    {# Determine the final alias -#}
    {%- if name_override -%}
        {%- set alias = name_override -%}
    {%- elif prefix -%}
        {%- set alias = prefix ~ '_' ~ column_name -%}
    {%- elif column_name.endswith('_' ~ type_suffix) or column_name.endswith(type_suffix) -%}
        {%- set alias = column_name -%}
    {%- else -%}
        {%- set alias = column_name ~ '_' ~ type_suffix -%}
    {%- endif -%}

    {# Apply the CAST logic -#}
    {%- if type_suffix == 'ts' -%}
        cast({{ column_name }} as timestamp) as {{ alias }}
    {%- elif type_suffix == 'dt' -%}
        cast({{ column_name }} as date) as {{ alias }}
    {%- elif type_suffix == 'flag' -%}
        cast({{ column_name }} as boolean) as {{ alias }}
    {%- elif type_suffix == 'amt' -%}
        cast({{ column_name }} as double) as {{ alias }}
    {%- elif type_suffix == 'id' -%}
        cast({{ column_name }} as varchar) as {{ alias }}
    {%- elif type_suffix == 'cd' -%}
        cast({{ column_name }} as varchar) as {{ alias }}
    {%- elif type_suffix == 'num' -%}
        cast({{ column_name }} as integer) as {{ alias }}
    {%- else -%}
        {{ column_name }} as {{ alias }}
    {%- endif -%}

{%- endmacro %}