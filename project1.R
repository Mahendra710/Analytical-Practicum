# Load the necessary packages
library(readr)
library(ggplot2)
library(reshape2)
#install.packages("corrplot")
library(corrplot)
# install.packages("GGally")
library(GGally)
library(dplyr)
library(factoextra)
library(caret)
#install.packages("rpart")
library(rpart)
library(rpart.plot)
library(e1071)
library(forecast)
library(gains)
library(gridExtra)
###---------------------- Data Exploration--------------------------------------

#Load the dataset
North_Point_List <- read_csv("G:/Webster/Analytical Practicum/Final/North-Point List.csv")
North_Point_List <- data.frame(North_Point_List)

#First Six rows 
head(North_Point_List)
#the dimension of the data
dim(North_Point_List)

#colnames of the dataset
colnames(North_Point_List)

#Summary of the data
summary(North_Point_List)

#the data types of the variables
str(North_Point_List)

#seeing the missing values
colSums(is.na(North_Point_List))

#check for zero
colSums(North_Point_List==0)

##--------Distribution of Variables-------------
# Distribution of 'Purchase'
ggplot(North_Point_List, aes(x = Purchase)) +
  geom_bar(fill = "grey", color = "black") +
  theme_minimal() +
  labs(title = "Distribution of Purchase",
       x = "Purchase",
       y = "Frequency")

#Distribution of Gender
barplot(table(North_Point_List$Gender.male), main = "Distribution of Gender= Male", xlab = "Gender", col = "grey", border = "black")

#Distribution of the no of transaction
ggplot(North_Point_List, aes(x = Freq)) +
  geom_bar(fill = "grey", color = "black") +
  theme_minimal() +
  labs(title = "Distribution of the No of transactions",
       x = "No of transactions",
       y = "Frequency")

#Distribution of Spending
hist(North_Point_List$Spending, main = "Distribution of Spending amount", xlab = "Spending", col = "grey", border = "black")

#Distribution of Web order
barplot(table(North_Point_List$Web.order), main = "Distribution of Web Order", xlab = "Web Order", col = "grey", border = "black")

#Distribution of US
barplot(table(North_Point_List$US), main = "Distribution of US address", xlab = "US address", col = "grey", border = "black")

#Distribution of US Residence
barplot(table(North_Point_List$Address_is_res), main = "Distribution of US Residence", xlab = "US Residence", col = "grey", border = "black")


###------------------Predictors analysis and Relevancy--------------------------

#correlation matrix
correlation_matrix <- cor(North_Point_List[, c("Freq", "last_update_days_ago", "X1st_update_days_ago","Purchase", "Spending")])
corrplot(correlation_matrix, method="number")

#Matrix and pairwise plots
ggpairs(North_Point_List[, c("Freq", "last_update_days_ago", "X1st_update_days_ago","Purchase","Spending")])


#Scatter plot of  Spending vs Last update days ago
plot(x = North_Point_List$last_update_days_ago,
     y = North_Point_List$Spending,
     main = "Last_update_days_ago vs. Spending",
     xlab = "Last_update_days_ago",
     ylab = "Spending",
     col = "black")

#Scatter plot of Spending vs first update days ago
plot(x = North_Point_List$X1st_update_days_ago,
     y = North_Point_List$Spending,
     main = "1st_update_days_ago vs. Spending",
     xlab = "1st_update_days_ago",
     ylab = "Spending",
     col = "black")

#Scatter plot of spending vs frequency
plot(x = North_Point_List$Freq,
     y = North_Point_List$Spending,
     main = "Frequency vs. Spending",
     xlab = "Frequency",
     ylab = "Spending",
     col = "black")

#boxplot of Spending by Web order
boxplot(North_Point_List$Spending ~ North_Point_List$Web.order,
        main = "Spending by Web Order",
        xlab = "Web Order",
        ylab = "Spending",
        col = "grey")

#boxplot of Spending by Purchaser
boxplot(North_Point_List$Spending ~ North_Point_List$Purchase,
        main = "Spending by Purchaser",
        xlab = "Purchase",
        ylab = "Spending",
        col = "grey")

#boxplot of Spending by Gender
boxplot(North_Point_List$Spending ~ North_Point_List$Gender.male,
        main = "Spending by Gender= Male",
        xlab = "Gender= Male",
        ylab = "Spending",
        col = "grey")

#boxplot of spending by US address
boxplot(North_Point_List$Spending ~ North_Point_List$US,
        main = "Spending by US address",
        xlab = "US address",
        ylab = "Spending",
        col = "grey")

#boxplot of spending by US residence
boxplot(North_Point_List$Spending ~ North_Point_List$Address_is_res,
        main = "Spending by US residence",
        xlab = "US residence",
        ylab = "Spending",
        col = "grey")



###-------------------------Dimension Reduction--------------------------------
df <- North_Point_List
#remove the sequence column
df<-df[,-1]
names(df)
#PCA analysis
pca_result <- prcomp(df, scale. = T)
names(pca_result)
#PCA Plot
plot(pca_result)
fviz_eig(pca_result, 
         addlabels = TRUE,
         ylim = c(0, 20),
         main="PCA plot")


