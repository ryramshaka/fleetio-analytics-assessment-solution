select leads.lead_id
    , contacts.contact_id
    , accounts.account_id
    , opps.opp_id
from {{ ref('base_leads_dim') }} leads
left join {{ ref('base_contacts_dim') }} contacts
    on leads.lead_id = contacts.contact_lead_id
left join {{ ref('base_accounts_dim')}} accounts
    on contacts.contact_account_id = accounts.account_id
left join {{ ref('base_opps_dim')}} opps
    on accounts.account_id = opps.opp_account_id
    and leads.lead_converted_at_ts = opps.opp_created_at_ts -- Opp created as lead converted
    and leads.lead_created_at_ts <= opps.opp_closed_at_ts -- Safety guard, redudant
where leads.lead_conversion_flag = true