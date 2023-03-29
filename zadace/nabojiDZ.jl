import Distributions: Uniform

# konstante
eps0 = 8.854e-12
k = 1 / (4 * π * eps0)

function elektricnoPolje(koordinateNaboja, iznosNaboja, xG, yG, N)
    n = Int(sizeof(koordinateNaboja[:, 1]) / 8)
    Ex = Ey = zeros(N, N)
    for i = 1:n
        Rx = xG .- koordinateNaboja[i, 1]
        Ry = yG .- koordinateNaboja[i, 2]
        R = sqrt.(Rx .^ 2 + Ry .^ 2) .^ 3
        Ex += k .* iznosNaboja[i] .* Rx ./ R
        Ey += k .* iznosNaboja[i] .* Ry ./ R
    end
    return Ex, Ey
end



#ulazni podaci



koordinateNaboja = rand(Uniform(-1, 1), 10, 2)
iznosNaboja = rand(Uniform(-30, 30), 10)

koordinateNaboja[2, 2]


# !!MODEL - funkcije i matematika!!
# definicija mreže
# granice i gustoća mreže
N = 25
minX = minimum(koordinateNaboja[:, 1]) * 2
maxX = maximum(koordinateNaboja[:, 1]) * 2
minY = minimum(koordinateNaboja[:, 2]) * 2
maxY = maximum(koordinateNaboja[:, 2]) * 2

x = range(minX, maxX, length=N)     # x koordinate točaka
y = range(minY, maxY, length=N)     # y koordinate točaka

xG = x' .* ones(N)                  # mreža x koordinata
yG = ones(N)' .* y                  # mreža y koodrinata



Ex = zeros(N, N)
Ey = zeros(N, N)
#izračun vektora polja

Ex, Ey = elektricnoPolje(koordinateNaboja, iznosNaboja, xG, yG, N)

#rezultat - izračun ukupnog polja
E = sqrt.(Ex .^ 2 + Ey .^ 2)

u = Ex ./ E   # normiranje vrijednosti polja
v = Ey ./ E

#vizualizacija
using Plots
gr()

# pozicioniranje naboja u plot
Plots.scatter(koordinateNaboja[:, 1], koordinateNaboja[:, 2], label="Naboj", aspect_ratio=:equal)

for i = 1:N
    display(quiver!(xG[i, :], yG[i, :], quiver=(u[i, :] / 10, v[i, :] / 10)))
end

# random koordinate u vektori i podešavanje mreže prema tome, funkcije
# izborni zadatak: napraviti za više naboja (skini Distributu)