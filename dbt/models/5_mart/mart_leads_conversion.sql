select date_day_dt
    , date_week_dt
    , date_month_dt
    , date_quarter_dt
    , date_year_dt
    , round((sum(lead_conversion_ct) * 1.0 
        / nullif(sum(lead_creation_ct), 0)) * 100, 1)   as lead_conversion_perc
    , sum(lead_creation_ct)                             as lead_creation_ct
    , sum(lead_conversion_ct)                           as lead_conversion_ct
from {{ ref('int_leads_conversion') }}
group by date_day_dt
    , date_week_dt
    , date_month_dt
    , date_quarter_dt
    , date_year_dt
order by date_day_dt desc