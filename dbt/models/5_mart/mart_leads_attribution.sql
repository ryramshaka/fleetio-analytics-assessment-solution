select date_day_dt
    , lead_source_cd

    -- Calculations
    , lead_creation_ct
    , lead_conversion_ct

    -- Optional grains
    , date_week_dt
    , date_month_dt
    , date_quarter_dt
    , date_year_dt
from {{ ref('int_leads_source_conversion') }}