# Analytical-Practicum

### North Point Software Listing Company Dataset File: [Click Here:](https://github.com/Mahendra710/Analytical-Practicum/blob/main/North-Point%20List.csv)

## Table of Contents
- [Introduction](#introduction)	
- [1.0 Business Problems and Goals](#10-business-problems-and-goals)	
  - [1.1 Business Problems:](#11-business-problems)	
  - [1.2 Analytics Goals:](#12-analytics-goals)
- [2.0 Data Exploration and Preprocessing](#20-data-exploration-and-preprocessing)	
  - [2.1 Attributes Definition:](21-attributes-definition)	
  - [2.2 Data Exploration:](22-data-exploration)	
  - [2.3 Distribution of Variables](23-distribution-of-variables)
 
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
``` R Code:
#Load the dataset
North_Point_List <- read_csv("G:/Webster/Analytical Practicum/Final/North-Point List.csv")
North_Point_List <- data.frame(North_Point_List)

#First Six rows 
head(North_Point_List)
#the dimension of the data
dim(North_Point_List)
```
<div align="center">
    <img src="https://github.com/Mahendra710/Analytical-Practicum/assets/83266654/9e940f13-f4cd-4f56-82a2-c94a7634ef6d" alt="Summary" style="max-width:100%;">
    <p><b>Figure 2.2.1:</b> First Six Rows and dimension of the data</p>
</div>

- Figure 2.2.2 displays the column names of the dataset which includes sequence number, US, different sources, freq (frequency), last update days ago and 1st update days ago, web order, Gender=male, Address is res (US), Purchase, and Spending.
```
#colnames of the dataset
colnames(North_Point_List)
```
<div align="center">
    <img src="https://github.com/Mahendra710/Analytical-Practicum/assets/83266654/b636279c-f9a7-4f27-bc86-008c2544171c"
 alt="Summary" style="max-width:100%;">
    <p><b>Figure 2.2.2:</b> Columns names of the dataset</p>
</div>

- Summary statistics provide an overview of the dataset including mean, median, minimum, maximum,1st Quartile, and 3rd Quartile. In the summary of the dataset (figure: 2.2.3), the company got customers from various sources and the majority of the customers are from the US. However, there are very few customers whose addresses are residential (mean: 0.221). From all the sources, the company got the highest number of customers from source_e (mean: 0.151) and the lowest number of customers from source_p (mean:0.006). The average spending amount by the customers is $102.6 with minimum spending $0 and maximum spending $1500. Also, some variables are related to customer behaviors like frequency (the number of purchases), last_update_days_ago, and spending.
```
#Summary of the data
summary(North_Point_List)
```
<div align="center">
    <img src="https://github.com/Mahendra710/Analytical-Practicum/assets/83266654/8c471399-6958-4fcf-8a92-5ab88c749479"
 alt="Summary" style="max-width:100%;">
    <p><b>Figure 2.2.3:</b> Summary of the data </p>
</div>

- Figure 2.2.4 shows that the data types for all the variables are numeric. In the dataset, the Sources, US, Web Order, Gender=male, Address_is_res, and Purchase columns have categorical data where 0 represents ‘no’ and 1 represents ‘yes’.
```
#the data types of the variables
str(North_Point_List)
```
<div align="center">
    <img src="https://github.com/Mahendra710/Analytical-Practicum/assets/83266654/0a22932c-77d3-40aa-bff5-c38504868934"
 alt="Summary" style="max-width:100%;">
    <p><b>Figure 2.2.4:</b> Data Types of the Variables </p>
</div>

- Missing values in the dataset give information about fake transactions or other information. However, checking the missing values in the dataset, figure 2.2.5 shows that there is no missing value in the dataset. This means all the transaction data and other information (e.g., sources, gender=male, address) are correctly collected.
```
#seeing the missing values
colSums(is.na(North_Point_List))
```
<div align="center">
    <img src="https://github.com/Mahendra710/Analytical-Practicum/assets/83266654/4468ec0e-4abe-4dd3-a59b-7ecf0a8c49e0"
 alt="Summary" style="max-width:100%;">
    <p><b>Figure 2.2.5:</b> Checking the missing Values </p>
</div>

- When it comes to checking the zeros in the dataset (Figure 2.2.6), there are 999 zeros in spending, which means there are 1001 customers who spent money, but there are only 1000 customers who purchased after receiving a mail. This might be happening due to a web order or a customer making an offline transaction. Also, 951 zeros in gender columns show that 951 customers are females and 1049 are males.
```
#check for zero
colSums(North_Point_List==0)
```
<div align="center">
    <img src="https://github.com/Mahendra710/Analytical-Practicum/assets/83266654/2c048367-b766-4d9d-8037-7e097562752c"
 alt="Summary" style="max-width:100%;">
    <p><b>Figure 2.2.6:</b> Check for the Zero’s </p>
</div>

#### 2.3 Distribution of Variables
- The Distribution of Purchase graph (Figure 2.3.1) shows that 1000 customers made purchases and 1000 customers didn't make any purchases after receiving a mail from the company. The distribution of gender (Figure 2.3.1) shows that male customers are more than female customers.
