---
date: 2017-02-07
title: "Project 1: Similar document searching via MinHash and Locality Sensitive Hashing" 
---

**Due: Monday Oct 3, 2017**  
**Posted: Sept. 12, 2017**   
**Last Update:  Sept. 12, 2017** 

In this first project we will implement the system described in the lecture notes for similar document searching.
This project is inspired by http://mccormickml.com/2015/06/12/minhash-tutorial-with-python-code/ (Note: you can look at code there
for inspiration but implement your own).

## The Task

We will use documents from this repository http://www.inf.ed.ac.uk/teaching/courses/tts/assessed/assessment3.html.
This is a dataset of documents for which we want to find possible plagiarism. It consists of 10,000 documents for which
some pairs are tagged as instances of plagiarism. The goal of this exercise is to see how effectively and efficiently 
a minhash and LSH system can identify these instances.

Note that smaller subsets of data suitable for testing are available here:
https://github.com/chrisjmccormick/MinHash/tree/master/data

# Part I: Preliminaries

## Part IA: Dataset parsing

Write a function `parse_data`that given the path to a filename, reads in the article data and returns an array of tuples. With

- One tuple per article (there is one article per line)  
- For each article tuples will contain `(id, string)` where `id` is the article id and `string` is the article text as described next
- Process the article text to 
  1. remove all punctuation
  2. change all letters to lowercase
  3. remove all whitespace so that all words are concatenated

The function should have skeleton:

```python
def parse_data(filename):
  # read lines from filename
  # construct tuple of id and text
  # process string as described above
  # return tuple with id and processed string
```
## Part IB: Document sharding

Write a function `shard_document` that given a processed article string and a parameter `k` shards the document as follows:

- each substring of lenght $k$ in document is hashed to a 32-bit integer (see `crc32` fucntion in https://docs.python.org/3/library/binascii.html)
- returns a list of the unique 32-bit integers obtained in previous step (possibly look at python `sets` for this)

The function should have skeleton

```python
def shard_document(string, k):
  # initialize set data structure
  # for each position in string, extract substring of length k
  # hash into 32-bit integer
  # insert into set
```

## Part IC: Jaccard Similarity

Write a function `jaccard` that given two sharded documents, computes their Jaccard distance

Function should have skeleton

```python
def jaccard(a, b):
  # initialize variables with size of union and intersections to 0
  # scan both sets in sorted order
  # update union and intersection sizes as appropriate
  # return ratio of union and intersection
```

## Part ID: Put these together

Write a function that uses the above to do the following:

- Parse a file with data
- Return a list of tuples each tuple contains: `(id1, id2, s)`, where `id1` and `id2` are document ids and `s` is the computed Jaccard similarity

## Part IE: Experiment 0

Use your function to carry out the following experiment:

What is the effect of sharding length `k` on the Jaccard similarity of plagiarism instances versus instances that are not plagiarized. Carry out this experiment using the 1000 document dataset.

# Part II: MinHash

COMING SOON

# Part III: Locality-Sensitive Hashing

COMING SOON

