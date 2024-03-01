using GLMakie

## numerical answer
midpoint(p1, p2) = (p1 + p2) / 2
radius(p1, p2) = 0.5 * sqrt(sum(abs2, p2 - p1))
inside(p1, p2) = all(radius(p1, p2) .≤ midpoint(p1, p2) .≤ 1 - radius(p1, p2))

trials = (inside(rand(2), rand(2)) for _ in 1:1_000_000)
answer = 1 - (count(trials) / length(trials)) # probability some part of circle is outside square

## try to draw problem
let
    f = Figure()
    ax = Axis(f[1, 1], autolimitaspect=1)

    N = 1000
    x = 0
    for i in 1:N
        empty!(ax)
        p1 = rand(Point2)
        p2 = rand(Point2)
        centre = (p1 + p2) / 2
        radius = sqrt(sum(abs2, p1 - p2)) / 2
        poly!(ax, Point2[(0.0, 0.0), (0.0, 1.0), (1.0, 1.0), (1.0, 0.0)], color=:transparent, strokewidth=2)
        scatter!(ax, p1)
        scatter!(ax, p2)

        poly!(ax, Circle(centre, radius))

        # extreme points of circle
        is_inside = inside(p1, p2)
        is_inside ? ax.title[] = "inside" : ax.title[] = "outside"
        x += !is_inside
        @show x / i
        display(f)
        sleep(0.5 * (100 / N)^2)
    end
    ax.title[] = "relative frequency of circles outside: $(round(x/N, digits=2))"


    f
end


xs = (rand(4) for _ in 1:1_000_000)
count(xs) do x
    x1, y1, x2, y2 = x
    radius = 0.5 * sqrt((x2 - x1)^2 + (y2 - y1)^2)
    midpointx = (x1 + x2) / 2
    midpointy = (y1 + y2) / 2
    insidex = radius ≤ midpointx ≤ (1 - radius)
    insidey = radius ≤ midpointy ≤ (1 - radius)

    return insidex && insidey
end / length(xs) |> x -> (1 - x)

count(xs) do x
    x1, y1, x2, y2 = x
    # radius = 0.5 * sqrt((x2 - x1)^2 + (y2 - y1)^2)
    # midpointx = (x1 + x2) / 2
    # midpointy = (y1 + y2) / 2
    # c1 = midpointx ≤ radius
    # c2 = midpointx ≥ 1 - radius
    # c3 = midpointy ≤ radius
    # c4 = midpointy ≥ 1 - radius

    c1 = x1 * x2 ≤ ((y2 - y1) / 2)^2
    c2 = (x1 - 1) * (x2 - 1) ≤ ((y2 - y1) / 2)^2
    c3 = y1 * y2 ≤ ((x2 - x1) / 2)^2
    c4 = (y1 - 1) * (y2 - 1) ≤ ((x2 - x1) / 2)^2


    # return c1 || c2 || c3 || c4
    return (!c1 && !c2 && !c3 && !c4)
end / length(xs)



##
x1s = range(0, 1, length=100)
x2s = range(0, 1, length=100)
surface(x1s, x2s, (x1, x2) -> x1 * x2, colormap=:reds)
surface!(x1s, x2s, (x1, x2) -> (x1 - 1) * (x2 - 1), colormap=:blues)