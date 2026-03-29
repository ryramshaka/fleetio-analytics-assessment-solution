select date_day_dt
    , date_week_dt
    , date_month_dt
    , date_quarter_dt
    , date_year_dt
    , sum(lead_conversion_ct) as lead_conversion_ct
from {{ ref('int_leads_sources_dates') }}
group by date_day_dt
    , date_week_dt
    , date_month_dt
    , date_quarter_dt
    , date_year_dt
order by date_day_dt desc