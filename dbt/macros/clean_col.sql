{% macro clean_col(column_name, type_suffix, name_override=none, prefix=none) -%}

    {# 1. Determine the Base Alias Name #}
    {%- if name_override -%}
        {%- set alias = name_override -%}
    {%- else -%}
        {# Start with the prefix if it exists #}
        {%- set base_name = column_name -%}
        {%- if prefix -%}
            {%- set clean_prefix = prefix if prefix.endswith('_') else prefix ~ '_' -%}
            {%- set base_name = clean_prefix ~ column_name -%}
        {%- endif -%}

        {# Append the suffix if it isn't already there #}
        {%- if base_name.endswith('_' ~ type_suffix) or base_name.endswith(type_suffix) -%}
            {%- set alias = base_name -%}
        {%- else -%}
            {%- set alias = base_name ~ '_' ~ type_suffix -%}
        {%- endif -%}
    {%- endif -%}

    {# 2. Apply the CAST logic using the calculated alias #}
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