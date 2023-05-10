using DifferentialEquations


skok = function (du, u, p, t) # prema dokumentaciji je potrebno ovako zadati funkciju. du označava derivacije puta i brzine, u početne vrijednosti puta i brine, p daje parametre a t vrijeme u kojem se provodi
    L, Cd, m, k, gamma = p
    g = 9.81
    opruga = 0
    pocetni_put = u[1]
    pocetna_brzina = u[2]
    if pocetni_put > L # ako je nategnuto uže onda opruga doprinosi za:
        opruga = (k / m) * (pocetni_put - L) + (gamma / m) * pocetna_brzina
    end
    du[1] = pocetna_brzina
    du[2] = g - pocetna_brzina * abs(pocetna_brzina) * (Cd / m) - opruga
end



## potrebno prvo zadati početne parametre
h = 56 - 2 #visina mosta - maks. visina čovjeka
L = 56 / 2 # duljina užeta
Cd = 0.25 # koeficijent otpora zraka
mase = [60 65 70 75 80] # masa skakača
k = 40 # konstanta opruge
gamma = 8 # koeficijent prigušenja
##



najbolji = 56
najbolji_k = 0
for k = 0:200
    println(k)
    max_s = Float64[]
    for m in mase
        p = (L, Cd, m, k, gamma) # sve parametre stavljamo u jedan array
        u0 = [0.0; 0.0] # podešavanje početnih uvjeta za put i brzinu
        tspan = (0.0, 50.0) # gledamo od 0 do 50 sekunde
        problem = ODEProblem(skok, u0, tspan, p) # zadaje se ODE problem - unutar solvea će se zvati naša prethodno napisana funkcija
        ## Rješimo problem
        sol = solve(problem)
        max = 0
        for s in sol.u
            if s[1] > max
                max = s[1]
            end
        end
        push!(max_s, max)
    end
    avg = 0.0
    prolazan = 1
    for max in max_s
        if max > h
            prolazan = 0
            break
        end
        avg += h - max
    end
    if prolazan == 0
        continue
    else
        println(max_s)
        avg = avg / 5
        if najbolji > avg
            najbolji = avg
            najbolji_k = k
        end
    end
end
print(najbolji_k)

using Plots
gr()
k = najbolji_k
for m in mase
    p = (L, Cd, m, k, gamma) # sve parametre stavljamo u jedan array
    u0 = [0.0; 0.0] # podešavanje početnih uvjeta za put i brzinu
    tspan = (0.0, 50.0) # gledamo od 0 do 50 sekunde
    problem = ODEProblem(skok, u0, tspan, p) # zadaje se ODE problem - unutar solvea će se zvati naša prethodno napisana funkcija
    ## Rješimo problem
    sol = solve(problem)
    println(sol.u)
    if m == 60
        plot(sol, vars=(0, 1), label=string(m), legend=:bottomright)
        savefig("prikaz.png")
    else
        plot!(sol, vars=(0, 1), label=string(m), legend=:bottomright)
        savefig("prikaz.png")
    end
end
