# first tests with julia

Julia [cheat sheet](https://juliadocs.github.io/Julia-Cheat-Sheet/)

Start julia from command line with alias:

```
# .zshrc or .bashrc
alias julia="/Applications/Julia-1.6.app/Contents/Resources/julia/bin/julia"
```

## julia REPL

Here is the [doc](https://docs.julialang.org/en/v1/stdlib/REPL/)

- *Help mode*: `?`
- *Shell mode*: `;` (`ctrl-C` to exit)
- *Pkg mode*: `]` (`ctrl-C` to exit). \
Errors of the following type will be generated otherwise:
```
julia> rm UnderwaterAcoustics
ERROR: syntax: extra token "UnderwaterAcoustics" after end of expression
Stacktrace:
 [1] top-level scope
   @ none:1
```



## create / update environments

See julia [Pkg doc](https://docs.julialang.org/en/v1/stdlib/Pkg/)

Activate an existing environment (called `project`):

```
(@v1.6) pkg> activate project
```

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
or with `st` abbreviation. To show dependencies: `st --manifest`

Add a package (in pkg mode):
```
(@v1.6) pkg> add UnderwaterAcoustics
```

Or make a local copy of the library from github:
```
(@v1.6) pkg> develop --local UnderwaterAcoustics
# or
(@v1.6) pkg> add https://github.com/org-arl/UnderwaterAcoustics.jl#master
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

If you want to run a script from the command line with a specific environment, do:

```
julia --project=path_to_project myscript.jl
```

## Physical oceanography & acoustics

- GHER juliab [webpage](https://gher-ulg.github.io/julia_ocean.html)
- [PhysOcean](https://github.com/gher-ulg/PhysOcean.jl)
- [Clima](https://github.com/CliMA)
- [Oceananigans.jl](https://github.com/CliMA/Oceananigans.jl)

Acoustics:

- [UnderwaterAcoustics.jl](https://org-arl.github.io/UnderwaterAcoustics.jl/dev/)


## other useful packages

- [pluto](https://juliahub.com/docs/Pluto/OJqMt/0.7.4/). Launch Pluto with:
```
julia> using Pluto
julia> Pluto.run()
```
- [plutoUI](https://juliahub.com/docs/PlutoUI/abXFp/0.7.9/autodocs/)

## installed environment

```
add UnderwaterAcoustics Plots Pluto
```
