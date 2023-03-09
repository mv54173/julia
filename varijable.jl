#tipovi podataka
ime = "Marko Varga"
godine = 21
tezina = 75
visina = 179.8
println(ime, " ima ", godine, " godinu")
typeof(ime)
typeof(godine)
typeof(visina)
a = 5
b = 3.0
println(typeof(a - b))
1.5e-2
1.5f-2
1 / Inf
1 / 0
100 - Inf
Inf - Inf
1 + 2.5im
typeof(1 + 2.5im)
rac = 35 // 75
numerator(rac)
5 < 2
typeof(ans)
#scope of variables
function proba()
    global z = 2.5
    return
end

#osnovne aritmeticke operacije
a = 5
b = 7
zbroj = a + b
oduzimanje = a - b
umnozak = a * b
dijeljenje = a / b
cjelobrojno_dijeljenje = a // b
potencija = a^b

#osnove logicke operacije
a == b
a > b
a === b
a <= b