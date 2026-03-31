select opps.opp_id
    , accounts.account_id
    , accounts.account_industry_cd
    , accounts.account_fleet_size_cd
from {{ ref('base_opps_dim') }} opps
left join {{ ref('base_accounts_dim') }} accounts
    on accounts.account_id = opps.opp_account_id