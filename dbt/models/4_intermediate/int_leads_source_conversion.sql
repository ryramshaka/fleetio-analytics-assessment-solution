with day_leads as (
    select leads.lead_created_at_dt
        , leads.lead_source_cd
        , sum(leads.lead_creation_num)      as lead_creation_ct
        , sum(leads.lead_conversion_num)    as lead_conversion_ct
    from {{ ref('base_leads_dim') }} leads
    group by leads.lead_created_at_dt, leads.lead_source_cd
)

, day_bounds as (
    select lead_source_cd
        , min(lead_created_at_dt)  as first_lead_created_dt
        , max(lead_created_at_dt)  as last_lead_created_dt
    from day_leads
    group by lead_source_cd
)

select dates.date_day_dt
    , dl.lead_source_cd

    -- Calculations
    , coalesce(dl.lead_creation_ct, 0)      as lead_creation_ct
    , coalesce(dl.lead_conversion_ct, 0)    as lead_conversion_ct

    -- Optional grains
    , dates.date_week_dt
    , dates.date_month_dt
    , dates.date_quarter_dt
    , dates.date_year_dt
from day_leads dl
full outer join {{ ref('base_dates_dim') }} dates
    on dl.lead_created_at_dt = dates.date_day_dt
inner join day_bounds db
    on db.first_lead_created_dt <= dates.date_day_dt
    and db.last_lead_created_dt >= dates.date_day_dt
    and db.lead_source_cd = dl.lead_source_cd

order by dates.date_day_dt, dl.lead_source_cd