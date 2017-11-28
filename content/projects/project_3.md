---
date: 2017-02-23
title: "Project 3: Time Series Forecasting with Recurrent Neural Nets"
---

## Repository

The github repository for this project is at https://github.com/hcorrada/mldm_project3. You should have received an email from github to access the repository.

## Part I: Introduction to Tensor Flow

Follow the Introduction to Tensor Flow provided in the `partI_shell.ipynb` IPython notebook. Your task is to re-implement your linear SVM algorithm using gradient descent
using tensor flow. You don't need to run it on a specific dataset, as I will only look at the implementation. For debugging, you can try using the iris dataset: http://scikit-learn.org/stable/auto_examples/datasets/plot_iris_dataset.html

## Part II: Supervised methods for time series forecasting

We will be using the mortgage affordability provided by Zillow https://www.zillow.com/research/data/. For this part you will implement a single layer neural net, and a deep neural net for
time series forecasting. Follow the instructions in `partII_shell.ipynb`.

## Part III: Recurrent Neural Nets

### RNN

Use the `tf.nn.dynamic_rnn` and `tf.nn.rnn_cell.BasicRNNCell` functions to build a basic recurrent neural net to solve the affordability prediction problem.
A couple of notes:

- Setup input/target pairs as follows: for sequence $x_0, x_1, x_2, x_3, \ldots, x_m$ use targets as $x_1, x_2, x_3, \ldots, x_m, x_{m+1}$.

- Use truncated back propagation through time (use about 8 timesteps for each backprop), remember to carry state forward between truncated backprop chunks.

- To make predictions for county $j$ over the test set period, you should pass the training sequence (time series) for that county through the RNN so that
state is used properly.

Try a few different architectures and report on performance

### LSTM

Do the same as above using $tf.nn.rnn_cell.BasicLSTMCell` to use the LSTM model. Also look at `tf.nn.rnn_cell.MultiLSTMCell` to build deep LSTM network.

## Part IV: Discussion

Discuss the models you have used so far. Which proved to be most effective, and why? What were challenges in using these methods? What would you wish to try if you had more time to work on this?

Bonus question: how would you use these models to make longer-horizon forecasts (e.g., two or more years out)

