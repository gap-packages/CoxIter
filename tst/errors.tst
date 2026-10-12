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

#
gap> STOP_TEST("errors.tst");
