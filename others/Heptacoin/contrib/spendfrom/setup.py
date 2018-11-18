# Copyright (c) 2013 The Bitcoin Core developers
# Copyright (c) 2017-2018 The Heptacoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
from distutils.core import setup
setup(name='heptaspendfrom',
      version='1.0',
      description='Command-line utility for heptacoin "coin control"',
      author='Gavin Andresen',
      author_email='gavin@bitcoinfoundation.org',
      requires=['jsonrpc'],
      scripts=['spendfrom.py'],
      )
