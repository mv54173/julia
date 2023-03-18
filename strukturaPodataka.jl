str1 = "pisemo"
str2 = "nesto"
str3 = "za zabavu"

str1[3]
str3[2]
str2[2] = "s" # ne funkcionira

length(str1)
join([str1, str2], " i radimo ")
string(str1, str2, str3)
contains(str2, "nest")

a = [1, 2, 3, 4, 5]
b = [1.2, 3, 4, 5]

b[2]
a[0]    # !!!! sve je jedan-indeksirano

append!(a, 8)
println(a)
typeof(a)
a[3] = 6    #vektori (polja) se daju mijenjati
println(a)

d = Vector(1:0.5:10)  # Vector(start_value:step:end_value)
show(d)

mat1 = [1 2 3; 4 5 6] # !!! bez zareza
show(mat1)
mat1[2, 3]      # !!! pazi nije [i][j]
show(mat1[1, :])    # neki redak
show(mat1[:, 1])    # neki stupac

mat2 = mat1'  #kompleksno konjugirano transponiranje
show(mat2)  #može i mat1[:]
show(vec(mat1))
show(mat1 * mat2)     # množenje matrica
show(mat1 \ mat1)     # daje rješenj jednadžbe mat1*x=mat1

a = zeros(2, 3)        # inicijalizacija s nulama
a = ones(4, 3)         # inicijalizacija s jedinicama
a = 4 .* ones(4, 3)   # množenje matrice skalarom 
a = [2 2; 2 2] .* ones(4, 3)    # množi elemente na odgovarajućim indeksima
a = fill(7, 2, 8)     # fill(value, rows, columns)
a = rand(5, 6)

tablica = zeros(2, 3, 4)
for k in 1:4                            # na kraju for petlje mora ići end
    for j in 1:3
        for i in 1:2
            tablica[i, j, k] = i * j * k
        end
    end
end
show(tablica)

# konstantni nizovi
a = (1, 2, 3)
b = 1, 2, 3         #ekvivalentni su a i b

tuple1 = (1, 2, 3)
x, y, z = tuple1
print("$x $y $z")

