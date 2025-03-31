# Description
This is a project for data analysis using Python (pandas) and SQL for cytometry data provided by Teiko.
The detail problem description can be found in questions.txt.

## Setup the environment
For Linux users, please use anaconda to create virtual environment.
1. run this command to create a virtual environment
`bash
python3.10 -m venv venv


3. activate the virtual environment
`bash
source venv/bin/activate
   

4. install the required packages
'bash
pip install -r requirements.txt
   

## Files Directory
```plaintext
cell_count_project/
├── README.md
├── requirements.txt
├── cell_count_analysis.py
└── data/
    └── cell-count.csv
```

## Python Question
To get the result for the python questions, please execute the following command: python cell_count_analysis.py
Then, you will have the results in the output folder, and the boxplots will be in output/plots folder
The command window will also print out the statistical results for the second python question.



## SQL Question
### Question 1.
schema.sql is a prototype of the database. In the script, we will create multiple tables to store information, and then create indexing to help us query the database.

### Question 2.
The design of the schema can make database:
1. consistency and integrity
2. efficient querying
3. scalability (muti-project support)
4. minimize data redundancy

### Question 3-5
queries.sql is developed based on schema.sql. For question 3-5, we can use the query function to get the results.


