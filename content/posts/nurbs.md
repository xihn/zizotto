+++
title = "Non-Uniform Rational B-Splines"
date = 2025-02-21
[extra]
    katex_enable = true
    toc = true
+++

## 1. **NURBS Curve Definition**

A **NURBS curve** of degree \\( p \\) is defined as:

{% math() %}
\mathbf{C}(u) = \frac{\sum_{i=0}^{n} N_{i,p}(u) w_i \mathbf{P}_i}{\sum_{i=0}^{n} N_{i,p}(u) w_i}, \quad u \in [u_0, u_m]
{% end %}


Where:
- \\( \mathbf{P}_i \\): Control points
- \\( w_i \\): Weights (positive real numbers)
- \\( N_{i,p}(u) \\): B-spline basis functions of degree \\( p \\)
- \\( u \\): Parameter value
- \\( n \\): Number of control points - 1
- \\( m \\): Number of knots - 1
- \\( [u_0, u_m] \\): Domain of the curve (defined by the knot vector)



## 2. **B-spline Basis Functions**

B-spline basis functions are defined **recursively** using the **Cox–de Boor recursion formula**:

### Base case (degree 0):

\\[
N_{i,0}(u) =
\begin{cases}
1 & \text{if } u_i \le u < u_{i+1} \\
0 & \text{otherwise}
\end{cases}
\\]

### Recursive case (degree \\( p > 0 \\)):
\\[
N_{i,p}(u) = \frac{u - u_i}{u_{i+p} - u_i} N_{i,p-1}(u) + \frac{u_{i+p+1} - u}{u_{i+p+1} - u_{i+1}} N_{i+1,p-1}(u)
\\]

(With the convention that any term with a zero denominator is taken to be zero.)



## 3. **Knot Vector**

A **non-decreasing sequence**:

\\[
\mathbf{U} = \{ u_0, u_1, \dots, u_m \}, \quad u_i \le u_{i+1}
\\]

- The **length** of the knot vector is \\( m + 1 \\)
- For a curve of degree \\( p \\) with \\( n + 1 \\) control points:
  \\[
  m = n + p + 1
  \\]
- Uniform/non-uniform, open/closed knot vectors all influence the shape and continuity.



## 4. **Homogeneous Coordinates (optional)**

NURBS can be viewed as **projective transformation of B-splines** using homogeneous coordinates:

\\[
\mathbf{P}_i^h = w_i \mathbf{P}_i = (w_i x_i, w_i y_i, w_i z_i, w_i)
\\]

Evaluate the curve in homogeneous space and project back:

\\[
\mathbf{C}^h(u) = \sum_{i=0}^{n} N_{i,p}(u) \mathbf{P}_i^h
\quad \Rightarrow \quad
\mathbf{C}(u) = \frac{(x_h, y_h, z_h)}{w_h}
\\]



## 5. **Derivatives of NURBS Curves**

If \\( \mathbf{C}(u) \\) is a NURBS curve:

{% math() %}
\mathbf{C}'(u) = \frac{d}{du} \left( \frac{\sum_i N_{i,p}(u) w_i \mathbf{P}_i}{\sum_j N_{j,p}(u) w_j} \right)
{% end %}

Use the quotient rule:
{% math() %}
\mathbf{C}'(u) = \frac{ \sum_i N_{i,p}'(u) w_i \mathbf{P}_i \cdot W(u) - \sum_i N_{i,p}(u) w_i \mathbf{P}_i \cdot W'(u) }{ W(u)^2 }
{% end %}
Where:
- \\( W(u) = \sum_j N_{j,p}(u) w_j \\)
- \\( W'(u) = \sum_j N_{j,p}'(u) w_j \\)



## 6. **Important Properties**

- **Affine invariance** (unlike rational Bézier)
- **Local control**: Modifying \\( \mathbf{P}_i \\) only affects curve in \\( [u_i, u_{i+p+1}] \\)
- **Continuity**: Depends on knot multiplicity \\( m \\): if a knot has multiplicity \\( r \\), the continuity at that knot is \\( C^{p-r} \\)
