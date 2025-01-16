# Eliza in Interlisp/Medley

Jeff Shrager has done impressive detective work in tracking down the
origin's of Eliza/DOCTOR.  The earliest implementation not created by
Joseph Weizenbaum z"l that I'm aware of is Bernie Cosell's version in
BBN-Lisp.  As BBN-Lisp is the immediate ancestor of Interlisp, I
wanted to see what's required to get it running in the most up-to-date
Interlisp version, Medley.

I chose the 1969 papertape version from Jeff's ElizaGen repo.

## My self-imposed rules:

- Keep the source code as close to the original as possible: no
  changes to the logic or data structures, minimal changes to the
  program text.
  
- Don't require special tooling or emulation running in the Medley system.
  The code should run as-is.
  
- If a function or global variable in BBN-Lisp has a new name in
  Interlisp, it's OK to change it in the program.

- I'm not sure what to do about big changes to the I/O system that
  might require changes to the source code.  I've already had to quote
  a few characters that have special meaning in Interlisp, but
  anticipate that Interlisp may treat TTY input differently.

## How to run it

In an Interlisp exec:

````
> (load "doctor1969.lisp" nil nil *package*)
> (load "script1969.lisp" nil nil *package*)
> (doctor)
````
