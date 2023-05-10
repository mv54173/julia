using DataFrames
using CSV


#funckija za odabir analitičkog modela
function analiticki(poc_god, zav_god, poc_pop, p, tip)
    pop = zeros(zav_god - poc_god + 1)  #inicijalizacija polja za rješenje modela
    god_rast, natalitet, mortalitet, alfa, beta = p #učitavanje podataka
    #odabir modela prema predanom tipu
    if tip == "lin"
        for i in 1:(zav_god-poc_god)+1
            if i == 1
                pop[i] = poc_pop    #populacija prve godine u rasponu
            else
                pop[i] = pop[i-1] + god_rast #dodavanje godišnjeg rasta na prošlogodišnji broj stanovnika
            end
        end
    elseif tip == "eks"
        for i in 1:(zav_god-poc_god)+1
            if i == 1
                pop[i] = poc_pop     #populacija prve godine u rasponu
            else
                pop[i] = pop[i-1] * (1 + (natalitet - mortalitet)) #izračun povećanja populacije u ovisnosti na stopu rođenja i smrti
            end
        end
    elseif tip == "log"
        K = -alfa / beta    # izračun kapaciteta okoliša
        for i in 1:(zav_god-poc_god)+1
            if i == 1
                pop[i] = poc_pop     #populacija prve godine u rasponu
            else
                pop[i] = pop[i-1] * (1 + alfa * (1 - pop[i-1] / K)) #izračun prema formuli za logističkirast
            end
        end
    else
        println("Krivi tip modela")
        return
    end
    return pop
end


# diferencijalna jednadžba za linearni rast populacije
linearni = function (du, u, p, t)
    god_rast = p
    du[1] = god_rast
end

# diferencijalna jednadžba za eksponencijalni rast populacije
eksponencijalni = function (du, u, p, t)
    natalitet, mortalitet = p
    du[1] = u[1] * (natalitet - mortalitet)
end

# diferencijalna jednadžba za logisticki rast populacije
logisticki = function (du, u, p, t)
    alfa, beta = p
    K = -alfa / beta
    du[1] = u[1] * alfa * (1 - u[1] / K)
end


#funckija za odabir odgovarajućeg modela 
function diferencijalne(tspan, poc_pop, p, tip)
    god_rast, natalitet, mortalitet, alfa, beta = p #učitavanje parametara
    sol = zeros(0)  #inicijalizacija polja rješenja
    #odabir modela prema predanom tipu
    if tip == "lin"
        problem = ODEProblem(linearni, [poc_pop], tspan, god_rast)
        sol = solve(problem)
    elseif tip == "eks"
        problem = ODEProblem(eksponencijalni, [poc_pop], tspan, (natalitet, mortalitet))
        sol = solve(problem)
    elseif tip == "log"
        problem = ODEProblem(logisticki, [poc_pop], tspan, (alfa, beta))
        sol = solve(problem)
    else
        println("Krivi tip modela")
        return
    end
    return sol
end


## podaci - učitavanje iz datoteke
populacija = CSV.read("Populacija_zemlja.csv", DataFrame)
delta_vrijeme = populacija[nrow(populacija), 1] - populacija[1, 1]
delta_populacija = (populacija[nrow(populacija), 2] - populacija[1, 2]) / 1e9
godine = populacija[:, 1]
broj_stanovnika = populacija[:, 2]
god_rast = delta_populacija / delta_vrijeme



##analitički modeli dosadašnjeg kretanje broja broja stanovnika
#podešavanje parametara za bolji fit
natalitet = 0.0215
mortalitet = 0.00514
alfa = 0.025
beta = -0.0018
p = (god_rast, natalitet, mortalitet, alfa, beta)

#poziv funckija i vizualizacija analitičkih rješenja
linAnalModel = analiticki(godine[1], godine[length(godine)], broj_stanovnika[1] / 1e9, p, "lin")
eksAnalModel = analiticki(godine[1], godine[length(godine)], broj_stanovnika[1] / 1e9, p, "eks")
logAnalModel = analiticki(godine[1], godine[length(godine)], broj_stanovnika[1] / 1e9, p, "log")
plot(godine, broj_stanovnika / 1e9, label="Podaci UN-a")
plot!(godine, linAnalModel, label="Analitički linearni model")
plot!(godine, eksAnalModel, label="Analitički eksponencijalni model")
plot!(godine, logAnalModel, label="Analitički logistički model")



##modeli projekcije populacije do 2100 pomoću diferencijalnih jednadžbi
#učitavanje UN-ove projekcije
projekcija = CSV.read("Projekcija.csv", DataFrame)
using DifferentialEquations


#podešavanje parametara za bolji fit
alfa = 0.0271
beta = -0.00235
natalitet = 0.0150
mortalitet = 0.0107
p = (god_rast, natalitet, mortalitet, alfa, beta)
vrijeme = (2020.0, 2100.0)

#poziv funckija i vizualizacija projekcija
linModel = diferencijalne(vrijeme, broj_stanovnika[length(broj_stanovnika)] / 1e9, p, "lin")
eksModel = diferencijalne(vrijeme, broj_stanovnika[length(broj_stanovnika)] / 1e9, p, "eks")
logModel = diferencijalne(vrijeme, broj_stanovnika[length(broj_stanovnika)] / 1e9, p, "log")
plot(projekcija[:, 1], projekcija[:, 2] / 1e9, label="UN projekcija")
plot!(linModel, vars=(0, 1), label="Analitički linearni model")
plot!(eksModel, vars=(0, 1), label="Analitički eksponencijalni model")
plot!(logModel, vars=(0, 1), label="Analitički logistički model")
