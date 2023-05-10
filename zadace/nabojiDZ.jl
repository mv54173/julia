import Distributions: Uniform

# konstante
eps0 = 8.854e-12
k = 1 / (4 * π * eps0)

# funkcija za odrešivanje polja u svakoj točki mreže
function elektricnoPolje(koordinateNaboja, iznosNaboja, xG, yG, N, n, m)
    # inicijalizacija polja
    Ex = zeros(N, N)
    Ey = zeros(N, N)
    E = zeros(N, N)
    # iteriramo kroz svaku točku i koristimo funkciju poljeUTocki kako bismo
    # polje u pojedinoj točki
    for i = 1:N
        for j = 1:N
            E_ij, Ex_ij, Ey_ij = poljeUTocki(koordinateNaboja, iznosNaboja, xG[i, j], yG[i, j], n, m)
            E[i, j] = E_ij
            Ex[i, j] = Ex_ij
            Ey[i, j] = Ey_ij
        end
    end
    return E, Ex, Ey    # vraćamo ukupni vektore polja kao i rastav na x i y komponente
end

# funkcija za određivanje električnog polja u jednoj točki
function poljeUTocki(koordinateNaboja, iznosNaboja, x, y, n, m)
    Ex = Ey = 0     #početne vrijednosti polja
    # dodajemo utjecaj svakog polja po načelu superpozicije
    for i = 1:(n+m)
        Rx = x - koordinateNaboja[i, 1]
        Ry = y - koordinateNaboja[i, 2]
        R = sqrt(Rx^2 + Ry^2)^3
        Ex += k * (i < n ? iznosNaboja : -iznosNaboja) * Rx / R
        Ey += k * (i < n ? iznosNaboja : -iznosNaboja) * Ry / R
    end
    println(string(Ex) * " " * string(Ey))
    return sqrt(Ex^2 + Ey^2), Ex, Ey  # vraćamo ukupni iznos polja kao i rastav na x i y komponentu
end


# funkcija za generiranje mreže
function mreza(koordinateNaboja, N)
    # određivanje granica
    minX = floor(minimum(koordinateNaboja[:, 1]) * 2)
    maxX = ceil(maximum(koordinateNaboja[:, 1]) * 2)
    minY = floor(minimum(koordinateNaboja[:, 2]) * 2)
    maxY = ceil(maximum(koordinateNaboja[:, 2]) * 2)
    x = range(minX, maxX, length=N)         # x koordinate mreže
    y = range(minY, maxY, length=N)         # y koordinate mreže
    return x' .* ones(N), ones(N)' .* y     # generirana mreža
end



#ulazni podaci
n = 10               #broj pozitivnih naboja
m = 10               #broj negativnih naboja
maksNaboj = 30       #maksimalna apsolutna vrijednost naboja
maksUdaljenost = 2   #maksimalna apsolutna udaljnost naboja od ishodišta
N = 25               #gustoća koordinatne mreže


# generiranje koordinata naboja:
# prvih n za pozitivne, a ostali za negativne
koordinateNaboja = rand(Uniform(-maksUdaljenost, maksUdaljenost), n + m, 2)

# slučajno izgenerirane vrijednosti pozitivnih i negativnih naboja 
iznosNaboja = rand(Uniform(0, maksNaboj))

# definicija mreže
xG, yG = mreza(koordinateNaboja, N)

#izračun vektora polja
E, Ex, Ey = elektricnoPolje(koordinateNaboja, iznosNaboja, xG, yG, N, n, m)


#vizualizacija
using Plots
gr()

# normiranje vrijednosti polja
u = Ex ./ E
v = Ey ./ E

# pozicioniranje naboja u plot
Plots.scatter(koordinateNaboja[1:n, 1], koordinateNaboja[1:n, 2], label="Pozitivni naboj", aspect_ratio=:equal)
Plots.scatter!(koordinateNaboja[n+1:n+m, 1], koordinateNaboja[n+1:n+m, 2], label="Negativni naboj", aspect_ratio=:equal)

for i = 1:N
    display(quiver!(xG[i, :], yG[i, :], quiver=(u[i, :] / 10, v[i, :] / 10)))
end
