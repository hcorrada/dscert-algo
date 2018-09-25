---
title: Gradient Descent Homework
author: CMSC643
geometry: margin=1in
fontfamily: utopia
---

Name(s):  
UID(s):

1. Write the gradient of Residual Sum of Squares (RSS) loss

$$
L(b, \mathbf{w}) = \frac{1}{2} \sum_{i=1}^n \left[ y_i - (b + \mathbf{w}'\mathbf{x}_i) \right] ^2
$$

2. Write the gradient descent update equations to minimize RSS

3. Write the gradient of _regularized_ RSS loss 

$$
L(b, \mathbf{w}) = \frac{1}{2} \sum_{i=1}^n \left[ y_i - (b + \mathbf{w}'\mathbf{x}_i) \right] ^2 + \frac{\lambda}{2} \| \mathbf{w} \|^2
$$

4. Write the gradient descent update equations to minimize _regularized_ RSS

5. Write the gradient of SVM loss (regularized hinge-loss)

$$
L(b, \mathbf{w}) = \sum_{i=1}^n \left[ 1 - y_i(b + \mathbf{w}'\mathbf{x}_i) \right]_{+} + \frac{\lambda}{2} \| \mathbf{w} \|^2
$$

6. Write the gradient descent update equations to fit a linear SVM (minimize regularized hinge-loss)
