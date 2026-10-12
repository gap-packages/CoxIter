#
# CoxIterGAP: Computation of invariants of hyperbolic Coxeter groups
#
# Implementations
#

InstallValue( _CoxIter_MAXSIZES, [ 4294967295, 65535, 65535 ] );

InstallMethod( CoxIterCompute,
	"Call CoxIter to perform the computations of the invariants",
	[ IsCoxIter ],
	function( ci )
		local ci_file, ci_input, ci_stream, ci_output, row, line, data, fnum, fden;
	
		ci_file := Filename(DirectoriesPackagePrograms("CoxIterGAP"), "coxiter");
		
		# -----------------------------------------
		# Sending information
		ci_input := "";
		ci_stream := OutputTextString(ci_input,true);
		WriteLine(ci_stream,Concatenation("dimension:",String(ci!.iDimension)));
		WriteLine(ci_stream,"matrix:start");
		for row in ci!.iCoxeterMatrix do
			# String(row) would print a range as "[ 1 .. 3 ]"
			WriteLine(ci_stream,JoinStringsWithSeparator(List(row,String),","));
		od;
		WriteLine(ci_stream,"matrix:end");
		WriteLine(ci_stream,"exit");
		CloseStream(ci_stream);
		
		# Not InputOutputLocalProcess: reading from a pseudo terminal may
		# return half a line.
		ci_output := "";
		Process(DirectoryCurrent(),ci_file,InputTextString(ci_input),OutputTextString(ci_output,true),[]);
		
		# -----------------------------------------
		# Reading information
		for line in SplitString(ci_output,"","\n") do
			data := SplitString( line, ":" );
			
			if data[1] = "error" then Error("One error occured: ", data[2] ); return; fi;
			
			if data[1] = "fv" then SetCofinite(ci, EvalString(data[2]));
			elif data[1] = "c" then SetCocompact(ci, EvalString(data[2])); 
			elif data[1] = "euler" then SetEulerCharacteristic(ci, EvalString(data[2]));
			elif data[1] = "fvector" then SetFVector(ci, EvalString(data[2]));
			elif data[1] = "fnum" then fnum := Concatenation( "Product( [", data[2], "], i -> CyclotomicPolynomial(Rationals,i) )" );
			elif data[1] = "fden" then fden := Concatenation( "ValuePol([", data[2], "], X(Rationals))" );
			elif data[1] = "dimensionguessed" then Print( "Dimension was assumed to be ", data[2], "\n" ); 
			fi;
		od;
		
		if not IsBound(fnum) or not IsBound(fden) then
			Error("Unexpected output of the coxiter program: ", ci_output);
		fi;
		
		SetGrowthSeries(ci, [EvalString(fnum),EvalString(fden)] );
		
		# -----------------------------------------
		# Final
		ci!.bInvariantsComputed := true;
	end );
	
InstallMethod( Cofinite,
	"for hyperbolic Coxeter groups", 
	[IsCoxIter and IsCoxIterRep], 
	function(obj)
		if obj!.bInvariantsComputed = false then CoxIterCompute(obj); fi;
		if obj!.bInvariantsComputed = false then return fail; fi;
		
		if HasCofinite(obj) then 
			return Cofinite(obj);
		fi;
	end);
	
InstallMethod( Cocompact,
	"for hyperbolic Coxeter groups", 
	[IsCoxIter and IsCoxIterRep], 
	function(obj)
		if obj!.bInvariantsComputed = false then CoxIterCompute(obj); fi;
		if obj!.bInvariantsComputed = false then return fail; fi;
		
		if HasCocompact(obj) then 
			return Cocompact(obj);
		fi;
	end);
	
InstallMethod( FVector,
	"for hyperbolic Coxeter groups", 
	[IsCoxIter and IsCoxIterRep], 
	function(obj)
		if obj!.bInvariantsComputed = false then CoxIterCompute(obj); fi;
		if obj!.bInvariantsComputed = false then return fail; fi;
		
		if HasFVector(obj) then 
			return FVector(obj);
		fi;
	end);
	
InstallMethod( EulerCharacteristic,
	"for hyperbolic Coxeter groups", 
	[IsCoxIter and IsCoxIterRep], 
	function(obj)
		if obj!.bInvariantsComputed = false then CoxIterCompute(obj); fi;
		if obj!.bInvariantsComputed = false then return fail; fi;
		
		if HasEulerCharacteristic(obj) then 
			return EulerCharacteristic(obj);
		fi;
	end);
	
InstallMethod( GrowthSeries,
	"for hyperbolic Coxeter groups", 
	[IsCoxIter and IsCoxIterRep], 
	function(obj)
		if obj!.bInvariantsComputed = false then CoxIterCompute(obj); fi;
		if obj!.bInvariantsComputed = false then return fail; fi;
		
		if HasGrowthSeries(obj) then 
			return GrowthSeries(obj);
		fi;
	end);

