# sienna-examples
Examples of how to use NREL Sienna for power systems modeling and simulation.

# Setup

## Download Julia

1. Go to https://julialang.org/downloads/
2. Scroll down to "Official Binaries for Manual Download" and open the [help] link for your platform in a new tab. Follow the instructions.
3. Open the Julia app. Check that it worked by typing the following. It should print `Hello World` to the console.
    ```bash
    julia> println("Hello World!")
    ```

## Download VSCode

If you don't already have a preferred IDE (integrated development environment), VSCode is a good option. This is software that makes it easy to open, write, and edit code.

1. Go to https://code.visualstudio.com/docs/languages/julia
2. Follow the steps under "Getting Started." Skip Step 1 (the Julia install) if you already did that.

## Setup Jupyter Notebooks to work with Julia
Source: https://julialang.github.io/IJulia.jl/stable/manual/running/ 
1. Open Julia
2. Open the package
manager
    ```julia
    ]
    ```
3. Add the `IJulia` package which will allow Jupyter to run Julia code.
    ```julia
    add IJulia
    ```
4. Exit the package manager by hitting backspace.
5. Open `jupyter notebook` from Julia
    ```julia
    using IJulia
    notebook()
    ```
6. You will be prompted to install Jupyter using Conda. Choose yes by typing `y`. 
7. Once this is done installing, `jupyter notebook` will open in your browser. You will see your local file structure. 
7. To use a downloaded notebook, navigate to the notebook in your file structure and open it.
7. To create a new notebook for running Julia code, select the dropdown in the upper right corner labeled `New` and select Julia. 

## Setup NREL-Sienna
NREL-Sienna is a set of "Open Source Tools for Scientific Energy Systems Analysis". More information can be found on their GitHub page (https://github.com/NREL-Sienna).

### To run examples in this repo
1. Download one of the examples in this repo.
2. Run the first few lines of the file under `# Set up the package environment`. This will download all of the packages necessary for the example if you don't already have them.

### To create new projects
1. Open Julia
2. Open the package manager using `]`
3. (Optional but recommended) Create a new project with an environment by [following these instructions](https://pkgdocs.julialang.org/v1/environments/).
3. Add whatever packages you need. For example:
    ```julia
    add PowerSystems
    add PowerSystemCaseBuilder
    add PowerSimulationsDynamics
    add Sundials
    add Plots
    ```
    (These packages is just an example starting point, not an extensive list)
    
# Resources

## Julia

### Tutorials
- [JuliaTutorials](https://github.com/JuliaAcademy/JuliaTutorials) - introductory (jupyter notebooks)
- [JuliaAcademy](https://juliaacademy.com/) - introductory (courses)

## NREL-Sienna

### Tutorials
- [High-level Sienna Tutorials created by NREL](https://www.youtube.com/playlist?list=PLxNyxpdXOTcMHyT5ZyXxzvbER06wvMW6e)

### Package Documentation
- [`PowerSystems.jl`](https://nrel-sienna.github.io/PowerSystems.jl/stable/)
- [`PowerSimulationsDynamics.jl`](https://nrel-sienna.github.io/PowerSimulationsDynamics.jl/stable/)

### Quick Links
- [Example -- Simple `BranchTrip` simulation with `PowerSimulationsDynamics.jl`](https://nrel-sienna.github.io/PowerSimulationsDynamics.jl/stable/quick_start_guide/)
    - Note: this example has been copied into this repo as `Dynamics/OMIBBranchTrip.jl`
- [Docs -- Perturbation types in `PowerSimulationsDynamics.jl`](https://nrel-sienna.github.io/PowerSimulationsDynamics.jl/stable/perturbations/)
- [Docs -- Details about the dynamic simulation initialization process](https://nrel-sienna.github.io/PowerSimulationsDynamics.jl/stable/initialization/)
