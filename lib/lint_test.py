#!/usr/bin/env python
# lint_test.py
# Test the Lint class

from unittest import *
from lint import *

class TestLinter(TestCase):
    def test_report(self):
        with self.assertRaises(NotImplementedError):
            Linter.report()


if __name__ == '__main__':
    main()
