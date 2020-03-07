# Ok Test Generator

<!-- [![Build Status](https://travis-ci.org/chrispyles/okpy-test-generator.svg?branch=master)](https://travis-ci.org/chrispyles/okpy-test-generator) [![codecov](https://codecov.io/gh/chrispyles/ok-test-generator/branch/master/graph/badge.svg)](https://codecov.io/gh/chrispyles/ok-test-generator) -->

This is the source code for small JS-based webpage that generates Python test cases in ok format. This test format is used in various autograders, including [otter-grader](https://github.com/ucbds-infra/otter-grader), [okpy](https://github.com/okpy/ok), and [gofer-grader](https://github.com/data-8/gofer-grader).

The generator is at [https://oktests.chrispyles.io](https://oktests.chrispyles.io).

## Changelog

**v0.4.0:**

* Changed from webapp on Ruby + Sinatra to static JS + HTML + CSS

**v0.3.1:**

* Removed extraneous code

**v0.3.0:**

* Added Cucumber tests
* Added Travis CI and Codecov

**v0.2.0:**

* Changed "Copy to Clipboard" button to "Download" button

**v0.1.1:**

* Fixed bug where last test case was not included in output
* Reorganized `lib/test.rb` so that fewer abstraction barriers are violated

**v0.1.0:**

* Added hidden and locked test cases
* Added scoring and points to suites

**v0.0.1:**

* Initial release!
