select contacts.contact_id
    , contacts.contact_account_id
    , contacts.contact_lead_id
    , contacts.contact_first_name_cd
    , contacts.contact_last_name_cd
    , contacts.contact_job_title_cd
    , contacts.contact_email_cd
    , contacts.contact_created_at_ts
from {{ ref('stg_fleetio_contacts') }} contacts