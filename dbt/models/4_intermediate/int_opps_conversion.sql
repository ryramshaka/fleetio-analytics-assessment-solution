with day_opps as (
    select opps.opp_created_at_dt
        , opps.opp_state_cd
        , opps_lead.first_lead_source_cd
        , opps_account.account_industry_cd
        , opps_account.account_fleet_size_cd
        , sum(opps.opp_creation_num)         as opp_creation_ct
        , sum(opps.opp_won_num)              as opp_won_ct
        , sum(opps.opp_lost_num)             as opp_lost_ct
    from {{ ref('base_opps_dim') }} opps
    left join {{ ref('base_opps_lead_fct') }} opps_lead
        on opps.opp_id = opps_lead.opp_id
    left join {{ ref('base_opps_account_fct') }} opps_account
        on opps.opp_id = opps_account.opp_id
    where opps.opp_closed_num = 1
    group by opps.opp_created_at_dt
        , opps.opp_state_cd
        , opps_lead.first_lead_source_cd
        , opps_account.account_industry_cd
        , opps_account.account_fleet_size_cd
)

, day_bounds as (
    select min(opp_created_at_dt)           as first_opp_created_dt
        , max(opp_created_at_dt)            as last_opp_created_dt
    from {{ ref('base_opps_dim') }} opps
    where opp_closed_num = 1
)

select dates.date_day_dt
    , dopp.opp_state_cd
    , dopp.first_lead_source_cd
    , dopp.account_industry_cd
    , dopp.account_fleet_size_cd

    -- Calculations
    , coalesce(dopp.opp_creation_ct, 0)       as opp_creation_ct
    , coalesce(dopp.opp_won_ct, 0)            as opp_won_ct
    , coalesce(dopp.opp_lost_ct, 0)           as opp_lost_ct

    -- Optional grains
    , dates.date_week_dt
    , dates.date_month_dt
    , dates.date_quarter_dt
    , dates.date_year_dt
from day_opps dopp
full outer join {{ ref('base_dates_dim') }} dates
    on dopp.opp_created_at_dt = dates.date_day_dt
inner join day_bounds db
    on db.first_opp_created_dt <= dates.date_day_dt
    and db.last_opp_created_dt >= dates.date_day_dt