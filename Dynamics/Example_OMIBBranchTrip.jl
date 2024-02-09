# Example: Dynamic simulation of OMIB branch trip
# This example runs a dynamic simulation of the OMIB System with a Branch Trip perturbation. 
# It is copied directly from the NREL-Sienna Documentation: "Quick Start Guide for PowerSimulationsDynamics.jl"
# https://nrel-sienna.github.io/PowerSimulationsDynamics.jl/stable/quick_start_guide/

# Set up the package environment
cd(@__DIR__)      # go to the directory of this script
using Pkg         # use the package manager
Pkg.activate(".") # activate the environment defined by the toml files in this directory
Pkg.instantiate() # install missing dependencies, make sure environment is ready to use

# Import packages
using PowerSystems
using PowerSystemCaseBuilder
using PowerSimulationsDynamics
using Sundials
using Plots

# Build a system (i.e. network model) from Sienna's built-in library.
omib_sys = build_system(PSIDSystems, "OMIB System")

# Define the perturbation you are interested in modeling. 
show_components(omib_sys, Line, [:r, :x])
perturbation_trip = BranchTrip(1.0, Line, "BUS 1-BUS 2-i_1")

# Define the time span of the simulation
time_span = (0.0, 30.0)

# Create the simulation object. This step includes initialization of the system. 
# This means that it first finds a stable equilibrium point to which the disturbance is applied.
# [More info about initialization](https://nrel-sienna.github.io/PowerSimulationsDynamics.jl/stable/initialization/)
sim = Simulation!(ResidualModel, omib_sys, pwd(), time_span, perturbation_trip)

# (Optional) Explore the initial condition (i.e. stable equilibirum point) that was found.
# These are the values at t=0 (pre-disturbance) of all state variables in the system
show_states_initial_value(sim)

# (Optional) Perform small-signal analysis (this has a binary output, i.e. stable or not-stable)
small_sig = small_signal_analysis(sim)

# (Optional) Print small-signal analysis results (if stable, all of the real parts are negative)
summary_eigenvalues(small_sig)

# Run the simulation
# NOTE: This is the first time our perturbation_trip variable is used
# NOTE: IDA() is a differential-algebraic equation solver 
execute!(sim, IDA(), dtmax = 0.02, saveat = 0.02)

# Store the results of the simulation
results = read_results(sim)

# Get time series of state variable, delta, for the generator named `generator-102-1`.
angle = get_state_series(results, ("generator-102-1", :δ));

# Plot results of simulation.
plot(angle, xlabel = "time", ylabel = "rotor angle [rad]", label = "gen-102-1")
