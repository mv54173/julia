# 1. zadatak - preračunavanje iz °C u °F ili K ovisno o odabiru
function tempCalc(tC, type)
    if type == "Fahrenheit"
        return tC * 9 / 5 + 32
    elseif type == "Kelvin"
        return tC + 273.15
    else
        print("wrong type")
        return
    end
end

tempCalc(100, "Fahrenheit")
tempCalc(100, "Kelvin")

# 2. zadatak - računanje površine pravokutnog trokuta ovisno o zadanim stranicama

function areaOfRightTriangle(a=-1; b=-1, c=-1)
    if a > 0 && b > 0
        return a * b / 2
    elseif a > 0 && c > 0
        b = sqrt(c^2 - a^2)
        return a * b / 2
    elseif b > 0 && c > 0
        a = sqrt(c^2 - b^2)
        return a * b / 2
    end
    return "Greška"
end

areaOfRightTriangle(3, b=4)
areaOfRightTriangle(b=4, c=5)
areaOfRightTriangle(3, c=5)

# 3. zadatak - računanje površine trokuta preko stranica

function areaOfTriangle(a, b, c)
    s = (a + b + c) / 2
    return sqrt(s * (s - a) * (s - b) * (s - c))
end

areaOfTriangle(26, 28, 30)