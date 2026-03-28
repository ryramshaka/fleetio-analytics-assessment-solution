with source as (
    select * from {{ ref('raw_fleetio_accounts') }}
)

select
    -- Primary Key
    {{ clean_col('id', 'id', name_override='account_id') }}

    -- Names & Info
    , {{ clean_col('company', 'cd', prefix='account') }}
    
    -- Foreign Keys
    , {{ clean_col('primary_contact_id', 'id', prefix='account') }}

    -- Attributes
    , {{ clean_col('country', 'cd', prefix='account') }}
    , {{ clean_col('state', 'cd', prefix='account') }}
    , {{ clean_col('city', 'cd', prefix='account') }}
    , {{ clean_col('industry', 'cd', prefix='account') }}
    , {{ clean_col('fleet_size', 'cd', prefix='account') }}

from source