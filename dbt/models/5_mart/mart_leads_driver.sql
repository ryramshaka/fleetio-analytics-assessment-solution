select date_day_dt
    , lead_source_cd
    , lead_state_cd
    , lead_industry_cd
    , lead_fleet_size_cd

    -- Calculations
    , lead_creation_ct                              as lead_creation_ct
    , lead_conversion_ct                            as lead_conversion_ct

    , round(coalesce(lead_conversion_ct, 0) * 1.0 
        / nullif(lead_creation_ct, 0) * 100, 1)     as lead_conversion_perc

    -- Optional grains
    , date_week_dt
    , date_month_dt
    , date_quarter_dt
    , date_year_dt
from {{ ref('int_leads_conversion') }}
order by date_day_dt desc
    , lead_source_cd
    , lead_state_cd
    , lead_industry_cd
    , lead_fleet_size_cd