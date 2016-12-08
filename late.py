#!/usr/bin/env python
# a tool, given a filename and date
# display a list of students that turned in
# work after the given date
from lxml import html
import re, os, sys
from datetime import datetime

selector = "//tr/td/font/b/text()|//tr/td[2]/text()"
form = '%b %d, %Y %I:%M %p'

# returns list of students 
# that turned in late work
def is_late(fn, date):
    # get the parsed html tree from a filename
    def get_tree():
        with open(fn, 'r') as f:
            return html.fromstring(f.read().replace('\n', ''))

    # generate all of the (name, [dates turned in])
    # for a tree
    def lazy_do(tree):
        items = tree.xpath(selector)
        name = items.pop(0)
        col = []
        for item in items:
            if not re.search('2016', item):
                yield (name, col)
                name = item
                col = []
            else:
                col.append(datetime.strptime(item, form))

    # with a (name, times turned in)
    # return a dictionary
    # student: [times turned in]
    def names_dict(lazy_did):
        return { name: dates for (name, dates) in lazy_did }

    # map all dates to late: True, on time: False
    d = dict((name, map(lambda x: x > date, dates)) \
            for (name, dates) \
            in names_dict(lazy_do(get_tree())).items())
    return [name for (name, dates) in d.items() if True in dates]

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("usage: ./late.py <d2l index> \'<late date>\'")
        print("(quotes are important)")
        sys.exit(1)

    f = sys.argv[1]
    late_date = \
        datetime.strptime(sys.argv[2], form)

    for late_student in is_late(f, late_date):
        print(late_student)
