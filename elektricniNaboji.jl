# konstante
eps0 = 8.854e-12
k = 1 / (4 * π * eps0)

#ulazni podaci
x1 = 0.5        # x koordinata od Q1
y1 = 0          # y koordinata od Q1
Q1 = -20        # iznos prvog naboja

x2 = -0.5       # x koordinata od Q2
y2 = 0          # y koordinata od Q2
Q2 = +20        # iznos drugog naboja  

# !!MODEL - funkcije i matematika!!
# definicija mreže
N = 20          # granice i gustoća mreže
minX = -2
maxX = 2
minY = -2
maxY = 2

x = range(minX, maxX, length=N)     # x koordinate točaka
y = range(minY, maxY, length=N)     # y koordinate točaka

xG = x' .* ones(N)                  # mreža x koordinata
yG = ones(N)' .* y                  # mreža y koodrinata

#izračun vektora polja
Rx = xG .- x1;
Ry = yG .- y1;
R = sqrt.(Rx .^ 2 + Ry .^ 2) .^ 3

Ex = k .* Q1 .* Rx ./ R
Ey = k .* Q1 .* Ry ./ R

Rx = xG .- x2
Ry = yG .- y2
R = sqrt.(Rx .^ 2 + Ry .^ 2) .^ 3

Ex += k .* Q2 .* Rx ./ R
Ey += k .* Q2 .* Ry ./ R

#rezultat - izračun ukupnog polja
E = sqrt.(Ex .^ 2 + Ey .^ 2)

u = Ex ./ E   # normiranje vrijednosti polja
v = Ey ./ E

#vizualizacija
using Plots
gr()

# pozicioniranje naboja u plot
Plots.scatter([x1 x2], [y1 y2], label="Naboj", aspect_ratio=:equal)

for i = 1:N
    display(quiver!(xG[i, :], yG[i, :], quiver=(u[i, :] / 10, v[i, :] / 10)))
end

# random koordinate u vektori i podešavanje mreže prema tome, funkcije
# izborni zadatak: napraviti za više naboja (skini Distributu)