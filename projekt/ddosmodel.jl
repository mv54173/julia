using DifferentialEquations
using Plots
using CSV
using DataFrames

## opis parametara i definicija modela 
#=
beta - vjerojatnost zaraze/aktivacije po kontaktu
ipsilon - stopa oporavka zaraženih čvorova
mi - mortalitet/natalitet napadača
epsilont - stopa gubitka imuniteta napadnutih čvorova
epsilona - stopa prelaska iz aktivnih u potencijalne čvorove napadače 
omega - stopa prelaska iz neaktivnih u aktivne čvorove napadače (spajanje na internet)
alfa -  stopa prelaska iz aktivnih u neaktivne čvorove napadače (odspajanje s interneta)
=#

DDOS = function (du, u, p, t)
    beta, epsilont, ipsilon, mi, epsilona, omega, alfa = p
    du[1] = -beta * u[1] * u[5] + epsilont * u[3]   # promjena broja podložnih napadnutih čvorova
    du[2] = beta * u[1] * u[5] - ipsilon * u[2]     # promjena broja zaraženih napadnutih čvorova
    du[3] = ipsilon * u[2] - epsilont * u[3]        # promjena broja oporabljenih napadnutih čvorova
    du[4] = -beta * u[4] * u[5] - mi * u[4] + epsilona * u[5] + omega * u[6] - alfa * u[4] # promjena broja potencijalnih čvorova napadača
    du[5] = beta * u[4] * u[5] - mi * u[5] - epsilona * u[5] - alfa * u[5]                 # promjena broja aktivnih čvorova napadača
    du[6] = -omega * u[6] - mi * u[5] + mi * (u[4] + u[5] + u[6]) + alfa * u[5] + alfa * u[4]  # promjena broja neaktivnih čvorova napadača
end

## ulazni podaci
u0 = [0.89; 0.01; 0.1; 0.55; 0.2; 0.25]  # (S, I, R, Na, A, E)
p = (0.75, 0.21, 0.09, 0.12, 0.005, 0.5, 0.1) # beta, epsilont, ipsilon, mi, epsilona, omega, alfa
tspan = (0, 50)
## rješavanje
problem = ODEProblem(DDOS, u0, tspan, p)
sol = solve(problem)
## dohvaćanje preuzetih podataka i vizualizacija
populacija = CSV.read("plot-data.csv", DataFrame)
vrijeme_podaci = populacija[:, 1]
broj_podaci = populacija[:, 2]

plot(vrijeme_podaci, broj_podaci, label="Populacija botnet mreže", legend=:bottomright)
plot!(sol, vars=(0, 1), label="podložni_meta", legend=:topright)
plot!(sol, vars=(0, 2), label="zaraženi_meta", legend=:bottomright)
plot!(sol, vars=(0, 3), label="oporavljeni_meta", legend=:topright)
plot!(sol, vars=(0, 4), label="potencijalni_napadač", legend=:topright)
plot!(sol, vars=(0, 5), label="aktivni_napadač", legend=:topright)
plot!(sol, vars=(0, 6), label="neaktivni_napadač", legend=:topright)