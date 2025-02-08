```markdown
# Shebang

A shebang is a character sequence consisting of the characters `#!` at the beginning of a script. It is used in Unix-like operating systems to indicate which interpreter should be used to execute the script.

## Example

Here is an example of a shebang for a Bash script:

```bash
#!/bin/bash
# Your script content goes here
```

For a Python script, the shebang would look like this:

```python
#!/usr/bin/env python3
# Your script content goes here
```

## Usage

The shebang should be the very first line in the script file. It tells the operating system how to execute the file by specifying the path to the interpreter.

## Common Shebangs

- `#!/bin/bash` - Bash shell
- `#!/bin/sh` - Bourne shell
- `#!/usr/bin/env python3` - Python 3
- `#!/usr/bin/env ruby` - Ruby
- `#!/usr/bin/perl` - Perl

Make sure the script file has execute permissions. You can set the execute permission using the `chmod` command:

```sh
chmod +x your_script.sh
```
```