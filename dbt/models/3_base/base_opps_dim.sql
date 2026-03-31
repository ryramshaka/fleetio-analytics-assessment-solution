select opps.opp_id
    , opps.opp_account_id

    -- Creation
    , opps.opp_created_at_ts
    , cast(opps.opp_created_at_ts as date)      as opp_created_at_dt
    , 1                                         as opp_creation_num

    -- Closed
    , opps.opp_closed_at_ts
    , cast(opps.opp_closed_at_ts as date)       as opp_closed_at_dt
    , case
        when opps.opp_is_closed_flag = true then 1
        when opps.opp_is_closed_flag = false then 0
        else null end                           as opp_closed_num
    , opps.opp_is_closed_flag

    -- Conversion
    , opps.opp_is_won_flag
    , case
        when opps.opp_is_won_flag = true then 1
        when opps.opp_is_won_flag = false then 0
        else null end                           as opp_won_num
    , case
        when opps.opp_is_won_flag = false then 1
        when opps.opp_is_won_flag = true then 0
        else null end                           as opp_lost_num

    -- Attributes
    , opps.opp_country_cd
    , opps.opp_state_cd
    , opps.opp_city_cd
from {{ ref('stg_fleetio_opps') }} opps