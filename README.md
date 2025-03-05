# All you base are belongs to us

## Front-End:
1. Tokenizer
2. Parser
3. Code Generator

The input of Front End is SQL query.
The out of the Front End is bytecode.

## Back-End:
1. Virtual Machine
2. B-Tree
3. Pager
4. OS Interface

### Virtual Machine
Takes bytecode from Front End as instructions -> performs operations on table(s) ->
stores data in B-Tree.

### B-Tree
It consists of many nodes -> each is one page length. B-Tree can read/write to pages
is disk using pager.

### Pager
Receives cmds to read/write page of data. Also keeps cache of recent access.

### OS Interface
Interfaces with the OS - duh!
