install.packages('dplyr')
library(dplyr)
data('mtcars')
typeof(mtcars)
auto <- data.frame(mtcars)
class(auto)
head(auto)

str(auto)

summary(auto)

names(auto)

nrow(auto)

ncol(auto)

cor(auto)

install.packages('ggplot2')
library(ggplot2)
ggplot(auto, aes(x = auto$cyl, y = auto$mpg)) +
         geom_point()

auto$cyl <- as.factor(auto$cyl)
str(auto)
auto <- na.omit(auto)
auto[is.na(auto)]
lm.fit <- lm(mpg ~ cyl + hp + disp, data = auto)
summary(lm.fit)
confint(lm.fit)

predict(lm.fit)

plot(auto$hp, auto$mpg)

data('boston')
library(MASS)
plot(lm.fit)


Bost
ggplot(Boston, aes)

# The Boston dataset
library(MASS)
Boston
?Boston
class(Boston)
head(Boston)
# similar to pandas .describ
summary(Boston)
# similar to pandas .info()
str(Boston)


attach(Boston)
medv
lm.fit = lm(medv~lstat, data=Boston)
summary(lm.fit)
Boston
names(lm.fit)
coef(lm.fit)

confint(lm.fit)
# Predicting values
#hatvalues <- predict(lm.fit, data.frame(lstat = c(5, 10, 15)),
       #interval = 'confidence')
#hatvalues
y_hat <- predict(lm.fit)
y_hat
lm.fit$fitted.values 
names(lm.fit)
names(Boston)
# Making some plots
plot(lstat, medv)

abline(lm.fit, lwd=3, col= 'red')
plot(lstat, medv, col='black')

plot(lstat, medv, pch=20)

plot(lstat, medv, pch = '+')


par(mfrow = c(2,2))
plot(lm.fit)
library(ggplot2)
install.packages('ggfortify')
library(ggfortify)
autoplot(lm.fit)

plot(predict(lm.fit), residuals(lm.fit))


lm.fit = lm(medv~lstat + age, data = Boston)
summary(lm.fit)

lm.fit = lm(medv ~., data=Boston)

summary(lm.fit)
# Variance inflation factor
# library(tidyverse)
# library(caret)
# vif(lm.fit)


lm.fit = lm(medv ~ ., data = Boston)
summary(lm.fit)
lm.fit = lm(medv ~ . -chas, data = Boston)
summary(lm.fit)
summary(lm(medv ~lstat*age, data = Boston))

#vif(lm.fit)

# Adding in new features(lstat^2)
lm.fit2 = lm(medv ~lstat + I(lstat^2), data = Boston)
summary(lm.fit2)
Boston$crim

lm.fit = lm(medv ~lstat, data = Boston)

anova(lm.fit, lm.fit2)
par(mfrow = c(2,2))
plot(lm.fit2)

# Interaction terms
lm.fit1 = lm(medv ~lstat + rad + tax, data = Boston)
summary(lm.fit1)
lm.fit1 = lm(medv ~lstat + rad*tax, data = Boston)
summary(lm.fit1)
lm.fit1 = lm(medv ~., data = Boston)
summary(lm.fit1)
lm.fit1 = lm(medv ~. -age, data = Boston)
summary(lm.fit1)
lm.fit1 = lm(medv ~. -age -indus, data = Boston)
summary(lm.fit1)
lm.fit1 = lm(medv ~. -age -indus -chas, data = Boston)
summary(lm.fit1)
lm.fit1 = lm(medv ~. -age -indus -chas -rad, data = Boston)
summary(lm.fit1)
lm.fit1 = lm(log(medv) ~. -age -indus -chas -rad + log(lstat), data = Boston)
summary(lm.fit1)
# Using polynomial features
install.packages('GGally')
library(GGally)
lm.fit5 = lm(log(medv) ~ . + poly(lstat, 5), data = Boston)
summary(lm.fit5)
ggpairs(Boston)
install.packages('purrr')
library(purrr)
library(dplyr)
summary(lm(medv ~ log(rm), data = Boston))
scatter_plot <- function(x){
  ggplot(Boston,aes(y=medv)) + 
    aes_string(x=x) +
    geom_point(alpha=0.5) +
    geom_smooth(method=lm,se=FALSE)
}
scatter_plots <- map(names(Boston)[-length(names(Boston))],scatter_plot)
grid.arrange(grobs =scatter_plots,ncol=4)


