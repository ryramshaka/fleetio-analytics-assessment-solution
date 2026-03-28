with source as (
    select * from {{ ref('raw_fleetio_contacts') }}
)

select
    -- Primary key
    {{ clean_col('id', 'id', name_override='contact_id') }}
    
    -- Foreign keys
    , {{ clean_col('account_id', 'id', prefix='contact')}}
    , {{ clean_col('lead_id', 'id', prefix='contact')}}
    
    -- Personal Info
    , {{ clean_col('first_name', 'cd', prefix='contact')}}
    , {{ clean_col('last_name', 'cd', prefix='contact')}}
    , {{ clean_col('job_title', 'cd', prefix='contact')}}
    , {{ clean_col('email', 'cd', prefix='contact')}}
    
    -- Timestamps
    , {{ clean_col('created_at', 'ts', prefix='contact')}}

from source