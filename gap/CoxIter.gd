#
# CoxIterGAP: Computation of invariants of hyperbolic Coxeter groups
#
# Declarations
#

BindGlobal( "CoxIterFamily", NewFamily("CoxIterFamily") );

DeclareCategory( "IsCoxIter", IsObject );

DeclareRepresentation( "IsCoxIterRep", IsComponentObjectRep and IsAttributeStoringRep, [ "iCoxeterMatrix", "iDimension", "bInvariantsComputed", "iCofinite", "iCocompact", "iFVector", "rEulerCharacteristic", "pGrowthSeries" ]);

BindGlobal( "CoxIterType", NewType( CoxIterFamily, IsCoxIter and IsCoxIterRep ) );

#! @Chapter Functions

#! @Section Creating a CoxIter object

#! @Arguments gr, dim
#! @Returns a CoxIter object
#! @Label
#! @Description
#! Creates a CoxIter object from the Coxeter graph <A>gr</A>, encoded as
#! described in <Ref Subsect="subsection:encoding"/>. If the dimension
#! <A>dim</A> is unknown, 0 can be given.
DeclareOperation( "CreateCoxIterFromCoxeterGraph", [ IsList, IsInt ] );

#! @Arguments mat, dim
#! @Returns a CoxIter object
#! @Label
#! @Description
#! Creates a CoxIter object from the Coxeter matrix <A>mat</A>, encoded as
#! described in <Ref Subsect="subsection:encoding"/>. If the dimension
#! <A>dim</A> is unknown, 0 can be given.
DeclareOperation( "CreateCoxIterFromCoxeterMatrix", [ IsMatrix, IsInt ] );

#! @Section Invariants

#! @Arguments ci
#! @Returns 1 (cofinite), 0 (not cofinite), -1 (cannot decide)
#! @Description
#! Test whether the group is cofinite or not.
DeclareAttribute( "Cofinite", IsCoxIter );

#! @Arguments ci
#! @Returns 1 (cocompact), 0 (not cocompact), -1 (cannot decide)
#! @Description
#! Test whether the group is cocompact or not.
DeclareAttribute( "Cocompact", IsCoxIter );

#! @Arguments ci
#! @Returns the Euler characteristic
#! @Description
#! Compute the Euler characteristic
DeclareAttribute( "EulerCharacteristic", IsCoxIter );

#! @Arguments ci
#! @Returns the f-vector of the associated polyhedron
#! @Description
#! Compute the f-vector of the associated polyhedron
DeclareAttribute( "FVector", IsCoxIter );

#! @Arguments ci
#! @Returns [f,g] where f/g is the rational expansion of the growth series
#! @Description
#! Compute the rational expansion of the growth series
DeclareAttribute( "GrowthSeries", IsCoxIter );

#! @Arguments ci
#! @Description
#! Compute all invariants of the CoxIter object <A>ci</A>. The attributes
#! above call this when needed.
DeclareOperation( "CoxIterCompute", [ IsCoxIter ] );

DeclareGlobalVariable( "_CoxIter_MAXSIZES", "Maximum: weight for an edge, index for a vertex, dimension" );
