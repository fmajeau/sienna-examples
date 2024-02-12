# Exercise: Dynamic simulation of 14 Bus Base Case branch trip
# In this exercise, you will create a dynamic simulation with a branch trip of your choosing.

# [Here is one possible solution for this exercise]

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


# Choosing a system
# ------------------------------

# Explore the systems available in Sienna's built-in library
# NOTE: Some categories have been tested and tuned more than others. For example, systems in PSIDSystems 
#  have been tested a lot and are a good choice for the general public. PSIDTestSystems is intended more 
#  for NREL folks as they develop this software.
show_systems() # all of the available systems
show_systems(PSIDSystems) # systems within one category

# Find "14 Bus Base Case" within the PSIDSystems category and build it.
system = build_system(PSIDSystems, "14 Bus Base Case")


# Defining the perturbation
# ------------------------------

# Look at the Types in this system
system

# Explore the components of a few of these Types
# This is mainly just to get practice interacting with a system
# NOTE: to find the fields (e.g. ":r" or ":x") for a given Type, run ?Type in the REPL (e.g. ?Transformer2W)
show_components(system, Line, [:r,:x])
show_components(system, ThermalStandard)
show_components(system, ACBus)

# Choose a branch to trip and create the perturbation
# NOTE: You can learn more about the other available perturbation types in the documentation: 
#  "Perturbation types in `PowerSimulationsDynamics.jl`" 
#  https://nrel-sienna.github.io/PowerSimulationsDynamics.jl/stable/perturbations/
perturbation = BranchTrip(1.0, Line, "BUS 06-BUS 11-i_1")


# Creating the simulation
# ------------------------------

# Define the time span of the simulation
time_span = (0.0, 30.0)

# Create the simulation object
sim = Simulation!(ResidualModel, system, pwd(), time_span, perturbation)

# Sanity check the initial conditions
# (Are bus voltages around 1pu?)
show_states_initial_value(sim)

# Check small signal stability
# TIP: if the pre-disturbance system is not small signal stable, it is unlikely that the time domain simulation will converge.
small_sig = small_signal_analysis(sim)
summary_eigenvalues(small_sig)


# Execute the simulation
# ------------------------------

# Execute the simulation using IDA()
execute!(sim, IDA())

# Store the results
results = read_results(sim)


# Plot
# ------------------------------

# Plot the voltage magnitude of the buses on either end of your tripped branch on a single plot
Vm_bus6 = get_voltage_magnitude_series(results, 6);
Vm_bus11 = get_voltage_magnitude_series(results, 11);
plot(
    [Vm_bus6, Vm_bus11], 
    xlabel = "Time", 
    ylabel = "Voltage Magnitude [pu]", 
    label = ["Bus 6" "Bus 11"],
    title = "Voltage magnitude on ends of tripped line"
    )

# Plot the rotor angle trajectory of all the generators on a single plot
gen_state_series = Array{Tuple{Array{Float64, 1}, Array{Float64, 1}}, 1}()
gen_labels = Array{String,1}()
for gen in get_components(ThermalStandard, system)
    time_series = get_state_series(results, (get_name(gen), :δ))
    push!(gen_state_series, time_series);
    push!(gen_labels, get_name(gen));
end
gen_labels = reshape(gen_labels,1,5)
plot(
    gen_state_series,
    xlabel = "Time", 
    ylabel = "Rotor Angle [rad]", 
    label = gen_labels,
    title = "Rotor angle of generators"
    )
