---
date: 2017-02-07
title: "Project 1: Similar document searching via MinHash and Locality Sensitive Hashing" 
---

**Due: Monday Oct 3, 2017**  
**Posted: Sept. 12, 2017**   
**Last Update:  Sept. 18, 2017** 

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
## Part IB: Document shingles

Write a function `shingle_document` that given a processed article string and a parameter `k` shards the document as follows:

- each substring of length $k$ in document is hashed to a 32-bit integer (see `crc32` fucntion in https://docs.python.org/3/library/binascii.html)
- returns a list of the unique 32-bit integers obtained in previous step (look at python `sets` for this)

The function should have skeleton

```python
def shingle_document(string, k):
  # initialize set data structure
  # for each position in string,
    # extract substring of length k
    # hash substring into 32-bit integer using crc32
    # insert into set
  # return set
```

## Part IC: Jaccard Similarity

Write a function `jaccard` that given two sharded documents, computes their Jaccard distance

Function should have skeleton

```python
def jaccard(a, b):
  # compute union size
  # compute intersection size
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

In this section you will implement the MinHash algorithm and perform an experiment to see how well it estimates Jaccard similarity.

## Part IIA: Prepare shingles for processing

Implement a function that takes the shingled documents and returns a list of item-document pairs sorted by items that we'll use to compute the minhash signature of each document. Remember that because of the shingling logic we used above, we represent items as 32-bit integers. The function specs are as follows:

- Input is a list of tuples of form `(docid, [items])`
- Output will be a tuple with two elements:
    - a list of tuples of form `(item, docid)`. It will contain one entry for each item appearing in each document.
    - a list of document ids found in the dataset
- Output should be sorted by `item`

This function should have skeleton

```python
def invert_shingles(shingled_documents):
  # initialize list for tuples
  # initialize list for document ids
  # for each document in input
    # append document id to list
    
    # for each item in document
      # append (item, docid) tuple
  
  # sort tuple list
  # return sorted tuple list, and document list
```

## Part IIB: Generate hash functions

Use the `generate_random_hash_fn` function below to create function `make_hashes`. Given input `num_hashes` this function will return a list
of hash functions that mimic the random permutation approach used in Minhash calculation. The function specs are:

- Input is an integer `num_hash`
- Output is a list of hash functions created by function `generate_random_hash_fn`

## Part IIC: Construct the Minhash Signature Matrix

Implement a function that builds the Minhash signature matrix. You can use this code as a starting point. It refers to the
functions you implemented above and sketches the construction algorithm.

```python
import numpy

def make_minhash_signature(shingled_data, num_hashes):
  inv_index, docids = invert_shingles(shingled_data)
  num_docs = len(docids)
  
  # initialize the signature matrix with infinity in every entry
  sigmatrix = np.full([num_hash, num_docs], np.inf)
  
  # generate hash functions
  hash_funcs = make_hashes(num_hashes)
  
  # iterate over each non-zero entry of the characteristic matrix
  for row, docid in inv_index:
    # update signature matrix if needed 
    # THIS IS WHAT YOU NEED TO IMPLEMENT
  
  return sigmatrix, docids
```

## Part IID: MinHash similarity estimate

Write a function that computes the similarity of two documents using the minhash matrix computed above. The function specs are:

- Input: 
  - `id1`, `id2`: document ids
  - `minhash_sigmat`: minhash signature matrix
  - `docids`: list of document ids, used to index the columns of the minhash signature matrix
- Output: Jaccard similarity estimated using minhash

Here is the function skeleton:

```python
def minhash_similarity(id1, id2, minhash_sigmat, docids):
  # get column of the similarity matrix for the two documents
  # calculate the fraction of rows where two columns match
  # return this fraction as the minhash similarity estimate
```

See hint below on comparing numpy arrays

## Part IIE: Put these together

Write a function that given shingled documents computes the Minhash estimated similarities between each pair of documents. This will be similar
to your function for Part ID.

## Part IIF: Experiment 1

Use your function to carry out the following experiment:

What is the effect of the number of hash functions used to compute the Minhash signature on the accuracy of the
Minhash estimate of Jaccard similarity. Carry out this experiment on the 1000 document dataset.

# Part III: Locality-Sensitive Hashing

## Implement LSH

Write a function that implements locality sensitive hashing. Function specifications:

- Input: 
    - `minash_sigmatrix`: a minhash signature matrix
    - `numhashes`: number of hash functions used to construct minhash signature matrix
    - `docids`: list of document ids
    - `threshold` a minimum Jaccard similarity threshold
- Output:
    - a list of hash tables
    
```python
from collections import defaultdict

def do_lsh(minhash_sigmatrix, numhashes, docids, threshold):
  b, _ = choose_nbands(threshold, numhashes)
  r = int(numhashes / b)
  narticles = len(docids)
  hash_func = _make_vector_hash(r)
  
  buckets = []
  for band in range(b):
    start_index = int(b * r)
    end_index = min(start_index + r, numhashes)
    
    cur_buckets = defaultdict(list)
    
    for j in range(narticles):
      # THIS IS WHAT YOU NEED TO IMPLEMENT
    
    buckets.append(cur_buckets)
  
  return buckets
```

## Find candidate similar article pairs

Write a function that uses the result of your LSH function and returns list of candidate article pairs. Spec:

- Input: the result of `do_lsh`
- Output: list of tuples `(docid1, docid2)` each a candidate similar article pair according to LSH

## Experiment 2: LSH sensitivity

Use these functions to compute the sensitivity and specificity of LSH as a function of the `threshold`. Use the 10,000 document dataset to perform this experiment.

# Helpers

## Obtaining data

You can use the following python code to download data for the project

```python
import os
from six.moves import urllib

DOWNLOAD_ROOT = "https://raw.githubusercontent.com/chrisjmccormick/MinHash/master/data"
PLAGIARISM_PATH = "datasets/plagiarism"
DATA_SIZES = [100,1000,2500,10000]

def fetch_data(download_root=DOWNLOAD_ROOT, 
               plagiarism_path=PLAGIARISM_PATH, 
               data_sizes=DATA_SIZES,
               maxsize=1000):
  if not os.path.isdir(plagiarism_path):
      os.makedirs(plagiarism_path)
  for size in data_sizes:
      if size <= maxsize:
          train_file = "articles_" + str(size) + ".train" 
          train_path = plagiarism_path + '/' + train_file
          if not os.path.exists(train_path):
              train_url = download_root + '/' + train_file
              urllib.request.urlretrieve(train_url, train_path)
          
          truth_file = "articles_" + str(size) + ".truth"
          truth_path = plagiarism_path + '/' + truth_file
          if not os.path.exists(truth_path):
              truth_url = download_root + "/" + truth_file
              urllib.request.urlretrieve(truth_url, truth_path)
```

Using the function `fetch_data` will download data to a subdirectory pointed to by the variable `PLAGIARISM_PATH`. You can assign
the path you want to use for your data to taht variable. The `maxsize` argument of the `fetch_data` function is used to limit the size of data downloaded. For testing and development you should use the 1000 document dataset. You can get that with function call `fetch_data(maxsize=1000)`.


## Generating random hash functions

This function generates a random hash function suitable to mimic permutations over 32-bit integers. Recall since we are using `crc32` to represent items
we need random hash functions that generate 32-bit numbers.

```python
import random

def make_random_hash_fn(p=2**33-355, m=4294967295):
    a = random.randint(1,p-1)
    b = random.randint(0, p-1)
    return lambda x: ((a * x + b) % p) % m
```

This is an example of how to use this function:

```python
hash_fn = make_random_hash_fn()
hash_fn(12345)
```

Some notes: this implements a universal hash function for 32-bit integers, which will ensure the result corresponds to a permutation of rows of the 
characteristic matrix as required by Minhash (see https://en.wikipedia.org/wiki/Universal_hashing). Here `m` is the largest number returned by crc32, and `p`
is a prime number larger than `m`.


## Comparing numpy vectors

The following bit of code shows how to use numpy to compare two integer vectors as required to compute the minhash similarity estimate.

```python
# generate two vectors of length 50 with random integers from 0 to 100
a = np.random.randint(100, size=50)
b = np.random.randint(100, size=50)

# compute the fraction of entries in which two vectors are equal
np.mean(a == b)
```

## Choosing the number of bands for LSH

Given a similarity threshold, we need to choose the number of bands to use in LSH. Use this function to do this:

```python
import scipy.optimize as opt
import math

def _choose_nbands(threshold, nhashes):
    error_fun = lambda x: (threshold-((1/x[0])**(x[0]/nhashes)))**2
    res = opt.minimize(error_fun, x0=(10), method='Nelder-Mead')
    b = int(math.ceil(res['x'][0]))
    r = int(n / b)
    final_t = (1/b)**(1/r)
    return b, final_t
```

## Hashing a vector

In LSH for each band we hash the r hash values for each document. We can use this function to generate a hash function for vectors

```python
def _make_vector_hash(num_hashes, m=4294967295):
    hash_fns = make_hashes(num_hashes)
    def _f(vec):
      acc = 0
      for i in range(len(vec)):
        h = hash_fns[i]
        acc += h(vec[i])
        return acc % m
    return _f
```
