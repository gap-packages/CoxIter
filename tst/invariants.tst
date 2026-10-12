gap> START_TEST("invariants.tst");

# the compact simplex [4,3,3,5], given by its Coxeter graph
gap> ci := CreateCoxIterFromCoxeterGraph(
>   [[1,[2,4]],[2,[3,3]],[3,[4,3]],[4,[5,5]]], 4);
CoxIter : Coxeter group with 5 generators in dimension 4
gap> EulerCharacteristic(ci);
17/28800
gap> Cocompact(ci);
1
gap> Cofinite(ci);
1
gap> FVector(ci);
[ 5, 10, 10, 5, 1 ]
gap> g := GrowthSeries(ci);;
gap> List(g, Degree);
[ 64, 64 ]
gap> Value(g[2], 1) / Value(g[1], 1);
17/28800

# the same group, given by its Coxeter matrix
gap> ci := CreateCoxIterFromCoxeterMatrix(
>   [[1,4,2,2,2],[4,1,3,2,2],[2,3,1,3,2],[2,2,3,1,5],[2,2,2,5,1]], 4);
CoxIter : Coxeter group with 5 generators in dimension 4
gap> EulerCharacteristic(ci);
17/28800
gap> FVector(ci);
[ 5, 10, 10, 5, 1 ]

# the triangle group (2,3,7); a row of the matrix may be a range
gap> ci := CreateCoxIterFromCoxeterMatrix([[1..3],[2,1,7],[3,7,1]], 2);;
gap> EulerCharacteristic(ci);
-1/84

# an unknown dimension is guessed
gap> ci := CreateCoxIterFromCoxeterGraph(
>   [[1,[2,4]],[2,[3,3]],[3,[4,3]],[4,[5,5]]], 0);
CoxIter : Coxeter group with 5 generators in dimension ?
gap> FVector(ci);
Dimension was assumed to be 4
[ 5, 10, 10, 5, 1 ]

# Bugaenko's cocompact group in dimension 8
gap> ci := CreateCoxIterFromCoxeterGraph([[1,[2,5]],[2,[3,3]],[3,[4,3]],
>   [4,[5,3],[10,3]],[5,[6,3]],[6,[7,3],[11,3]],[7,[8,3]],[8,[9,5]],
>   [10,[11,1]]], 8);
CoxIter : Coxeter group with 11 generators in dimension 8
gap> Cofinite(ci);
1
gap> Cocompact(ci);
1
gap> FVector(ci);
[ 41, 164, 316, 374, 294, 156, 54, 11, 1 ]
gap> EulerCharacteristic(ci);
24187/8709120000
gap> g := GrowthSeries(ci);;
gap> Value(g[2], 1) / Value(g[1], 1);
24187/8709120000

# the ideal triangle: weight 0 encodes parallel hyperplanes
gap> ci := CreateCoxIterFromCoxeterGraph([[1,[2,0],[3,0]],[2,[3,0]]], 2);;
gap> [ Cofinite(ci), Cocompact(ci), EulerCharacteristic(ci), FVector(ci) ];
[ 1, 0, -1/2, [ 3, 3, 1 ] ]

# weight 1 encodes ultra-parallel hyperplanes: infinite covolume
gap> ci := CreateCoxIterFromCoxeterGraph([[1,[2,1],[3,1]],[2,[3,1]]], 2);;
gap> [ Cofinite(ci), Cocompact(ci), EulerCharacteristic(ci), FVector(ci) ];
[ 0, 0, -1/2, [ 0, 3, 1 ] ]

#
gap> STOP_TEST("invariants.tst");
