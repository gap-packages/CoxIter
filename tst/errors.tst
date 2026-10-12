gap> START_TEST("errors.tst");

#
gap> CreateCoxIterFromCoxeterGraph([[1,[2,3]]], -1);
Error, Dimension must be a non-negative integer smaller than 65535
gap> CreateCoxIterFromCoxeterGraph([[1,[2,3]],[2,[1,4]]], 2);
Error, Two different weights for edge(2,1) given
gap> CreateCoxIterFromCoxeterGraph([[1,[2,3,4]]], 2);
Error, Ill formed graph
gap> CreateCoxIterFromCoxeterGraph([[1,[0,3]]], 2);
Error, Incorrect vertex format: 0
gap> CreateCoxIterFromCoxeterGraph([[1,[2,-3]]], 2);
Error, Weight for edge(1,2) is incorrect
gap> CreateCoxIterFromCoxeterGraph([[0,[2,3]]], 2);
Error, Incorrect vertex format: 0
gap> CreateCoxIterFromCoxeterGraph([[1,2]], 2);
Error, Ill formed graph
gap> CreateCoxIterFromCoxeterGraph([[1,[]]], 2);
Error, Ill formed graph
gap> CreateCoxIterFromCoxeterGraph([1,2], 2);
Error, Ill formed graph

#
gap> CreateCoxIterFromCoxeterMatrix([[1,2,3],[2,1,3]], 2);
Error, The Coxeter matrix must be a symmetric matrix of non-negative integers
gap> CreateCoxIterFromCoxeterMatrix([[1,2,3],[2,1]], 2);
Error, The Coxeter matrix must be a symmetric matrix of non-negative integers
gap> CreateCoxIterFromCoxeterMatrix([[1,3],[4,1]], 1);
Error, The Coxeter matrix must be a symmetric matrix of non-negative integers
gap> CreateCoxIterFromCoxeterMatrix([[1,-3],[-3,1]], 1);
Error, The Coxeter matrix must be a symmetric matrix of non-negative integers
gap> CreateCoxIterFromCoxeterMatrix([[1,1/2],[1/2,1]], 1);
Error, The Coxeter matrix must be a symmetric matrix of non-negative integers

# the simplex [4,3,3,5] has dimension 4
gap> ci := CreateCoxIterFromCoxeterGraph(
>   [[1,[2,4]],[2,[3,3]],[3,[4,3]],[4,[5,5]]], 2);;
gap> FVector(ci);
Error, One error occured: The specified graph contains a spherical subgraph wh\
ich has too big rank.

#
gap> STOP_TEST("errors.tst");
