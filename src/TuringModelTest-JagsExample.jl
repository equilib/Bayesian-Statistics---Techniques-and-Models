# @author b33rNc0d3
# @date 2020-06-10
# Using Turing to implement JAGS model from Coursera Bayesian Statistics: Techniques and Models

using Turing
using Distributions
using StatsPlots
using Random

Random.seed!(50)

@model TuringJagsModel(y) = begin
    μ ~ TDist(1.0)
    σ = 1.0
    N = length(y)

    for i = 1 : N
        y[i] ~ Normal(μ, σ)
    end
end;

y = [1.2, 1.4, -0.5, 0.3, 0.9, 2.3, 1.0, 0.1, 1.3, 1.9]

iterations = 1000
ϵ = 0.05
τ = 10

chain = sample( TuringJagsModel(y), HMC(ϵ, τ), iterations)

StatsPlots.plot(chain)

print(chain)
