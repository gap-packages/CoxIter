#
# CoxIter: Computation of invariants of hyperbolic Coxeter groups
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "CoxIter",
Subtitle := "Computation of invariants of hyperbolic Coxeter groups",
Version := "1.1.0dev",
Date := "12/10/2026", # dd/mm/yyyy format
License := "GPL-3.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := false,
    FirstNames := "Rafael",
    LastName := "Guglielmetti",
    WWWHome := "https://rgug.ch",
    Email := "rafael@rgug.ch",
    GitHubUsername := "rgugliel",
  ),
  rec(
    LastName      := "GAP Team",
    FirstNames    := "The",
    IsAuthor      := false,
    IsMaintainer  := true,
    Email         := "support@gap-system.org",
  ),
],

SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/gap-packages/", ~.PackageName ),
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := Concatenation( "https://gap-packages.github.io/", ~.PackageName, "/" ),
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

Status := "dev",

AbstractHTML   :=  "The <span class=\"pkgname\">CoxIter</span> package \
computes invariants of hyperbolic Coxeter groups: the Euler characteristic, \
the f-vector of the associated polyhedron, the growth series, and whether \
the group is cofinite or cocompact. It does so by calling the C++ program \
CoxIter, whose source code it includes.",

PackageDoc := rec(
  BookName  := "CoxIter",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Computation of invariants of hyperbolic Coxeter groups",
),

Dependencies := rec(
  GAP := ">= 4.12",
  NeededOtherPackages := [ ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
    # test for existence of the compiled binary
    if Filename( DirectoriesPackagePrograms( "coxiter" ), "coxiter" ) = fail then
      LogPackageLoadingMessage( PACKAGE_WARNING,
          [ "The program `coxiter' is not compiled,",
            "see the installation instructions in README.md" ] );
      return false;
    fi;
    return true;
  end,

TestFile := "tst/testall.g",

Keywords := [ "hyperbolic Coxeter group", "Coxeter polyhedron",
              "Euler characteristic", "f-vector", "growth series" ],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := """
          &copyright; 2013-2017 by Rafael Guglielmetti<P/>

          This package is free software: you can redistribute it and/or
          modify it under the terms of the <URL Text="GNU General Public
          License">https://www.gnu.org/licenses/gpl.html</URL> as published
          by the Free Software Foundation, either version 3 of the License,
          or (at your option) any later version.""",
    ),
),

));
