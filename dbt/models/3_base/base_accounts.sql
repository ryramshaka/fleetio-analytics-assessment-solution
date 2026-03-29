select accounts.account_id
    , accounts.account_company_cd
    , accounts.account_primary_contact_id
    , accounts.account_country_cd
    , accounts.account_state_cd
    , accounts.account_city_cd
    , accounts.account_industry_cd
    , accounts.account_fleet_size_cd
from {{ ref('stg_fleetio_accounts')}} accounts