gap> START_TEST("globals.tst");

#
gap> Filtered([ "CoxIterFamily", "IsCoxIterRep", "CoxIterType" ],
>   name -> not IsReadOnlyGlobal(name));
[  ]
gap> IsBoundGlobal("ExpandSquareMatrix");
false

#
gap> STOP_TEST("globals.tst");
