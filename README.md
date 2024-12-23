# Ikaros

## Requirements

- Godot 4.4
- Python >= 3.7

## Running the linter

Before pushing code to GitHub you should run the linter on the project.

### Install gdtoolkit

Set up and activate a virtual environment in the project root and run `pip install -r requirements.txt`.

### Run the linter

With gdtoolkit installed in the venv, run `gdlint Ikaros/core Ikaros/game` in the terminal.
Fix any errors in your code the linter may find.

## About autoloads

For the time being autoloads have been removed from the project, as they can't be resolved when running
script checks (`godot --headless --quit --check-only --script <script>`) on specific files.

Prior to this there were two autoloads:
- Ikaros - a singleton acting as a pseudo-namespace for the project
  - Turned into a static class (i.e. all members and methods are now static)
- Log - an autoload injected by the Log addon
  - Section of code in `logger/log-stream.gd` requiring the `Log` autoload has been modified to work without it

## Acknowledgments

- [Godot Unit Test](https://github.com/bitwes/Gut)
- [Log](https://github.com/albinaask/Log) (Note that this addon has been modified to remove its dependence on having an autoload)
- [GDScript Toolkit](https://github.com/Scony/godot-gdscript-toolkit)

