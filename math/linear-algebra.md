# Linear Algebra

## Index

- [1. Foundations and Prerequisites](#1-foundations-and-prerequisites)
  - [1.1 Sets, Functions, and Notation](#11-sets-functions-and-notation)
  - [1.2 Number Systems and Fields](#12-number-systems-and-fields)
  - [1.3 Proof Techniques in Linear Algebra](#13-proof-techniques-in-linear-algebra)
- [2. Vectors in Euclidean Space](#2-vectors-in-euclidean-space)
  - [2.1 Vector Fundamentals](#21-vector-fundamentals)
  - [2.2 Vector Operations](#22-vector-operations)
  - [2.3 Dot Product and Geometry](#23-dot-product-and-geometry)
  - [2.4 Cross Product and Spatial Geometry](#24-cross-product-and-spatial-geometry)
  - [2.5 Lines and Planes](#25-lines-and-planes)
- [3. Systems of Linear Equations](#3-systems-of-linear-equations)
  - [3.1 Linear Systems and Solutions](#31-linear-systems-and-solutions)
  - [3.2 Matrix Representation](#32-matrix-representation)
  - [3.3 Gaussian Elimination](#33-gaussian-elimination)
  - [3.4 Structure of Solution Sets](#34-structure-of-solution-sets)
  - [3.5 Applications of Linear Systems](#35-applications-of-linear-systems)
- [4. Matrix Algebra](#4-matrix-algebra)
  - [4.1 Matrices and Basic Operations](#41-matrices-and-basic-operations)
  - [4.2 Transpose and Special Matrices](#42-transpose-and-special-matrices)
  - [4.3 Matrix Inverses](#43-matrix-inverses)
  - [4.4 Elementary Matrices and Factorizations](#44-elementary-matrices-and-factorizations)
  - [4.5 Block Matrices](#45-block-matrices)
- [5. Determinants](#5-determinants)
  - [5.1 Definition and Computation](#51-definition-and-computation)
  - [5.2 Properties of Determinants](#52-properties-of-determinants)
  - [5.3 Applications of Determinants](#53-applications-of-determinants)
- [6. Vector Spaces](#6-vector-spaces)
  - [6.1 Abstract Vector Spaces](#61-abstract-vector-spaces)
  - [6.2 Subspaces](#62-subspaces)
  - [6.3 Linear Independence](#63-linear-independence)
  - [6.4 Basis and Dimension](#64-basis-and-dimension)
  - [6.5 Coordinates and Change of Basis](#65-coordinates-and-change-of-basis)
  - [6.6 Fundamental Subspaces of a Matrix](#66-fundamental-subspaces-of-a-matrix)
- [7. Linear Transformations](#7-linear-transformations)
  - [7.1 Definition and Examples](#71-definition-and-examples)
  - [7.2 Matrix Representations](#72-matrix-representations)
  - [7.3 Kernel, Image, and Structure](#73-kernel-image-and-structure)
  - [7.4 Spaces of Linear Maps and Duality](#74-spaces-of-linear-maps-and-duality)
  - [7.5 Quotient Spaces](#75-quotient-spaces)
- [8. Eigenvalues and Eigenvectors](#8-eigenvalues-and-eigenvectors)
  - [8.1 Eigenvalue Fundamentals](#81-eigenvalue-fundamentals)
  - [8.2 Diagonalization](#82-diagonalization)
  - [8.3 Advanced Eigenstructure](#83-advanced-eigenstructure)
  - [8.4 Applications of Eigenvalues](#84-applications-of-eigenvalues)
- [9. Inner Product Spaces and Orthogonality](#9-inner-product-spaces-and-orthogonality)
  - [9.1 Inner Products](#91-inner-products)
  - [9.2 Orthogonal Sets and Bases](#92-orthogonal-sets-and-bases)
  - [9.3 Gram-Schmidt and QR](#93-gram-schmidt-and-qr)
  - [9.4 Orthogonal and Unitary Matrices](#94-orthogonal-and-unitary-matrices)
  - [9.5 Least Squares Approximation](#95-least-squares-approximation)
- [10. Symmetric Matrices and Quadratic Forms](#10-symmetric-matrices-and-quadratic-forms)
  - [10.1 Spectral Theory](#101-spectral-theory)
  - [10.2 Quadratic Forms](#102-quadratic-forms)
  - [10.3 Definiteness and Optimization](#103-definiteness-and-optimization)
- [11. Singular Value Decomposition and Matrix Analysis](#11-singular-value-decomposition-and-matrix-analysis)
  - [11.1 Singular Value Decomposition](#111-singular-value-decomposition)
  - [11.2 Applications of SVD](#112-applications-of-svd)
  - [11.3 Matrix Norms and Conditioning](#113-matrix-norms-and-conditioning)
- [12. Numerical and Computational Linear Algebra](#12-numerical-and-computational-linear-algebra)
  - [12.1 Direct Methods](#121-direct-methods)
  - [12.2 Iterative Methods for Linear Systems](#122-iterative-methods-for-linear-systems)
  - [12.3 Eigenvalue Algorithms](#123-eigenvalue-algorithms)
- [13. Advanced Topics and Applications](#13-advanced-topics-and-applications)
  - [13.1 Multilinear Algebra](#131-multilinear-algebra)
  - [13.2 Positive Matrices and Graph Theory](#132-positive-matrices-and-graph-theory)
  - [13.3 Linear Algebra in Applied Domains](#133-linear-algebra-in-applied-domains)
  - [13.4 Connections to Further Mathematics](#134-connections-to-further-mathematics)

---

<a id="1-foundations-and-prerequisites"></a>
## 1. Foundations and Prerequisites

<a id="11-sets-functions-and-notation"></a>
### 1.1 Sets, Functions, and Notation

#### Set Notation and Operations

#### Functions, Domain, and Codomain

#### Injective, Surjective, and Bijective Maps

#### Summation and Index Notation

#### Mathematical Induction

<a id="12-number-systems-and-fields"></a>
### 1.2 Number Systems and Fields

#### Real Numbers

#### Complex Numbers and Arithmetic

#### Complex Conjugate and Modulus

#### Definition of a Field

#### Finite Fields and Modular Arithmetic

<a id="13-proof-techniques-in-linear-algebra"></a>
### 1.3 Proof Techniques in Linear Algebra

#### Direct Proof and Contrapositive

#### Proof by Contradiction

#### If and Only If Statements

#### Counterexamples and Existence Proofs

<a id="2-vectors-in-euclidean-space"></a>
## 2. Vectors in Euclidean Space

<a id="21-vector-fundamentals"></a>
### 2.1 Vector Fundamentals

#### Vectors in R^2 and R^3

#### Vectors in R^n

#### Geometric vs. Algebraic Interpretation

#### Position Vectors and Points

<a id="22-vector-operations"></a>
### 2.2 Vector Operations

#### Vector Addition and Subtraction

#### Scalar Multiplication

#### Algebraic Properties of Vector Operations

#### Linear Combinations of Vectors

<a id="23-dot-product-and-geometry"></a>
### 2.3 Dot Product and Geometry

#### Dot Product Definition

#### Norm and Length of a Vector

#### Angle Between Vectors

#### Orthogonality

#### Cauchy-Schwarz Inequality

#### Triangle Inequality

#### Vector Projection

<a id="24-cross-product-and-spatial-geometry"></a>
### 2.4 Cross Product and Spatial Geometry

#### Cross Product in R^3

#### Geometric Meaning and Right-Hand Rule

#### Scalar Triple Product

#### Area and Volume Interpretations

<a id="25-lines-and-planes"></a>
### 2.5 Lines and Planes

#### Parametric Equations of Lines

#### Vector Equation of a Plane

#### Normal Vectors and Scalar Equations

#### Distance from Point to Line and Plane

#### Intersections of Lines and Planes

<a id="3-systems-of-linear-equations"></a>
## 3. Systems of Linear Equations

<a id="31-linear-systems-and-solutions"></a>
### 3.1 Linear Systems and Solutions

#### Linear Equations in n Variables

#### Systems of Linear Equations

#### Consistent and Inconsistent Systems

#### Geometric Interpretation of Solution Sets

#### Unique, Infinite, and No Solutions

<a id="32-matrix-representation"></a>
### 3.2 Matrix Representation

#### Coefficient Matrix

#### Augmented Matrix

#### Matrix-Vector Form Ax = b

#### Vector Equation Form

<a id="33-gaussian-elimination"></a>
### 3.3 Gaussian Elimination

#### Elementary Row Operations

#### Row Echelon Form

#### Reduced Row Echelon Form

#### Gaussian Elimination Algorithm

#### Gauss-Jordan Elimination

#### Pivot Positions and Pivot Columns

<a id="34-structure-of-solution-sets"></a>
### 3.4 Structure of Solution Sets

#### Free Variables and Basic Variables

#### Parametric Vector Form of Solutions

#### Homogeneous Systems

#### Nonhomogeneous Systems and Particular Solutions

#### Rank and Number of Solutions

<a id="35-applications-of-linear-systems"></a>
### 3.5 Applications of Linear Systems

#### Network and Traffic Flow

#### Electrical Circuits and Kirchhoff's Laws

#### Chemical Equation Balancing

#### Polynomial Interpolation

#### Leontief Input-Output Models

<a id="4-matrix-algebra"></a>
## 4. Matrix Algebra

<a id="41-matrices-and-basic-operations"></a>
### 4.1 Matrices and Basic Operations

#### Matrix Definition and Notation

#### Matrix Addition and Scalar Multiplication

#### Matrix Multiplication

#### Properties and Non-Commutativity

#### Powers of a Matrix

<a id="42-transpose-and-special-matrices"></a>
### 4.2 Transpose and Special Matrices

#### Matrix Transpose and Properties

#### Identity and Zero Matrices

#### Diagonal and Scalar Matrices

#### Triangular Matrices

#### Symmetric and Skew-Symmetric Matrices

#### Conjugate Transpose and Hermitian Matrices

<a id="43-matrix-inverses"></a>
### 4.3 Matrix Inverses

#### Definition of the Inverse

#### Invertibility of 2x2 Matrices

#### Computing Inverses by Row Reduction

#### Properties of Inverses

#### Solving Systems with Inverses

#### Singular vs. Nonsingular Matrices

<a id="44-elementary-matrices-and-factorizations"></a>
### 4.4 Elementary Matrices and Factorizations

#### Elementary Matrices

#### Row Operations as Matrix Products

#### LU Decomposition

#### PLU Decomposition with Pivoting

#### Solving Systems via LU

<a id="45-block-matrices"></a>
### 4.5 Block Matrices

#### Partitioned Matrix Notation

#### Block Addition and Multiplication

#### Block Diagonal and Block Triangular Forms

#### Block Inverses and Schur Complements

<a id="5-determinants"></a>
## 5. Determinants

<a id="51-definition-and-computation"></a>
### 5.1 Definition and Computation

#### Determinants of 2x2 and 3x3 Matrices

#### Minors and Cofactors

#### Cofactor Expansion

#### Determinants of Triangular Matrices

<a id="52-properties-of-determinants"></a>
### 5.2 Properties of Determinants

#### Effect of Row Operations

#### Determinant of a Product

#### Determinant of Transpose and Inverse

#### Multilinearity and Alternating Property

#### Determinants via Row Reduction

<a id="53-applications-of-determinants"></a>
### 5.3 Applications of Determinants

#### Invertibility Criterion

#### Cramer's Rule

#### Adjugate Matrix and Inverse Formula

#### Area, Volume, and Orientation

#### Jacobian and Change of Variables

<a id="6-vector-spaces"></a>
## 6. Vector Spaces

<a id="61-abstract-vector-spaces"></a>
### 6.1 Abstract Vector Spaces

#### Vector Space Axioms

#### Examples: R^n, Polynomials, Matrices, Functions

#### Elementary Consequences of the Axioms

#### Vector Spaces over Complex and General Fields

<a id="62-subspaces"></a>
### 6.2 Subspaces

#### Definition and Subspace Test

#### Examples and Non-Examples

#### Intersections and Sums of Subspaces

#### Direct Sums

#### Span of a Set as a Subspace

<a id="63-linear-independence"></a>
### 6.3 Linear Independence

#### Linear Combinations and Span

#### Linear Independence and Dependence

#### Testing Independence via Row Reduction

#### Dependence Relations

#### Wronskian for Functions

<a id="64-basis-and-dimension"></a>
### 6.4 Basis and Dimension

#### Definition of a Basis

#### Standard Bases

#### Spanning Sets and Basis Extraction

#### Extending to a Basis

#### Dimension of a Vector Space

#### Dimension of Subspaces

<a id="65-coordinates-and-change-of-basis"></a>
### 6.5 Coordinates and Change of Basis

#### Coordinate Vectors Relative to a Basis

#### Coordinate Mapping and Isomorphism to R^n

#### Change of Basis Matrix

#### Transition Between Bases

<a id="66-fundamental-subspaces-of-a-matrix"></a>
### 6.6 Fundamental Subspaces of a Matrix

#### Column Space

#### Row Space

#### Null Space

#### Left Null Space

#### Rank and Nullity

#### Rank-Nullity Theorem

#### Orthogonality Relations Among the Four Subspaces

<a id="7-linear-transformations"></a>
## 7. Linear Transformations

<a id="71-definition-and-examples"></a>
### 7.1 Definition and Examples

#### Linear Map Definition and Properties

#### Geometric Transformations in R^2

#### Rotations, Reflections, Shears, and Scalings

#### Projections

#### Differentiation and Integration as Linear Maps

<a id="72-matrix-representations"></a>
### 7.2 Matrix Representations

#### Standard Matrix of a Transformation

#### Matrix Relative to Arbitrary Bases

#### Composition and Matrix Multiplication

#### Similarity and Change of Basis for Operators

<a id="73-kernel-image-and-structure"></a>
### 7.3 Kernel, Image, and Structure

#### Kernel of a Linear Map

#### Image and Range

#### Rank-Nullity for Linear Maps

#### Injectivity, Surjectivity, and Invertibility

#### Isomorphisms of Vector Spaces

<a id="74-spaces-of-linear-maps-and-duality"></a>
### 7.4 Spaces of Linear Maps and Duality

#### The Vector Space L(V, W)

#### Linear Functionals

#### Dual Space and Dual Basis

#### Transpose of a Linear Map

#### Annihilators

<a id="75-quotient-spaces"></a>
### 7.5 Quotient Spaces

#### Cosets and Quotient Construction

#### Dimension of a Quotient Space

#### First Isomorphism Theorem

<a id="8-eigenvalues-and-eigenvectors"></a>
## 8. Eigenvalues and Eigenvectors

<a id="81-eigenvalue-fundamentals"></a>
### 8.1 Eigenvalue Fundamentals

#### Definition of Eigenvalues and Eigenvectors

#### Eigenspaces

#### Characteristic Polynomial

#### Computing Eigenvalues and Eigenvectors

#### Algebraic vs. Geometric Multiplicity

#### Complex Eigenvalues

<a id="82-diagonalization"></a>
### 8.2 Diagonalization

#### Similar Matrices and Invariants

#### Diagonalizability Criteria

#### Eigenbasis Construction

#### Diagonalization Procedure

#### Powers of Diagonalizable Matrices

#### Matrix Exponential

<a id="83-advanced-eigenstructure"></a>
### 8.3 Advanced Eigenstructure

#### Invariant Subspaces

#### Triangularization and Schur Decomposition

#### Cayley-Hamilton Theorem

#### Minimal Polynomial

#### Generalized Eigenvectors

#### Jordan Canonical Form

#### Rational Canonical Form

<a id="84-applications-of-eigenvalues"></a>
### 8.4 Applications of Eigenvalues

#### Discrete Dynamical Systems

#### Markov Chains and Steady States

#### Systems of Linear Differential Equations

#### Population and Growth Models

#### PageRank and Network Centrality

<a id="9-inner-product-spaces-and-orthogonality"></a>
## 9. Inner Product Spaces and Orthogonality

<a id="91-inner-products"></a>
### 9.1 Inner Products

#### Inner Product Axioms

#### Real and Complex Inner Products

#### Induced Norms and Distance

#### Weighted and Function Space Inner Products

#### Angles and Orthogonality in General Spaces

<a id="92-orthogonal-sets-and-bases"></a>
### 9.2 Orthogonal Sets and Bases

#### Orthogonal and Orthonormal Sets

#### Orthonormal Bases and Coordinates

#### Orthogonal Projection onto a Subspace

#### Orthogonal Complements

#### Orthogonal Decomposition Theorem

<a id="93-gram-schmidt-and-qr"></a>
### 9.3 Gram-Schmidt and QR

#### Gram-Schmidt Process

#### Modified Gram-Schmidt for Stability

#### QR Decomposition

#### Householder Reflections

#### Givens Rotations

<a id="94-orthogonal-and-unitary-matrices"></a>
### 9.4 Orthogonal and Unitary Matrices

#### Orthogonal Matrices and Properties

#### Unitary Matrices

#### Isometries and Norm Preservation

#### Rotation Groups and Orthogonal Groups

<a id="95-least-squares-approximation"></a>
### 9.5 Least Squares Approximation

#### Least Squares Problem

#### Normal Equations

#### Least Squares via QR

#### Linear Regression and Curve Fitting

#### Pseudoinverse and Minimum Norm Solutions

#### Fourier Series as Orthogonal Projection

<a id="10-symmetric-matrices-and-quadratic-forms"></a>
## 10. Symmetric Matrices and Quadratic Forms

<a id="101-spectral-theory"></a>
### 10.1 Spectral Theory

#### Properties of Symmetric Matrices

#### Spectral Theorem for Real Symmetric Matrices

#### Orthogonal Diagonalization

#### Spectral Theorem for Hermitian Matrices

#### Normal Matrices

#### Spectral Decomposition and Rank-One Sums

<a id="102-quadratic-forms"></a>
### 10.2 Quadratic Forms

#### Quadratic Forms and Matrix Representation

#### Change of Variable and Principal Axes Theorem

#### Classification of Conics and Quadric Surfaces

#### Congruence and Sylvester's Law of Inertia

<a id="103-definiteness-and-optimization"></a>
### 10.3 Definiteness and Optimization

#### Positive Definite and Semidefinite Matrices

#### Tests for Definiteness

#### Cholesky Decomposition

#### Constrained Optimization of Quadratic Forms

#### Rayleigh Quotient and Courant-Fischer Theorem

<a id="11-singular-value-decomposition-and-matrix-analysis"></a>
## 11. Singular Value Decomposition and Matrix Analysis

<a id="111-singular-value-decomposition"></a>
### 11.1 Singular Value Decomposition

#### Singular Values and Singular Vectors

#### Full and Reduced SVD

#### Geometric Interpretation of SVD

#### SVD and the Four Fundamental Subspaces

#### Computing the SVD

<a id="112-applications-of-svd"></a>
### 11.2 Applications of SVD

#### Low-Rank Approximation and Eckart-Young Theorem

#### Moore-Penrose Pseudoinverse

#### Image Compression

#### Principal Component Analysis

#### Latent Semantic Analysis

#### Noise Filtering and Denoising

<a id="113-matrix-norms-and-conditioning"></a>
### 11.3 Matrix Norms and Conditioning

#### Vector Norms

#### Induced and Frobenius Matrix Norms

#### Spectral Radius

#### Condition Number

#### Sensitivity and Error Bounds

#### Numerical Stability of Algorithms

<a id="12-numerical-and-computational-linear-algebra"></a>
## 12. Numerical and Computational Linear Algebra

<a id="121-direct-methods"></a>
### 12.1 Direct Methods

#### Floating Point Arithmetic and Roundoff

#### Pivoting Strategies

#### Operation Counts and Complexity

#### Sparse Matrix Storage and Solvers

<a id="122-iterative-methods-for-linear-systems"></a>
### 12.2 Iterative Methods for Linear Systems

#### Jacobi Method

#### Gauss-Seidel Method

#### Successive Over-Relaxation

#### Convergence Criteria

#### Conjugate Gradient Method

#### Preconditioning

<a id="123-eigenvalue-algorithms"></a>
### 12.3 Eigenvalue Algorithms

#### Power Method

#### Inverse and Shifted Power Iteration

#### QR Algorithm

#### Krylov Subspaces and Arnoldi Iteration

#### Lanczos Method

<a id="13-advanced-topics-and-applications"></a>
## 13. Advanced Topics and Applications

<a id="131-multilinear-algebra"></a>
### 13.1 Multilinear Algebra

#### Bilinear and Sesquilinear Forms

#### Tensor Products of Vector Spaces

#### Tensors and Index Notation

#### Exterior Algebra and Wedge Products

#### Kronecker Product and Vectorization

<a id="132-positive-matrices-and-graph-theory"></a>
### 13.2 Positive Matrices and Graph Theory

#### Nonnegative Matrices

#### Perron-Frobenius Theorem

#### Adjacency and Incidence Matrices

#### Graph Laplacian

#### Spectral Clustering

<a id="133-linear-algebra-in-applied-domains"></a>
### 13.3 Linear Algebra in Applied Domains

#### Computer Graphics and Homogeneous Coordinates

#### Cryptography and Coding Theory

#### Linear Programming and the Simplex Method

#### Signal Processing and Discrete Fourier Transform

#### Machine Learning Foundations

#### Quantum State Spaces

<a id="134-connections-to-further-mathematics"></a>
### 13.4 Connections to Further Mathematics

#### Modules over Rings

#### Group Representations

#### Infinite-Dimensional Spaces and Hilbert Spaces

#### Operator Theory Preview

#### Linear Algebra in Differential Geometry
