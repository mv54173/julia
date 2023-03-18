# tri načina definiranja funkcija
function kvadrat1(x)
    return x * x    # kad ne bi bilo return vratilo bi x + x
    x + x
end
kvadrat2(x) = x * x
kvadrat3 = x -> x * x

# "void" i bezargumentna funkcija
function ispis_rezultata()
    println("Rezultat je izračunat")
end

# možemo postaviti argumente na default vrijednost
function mojaTezina(težinaNaZemlji, g=9.81)
    return težinaNaZemlji * g / 9.81
end

a, b, c = cos(0.5), sin(0.5), tan(0.5)
kvadrat = kvadrat1(23)
kvadrat = kvadrat2(24)
kvadrat = kvadrat3(25)
ispis_rezultata()
mojaTezina(100, 8)
mojaTezina(100)
