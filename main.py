#!/usr/bin/env python
# -*- coding: utf-8 -*-
__author__ = "@britodfbr"  # pragma: no cover

"""
Tutorial disponível em: https://phrase.com/blog/posts/translate-python-gnu-gettext/
"""
import gettext
_ = gettext.gettext

# main.py
def print_some_strings():
    print(_("Hello world"))
    print(_("This is a translatable string"))

if __name__ == '__main__':
    print_some_strings()
