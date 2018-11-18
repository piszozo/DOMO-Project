#!/usr/bin/env python
'''
Copyright (c) 2012-2015 The Bitcoin Core developers
Copyright (c) 2017-2018 The Heptacoin Core developers
Distributed under the MIT software license, see the accompanying
file COPYING or http://www.opensource.org/licenses/mit-license.php.

Run this script to update all the copyright headers of files
that were changed this year.

For example:

// Copyright (c) 2017-2018 The Heptacoin Core developers

it will change it to

// Copyright (c) 2017-2019 The Heptacoin Core developers
'''
import os
import time
import re

year = time.gmtime()[0]
CMD_GIT_DATE = 'git log --format=%%ad --date=short -1 %s | cut -d"-" -f 1'
CMD_REGEX= "perl -pi -e 's/(20\d\d)(?:-20\d\d)? The Heptacoin/$1-%s The Heptacoin/' %s"
REGEX_CURRENT= re.compile("%s The Heptacoin" % year)
CMD_LIST_FILES= "find %s | grep %s"

FOLDERS = ["./qa", "./src"]
EXTENSIONS = [".cpp",".h", ".py"]

def get_git_date(file_path):
  r = os.popen(CMD_GIT_DATE % file_path)
  for l in r:
    # Result is one line, so just return
    return l.replace("\n","")
  return ""

n=1
for folder in FOLDERS:
  for extension in EXTENSIONS:
    for file_path in os.popen(CMD_LIST_FILES % (folder, extension)):
      file_path = os.getcwd() + file_path[1:-1]
      if file_path.endswith(extension):
        git_date = get_git_date(file_path)
        if str(year) == git_date:
          # Only update if current year is not found
          if REGEX_CURRENT.search(open(file_path, "r").read()) is None:
            print n,"Last git edit", git_date, "-", file_path
            os.popen(CMD_REGEX % (year,file_path))
            n = n + 1
