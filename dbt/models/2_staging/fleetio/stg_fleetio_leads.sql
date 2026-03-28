with source as (
    select * from {{ ref('raw_fleetio_leads') }}
)

select
    -- Primary Key
    {{ clean_col('id', 'id', name_override='lead_id')}}
    
    -- Names & Info
    , {{ clean_col('first_name', 'cd', prefix='lead')}}
    , {{ clean_col('last_name', 'cd', prefix='lead')}}
    , {{ clean_col('job_title', 'cd', prefix='lead')}}
    , {{ clean_col('email', 'cd', prefix='lead')}}
    , {{ clean_col('company', 'cd', prefix='lead')}}
    
    -- Timestamps
    , {{ clean_col('created_at', 'ts', 'lead')}}
    , {{ clean_col('converted_at', 'ts', 'lead')}}
    
    -- Attributes & Categorization
    , {{ clean_col('source', 'cd', prefix='lead')}}
    , {{ clean_col('country', 'cd', prefix='lead')}}
    , {{ clean_col('city', 'cd', prefix='lead')}}
    , {{ clean_col('state', 'cd', prefix='lead')}}
    , {{ clean_col('industry', 'cd', prefix='lead')}}
    , {{ clean_col('fleet_size', 'cd', prefix='lead')}}
from source