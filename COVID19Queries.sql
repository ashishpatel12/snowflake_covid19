//COVID 19 Queries STARSCHEMA_COVID19
//Global Cases Total
select sum(total_cases) from PUBLIC.WHO_SITUATION_REPORTS where date=(select max(DATE)from PUBLIC.WHO_SITUATION_REPORTS);

//Global Cases (New)
select sum(cases_new) from PUBLIC.WHO_SITUATION_REPORTS where date=(select max(DATE)from PUBLIC.WHO_SITUATION_REPORTS)

//Global Deaths 
select sum(deaths) from PUBLIC.WHO_SITUATION_REPORTS where date=(select max(DATE)from PUBLIC.WHO_SITUATION_REPORTS);

/Global Deaths (New)
select sum(deaths_new) from PUBLIC.WHO_SITUATION_REPORTS where date=(select max(DATE)from PUBLIC.WHO_SITUATION_REPORTS);

//COVID-19 (Total Cases)
select DATE,COUNTRY_REGION, SUM(CASES), SUM(DIFFERENCE) from "STARSCHEMA_COVID19"."PUBLIC"."JHU_COVID_19" where CASE_TYPE='Confirmed' and COUNTRY_REGION='United States' OR COUNTRY_REGION='Italy' OR COUNTRY_REGION='Spain' OR COUNTRY_REGION='Germany' OR COUNTRY_REGION='India' group by DATE,COUNTRY_REGION, COUNTRY_REGION order by DATE desc;

//Case Different (Past Day)
select * from PUBLIC.JHU_COVID_19 where COUNTRY_REGION='United States' and DATE=(select max(DATE) from PUBLIC.JHU_COVID_19) and CASE_TYPE='Confirmed';

//Total Cases USA
select province_state, sum(CASES) from PUBLIC.JHU_COVID_19 where COUNTRY_REGION='United States' and DATE=(select max(DATE) from PUBLIC.JHU_COVID_19) and CASE_TYPE='Confirmed' group by province_state;

//COVID-19 Tests (%Positive)
select PROVINCE_STATE, sum(POSITIVE)/nullif(sum(POSITIVE)+sum(NEGATIVE),0)*100 as Percent_Positive from public.ct_us_covid_tests where DATE=(select max(DATE) from PUBLIC.CT_US_COVID_TESTS) group by PROVINCE_STATE;

//Tests by State
select PROVINCE_STATE,sum(POSITIVE) as Positive, sum(NEGATIVE) as Negative,sum(PENDING) as Pending, sum(total) from PUBLIC.CT_US_COVID_TESTS where DATE=(select max(DATE) from PUBLIC.CT_US_COVID_TESTS) group by PROVINCE_STATE;


//USA COVID-19 Test Results
select PROVINCE_STATE,DATE,SUM(POSITIVE),SUM(NEGATIVE) from PUBLIC.CT_US_COVID_TESTS where COUNTRY_REGION='United States' group by PROVINCE_STATE, DATE;

//COVID-19 Cases Tri State + California
select PROVINCE_STATE,DATE,sum(cases) from PUBLIC.JHU_COVID_19 where COUNTRY_REGION='United States' and CASE_TYPE='Confirmed' and PROVINCE_STATE='New York' or PROVINCE_STATE='New Jersey' or PROVINCE_STATE='Pennsylvania' or PROVINCE_STATE='California' group by PROVINCE_STATE, DATE;



//Growth by Country (vs. Prior Day)
select DATE,COUNTRY_REGION, SUM(CASES), SUM(DIFFERENCE) from "STARSCHEMA_COVID19"."PUBLIC"."JHU_COVID_19" where CASE_TYPE='Confirmed' and COUNTRY_REGION='United States' OR COUNTRY_REGION='China' OR COUNTRY_REGION='Italy' OR COUNTRY_REGION='Spain' OR COUNTRY_REGION='Germany' group by DATE,COUNTRY_REGION, COUNTRY_REGION order by DATE desc;

//USA Growth (vs. Past Day)
select DATE,COUNTRY_REGION, SUM(CASES), SUM(DIFFERENCE) from "STARSCHEMA_COVID19"."PUBLIC"."JHU_COVID_19" where CASE_TYPE='Confirmed' and DATE!='2020-03-23' and COUNTRY_REGION='United States' group by DATE,COUNTRY_REGION, COUNTRY_REGION order by DATE desc;


//China Growth (vs. Past Day)
select DATE,COUNTRY_REGION, SUM(CASES), SUM(DIFFERENCE) from "STARSCHEMA_COVID19"."PUBLIC"."JHU_COVID_19" where CASE_TYPE='Confirmed' and COUNTRY_REGION='China' group by DATE,COUNTRY_REGION, COUNTRY_REGION order by DATE desc;

//Italy Growth (vs. Past Day)
select DATE,COUNTRY_REGION, SUM(CASES), SUM(DIFFERENCE) from "STARSCHEMA_COVID19"."PUBLIC"."JHU_COVID_19" where CASE_TYPE='Confirmed' and COUNTRY_REGION='Italy' group by DATE,COUNTRY_REGION, COUNTRY_REGION order by DATE desc;

//USA Cases
select
    DATE,
    COUNTRY_REGION,
    SUM(CASES),
    SUM(DIFFERENCE),
    CASE_TYPE
from
    "STARSCHEMA_COVID19"."PUBLIC"."JHU_COVID_19"
where
    COUNTRY_REGION = 'United States'
    and CASE_TYPE != 'Active'
    and CASE_TYPE !='Recovered'
group by
    DATE,
    COUNTRY_REGION,
    CASE_TYPE
order by
    DATE desc;


//China Cases
select
    DATE,
    COUNTRY_REGION,
    SUM(CASES),
    SUM(DIFFERENCE),
    CASE_TYPE
from
    "STARSCHEMA_COVID19"."PUBLIC"."JHU_COVID_19"
where
    COUNTRY_REGION = 'China'
    and CASE_TYPE != 'Active'
    and CASE_TYPE !='Recovered'
group by
    DATE,
    COUNTRY_REGION,
    CASE_TYPE
order by
    DATE desc;

//Italy Cases
select
    DATE,
    COUNTRY_REGION,
    SUM(CASES),
    SUM(DIFFERENCE),
    CASE_TYPE
from
    "STARSCHEMA_COVID19"."PUBLIC"."JHU_COVID_19"
where
    COUNTRY_REGION = 'Italy'
    and CASE_TYPE != 'Active'
    and CASE_TYPE !='Recovered'
group by
    DATE,
    COUNTRY_REGION,
    CASE_TYPE
order by
    DATE desc;
