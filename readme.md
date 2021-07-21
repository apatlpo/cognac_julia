# first tests with julia

## julia REPL

Here is the [doc](https://docs.julialang.org/en/v1/stdlib/REPL/)

*Help mode*: `?`

*Shell mode*: `;` (`ctrl-C` to exit)

*Pkg mode*: `]` (`ctrl-C` to exit). \
Errors of the following type will be generated otherwise:
```
julia> rm UnderwaterAcoustics
ERROR: syntax: extra token "UnderwaterAcoustics" after end of expression
Stacktrace:
 [1] top-level scope
   @ none:1
```



## managing environments

See julia [Pkg doc](https://docs.julialang.org/en/v1/stdlib/Pkg/)


Create an environment (in shell mode, then pkg mode):
```
shell> mkdir project
(@v1.6) pkg> activate project
  Activating new environment at `~/Code/cognac_julia/project/Project.toml`
```

Project is empty at first:
```
(project) pkg> status
      Status `~/Code/cognac_julia/project/Project.toml` (empty project)
```

Add a package (in pkg mode):
```
(@v1.6) pkg> add UnderwaterAcoustics
```

Or make a local copy of the library from github:
```
develop --local UnderwaterAcoustics
```

List installed packages (in pkg mode):

```
(@v1.6) pkg> status
      Status `~/.julia/environments/v1.6/Project.toml`
  [91a5bcdd] Plots v1.18.1
```

Remove package:

```
rm UnderwaterAcoustics
```




## Physical oceanography

- GHER juliab [webpage](https://gher-ulg.github.io/julia_ocean.html)

- [PhysOcean](https://github.com/gher-ulg/PhysOcean.jl)

- [Clima](https://github.com/CliMA)

- [Oceananigans.jl](https://github.com/CliMA/Oceananigans.jl)
