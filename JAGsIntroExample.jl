# @author b33rNc0d3
# @date 2020-06-10
# Using Jags.jl to test an intro model

projDir = dirname(@__FILE__)
cd(projDir)


model_str = "model
    for (i in 1:n) {
        y[i] ~ dnorm(mu, 1.0/sig2)
        }
    mu ~ dt(0.0, 1.0/1.0, 1.0)
    sig2 = 1.0
    }"

monitors = Dict(
    "mu" => true
)

jagsmodel = Jagsmodel(
                        name = "model test",
                        model = model_str,
                        monitor = monitors,
                        #ncommands=1, nchains=4,
                        #deviance=true, dic=true, popt=true,
                        pdir=projDir
                    );

data = Dict(
            "y" => [1.2, 1.4, -0.5, 0.3, 0.9, 2.3, 1.0, 0.1, 1.3, 1.0]
            )

inits = [
    Dict("mu" => 0.0)
]

sim = jags(jagsmodel, data, inits, projDir)
