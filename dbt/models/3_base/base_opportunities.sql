select opps.opportunity_id
    , opps.opportunity_account_id
    , opps.opportunity_created_at_ts
    , opps.opportunity_closed_at_ts
    , opps.opportunity_is_closed_flag
    , opps.opportunity_is_won_flag
    , opps.opportunity_country_cd
    , opps.opportunity_state_cd
    , opps.opportunity_city_cd
from {{ ref('stg_fleetio_opportunities') }} opps