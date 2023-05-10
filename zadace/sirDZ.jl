using DifferentialEquations
using Plots

SIR_osnovni = function (du, u, p, t)
    beta, gamma = p
    du[1] = -beta * u[1] * u[2]
    du[2] = beta * u[1] * u[2] - gamma * u[2]
    du[3] = u[2] * gamma
end

SIS = function (du, u, p, t)
    beta, gamma = p
    du[1] = u[2] * gamma - beta * u[1] * u[2]
    du[2] = beta * u[1] * u[2] - gamma * u[2]
end

SIRS = function (du, u, p, t)
    beta, gamma, delta = p
    du[1] = u[3] * delta - beta * u[1] * u[2]
    du[2] = beta * u[1] * u[2] - gamma * u[2]
    du[3] = u[2] * gamma - delta * u[3]
end

SIR_demografija = function (du, u, p, t)
    beta, gamma, mi, ni = p
    du[1] = -beta * u[1] * u[2] + ni * u[4] - mi * u[1]
    du[2] = beta * u[1] * u[2] - gamma * u[2] - mi * u[2]
    du[3] = u[2] * gamma - mi * u[3]
    u[4] = u[1] + u[2] + u[3]
end

SIR_demo_vakc = function (du, u, p, t)
    beta, gamma, mi, ni, kapa = p
    du[1] = -beta * u[1] * u[2] + (ni - kapa) * u[4] - mi * u[1]
    du[2] = beta * u[1] * u[2] - gamma * u[2] - mi * u[2]
    du[3] = u[2] * gamma - mi * u[3]
    u[4] = u[1] + u[2] + u[3]
end

SEIR = function (du, u, p, t)
    beta, gamma, mi, ni, kapa, nu = p
    du[1] = -beta * u[1] * u[3] + (ni - kapa) * u[5] - mi * u[1]
    du[2] = beta * u[1] * u[3] - nu * u[2] - mi * u[2]
    du[3] = beta * u[1] * u[3] - gamma * u[3] - mi * u[3]
    du[4] = u[3] * gamma - mi * u[4]
    u[5] = u[1] + u[2] + u[3] + u[4]
end

## ulazni podaci
S = 4088000 # broj podložnih bolesti
I = 1 # broj zaraženih
R = 0 # broj oporavljenih
t_oporavka = 10 # koliko dana je osoba bolesna
N = S + I + R # ukupan broj ljudi
k = 12 # broj kontakata na dan
b = 0.05
ni = 0.009
mi = ni
delta = 1/30
kapa = ni*323085/N
beta = (k * b) / N # koeficijent zaraze
gamma = 1 / t_oporavka # koeficijent oporavka
tspan = (0.0, 25 * 7) # vrijeme gledamo u danima, g


#=
#SIR_osnovni
p = (beta, gamma)
u0 = [S; I; R] # podešavanje početnih uvjeta
problem = ODEProblem(SIR_osnovni, u0, tspan, p)
=#
#=
#SIS
p = (beta, gamma)
u0 = [S; I] # podešavanje početnih uvjeta
problem = ODEProblem(SIS, u0, tspan, p)
=#
#=
#SIRS
p = (beta, gamma, delta)
u0 = [S; I; R] # podešavanje početnih uvjeta
problem = ODEProblem(SIRS, u0, tspan, p)
=#

#=
#SIR + demografija
p = (beta, gamma, mi, ni)
u0 = [S; I; R; N] # podešavanje početnih uvjeta
problem = ODEProblem(SIR_demografija, u0, tspan, p)
=#

#=
#SIR + demografija + cijepljenje
p = (beta, gamma, mi, ni, kapa)
u0 = [S; I; R; N] # podešavanje početnih uvjeta
problem = ODEProblem(SIR_demo_vakc, u0, tspan, p)
=#
#=
#vizualizacija
sol = solve(problem)
plot(sol, vars=(0, 1), title="oboljeli od gripe", label="podložni", legend=:topright)
plot!(sol, vars=(0, 2), title="oboljeli od gripe", label="zaraženi", legend=:topright)
plot!(sol, vars=(0, 3), title="oboljeli od gripe", label="oporavljeni", legend=:topright)
=#


#SEIR
nu = 1
E = 0
p = (beta, gamma, mi, ni, kapa, nu)
u0 = [S; E; I; R; N] # podešavanje početnih uvjeta
problem = ODEProblem(SEIR, u0, tspan, p)


sol = solve(problem)
plot(sol, vars=(0, 1), title="oboljeli od gripe", label="podložni", legend=:topright)
plot!(sol, vars=(0, 2), title="oboljeli od gripe", label="asimptomatski", legend=:topright)
plot!(sol, vars=(0, 3), title="oboljeli od gripe", label="zaraženi", legend=:topright)
plot!(sol, vars=(0, 4), title="oboljeli od gripe", label="oporavljeni", legend=:topright)