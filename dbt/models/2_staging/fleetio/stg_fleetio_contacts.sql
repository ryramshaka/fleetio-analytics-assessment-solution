with source as (
    select * from {{ ref('raw_fleetio_contacts') }}
)

select
    -- Primary key
    cast(id as varchar) as contact_id
    
    -- Foreign keys
    , cast(account_id as varchar) as account_id
    , cast(lead_id as varchar) as lead_id
    
    -- Personal Info
    , cast(first_name as varchar) as first_name
    , cast(last_name as varchar) as last_name
    , cast(job_title as varchar) as job_title
    , cast(email as varchar) as contact_email
    
    -- Timestamps
    , cast(created_at as timestamp) as created_at_ts

from source