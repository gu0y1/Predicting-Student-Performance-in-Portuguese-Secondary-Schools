# Project: STATS101A Group Project Report
# Authors: Yining Xu (405941895), Guoyi Chen (906315339), Yuexuan Wu (506038283)
# Code is available online @https://blog.nus.edu.sg/chenguoyi/modules/st3131/

# Install Dependency Packages
install.packages("car")

# Load necessary libraries
library(car)

# Load data
student <- read.csv("student-por.csv", header = TRUE)

# <Fig 2.1> Scatter plot matrix using base R
pairs(Gtotal ~ Medu + Fedu + studytime + health + absences, data = student)

# <Tab 3.1> Summary result of original model
model <- lm(Gtotal~Medu + Fedu + studytime + health + absences, data = student)
summary(model)

# <Tab 3.2> Transformation Results for each variable
transform_xy <- powerTransform(cbind(Gtotal,Medu,Fedu,studytime,health,(absences+1))~1,data = student)
summary(transform_xy)

# <Tab 3.3> Summary Result of Final Model
model2 <- lm(Gtotal~Medu + Fedu + log(studytime) + I(health^(1.4)) + log(absences+1), data = student)
summary(model2)

# <Tab 3.4> Result of Forward Stepwise Method
nullm <- lm(Gtotal~1, data = student)
forwardAIC <- step(nullm, scope=list(lower=~1, upper=~Medu + Fedu + log(studytime) +I(health^(1.4)) + log(absences+1)), direction="forward", data = student)

# <Tab 3.5> Summary Result of Final Model
model3 <- model2 <- lm(Gtotal~Medu + Fedu + log(studytime) + I(health^(1.4)) + log(absences+1), data = student)
summary(model3)
