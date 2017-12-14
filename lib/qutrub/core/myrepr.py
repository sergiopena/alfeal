﻿#!/usr/bin/python
# -*- coding: UTF-8 -*-
#-------------------------------------------------------------------------------
# Name:        myrepr
# Purpose:    Used to custmize repr fucntions 
#
# Author:      Taha Zerrouki (taha.zerrouki[at]gmail.com)
#
# Created:     31-10-2011
# Copyright:   (c) Taha Zerrouki 2011
# Licence:     GPL
#-------------------------------------------------------------------------------

import repr as reprlib
import sys
class MyRepr(reprlib.Repr):
	def repr_unicode(self, obj, level):
		"Modify unicode display "
		return u"u'%s'"%obj

