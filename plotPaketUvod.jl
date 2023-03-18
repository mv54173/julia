#using Plots    # može plotly, ali najbolje gr kak dole
#plotly()

using Plots
gr()

x = 1:0.1:2*π

y = cos.(x) .^ 2

plot(x, y, label="cos(x)^2")
plot!(xlab="x", ylab="f(x)")
y2 = sin.(x) .^ 2
plot!(x, y2, label="sin(x)^2")
savefig("prvi_img.png")

a = 1:20;
b = rand(20, 5);
c = 1:5;
d = rand(5, 2);
g = 1:25;
h = 1:25;
p1 = plot(a, b)     #linijski
p2 = scatter(a, b)  #točkasti
p3 = plot(a, b, xlabel="a", lw=0.5, title="proba")
p4 = histogram(c, d)

# DZ!!! prejdi vizualizaciju
# zadaci za vježbu budu objavljanji
