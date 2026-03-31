with source as (
    select * from {{ ref('raw_fleetio_opportunities') }}
)

select
    -- Primary Key
    {{ clean_col('id', 'id', name_override='opp_id') }}

    -- Foreign Key
    , {{ clean_col('account_id', 'id', prefix='opp') }}

    -- Timestamps
    , {{ clean_col('created_at', 'ts', prefix='opp') }}
    , {{ clean_col('closed_at', 'ts', prefix='opp') }}

    -- Booleans (Flags)
    , {{ clean_col('is_closed', 'flag', prefix='opp') }}
    , {{ clean_col('is_won', 'flag', prefix='opp') }}

    -- Attributes
    , {{ clean_col('country', 'cd', prefix='opp') }}
    , {{ clean_col('state', 'cd', prefix='opp') }}
    , {{ clean_col('city', 'cd', prefix='opp') }}

from source