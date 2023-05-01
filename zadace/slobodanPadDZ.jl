## numeričko rješenje
# parametri
global m = 70
global C_d = 0.25
global g = 9.81
##

# određivanje nagiba funkcije
function deriva(v)
    dv = g - (C_d / m) * v * abs(v)
    return dv
end


#izračunavanje brzine pada s otporom zraka numeričkom metodom
function brzina(v_0, dt, t_p, t_k)
    n = (t_k - t_p) / dt
    v_vek = zeros(round(Int, (n + 1)))
    v_i = v_0
    v_vek[1] = v_i
    t_vek = zeros(round(Int, (n + 1)))
    t_i = t_p
    t_vek[1] = t_p
    s_vek = zeros(round(Int, (n + 1)))
    s_i = 0
    s_vek[1] = s_i
    n_check = 0
    for i = 1:n
        n_check = i
        d_vPod_t = deriva(v_i)
        v_i = v_i + d_vPod_t * dt
        v_vek[round(Int, 1 + i)] = v_i
        t_i = t_i + dt
        t_vek[round(Int, 1 + i)] = t_i
        s_i = s_i - v_i * dt
        s_vek[round(Int, 1 + i)] = s_i
    end
    # provjera ako je za zadnju vrijednost izračunata brzina 
    if n_check * dt + t_p != t_k
        dt = t_k - (n_check * dt + t_p)
        d_vPod_t = deriva(v_i)
        v_i = v_i + d_vPod_t * dt
        s_i = s_i - v_i * dt
        push!(v_vek, v_i)
        push!(t_vek, t_k)
        push!(s_vek, s_i)
    end
    return v_vek, t_vek, s_vek
end

# poziv funkcije za izračun brzine
v, t, s = brzina(0, 0.7, 0, 12)
# analitičko rješenje
v_anal = @.sqrt(g * m / C_d) * tanh(sqrt(g * C_d / m) * t)
# relativna greška
greska = @.((v_anal - v) / v_anal * 100)
#prikaz grafa brzine s označenim greškama u postotcima
plot(t, v, yerror=greska, label="Brzina ovisno o vremenu_numericki")
plot!(xlab="t [s]", ylab="v [m/s]")
plot(t, s, label="prijeđeni put")