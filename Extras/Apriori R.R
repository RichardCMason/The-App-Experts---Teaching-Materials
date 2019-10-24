#Apriori

# Preprocessing
install.packages('arules')
library(arules)
dataset = read.csv('./Udemy Machine learning A-Z/Apriori/Market_Basket_Optimisation.csv', header = FALSE)
dataset = read.transactions('./Udemy Machine learning A-Z/Apriori/Market_Basket_Optimisation.csv', sep = ',', rm.duplicates = TRUE)
summary(dataset)
itemFrequencyPlot(dataset, topN = 10)

# Training apriori model 
# support and confidence depend on particular business problem
# support = #number of transactions of that item, over the total transactions
rules = apriori(data = dataset, parameter = list(support = (7 * 4/ 7500), confidence = 0.2))

#visualizing the results
inspect(sort(rules, by = 'lift')[1:10])

