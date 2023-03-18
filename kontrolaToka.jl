function Pozdrav(vrijeme)
    if vrijeme < 10                 # !!! if završi s end-om
        pozdrav = "Dobro jutro"
    elseif vrijeme < 20
        pozdrav = "Dobar dan"
    else
        pozdrav = "Dobra večer"
    end
    println(pozdrav)
end

Pozdrav(9.5)

if 1 < 5 && 3 < 7
    print("točno")
end

x = 0
# klasična petlja
for i = 1:20
    x += i
end
show(x)

osobe = ["Ana", "Petar", "Ivana", "Marko"]

# foreach petlja
for osoba in osobe
    println("Bok $osoba")
end

for i = 1:35
    if rem(i, 7) != 0
        continue     # ostatak pri djeljenju
    end
    print("$i ")
end

# klasični while
i = 0
while i < 20
    i += 1
end
