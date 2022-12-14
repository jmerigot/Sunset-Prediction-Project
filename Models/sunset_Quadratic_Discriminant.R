#######################################
### Quadratic Discriminant Analysis ###
#######################################

load("C:/Users/jules/OneDrive/Desktop/Sunset-Prediction-Project/RDA/sunset_Model_Setup.rda")

set.seed(8488)


# Setup quadratic discriminant model and workflow
sunset_qda_mod <- discrim_quad() %>% 
  set_mode("classification") %>% 
  set_engine("MASS")

sunset_qda_wkflow <- workflow() %>% 
  add_model(sunset_qda_mod) %>% 
  add_recipe(sunset_recipe)


# fitting model to the training data
sunset_qda_fit <- fit(sunset_qda_wkflow, sunset_train)
predict(sunset_qda_fit, new_data = sunset_train, type="prob")


# fitting model to the folds
sunset_qda_kfold_fit <- fit_resamples(sunset_qda_wkflow, sunset_folds, control = control_grid(save_pred = TRUE))
collect_metrics(sunset_qda_kfold_fit)


# using `augment()` to create a roc curve using our QDA fitted model
sunset_roc_qda <- augment(sunset_qda_fit, sunset_train)



# saving data to load into rmd file
save(sunset_qda_fit, sunset_qda_kfold_fit, sunset_roc_qda, 
     file = "C:/Users/jules/OneDrive/Desktop/Sunset-Prediction-Project/RDA/sunset_Quadratic_Discriminant.rda")