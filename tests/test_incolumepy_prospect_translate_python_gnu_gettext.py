from incolumepy_prospect_translate_python_gnu_gettext import __version__
import re

def test_version():
    # assert __version__ == '0.1.0'
    assert re.fullmatch(r'\d(\.\d){2}(\-\w+.?\d+)?', __version__, flags=re.I)
