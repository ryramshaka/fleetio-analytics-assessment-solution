# Fleetio Data Analyst Assessment

Welcome! Thank you for your interest in Fleetio. 

The following assessment is a semi-realistic scenario for a data analyst at Fleetio. There are no right or wrong answers and we are more interested in understanding how you approach the problem. Please write code in a manner as if you were collaborating with another member of the team. 

Please timebox this to no more than a couple of hours and remember that you will present your work to the rest of the team in the next stage. 

We hope you enjoy!

### Problem Statement

In order to efficiently analyze data we utilize dbt to model the data we expose to business intelligence tools. The sales and marketing teams capture leads, which may become contacts, accounts, and opportunities depending on whether or not they are converted. Those opportunities may then be open or closed and won or lost. Included in the `data` directory are four csv files of data for each object. This data and the relationships between the objects have been simplified for this assessment.

1. leads - Created automatically from various sources.
2. contacts - Records are created after leads have converted.
3. opportunities - Records are created after leads have converted.
4. accounts - Records are created after leads have converted.

### Exercise

1. Create a dbt project. More details on installing dbt can be found [here](https://docs.getdbt.com/dbt-cli/install/overview)
2. Define the included CSV files as dbt `seeds`.
3. In the `models` directory, define models to be exposed to a business intelligence tool that can be used to visualize and answer these questions:
    - How many leads were converted by different time grains (day, week, and month)?
    - Which lead sources generated the most converted leads at different time grains (day, week, and month)?
    - What are some possible drivers of lead conversion?
    - What are some possible drivers of closed/won opportunities?
4. Create `schema.yml` file(s) for your models to document them.
5. Be prepared to discuss the types of approaches you would use to visualize data in a business intelligence tool based on these models.
6. Publish your repo to GitHub and make it public, or zip up the entire repository to share it with your recruiter.

### Notes

- Use the `ref` function in dbt for referring to the seeds and any other model dependencies you create.
- Refer to the dbt [documentation](https://docs.getdbt.com/docs/introduction) as needed for formatting & syntax.
- You are not required to set up a local database to actually load the data and run models (you are welcome to if you would like), but your models should compile successfully.
- If you would like to set up the database locally, we suggest [this](https://postgresapp.com/) as a simple way to get a Postgres database up and running locally. You can then [install the dbt adapter](https://docs.getdbt.com/dbt-cli/install/overview) for Postgres to set up your project and profiles accordingly.
- We have a dbt and sql style guide that generally follows [this](https://discourse.getdbt.com/t/how-we-structure-our-dbt-projects/355) guide. We also use [sqlfluff](https://www.sqlfluff.com/) to lint and format our SQL models. You are not required to follow these exactly or install sqlfluff for this assessment, but your SQL should be well formatted, readable, and generally follow the dbt best practices referenced in these resources.
- The purpose of this assessment is not to arrive at a specific correct answer or perform the actual analysis, but rather to understand how you approach and think about modeling and analyzing data.