select leads.lead_id

    -- Creation
    , leads.lead_created_at_ts
    , cast(leads.lead_created_at_ts as date)        as lead_created_at_dt
    , 1                                             as lead_creation_num

    -- Conversion
    , leads.lead_converted_at_ts
    , cast(leads.lead_converted_at_ts as date)      as lead_converted_at_dt
    , case
        when leads.lead_converted_at_ts is not null then 1
        else 0 end                                  as lead_conversion_num
    , case
        when leads.lead_converted_at_ts is not null then true
        else false end                              as lead_conversion_flag

    -- Attributes
    , leads.lead_first_name_cd
    , leads.lead_last_name_cd
    , leads.lead_job_title_cd
    , leads.lead_email_cd
    , leads.lead_company_cd
    , leads.lead_source_cd
    , leads.lead_country_cd
    , leads.lead_state_cd
    , leads.lead_city_cd
    , leads.lead_industry_cd
    , leads.lead_fleet_size_cd
from {{ ref('stg_fleetio_leads') }} leads