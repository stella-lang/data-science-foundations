#!/usr/bin/env python

import re
import sys

for line in sys.stdin:
  val = line.strip()
  (year, temp, q) = (val[15:19], val[87:92], val[92:93])
  if (temp != "+9999"):
    if (re.match("[01459]", q)):
      print "%s\t%s\t%s" % (year, 1, 1)
    print "%s\t%s\t%s" % (year, 1, 0)
  else:
    if (re.match("[01459]", q)):
      print "%s\t%s\t%s" % (year, 0, 1)
    print "%s\t%s\t%s" % (year, 0, 0)
