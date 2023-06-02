# mice

library(mice)

data(nhanes)

nhanes.imp <- mice(nhanes, m = 5, method = 'pmm')

# Show imputation 3
head(complete(nhanes.imp, 3))

# Show just the imputed values. Columns are imputations, rows are observations
nhanes.imp$imp

# Extract the "tall" matrix which stacks the imputations
nhanes.comp <- complete(nhanes.imp, "long", include = TRUE)

# Now, the .imp variable identifies which imputation each belongs to.
# 0 (included because of `include = TRUE` above) is the un-imputed data.
table(nhanes.comp$.imp)


# Let's visualize the distribution of imputed and observed values.
# `cci` returns logical whether its input is complete at each observation. 
nhanes.comp$bmi.NA <- cci(nhanes$bmi)

# Note that the above uses the recylcing properties of matrixes/data.frame:
#  The `cci` call returns length 25; but because values are recylced to the total
#  number of rows in nhanes.comp, it replicates 6 times.
head(nhanes.comp[, c("bmi", "bmi.NA")])


library(ggplot2)
ggplot(nhanes.comp, 
       aes(x = .imp, y = bmi, color = bmi.NA)) + 
  geom_jitter(show.legend = FALSE, 
              width = .1)



with(nhanes.imp, mean(bmi))

with(nhanes.imp, t.test(bmi ~ hyp))

with(nhanes.imp, lm(bmi ~ age + chl))

mod1 <- with(nhanes.imp, lm(bmi ~ age + chl))

pool(mod1)

summary(pool(mod1))

pool.r.squared(mod1)
