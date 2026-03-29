select opps.opp_id
    , opps.opp_account_id
    , opps.opp_created_at_ts
    , opps.opp_closed_at_ts
    , opps.opp_is_closed_flag
    , opps.opp_is_won_flag
    , opps.opp_country_cd
    , opps.opp_state_cd
    , opps.opp_city_cd
from {{ ref('stg_fleetio_opps') }} opps