---
date: 2017-02-23
title: "Project 2: Classification with Health Records"
---

**Multiple due dates**

Posted: 10/2/2018  
Last Update: 10/9/2018

# Task

We will use data from the following Kaggle dataset: https://www.kaggle.com/joniarroba/noshowappointments.

The goal here is to predict patients that will not show up for medical appointments based on their medical records. You should read
the dataset and task prediction in Kaggle to familiarize yourself as much as possible with the task and data.

# Part I: Data prep

**Due Oct 9, 2018**

- Fork my project skeleton github repo on github https://github.com/hcorrada/cmsc643_noshow.git

  - Click the 'Fork' button on the upper right
  - Go to your forked repository e.g., https://github.com/<your_github_id>/cmsc643_noshow
  - Follow instructions there to clone the repository to your computer
  - See this for a quick overview of git: https://swcarpentry.github.io/git-novice/
  
- Download the dataset from [{{< baseurl >}}data/noshowappointments.zip]({{< baseurl >}}data/noshowappointments.zip). Unzip and copy the csv file on to the `data` directory in the project.
- Rename file `partI_shell.ipynb` to `partI.ipynb`
- Complete the `partI.ipynb` notebook

This includes:

- Reading in data csv file 
- Cleanup data column names
- Remove records with erroneous entries (e.g., negative ages, look at what people have done in Kaggle)
- Create a test set of 20k records that you won't touch again for the reminder of this project until Part III. Use stratified sampling on the `No-show` variable to ensure
test set and training set class proportions are the same. Save the train and test sets as csv files in the `processed_data` directory.
- Plot the `No-show` variable against the other variables in the dataset as part of Exploratory Data Analysis (USE THE TRAINING SET FOR THIS!!)
- Create a preprocessing pipeline using `scikit` to prepare the data for the ML algorithms we will use. At a minimum, standardize numerical variables, transform categorical variables into one or more numerical values. You may apply other transformations that you think would be useful (e.g., logarithmic transformations).

A lot of what you will do here is covered in the introduction notebook posted earlier this semester [{{< baseurl >}}/notebooks/intro_lab.html]({{< baseurl >}}/notebooks/intro_lab.html). Feel free to use that code for inspiration.

Commit your changes to your local repository (you should do this often as you work on this**  
Push your changes to your repository on github and submit part I on ELMS by the due date.
The submission on ELMS is just writing the URL to your github repository

# Part II: Classification Methods

**Due Oct 30**

- Using sklearn fit a DecisionTree, a RandomForest, a linear SVM and an SVM with a radial basis kernel to the transformed data.
For now, use default parameters for each method.

- Use 10 fold cross validation to estimate performance of each of the above methods using both accuracy and AUC as metrics
Report your estimated performances. Should you use accuracy or AUC as a metric for this task?

- Based on the above choose two of the ML methods and fit a model using 5 fold cross validation for model selection
and 10 fold cross validation for model assessment. Report estimated performance for the tuned classifiers.

- Implement gradient descent for a linear svm and test it on the training set. How did its performance compare to the above?

To update your repository with new code for Part II do the following on your command shell:

```shell
git remote add upstream https://github.com/hcorrada/cmsc643_noshow
git pull upstream
```

# Part III: Ensembles and Final Result

## Ensembles

- Train an AdaBoost classifier using Decision Tree stubs as weak learners. Compare its performance to the results obtained in Part II
using 10 fold cross validation as before

- Choose a set of 5 or so classifiers, e.g., Decision Trees of diverse depths, linear SVMs over diverse subsets of features, RBF kernels with diverse bandwidths, Random Forests with diverse number of trees in their ensemble, be creative!. Write a function that given a training set does the following:

1. Creates a validation set using 20% of the training set
2. Trains each of your chosen classifiers on the training set
3. Using the validation set creates a new dataset where features are predictions made by each of your chosen classifiers
4. Trains a logistic regression classifier to blend the predictions 

Compare its performance to the results obtained in Part II using 10 fold cross validation.

## Final Result

Choose a single model based on all previous project steps that you think will perform best on our prediction task. Training this model on your complete training set. Measure the model's performance on the held out test set and compare to the 10 fold cross validation performance estimate you derived previously. 

