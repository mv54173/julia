# opći model interakcije grabežljivac-plijen

using DifferentialEquations

Rosenzweig_MacArthur = function (du, u, p, t)
    alpha, beta, gamma, delta, K, b = p
    du[1] = u[1] * (alpha * (1 - u[1] / K) - beta * (u[2] / (b + u[1])))
    du[2] = -u[2] * (gamma - delta * (u[1] / (b + u[1])))
end

#= zadani parametri
## konstante
alpha = 0.9
beta = 1
gamma = 0.2
delta = 0.3
K = 100
b = 10
=#
alpha = 1.2
beta = 1
gamma = 0.2
delta = 0.3
K = 100
b = 20
p = (alpha, beta, gamma, delta, K, b)
## početni uvjeti
u0 = [20.0; 10.0]
tspan = (0.0, 300)
## rješavanje problema
problem = ODEProblem(Rosenzweig_MacArthur, u0, tspan, p)
sol = solve(problem)
## virtualizacija
using Plots
gr()
plot(sol, vars=(0, 1), title="grabežljivac plijen RM model", label="plijen", legend=:topright)
plot!(sol, vars=(0, 2), label="grabežljivac", legend=:topright)
plot!(xlab="vrijeme", ylab="populacija")
#plot(sol, vars=(1, 2), title="grabežljivci po plijenu")


# komentari:
# Za zadane konstante i parametre dolazi do greške u modelu
# gdje se bilježi pad populacije plijena na 0 jedinki.
# Zanimljiv ulaz je P = (2.2, 0.7, 0.2, 0.3, 50, 10) gdje 
# nakon određenog vreme broj jedinki grabežljivaca pređe broj
# jedinki plijena i tada oscilira nalik na lagano prigušeni 
# "ukošeni" sinus u pomaku na broj jedinki plijena koji oscilira na sličan način
# Za P = (1.2, 0.7, 0.2, 0.3, 50, 10) prvo bilježimo nagli rast jedinki plijena
# kojeg u pomaku prati "eksponencijalni" rast jedinki grabežljivaca što dovodi do pada
# broja jedinki plijena na otpriliku polovicu kapaciteta okoliša. Tada se postiže
# prigušena oscilacija populacija oko približno jednakog broja s tim da je amplituda
# populacije plijena veća.