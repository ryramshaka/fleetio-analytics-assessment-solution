-- This is a one-off audit query to check relationship cardinality
with opp_counts as (
    select leads.lead_id
        , count(distinct contacts.contact_id) as contact_ct
        , count(distinct accounts.account_id) as account_ct
        , count(distinct opps.opportunity_id) as opportunity_ct
    from {{ref('stg_fleetio_leads')}} leads
    left join {{ ref('stg_fleetio_contacts') }} contacts
        on leads.lead_id = contacts.contact_lead_id
    left join {{ ref('stg_fleetio_accounts')}} accounts
        on contacts.contact_account_id = accounts.account_id
    left join {{ ref('stg_fleetio_opportunities')}} opps
        on accounts.account_id = opps.opportunity_account_id
    group by leads.lead_id
)

select opportunity_ct
    , count(distinct lead_id) as lead_ct
from opp_counts
group by opportunity_ct
order by opportunity_ct desc