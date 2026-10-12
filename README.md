[![CI](https://github.com/gap-packages/CoxIter/actions/workflows/CI.yml/badge.svg)](https://github.com/gap-packages/CoxIter/actions/workflows/CI.yml)
[![Code Coverage](https://codecov.io/github/gap-packages/CoxIter/coverage.svg?branch=master&token=)](https://codecov.io/gh/gap-packages/CoxIter)

# The GAP package CoxIter

This package computes invariants of hyperbolic Coxeter groups: the Euler
characteristic, the f-vector of the associated polyhedron, the growth series,
and whether the group is cofinite or cocompact.

It is an interface to the C++ program
[CoxIter](https://github.com/rgugliel/CoxIter) by Rafael Guglielmetti, whose
source code it includes. The mathematics is described in

> R. Guglielmetti, *CoxIter - Computing invariants of hyperbolic Coxeter
> groups*, LMS J. Comput. Math. 18 (2015), 754-773,
> <https://doi.org/10.1112/S1461157015000273>.

## Installation

The program must be compiled. This needs a C++11 compiler and
[GMP](https://gmplib.org) with its C++ bindings (`gmpxx`). PCRE, which the
standalone CoxIter uses, is not needed.

| System                | Command                                |
|-----------------------|----------------------------------------|
| Debian, Ubuntu, Mint  | `sudo apt-get install g++ libgmp-dev`  |
| Fedora                | `sudo dnf install gcc-c++ gmp-devel`   |
| macOS with Homebrew   | `brew install gmp`                     |

Then run the following in the `pkg` directory of your GAP installation:

    git clone https://github.com/gap-packages/CoxIter
    cd CoxIter
    ./configure
    make

If the package is located elsewhere, pass the path of the GAP root directory
to `./configure`.

## Giving a hyperbolic Coxeter group

To specify a Coxeter group, describe its Coxeter graph by a list containing
the neighbours of every vertex, together with the weights. For example, the
group F_4 is given by

    [[1,[2,3]],[2,[3,4]],[3,[4,3]]]

and the group D_4 by

    [[1,[2,3]],[2,[3,3],[4,3]]]

A weight 0 corresponds to a bold line in the graph (parallel hyperplanes) and
a weight 1 to a dotted line (ultra-parallel hyperplanes).

## A first example

`CreateCoxIterFromCoxeterGraph` creates a CoxIter object from a graph. Its
second argument is the dimension of the space, or 0 if it is unknown. The
cocompact hyperbolic Coxeter group in dimension 8 found by Bugaenko is

    gap> LoadPackage("CoxIter");
    true
    gap> ci := CreateCoxIterFromCoxeterGraph([[1,[2,5]],[2,[3,3]],[3,[4,3]],
    >   [4,[5,3],[10,3]],[5,[6,3]],[6,[7,3],[11,3]],[7,[8,3]],[8,[9,5]],
    >   [10,[11,1]]], 8);
    CoxIter : Coxeter group with 11 generators in dimension 8

The following invariants are then available:

| Function              | Result                                             |
|-----------------------|----------------------------------------------------|
| `FVector`             | the f-vector, a list                               |
| `Cocompact`           | 1 (yes), 0 (no), -1 (unable to decide)             |
| `Cofinite`            | 1 (yes), 0 (no), -1 (unable to decide)             |
| `EulerCharacteristic` | a rational number                                  |
| `GrowthSeries`        | a list `[f,g]` of polynomials, the series is `f/g` |

For the example:

    gap> FVector(ci);
    [ 41, 164, 316, 374, 294, 156, 54, 11, 1 ]
    gap> Cocompact(ci);
    1
    gap> Cofinite(ci);
    1
    gap> EulerCharacteristic(ci);
    24187/8709120000
    gap> g := GrowthSeries(ci);;
    gap> Value(g[2],1)/Value(g[1],1) - EulerCharacteristic(ci);
    0

## Bug reports and feature requests

Please submit them to the
[issue tracker](https://github.com/gap-packages/CoxIter/issues).

## License

CoxIter is free software; you can redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free Software
Foundation; either version 3 of the License, or (at your option) any later
version. See the file `LICENSE` for details.
