with date_series as (
    -- Generates a series of dates from 2020 through 2027
    select cast(range as date)              as date_day
    from range(date '2020-01-01', date '2027-12-31', interval '1 day')
),

final as (
    select date_day                           as date_id
        
        -- Date Parts
        , extract(day from date_day)          as date_day_of_month_num
        , extract(month from date_day)        as date_month_num
        , extract(year from date_day)         as date_year_num
        
        -- Time Grains (Truncations)
        , date_trunc('day', date_day)         as date_day_dt
        , date_trunc('week', date_day)        as date_week_dt
        , date_trunc('month', date_day)       as date_month_dt
        , date_trunc('quarter', date_day)     as date_quarter_dt
        , date_trunc('year', date_day)        as date_year_dt
        
        -- Labels for BI Tools
        , strftime(date_day, '%A')            as date_day_name_cd
        , strftime(date_day, '%B')            as date_month_name_cd
        , 'Q' || extract(quarter from date_day) || '-' || extract(year from date_day) as date_quarter_name_cd
        
        -- Flags
        , case 
            when extract(dow from date_day) in (0, 6) then true 
            else false 
        end                                   as date_is_weekend_flag

    from date_series
)

select * from final