# Summary
summary(pca_result)
#Biplot
biplot(pca_result)


###------------------------Data Partition---------------------------------------

df<-df[,-24]
dim(df)
df <- df %>%
  mutate(
    Purchase = factor(Purchase, levels=c(0,1), labels=c("Non-Purchaser","Purchaser"))
  )


# data Partitioning
set.seed(1)
## partitioning into training (40%), validation (35%), holdout (25%)
train.rows <- sample(rownames(df), nrow(df)*0.4)
valid.rows <- sample(setdiff(rownames(df), train.rows),nrow(df)*0.35)
holdout.rows <- setdiff(rownames(df), union(train.rows, valid.rows))
# create the 3 data frames by collecting all columns from the appropriate rows
train.df <- df[train.rows, ]
valid.df <- df[valid.rows, ]
holdout.df <-df[holdout.rows, ]

head(train.df)
head(valid.df)
head(holdout.df)

dim(train.df)
dim(valid.df)
dim(holdout.df)


##-----------------------Logistic Regression------------------------------------
#Training the model
# build model

trControl <- caret::trainControl(method="cv", number=5, allowParallel=TRUE)
lgmodel <- caret::train(Purchase ~ ., data=train.df, trControl=trControl,
                        method="glm", family="binomial")
lgmodel
summary(lgmodel$finalModel)
options(scrippen = 999)

#evaluating performance of training data
confusionMatrix(predict(lgmodel, train.df), train.df$Purchase, positive = "Purchaser")
#evaluating performance of Validation data
confusionMatrix(predict(lgmodel, valid.df), valid.df$Purchase, positive = "Purchaser")

# ------------------Stepwise Logistic Regression------------------------
lg.full <- glm(Purchase ~ ., data = train.df, family = "binomial")

# Stepwise backward
step_backward <- step(lg.full, direction = "backward")
summary(step_backward)
# Confusion matrix for backward stepwise model
backward_pred_train <- predict(step_backward, newdata = train.df, type = "response")
backward_pred_valid <- predict(step_backward, newdata = valid.df, type = "response")
# Convert probabilities to binary predictions for backward stepwise model
backward_pred_train_binary <- ifelse(backward_pred_train > 0.5, "Purchaser", "Non-Purchaser")
backward_pred_valid_binary <- ifelse(backward_pred_valid > 0.5, "Purchaser", "Non-Purchaser")
# Confusion matrix for training data
confusionMatrix(table(backward_pred_train_binary, train.df$Purchase), positive = "Purchaser")
# Confusion matrix for validation data
confusionMatrix(table(backward_pred_valid_binary, valid.df$Purchase), positive = "Purchaser")

# Stepwise forward
lg.null <- glm(Purchase ~ 1, data = train.df, family = "binomial")  # Null model
step_forward <- step(lg.null, scope = list(lower = lg.null, upper = lg.full), direction = "forward")
summary(step_forward)
# Confusion matrix for forward stepwise model
forward_pred_train <- predict(step_forward, newdata = train.df, type = "response")
forward_pred_valid <- predict(step_forward, newdata = valid.df, type = "response")
# Convert probabilities to binary predictions
forward_pred_train_binary <- ifelse(forward_pred_train > 0.5, "Purchaser", "Non-Purchaser")
forward_pred_valid_binary <- ifelse(forward_pred_valid > 0.5, "Purchaser", "Non-Purchaser")
# Confusion matrix for training data
confusionMatrix(table(forward_pred_train_binary, train.df$Purchase), positive = "Purchaser")
# Confusion matrix for validation data
confusionMatrix(table(forward_pred_valid_binary, valid.df$Purchase), positive="Purchaser")


##-----------K-NN Model---------------------------------------------------------
# use leave-one-out cross-validation
trControl <- trainControl(method="loocv", number=5, allowParallel=TRUE)
knn_model <- train(Purchase ~ ., data=train.df,
                   method="knn",
                   preProcess=c("center", "scale"),
                   tuneGrid=expand.grid(k=seq(1, 13, 2)),
                   trControl=trControl)

knn_model

#knn model with k =3.
knn.model <- train(Purchase ~ ., data=train.df,
                   method="knn",
                   preProcess=c("center", "scale"),
                   tuneGrid=expand.grid(k=3),
                   trControl=trainControl(method="none"))
knn.model

#evaluating performance of training data
confusionMatrix(predict(knn.model, train.df), train.df$Purchase, positive = "Purchaser")
#evaluating performance of Validation data
confusionMatrix(predict(knn.model, valid.df), valid.df$Purchase, positive = "Purchaser")


#-------------Classification tree-----------------------------------------------
#Default tree
default.ct <- rpart(Purchase ~ ., data=train.df, method="class")
#count number of leaves
sum(default.ct$frame$var=='<leaf>')
# plot tree
rpart.plot(default.ct, extra=1, fallen.leaves=FALSE)
default.ct.pred.train <- predict(default.ct, train.df, type='class')
#training confusion matrix
confusionMatrix(default.ct.pred.train,train.df$Purchase,positive = "Purchaser")
#validation confusion matrix
default.ct.pred.valid <- predict(default.ct, valid.df, type='class')
confusionMatrix(default.ct.pred.valid ,valid.df$Purchase,positive = "Purchaser")


