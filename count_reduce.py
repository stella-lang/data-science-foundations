#!/usr/bin/env python

import sys

(last_key, temp_count, quality_count) = (None, 0, 0)
for line in sys.stdin:
  (key, count1, count2) = line.strip().split("\t")
  if last_key and last_key != key:
    print "%s\t%s\t%s" % (last_key, temp_count, quality_count)
    (last_key, temp_count, quality_count) = (key, int(count1), int(count2))
  else:
    (last_key, temp_count, quality_count) = (key, temp_count + int(count1), quality_count + int(count2))

if last_key:
  print "%s\t%s\t%s" % (last_key, temp_count, quality_count)
