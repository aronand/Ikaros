# Ikaros

## Requirements

- Godot 4.4 dev 7
- Python >= 3.7

## Running gdtoolkit

Before pushing code to GitHub you should run the linter and the formatter on the project.

### Installation

Set up and activate a Python virtual environment in the project root and run `pip install -r requirements.txt`.

### gdlint

Run `gdlint Ikaros/core Ikaros/game` in the terminal.
Fix any errors in your code the linter may find.

### gdformat

Run `gdformat -c Ikaros/core Ikaros/game` in the terminal to check if the formatter finds any issues with the code.

Run `gdformat -d Ikaros/core Ikaros/game` to show what the formatter would change.

Run `gdformat Ikaros/core Ikaros/game` to let the formatter edit the code, or make manual changes to satisfy the formatter.

## About autoloads

For the time being autoloads have been removed from the project, as they can't be resolved when running
script checks (`godot --headless --quit --check-only --script <script>`) on specific files.

## Acknowledgments

- [Godot Unit Test](https://github.com/bitwes/Gut)
- [GDScript Toolkit](https://github.com/Scony/godot-gdscript-toolkit)
