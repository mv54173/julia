using DifferentialEquations
using Plots
using CSV
using DataFrames


#viševalni SIRS model
MWSIRS = function (du, u, h, p, t)
    T, alfa, gama, beta = p
    saZakasnjenjem = h(p, t - T)[3] # dio nekad nedostupnih koji možda prijeđe u neaktivne
    # zapis diferencijalnih jednadžbi modela
    du[1] = -alfa * u[1] * u[2] + gama * saZakasnjenjem
    du[2] = alfa * u[1] * u[2] - beta * u[2]
    du[3] = beta * u[2] - gama * saZakasnjenjem
end


h(p, t) = zeros(3)

##ulazni podaci
I = 0 # broj neaktivnih uređaja
A = 45000 # broj aktivnih uređaja
R = 0 # broj nedostupnih uređaja 
N = A + I + R # ukupan broj urešaja
theta = 870 # vrijeme između zadnjeg 
alfa = 12 / (60 * N) # vjerojatnost zaraze između aktivnog i neaktivnog uređaja u minuti
gama = 1 / 120 # vjerojatnost da uređaj postane neaktivan
beta = 0.01 # faktor prelaska iz aktivnih u nedostupne uređaje
tspan = (0.0, 8500.0)


##pokretanje solvera za delay differential equations
p = (theta, alfa, gama, beta, delta)
u0 = [I; A; R] # podešavanje početnih uvjeta
problem = DDEProblem(MWSIRS, u0, h, tspan, p)
sol = solve(problem)


## vizualizacija
populacija = CSV.read("plot-data.csv", DataFrame)
vrijeme_podaci = populacija[:, 1]
broj_podaci = populacija[:, 2] * 10000

plot(vrijeme_podaci, broj_podaci, label="Populacija botnet mreže", legend=:topright) # osnovna naredba za plot
#plot!(sol, vars=(0, 1), label="podložni", legend=:topright)
plot!(sol, vars=(0, 2), label="zaraženi", legend=:topright)
#plot!(sol, vars=(0, 3), label="oporavljeni", legend=:topright)
##
