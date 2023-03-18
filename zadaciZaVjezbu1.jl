# 1. zadatak
x = y = 1
x
y
# vrijednost 1 zapiše se u obje varijable

# 2. zadatak
15 = a
# greške

# 3. zadatak
xy
# nedefinirana varijabla "xy"
x * y
# umnožak varijabli x i y

# 4. zadatak
function volume(a, tijelo)
    if tijelo == "kocka"
        V = a^3
    elseif tijelo == "sfera"
        V = 4 / 3 * pi * a^3
    else
        print("Tijelo nije kocka/sfera i volumen nije moguće izračunati")
        return
    end
    return V
end

volume(15, "kocka")
volume(10, "sfera")
volume(10, "konus")

# 5. zadatak
function apsolutna(a)
    if a < 0
        return -a
    else
        return a
    end
end

apsolutna(10)
apsolutna(-10)

# 6. zadatak
function udaljenost(x1, y1, x2, y2)
    return sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

udaljenost(2, 3, 7, 8)

# 7. zadatak
for i = 1:30
    if rem(i, 3) != 0
        print(i, " ")
    end
end


# 8. zadatak
count("a", "Volim studirati u Zagrebu!")