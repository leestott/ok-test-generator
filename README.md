# Okpy Test Generator

This is the source code for a Heroku-deployed webapp that generates Python test cases in ok format. This test format is used in various autograders, including [okpy](https://github.com/okpy/ok) and [gofer-grader](https://github.com/data-8/gofer-grader).

The generator is at [https://oktests.herokuapp.com](https://oktests.herokuapp.com).

## Changelog

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
