select distinct lead_source_cd
from {{ ref('stg_fleetio_leads') }} leads
order by lead_source_cd