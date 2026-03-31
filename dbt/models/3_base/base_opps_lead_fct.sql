with opp_leads as (
    select distinct opps.opp_id
        , first_value(leads.lead_id) over (
            partition by opps.opp_id order by leads.lead_created_at_ts
            rows between unbounded preceding and unbounded following
        ) as first_lead_id_by_lead_creation
        , last_value(leads.lead_id) over (
            partition by opps.opp_id order by leads.lead_created_at_ts
            rows between unbounded preceding and unbounded following
        ) as last_lead_id_by_lead_creation
    from {{ ref('base_opps_dim') }} opps
    left join (
        select lead_id, opp_id
        from {{ ref('base_leads_opp_fct') }}
     ) lead_opps on opps.opp_id = lead_opps.opp_id
    left join (
        select lead_id, lead_created_at_ts
        from {{ ref('base_leads_dim') }}
     ) leads on leads.lead_id = lead_opps.lead_id
)

select opp_leads.opp_id
    , opp_leads.first_lead_id_by_lead_creation
    , first_lead.lead_source_cd as first_lead_source_cd
    , opp_leads.last_lead_id_by_lead_creation
    , last_lead.lead_source_cd  as last_lead_source_cd
from opp_leads
left join {{ ref('base_leads_dim') }} first_lead
    on first_lead.lead_id = opp_leads.first_lead_id_by_lead_creation
left join {{ ref('base_leads_dim') }} last_lead
    on last_lead.lead_id = opp_leads.last_lead_id_by_lead_creation
