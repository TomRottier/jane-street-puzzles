# February 2024

## Question
Given two uniformly distributed random points in the unit square, make a circle such that each point is on its circumference. What is the probability that some portion of the circle is outside the square?

[Link to puzzle](https://www.janestreet.com/puzzles/some-off-square-index/)


## Working
- May have something to do with the magnitude of random vectors
- The probability that the length of a random standard uniform 2D vector $\mathbf{x} = [x_1,x_2]$ is less than $a$ is given by: 

$$ \begin{equation*}
    P(\lVert\mathbf{x}\rVert < a ) = \int_0^a \int_0^{\sqrt{a^2 - x_1^2}} dx_1 dx_2 = a^2 \frac{\pi}{4}
\end{equation*}
$$
- Equivalently the probability is the ratio of the area of the sample space where $\lVert\mathbf{x}\rVert < a$ to the total area of the sample space. For a standard uniform 2D sample space the total area is $1$ and the area where $\lVert\mathbf{x}\rVert < a$ is given by a quarter circle centred at the origin with radius of $a$ with area of $\frac{\pi a^2}{4}$. The ratio of which gives the same answer as above.
- The expectation of the squared length of a random uniform vector is $2/3$ which is given by:
$$
\mathbb{E}[\lVert\mathbf{X}\rVert^2] = \int_0^1 \int_0^1 x_1^2 + x_2^2 \, dx_1dx_2 = \frac{2}{3}
$$
- The expectation of the length of a random uniform vector is given by (taken from Wolfram Alpha, can't find an analytical solution):
$$
\begin{equation*}
    \mathbb{E}[\lVert\mathbf{X}\rVert] = \int_0^1 \int_0^1 \sqrt{x_1^2 + x_2^2} \, dx_1dx_2 = \frac{1}{3} \left(\sqrt{2}+ \sinh^{-1}{1} \right) \approx 0.765
\end{equation*}
$$
- Can also solve by converting to polar coordinates, with some help from Google:
$$
\begin{align*}
    \int_0^1 \int_0^1 \sqrt{x_1^2 + x_2^2} \, dx_1dx_2 &= 2\int_0^{\frac{\pi}{4}}\int_0^{\sec{\theta}} r^2 \, drd\theta \\ 
    &= \frac{2}{6}\left[\sec\theta\tan\theta + \ln |\sec\theta + \tan\theta|  \right]^{\frac{\pi}{4}}_0 \\
    & = \frac{1}{3}\left[\sqrt{2} +\ln(\sqrt{2} + 1)\right] \\
    &\approx 0.765
\end{align*}
$$
- Expected value for the angle a random standard uniform vector makes with the horizontal is:
$$
\begin{equation*}
    \int_0^1 \int_0^1 \arctan \frac{x_2}{x_1} \, dx_1dx_2 = \frac{\pi}{4}
\end{equation*}
$$
- Expected value for random point inside unit square will be $[0.5, 0.5]$.
- PDF for absolute difference of two uniform random variables, $|\Delta X| = |x_1 - x_2|$ is:
$$
\begin{equation*}
    f_{\Delta X}(x) = 2(1 - x) \,, 0 \le x \le 1
\end{equation*}
$$
- PDF for the squared difference $(\Delta X)^2 = (x_1 - x_2)^2$ given by:
$$
\begin{equation*}
    f_{(\Delta X)^2}(x) = \frac{1}{\sqrt{x}} - 1
\end{equation*}
$$
- Which has a CDF:
$$
\begin{equation*}
    F_{(\Delta X)^2}(X) = 2\sqrt{x} - x
\end{equation*}
$$
- CDF of $Z = \left(\frac{y_2 - y_1}{2}\right)^2$ given by $F_z(z) = 4\sqrt{z} - 4z$ 

## Solution
- For a given midpoint $\mathbf{m} = \left(\frac{x_1+x_2}{2}, \frac{y_1+y_2}{2}\right)$ and radius $r = \frac{1}{2}\sqrt{(x_2-x_1)^2 + (y_2-y_1)^2}$, the circle is entirely within the square if: $r \le \mathbf{m} \le 1 - r$.
- The complement of this gives the conditions, of which at least one must be true, for any point of the circle to be outside of the square:
$$
\begin{cases}
    \frac{x_1+x_2}{2} \lt \frac{1}{2}\sqrt{(x_2-x_1)^2 + (y_2-y_1)^2} \\
    \frac{x_1+x_2}{2} \gt 1 - \frac{1}{2}\sqrt{(x_2-x_1)^2 + (y_2-y_1)^2} \\
    \frac{y_1+y_2}{2} \lt \frac{1}{2}\sqrt{(x_2-x_1)^2 + (y_2-y_1)^2} \\
    \frac{y_1+y_2}{2} \gt 1 - \frac{1}{2}\sqrt{(x_2-x_1)^2 + (y_2-y_1)^2}
\end{cases}
$$
- These conditions simplify to:
$$
\begin{cases}
    x_1x_2 \lt \left(\frac{y_2 - y_1}{2}\right)^2 \\
    (x_1-1)(x_2-1) \lt \left(\frac{y_2 - y_1}{2}\right)^2 \\
    y_1y_2 \lt \left(\frac{x_2 - x_1}{2}\right)^2 \\
    (y_1-1)(y_2-1) \lt \left(\frac{x_2 - x_1}{2}\right)^2 \\

\end{cases}
$$
- The probability of any part of the circle being outside the square is therefore the probability of any of the conditions being true. Conversely, and probably easier to calculate, this probability is also $1$ minus the complement e.g. $1$ minus the the probability that all events are true

- The probability of the first condition can be calculated as follows:
    - Let $X = x_1x_2$ and therefore has pdf $f_X(x) = \log{\frac{1}{x}}$ over support $0 \le x \le 1$
    - Let $Y = \left(\frac{y_2-y_1}{2}\right)^2$ and therefore has pdf $f_Y(y) = \frac{2}{\sqrt{y} - 4}$ over support $0 \le y \le 0.25$
    - The two random variables are independent, therefore the joint pdf is given by: $f_{X,Y}(x,y) = \ln{\frac{1}{x}}\left(\frac{2}{\sqrt{y}} - 4\right)$ over the support $0 \le x \le 1, 0 \le y \le 0.25$
    - The support of the joint pdf is a rectangle with side length of $0.25$ and $1$. 
    - Separate the area of the support by the line $y = x$.
    - The $P(X \le Y)$ is given by integrating the joint pdf over the area of the support below this line.
    - This area can be split into two regions: a rectangle equal to $x \ge 0.25, y = 0.25$ and a triangular region sandwiched between $y = x$ and $y = 0.25$
    - Integrating over the rectangular area:
    $$
        \int_{0.25}^1 \int_0^{0.25} \ln{\frac{1}{x}}\left(\frac{2}{\sqrt{y}} - 4\right)\, dydx \approx 0.403426
    $$
    - Integrating over the triangular area:
    $$
        \int_0^{0.25}\int_0^x \ln{\frac{1}{x}}\left(\frac{2}{\sqrt{y}} - 4\right)\, dxdy \approx 0.448534 
    $$
    - The sum of these two probabilities and thus $P(X \le Y) \approx  0.85196$
- For the second case, the PDF of $(x_1-1)(x_2-1)$ is actually the same as for $x_1x_2$ and therefore the probability of the second case is is the same.
- The third and fourth cases also have the same probability as each random variable is iid and so could be swapped out interchangeably.
- Probability of the first case and the second case being true for a given $Y =  \left(\frac{y_2 - y_1}{2}\right)^2$ is given by:
    - Separate the support by the lines $x_2 = Y/x_1$ and $x_2 = 1 + Y/(x_1-1)$. The area below the first line and above the second give the conditions for when the two cases are both true
- Each condition defines a 3D volume in 4D space, the intersection of the four volumes gives the values of the variables for which all conditions are true. The probability of all four conditions being true is the integral of the joint pdf over this volume.

