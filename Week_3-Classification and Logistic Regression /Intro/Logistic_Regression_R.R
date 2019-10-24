# loading some packages
install.packages('ISLR')
library(ISLR)
library(dplyr)
library(tidyr)
library(readr)
library(tidyverse)
install.packages('caret')
library(caret)

# reading the data
credit <- read_csv('./german_credit_data (1).csv')
head(credit)
str(credit)
credit$X1 <- NULL
# finding missing values
sapply(credit, function(x) sum(is.na(x)))
# and the percentage of missing values
sapply(credit, function(x) sum(is.na(x))/dim(credit)[1])

# removing NA values
credit <- na.omit(credit)
#Converting columns into dummy variables and proper datatypes
credit$Job <- as.factor(credit$Job)
# Converting Risk column 'bad' and 'good' to 0 and 1
credit$Risk[credit$Risk =='bad'] <- 0
credit$Risk[credit$Risk =='good'] <- 1
credit$Risk <- as.integer(credit$Risk)
head(credit$Risk)

# Doing some EDA
ggplot(credit, aes(x = Sex)) +
  geom_bar()
ggplot(credit, aes(x = Job)) +
  geom_bar()
ggplot(credit, aes(x = Age)) +
  geom_histogram()
ggplot(credit, aes(x = `Credit amount`)) + 
  geom_histogram()
ggplot(credit, aes(x = Risk)) +
  geom_bar()


# package which will make dummy variables for us
install.packages('fastDummies')
library(fastDummies)

names(Filter(is.character, credit))
names(Filter(is.factor, credit))

credit.dummy <- dummy_columns(credit, select_columns = c(names(Filter(is.character, credit)), 
                                     names(Filter(is.factor, credit))))

str(credit.dummy)

credit.model <- subset(credit.dummy, select = -c(Sex, Job, Housing, `Saving accounts`, 
                                                 `Checking account`, Purpose))
str(credit.model)





# Performing a logistic regression
logistic <- glm(Risk ~ ., family = binomial, data = credit.model)
summary(logistic)

glm.probs <- predict(logistic, type = 'response')
glm.probs[1:5]

glm.pred <- ifelse(glm.probs < 0.5, 0, 1)
glm.pred[1:5]

# Classification table
table(glm.pred, credit$Risk)

# Accuracy
mean(glm.pred == credit$Risk)


