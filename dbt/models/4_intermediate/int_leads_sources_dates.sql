with day_conversions as (
    select leads.lead_converted_at_dt
        , leads.lead_source_cd
        , sum(leads.lead_conversion_num)    as lead_conversion_ct
    from {{ ref('base_leads_dim') }} leads
    group by leads.lead_converted_at_dt, leads.lead_source_cd
)

, day_bounds as (
    select lead_source_cd
        , min(leads.lead_converted_at_dt)  as first_lead_converted_dt
        , max(leads.lead_converted_at_dt)   as last_lead_converted_dt
    from {{ ref('base_leads_dim') }} leads
    group by lead_source_cd
)

select dates.date_day_dt
    , dc.lead_source_cd
    , coalesce(dc.lead_conversion_ct, 0)    as lead_conversion_ct

    -- Optional grains
    , dates.date_week_dt
    , dates.date_month_dt
    , dates.date_quarter_dt
    , dates.date_year_dt
from day_conversions dc
full outer join {{ ref('base_dates_dim') }} dates
    on dc.lead_converted_at_dt = dates.date_day_dt
inner join day_bounds db
    on db.first_lead_converted_dt <= dates.date_day_dt
    and db.last_lead_converted_dt >= dates.date_day_dt
    and db.lead_source_cd = dc.lead_source_cd

order by dates.date_day_dt, dc.lead_source_cd