with source as (
    select * from {{ ref('raw_fleetio_opportunities') }}
)

select
    -- Primary Key
    {{ clean_col('id', 'id', name_override='opportunity_id') }}

    -- Foreign Key
    , {{ clean_col('account_id', 'id', prefix='opportunity') }}

    -- Timestamps
    , {{ clean_col('created_at', 'ts', prefix='opportunity') }}
    , {{ clean_col('closed_at', 'ts', prefix='opportunity') }}

    -- Booleans (Flags)
    , {{ clean_col('is_closed', 'flag') }}
    , {{ clean_col('is_won', 'flag') }}

    -- Attributes
    , {{ clean_col('country', 'cd', prefix='opportunity') }}
    , {{ clean_col('state', 'cd', prefix='opportunity') }}
    , {{ clean_col('city', 'cd', prefix='opportunity') }}

from source