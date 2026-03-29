select leads.lead_id
    , leads.lead_first_name_cd
    , leads.lead_last_name_cd
    , leads.lead_job_title_cd
    , leads.lead_email_cd
    , leads.lead_company_cd
    , leads.lead_created_at_ts
    , leads.lead_converted_at_ts
    , leads.lead_source_cd
    , leads.lead_country_cd
    , leads.lead_city_cd
    , leads.lead_industry_cd
    , leads.lead_fleet_size_cd
from {{ ref('stg_fleetio_leads') }} leads