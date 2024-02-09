# Exercise: Dynamic simulation of 14 Bus Base Case branch trip
# In this exercise, you will create a dynamic simulation with a branch trip of your choosing.

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
system = """TODO"""


# Defining the perturbation
# ------------------------------

# Look at the Types in this system
system

# Explore the components of a few of these Types
# This is mainly just to get practice interacting with a system
# NOTE: to find the fields (e.g. ":r" or ":x") for a given Type, run ?Type in the REPL (e.g. ?Transformer2W)
show_components(system, Line, [:r,:x])
""" TODO """ 

# Choose a branch to trip and create the perturbation
# NOTE: You can learn more about the other available perturbation types in the documentation: 
#  "Perturbation types in `PowerSimulationsDynamics.jl`" 
#  https://nrel-sienna.github.io/PowerSimulationsDynamics.jl/stable/perturbations/
""" TODO """ 


# Creating the simulation
# ------------------------------

# Define the time span of the simulation
time_span = (0.0, 30.0)

# Create the simulation object
sim = """ TODO """

# Sanity check the initial conditions
# (Are bus voltages around 1pu?)
show_states_initial_value(sim)

# Check small signal stability
# TIP: if the pre-disturbance system is not small signal stable, it is unlikely that the time domain simulation will converge.
""" TODO """ 


# Execute the simulation
# ------------------------------

# Execute the simulation using IDA()
""" TODO """ 

# Store the results
results = read_results(sim)


# Plot
# ------------------------------

# Plot the voltage magnitude of the buses on either end of your tripped branch on a single plot
""" TODO """ 


# Plot the rotor angle trajectory of all the generators on a single plot
""" TODO """ 
