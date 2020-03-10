---
date: 2017-02-07
title: "Project 1: Similar document searching via MinHash and Locality Sensitive Hashing" 
---

In this first project we will implement the system described in the lecture notes for similar document searching.
This project is inspired by http://mccormickml.com/2015/06/12/minhash-tutorial-with-python-code/ (Note: you can look at code there
for inspiration but implement your own).

<!--more-->

**Posted: March 10, 2020**   
**Last Update:  March 10, 2020** 

## The Task

We will use documents from this repository http://www.inf.ed.ac.uk/teaching/courses/tts/assessed/assessment3.html.
This is a dataset of documents for which we want to find possible cases of plagiarism. It consists of 10,000 documents for which
some pairs are tagged as instances of plagiarism. The goal of this exercise is to see how effectively and efficiently 
a minhash and LSH system can identify these instances.

Note that smaller subsets of data suitable for testing are available here:
https://github.com/chrisjmccormick/MinHash/tree/master/data

You will base your solution off of the code provided by this repository:
https://github.com/hcorrada/data606_plagiarism

Open the notebook `plagiarism_solution.ipynb` and follow instructions there.

