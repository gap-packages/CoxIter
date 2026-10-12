This file describes changes in the CoxIterGAP package.

## Unreleased

- Rename the package from CoxIter to CoxIterGAP, to tell it apart from the
  program it wraps
- The GAP Team now maintains the package
- Require GAP >= 4.12
- Reject Coxeter matrices that are not symmetric or have entries other than
  non-negative integers, instead of computing with them
- Report malformed graphs with a proper error message
- No longer communicate with the coxiter program through a pseudo terminal,
  which could truncate long growth series
- Build with the system's GMP if the one GAP uses lacks the C++ bindings
- PCRE is not needed to build the package (#3)
- Add a test suite
- Update the bundled CoxIter to f172859 (#7)
- Revise the build system: support GAP 4.12, accept `--with-gaproot=PATH`,
  stop environment variables like `CXXFLAGS` from overriding required flags,
  and drop `-fopenmp` (#6); support building on macOS and on Windows with
  MinGW/MSYS
- Check bounds for edge weights and vertex indices, and report an error when
  the graph is badly encoded
- Add documentation of the operations and examples to the manual

## 1.0b (2016-08-17)

## 0.1b (2016-08-08)