#------------------------Naive Bayes-------------------------------
options(scipen=999, digits = 7)

purchase.nb <- naiveBayes(Purchase~ ., data = train.df)
purchase.nb
#training confusion matrix
confusionMatrix(predict(purchase.nb, newdata = train.df), train.df$Purchase, positive = "Purchaser")

#validation confusion matrix
confusionMatrix(predict(purchase.nb, newdata = valid.df), valid.df$Purchase, positive = "Purchaser")

#----------------------Regression Model----------------------------------
df1=data.frame(North_Point_List)
df1<-df1[,-1]

df1 <- df1 %>%
  mutate(
    Purchase = factor(Purchase, levels=c(0,1), labels=c("Non-Purchaser","Purchaser"))
  )
head(df1)
# data Partitioning
set.seed(1)
## partitioning into training (40%), validation (35%), holdout (25%)
train.rows <- sample(rownames(df1), nrow(df1)*0.4)
valid.rows <- sample(setdiff(rownames(df1), train.rows),nrow(df1)*0.35)
holdout.rows <- setdiff(rownames(df1), union(train.rows, valid.rows))
# create the 3 data frames by collecting all columns from the appropriate rows
train.df <- df1[train.rows, ]
valid.df <- df1[valid.rows, ]
holdout.df <-df1[holdout.rows, ]

train.p <- subset(train.df, Purchase == "Purchaser")
valid.p <- subset(valid.df, Purchase=="Purchaser")
train.p<-train.p[,-23]
valid.p <- valid.p[,-23]
dim(train.p)
dim(valid.p)

# -----------Linear Model------------------------
sr.model <- lm(Spending ~. , data = train.p)
summary(sr.model)
pred<- predict(sr.model,valid.p)
#Accuracy for validation
accuracy(pred,valid.p$Spending)

#----------------Stepwise methods---------------------
stepwise_backward <- step(sr.model,direction = "backward")
summary(stepwise_backward)
p <- predict(stepwise_backward, valid.p)
#Accuracy for Validation
accuracy(p,valid.p$Spending)


#----------------Regression tree Model-------------
tree.model <- rpart(Spending ~ ., data=train.p)
rpart.plot(tree.model)


tree.test.pred <- predict(tree.model, valid.p, type='vector')
#Accuracy for Validation
accuracy(tree.test.pred,valid.p$Spending)




#---------------------------------Profit Analysis-------------------------------

### Add a column to the data frame with the predicted probability of purchase 
holdout.df$predicted_probability_Purchaser <- predict(lgmodel,holdout.df,type= "prob")[,"Purchaser"]

### Add another column with predicted spending value 
holdout.df$predicted_spending_value <- predict(stepwise_backward,holdout.df)

### Add a column for “adjusted probability of purchase” to adjust for oversampling the purchaser 
original_purchase_rate <- 0.1065
holdout.df$adjusted_probability_of_purchase <- holdout.df$predicted_probability_Purchaser*original_purchase_rate

### Add another column for expected spending
holdout.df$expected_spending <- holdout.df$predicted_spending_value*holdout.df$adjusted_probability_of_purchase
head(holdout.df)
## ................................Cumulative Gain Chart.....................................

gain <- gains(holdout.df$expected_spending, holdout.df$adjusted_probability_of_purchase, groups=10)
df2 <- data.frame(
  ncases=c(0, gain$cume.obs),
  cumulative=sum(holdout.df$expected_spending)*c(0, gain$cume.pct.of.total)
)
df2
g1<-ggplot(df2, aes(x=ncases, y=cumulative)) +
  geom_line() +
  geom_segment(aes(x=0, y=0, xend=nrow(holdout.df), yend=sum(holdout.df$expected_spending)),
               color="gray", linetype=2) + # adds baseline
  labs(x="# Cases", y="# Expected Spending", title="Cumulative gains chart")

g1

barplot(gain$mean.resp / mean(holdout.df$expected_spending), names.arg=seq(10, 100, by=10),
        xlab="Percentile", ylab="Decile mean / global mean")

# Decile-wise lift chart
df3 <- data.frame(
  decile=gain$depth,
  meanResponse=gain$mean.resp /mean(holdout.df$expected_spending))

g2 <- ggplot(df3, aes(x=decile, y=meanResponse)) +
  geom_bar(stat="identity") +
  labs(x="decile", y=" ", title="Decile-wise lift chart")
grid.arrange(g1,g2,ncol=2)



##--------------Gross-Profit-------

#sum of total expected spending form 500 customers
sum(holdout.df$expected_spending)
#sum of total expectd spending form 180,000 customers
(180000*sum(holdout.df$expected_spending))/500

#expected gross profit from 180,000 customers
((180000*sum(holdout.df$expected_spending))/500)- (2*180000)

#expected gross profit from one customer
(((180000*sum(holdout.df$expected_spending))/500)- (2*180000))/180000

