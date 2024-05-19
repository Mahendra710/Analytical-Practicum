# Analytical-Practicum

### North Point Software Listing Company Dataset File: [Click Here:](https://github.com/Mahendra710/Analytical-Practicum/blob/main/North-Point%20List.csv)

## Table of Contents
- [Introduction](#introduction)	
- [1.0 Business Problems and Goals](#10-business-problems-and-goals)	
  - 1.1 Business Problems:	
  - 1.2 Analytics Goals:
- 2.0 Data Exploration and Preprocessing	
  - 2.1 Attributes Definition:	
  - 2.2 Data Exploration:	
  - 2.3 Distribution of Variables
 
### Introduction
The North Point Software Company is a firm that sells games and educational software. The company wants to expand its customer base, so they join the group name consortium. This group specializes in computer hardware and software products. Every member of the group shares their customer list in a pool, and they receive the same number of customers from the pool. The North Point Software Company shared 200,000 names in the pool, for a total of 5,000,000 names in the pool. The company picked 20,000 names and did a test mailing. Out of the 20,000 customers listed, 1065 purchased after receiving mail, with a response rate of 0.053, or 5.3%. So, the company made a list of 1000 purchasers and 1000 non-purchasers (a response rate of 0.5 or 50%) to build the best prediction model. While using the prediction model in the pool, the purchase rate needs to be adjusted back down by multiplying each “case’s probability of purchase” by 5.3/50, or 0.106. The company is allowed to use a prediction model in the pool (5,000,000), so they can select the top 180,000 customers from the pool. The study will use the models to identify the purchasers and predict their spending behaviours to maximize gross profit and the customer base.

### 1.0 Business Problems and Goals
#### 1.1 Business Problems:
The company's primary objectives are to expand its customer base and enhance profit. After paying $2 for mail, the company wants to know if the customer will make a purchase or not. The business also wants to know if the customers are purchasers and how much they are going to spend on software or games. The company believes that they can apply the models to the pool of 5,000,000 customers. The company needs to rank those customers from the pool based on the original purchase rate (adjusted probability: 0.106) and adjusted probabilities.
The aim of maximizing gross profit while maintaining cost-effectiveness led to the decision to focus on the top customers rather than all customers. This target is based on the knowledge that the greatest returns on investment will come from concentrating on the top customers who are most likely to make purchases.
The business can maximize profit and expand its customer base by focusing its efforts on the most promising customers.
#### 1.2 Analytics Goals:
The main goal of the North Point Software Company is to select all the potential customers from the pool to expand their business. The company aims to build prediction models that classify the customer as a purchaser or non-purchaser after receiving mail and their spending behaviors. Based on what the remaining 180,000 customers might spend on games and software, the company hopes to estimate the gross profit from them. By ranking all the customers from the pool, the company wants to use higher probabilities of spending customers to maximize their gross profit and the remaining average or lower probabilities of spending customers to make more cost-effective strategies.
### 2.0 Data Exploration and Preprocessing
#### 2.1 Attributes Definition:
- **Sequence_number:** It shows the distinct number or index associated with every record in the dataset.
- **US**: This column indicates whether the customer is located in the United States or not. It is likely a binary variable, with 1 representing customers from the US and 0 representing customers from other countries.
- **Source_a, source_b, source_c, source_d, source_e, source_m, source_o, source_h, source_r, source_s, source_t, source_u, source_p, source_x, source_w**: These columns likely represent different sources or channels through which customers were acquired. Each column may contain binary values (0 or 1) indicating whether a particular source was used to acquire the customer.
- **Freq**: This column represents the frequency or number of purchases made by the customer. It is likely a numeric variable that indicates the count of purchases.
- **last_update_days_ago**: This column may indicate the number of days that have passed since the last update or interaction with the customer's data.
-	**1st_update_days_ago**: It may represent the number of days that have passed since the first update or interaction with the customer's data.
-	**Web order**: This column may indicate whether the purchase was made through a web order or not. It could be a binary variable with 1 representing a web order and 0 representing other types of orders.
-	**Gender=male**: This column may indicate the gender of the customer, with a binary value of 1 representing male and 0 representing female or other genders.
-	**Address_is_res**: This column may indicate whether the customer's address is residential or not. It could be a binary variable with 1 representing a residential address and 0 representing a non-residential address.
-	**Purchase**: This variable indicates whether a prospect responded to the test mailing and made a purchase. It is likely a binary variable with values like 0 or 1, where 0 represents no purchase and 1 represents a purchase.
-	**Spending**: For those prospects who made a purchase (Purchase = 1), this variable represents the amount they spent. It is likely a numeric variable that indicates the monetary value of the purchase.

#### 2.2 Data Exploration:
- Data exploration helps to get the value inside of the dataset. First, the dataset is typically loaded using the 'read_csv' function. With the “head ()” function, which shows the first six rows and dimension of the dataset (Figure 2.2.1). In the dataset, there are 2000 rows (records) and 25 columns (attributes) stored as ‘North_Point_List’. The target variables are “Purchase” and “Spending” which show whether a customer made a purchase or not after receiving mail and how much amount (in dollars) a customer spent. 
<div align="center">
    <img src="https://github.com/Mahendra710/Analytical-Practicum/assets/83266654/9e940f13-f4cd-4f56-82a2-c94a7634ef6d" alt="First Six Rows and dimension of the data" style="max-width:100%;">
    <p><b>Figure 2.2.1:</b> Summary</p>
</div>