InstallMethod( CreateCoxIterFromCoxeterMatrix,
	"Create `CoxIter' from the Coxeter matrix",
	[ IsMatrix, IsInt ],
	function( M, Dim )
		local size, IsWeight;

		size := Length(M);
		IsWeight := x -> IsInt(x) and 0 <= x and x <= _CoxIter_MAXSIZES[1];
		if not ForAll(M, row -> Length(row) = size and ForAll(row, IsWeight)) or M <> TransposedMat(M) then
			Error("The Coxeter matrix must be a symmetric matrix of non-negative integers");
		fi;

		if Dim < 0 then
			Dim := 0;
		fi;
		
		return Objectify( CoxIterType, rec( iCoxeterMatrix := M, bInvariantsComputed := false, iDimension := Dim, iCofinite := -2, iCocompact := -2, rEulerCharacteristic := 0, iFVector := [] ) );
	end );
	
BindGlobal( "_CoxIter_ExpandSquareMatrix", function( mat, n )
	local cur_mat_size, r, c;
	
	cur_mat_size := Length(mat);
	
	if cur_mat_size > n then
		return;
	fi;
	
	for r in [1..cur_mat_size] do
		for c in [(cur_mat_size+1)..n] do
			mat[r][c] :=  2;
		od;
	od;
	
	for r in [(cur_mat_size+1)..n] do
		mat[r] := [];
		for c in [1..n] do 
			if r=c then	
				mat[r][c] := 1;
			else 
				mat[r][c] := 2;
			fi;
		od;
	od;
end );

InstallMethod( CreateCoxIterFromCoxeterGraph,	
	"Create `CoxIter' from the Coxeter graph",
	[ IsList, IsInt ],
	function( G, Dim )
		local graph_size, i, j, temp_size, starting_vertex, vertex, weight, mat;
		mat := [[1]];
		
		if IsInt(Dim)=false or Dim<0 or Dim>_CoxIter_MAXSIZES[3] then
			Error("Dimension must be a non-negative integer smaller than ", _CoxIter_MAXSIZES[3]);
		fi;
		
		graph_size := Length(G);
		for i in [1..graph_size] do
			if not IsList(G[i]) then
				Error("Ill formed graph");
			fi;

			temp_size := Length( G[i] );
			if temp_size = 0 then
				continue;
			fi;
			
			starting_vertex := G[i][1];
			if IsInt(starting_vertex)=false or starting_vertex<=0 or starting_vertex>_CoxIter_MAXSIZES[2] then
				Error("Incorrect vertex format: ", starting_vertex);
			fi;
			
			if Length(mat) < starting_vertex then
				_CoxIter_ExpandSquareMatrix( mat, starting_vertex );
			fi;
			
			for j in [2..temp_size] do
				if not IsList(G[i][j]) or not Length(G[i][j]) in [1,2] then
					Error("Ill formed graph");
				fi;
				
				vertex := G[i][j][1];
				
				if IsInt(vertex)=false or vertex<=0 or vertex>_CoxIter_MAXSIZES[2] then
					Error("Incorrect vertex format: ", vertex);
				fi;
				
				if Length(mat) < vertex then
					_CoxIter_ExpandSquareMatrix( mat, vertex );
				fi;
				
				if Length(G[i][j]) > 1 then
					weight := G[i][j][2];
					
					if IsInt(weight)=false or weight<0 or weight>_CoxIter_MAXSIZES[1] then
						Error("Weight for edge(",starting_vertex,",",vertex,") is incorrect");
					fi;
					
					if mat[starting_vertex][vertex] <> 2 and mat[starting_vertex][vertex] <> weight then
						Error("Two different weights for edge(",starting_vertex,",",vertex,") given");
					fi;
					
					mat[starting_vertex][vertex] := weight;
					mat[vertex][starting_vertex] := weight;
				fi;
			od;
		od;
		
		temp_size := Length(mat);
		for i in [1..temp_size] do
			mat[i][i] := 1;
		od;
		
		return CreateCoxIterFromCoxeterMatrix(mat, Dim);;
	end );

InstallMethod( ViewObj,	
	"for object in `IsCoxIter'",
	[ IsCoxIter and IsCoxIterRep ],
	function( obj )
		Print( "CoxIter : Coxeter group with ", Length( obj!.iCoxeterMatrix ) , " generators in dimension " );
		if obj!.iDimension > 0 then 
			Print(obj!.iDimension);
		else 
			Print("?");
		fi;
	end );

InstallMethod( PrintObj,
	"for object in `IsCoxIter'",
	[ IsCoxIter and IsCoxIterRep ],
	function( obj )
		Print( "CoxIter : Coxeter group with ", Length( obj!.iCoxeterMatrix ) , " generators in dimension " );
		if obj!.iDimension > 0 then 
			Print(obj!.iDimension);
		else 
			Print("?");
		fi;
	end );
