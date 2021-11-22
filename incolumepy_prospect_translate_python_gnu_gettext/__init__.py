import toml
from pathlib import Path

pyproject = Path(__file__).parents[1].joinpath('pyproject.toml')
assert pyproject.is_file(), f"{pyproject=}"

versionfile = Path(__file__).parent.joinpath('version.txt')
assert versionfile.is_file(), f"{versionfile}"

version = toml.load(pyproject)['tool']['poetry']['version']

# print(pyproject, versionfile)
# print(version)
versionfile.write_text(f"{version}\n")

__version__ = versionfile.read_text().strip()
