select date_day_dt
    , opp_state_cd
    , first_lead_source_cd
    , account_industry_cd
    , account_fleet_size_cd

    -- Calculations
    , opp_creation_ct
    , opp_won_ct
    , round(coalesce(opp_won_ct, 0) * 1.0 
        / nullif(opp_creation_ct, 0) * 100, 1)     as opp_won_perc
    , opp_lost_ct
    , round(coalesce(opp_lost_ct, 0) * 1.0 
        / nullif(opp_creation_ct, 0) * 100, 1)     as opp_lost_perc

    -- Optional grains
    , date_week_dt
    , date_month_dt
    , date_quarter_dt
    , date_year_dt
from {{ ref('int_opps_conversion') }}
order by date_day_dt desc
    , opp_state_cd
    , first_lead_source_cd
    , account_industry_cd
    , account_fleet_size_cd


