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

## Acknowledgments

- [Godot Unit Test](https://github.com/bitwes/Gut)
- [GDScript Toolkit](https://github.com/Scony/godot-gdscript-toolkit)
