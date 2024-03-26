+++
title= "Bayesian econometrics"
date= Date(2020,03,24)
+++

# Introduction

Since I'm in social distancing mode, I figured it would be a good time to write a blog post on Bayesian methods and financial economics. I have written a post in quite a while, as the past year and a half or so have been a busy time for me. The finance PhD takes up most of my time, as well as my work on [Turing.jl](https://turing.ml), a [probabilistic programming language](https://en.wikipedia.org/wiki/Probabilistic_programming) (PPL) for Julia. 

Before I continue, I want to make sure people understand my perspective. I do not work in fields of economics that people tend to think of when they think of economics -- maybe you think of labor, health, or macroeconomics, all of which are valuable fields that I know very little about. I study finance, which is the study of how money and securities are used and what they do to the economy. Keep that in mind as we go along. I'm in a smaller subfield of economics that shares many of the same methodologies and language, but is applied to the theory of the firm and to asset prices.

Back to Turing.jl. Everyone who works on Turing is of an extremely high quality level. They are all typically very skilled in their respective computational or statistical domains, and it is easy to feel a little out of place. I am not an optimization person, or a machine learning person, or even really anyone with any measure of formal engineering training[^training].

[^training]: I do have industry experience, but it's not a perfect substitute. It helps a lot to have thought about all the little fiddly bits that go into Turing.

I am, however, a financial economist (with training wheels). Working on Turing and spending a lot of time with CS and statistics people who are not economists has been particularly eye-opening, because economics is a unique field that I think tends to stand out in the sciences. Here's why:

## Ground truth

As with all social sciences, **ground truth is hard to come by**. In any of the hard sciences like physics, you can hypothesize something, and then sometimes you can spend hundred of millions of dollars to see if it is true. In economics, we don't really have this. You can't run experiments where you make half of all pregnant mothers smoke to see what happens to their kids, or randomly assign particular directors to company boards. 

## Causal inference

**Causal inference is the name of the game**. Economics is about how thing A causes thing B to change. The field has built up an enormous set of statistical tools just to identify whether and how a thing is causal, and many of these tools are commonly only used in social sciences[^iv].


[^iv]: Do physics people use [instrumental variables](https://en.wikipedia.org/wiki/Instrumental_variables_estimation)?

## Economists love math

**Economics is mathematical**. Because economists don't have ground truth, they build models of behavior and attempt to match empirical facts to what theory suggests should exist. Economists tend to bash other social scientists (especially sociology, sorry folks) because their methods are less sophisticated. Economists even bash financial economists like me, because we tend to be 5-10 years behind economics writ-large in terms of empirical and theoretical methodologies. 

# Bayesian methods and economics

I'm going to talk about how I think Bayesian methods are being used currently in financial economics, why I think Bayesian methods should be used more in empirical economics. I also want to pitch Turing.jl as a way for researchers to do more of this, if only because it is very easy to do so.

I mentioned before that economics does not have ground truth. There will never be a point when a researcher can be confident that their model is 100% correct, or that their parameter estiamtes are accurate. It's just not possible -- economics is the science of choices by people. People are made up of angry goop and they can behave irrationally at times, so a deterministic model is pretty hard to specify. 

That's why economists use standard errors, and think so hard about whether their model is free from material omitted bias, heteroskedasticity, etc. Standard errors in OLS (or whatever your method is) give you a good proxy for the variance of your estimator, assuming that estimator is normal. 

Economists have many ways to think about standard errors and causal inference -- do your errors have some kind of autocorrelation? What if clusters of observation share some common error? Does the instrument you are using satisfy the necessary requirements? These kinds of questions are where economics shines the brightest. Because there is no ground truth, you want to be as confident as you can when you say something.

## Bayesian methods

What does any of this have to do with Bayesian methods? Well, my biggest issue with contemporary econometrics is the use of priors. Every single time someone runs a regression with `lm(y ~ x, data)` or `reg y x`, they are doing a very specific thing. OLS is simply the [maximum a posteriori](https://en.wikipedia.org/wiki/Maximum_a_posteriori_estimation) estimate of the model's parameters with a flat prior everywhere, also called [maximum likelihood](https://en.wikipedia.org/wiki/Maximum_likelihood_estimation). By doing this, you let the data speak for you, which I am generally in favor of. 

But sometimes priors matter! When you have small datasets or multiple posterior  modes, sometimes priors can get your estimates to where you think is reasonable (conditional on a good prior). 

It's not like economists have a shortage of priors, either. Good papers are either backed by good theory or show intuitive relationships that don't need a formal theoretical link, and in all cases you can typically say something like 

> If the relationships in Person (2030) hold, then $\alpha > 1$.

Sounds like a prior to me. You can use theoretical predictions to motivate priors when you're writing models.

## The state of Bayesian methods in finance

My perception is that Bayesian methods are still somewhat fringe, but that they have a slight but regular appearance in finance. I went to our top journal, the [Journal of Finance](https://afajof.org/), and searched for the word "bayesian". I grabbed any of the papers that are not pure theory. Here's a list of papers that turned up:

- Cavagnaro et al. (2019). [Measuring Institutional Investors’ Skill at Making Private Equity Investments](https://onlinelibrary.wiley.com/doi/full/10.1111/jofi.12783).
- Pástor (2000). [Portfolio Selection and Asset Pricing Models](https://onlinelibrary.wiley.com/doi/full/10.1111/0022-1082.00204).
- Pástor and Stambaugh (1999). [Costs of Equity Capital and Model Mispricing](https://onlinelibrary.wiley.com/doi/full/10.1111/0022-1082.00099).
- Johannes, Lochstoer, and Mou (2016). [Learning About Consumption Dynamics](https://onlinelibrary.wiley.com/doi/full/10.1111/jofi.12246).
- Lamoureux and Witte (2002). [Empirical Analysis of the Yield Curve: The Information in the Data Viewed through the Window of Cox, Ingersoll, and Ross](https://onlinelibrary.wiley.com/doi/full/10.1111/1540-6261.00467).
- Kandel and Stambaugh (1996). [On the Predictability of Stock Returns: An Asset‐Allocation Perspective](https://onlinelibrary.wiley.com/doi/full/10.1111/j.1540-6261.1996.tb02689.x).
- Barillas and Shanken (2018). [Comparing Asset Pricing Models](https://onlinelibrary.wiley.com/doi/full/10.1111/jofi.12607). 
- Rouwenhorst (1999). [Local Return Factors and Turnover in Emerging Stock Markets](https://onlinelibrary.wiley.com/doi/full/10.1111/0022-1082.00151).
- Brav (2000). [Inference in Long‐Horizon Event Studies: A Bayesian Approach with Application to Initial Public Offerings](https://onlinelibrary.wiley.com/doi/full/10.1111/0022-1082.00279).
- Baks, Metrick, and Wachter (2001). [Should Investors Avoid All Actively Managed Mutual Funds? A Study in Bayesian Performance Evaluation](https://onlinelibrary.wiley.com/doi/full/10.1111/0022-1082.00319).
- Busse and Irvine (2006). [Bayesian Alphas and Mutual Fund Persistence](https://onlinelibrary.wiley.com/doi/full/10.1111/j.1540-6261.2006.01057.x).

Many of these papers use explicitly derived analytic forms, explicit Gibbs conditionals, or very basic MCMC models. Very few of these models are non-linear models, and in most cases they tend to be regular frequentist econometrics with the addition of a density function. 

# What's cool

My favorite papers apply Bayesian methods in a more interesting way. One example is [Barillas and Shanken (2018)](https://onlinelibrary.wiley.com/doi/full/10.1111/jofi.12607), who use a closed form solution to analyze the efficacy of various factor models. I like this paper quite a lot, but I think that researchers tend to work really hard to derive closed form solutions when they are not really ncessary. For example, [Chib, Zeng, and Zhao (2020)](https://onlinelibrary.wiley.com/doi/full/10.1111/jofi.12854) attempted to replicate Barillas and Shanken, and noticed that the use of a Jeffrey's prior on nuisance parameters makes the closed form solution unsound. 

You can avoid this by just numerically solving your model. I believe that we should start thinking more and more computationally as our models become more complex, and Markov Chain Monte Carlo lets you do this. Importantly, this is easier now that ever. It's not 2002 anymore and you don't have to roll your own Gibbs sampler every time you need to solve some model. You can just use a probabilistic programming language like Turing[^book]!

[^book]: Some other good PPLs are [Stan](https://mc-stan.org/), [Soss.jl](https://github.com/cscherrer/Soss.jl), [PyMC](https://docs.pymc.io/), and [Pyro](http://pyro.ai/), among many others.

Don't get me wrong -- I love theory as much as the next person. Theory is good for telling stories, whereas empirics are good for proving those stories. Or theory is getting more and more complex, and our empirics should rise to meet the challenge. Additionally, I think where Bayesian methods are concerned, people try to mix theory and empirics too closely, and they end up looking for closed form solutions where there are none.

I want to present a rough sketch of how I think about this, and how I'd do it computationally. Assume that there are $N$ factor models, each of which returns an expected return from a function `r(m, t, x)` for factor model index `m`, time `t`, and observable data `x`. Assume `x` is a matrix of returns and factors for one security. One nice way to do this in Turing is

```julia
# Import Turing
using Turing

#
# Declare our probabilistic model.
# - models is a vector of functions, r(n, t, x), that return an expected return.
# - data is a matrix with returns in the first column, and factors in the remaining columns.
# 
@model factors(models, data) = begin
    # Choose which model is "true", all models have equal priors.
    m ~ Categorical(length(models))

    # Draw a variance parameter.
    σ ~ InverseGamma(2,3)

    # Estimate each return.
    r_hat = r.(m, 1:size(data, 1), data)

    # Check the model's predictions:
    data[:, 1] ~ MvNormal(r_hat, σ)
end
```

And you're done! You can run this on whatever sampling method you want, and it'll give you posterior probabilities for models. As valuable as raw math is, sometimes it's nice to just type the model up and see what the data says, assuming you've thought about all the econometric issues as you normally would.

# Hopes

In this section, I want to talk about some things I want to see more of going forward.

## Structural estimation

Structural estimation is a really beautiful tool. When you structurally estimate something, you marry theory and empirics to determine the effect of some parameter. For the most part, it is done in a frequentist way by matching moments between simulated data and empirical data. You can do structural estimation in a Bayesian way by specifying a very general probabilistic model and then running it through your PPL of choice. Not only does this give you parameter estimates, but it also tells you how uncertain you are of those estimates. You might even learn that your parameterizations are multimodal, and that there are numerous nontrivial outcomes in your model that a simulated method of moments estimation might miss.

## Prior sensitivity

Bayesian methods let you test how realistic something is. I read a cool working paper a little while ago called [Volatility Expectations and Returns](https://sites.google.com/site/lalochstoer/VolUnderreactionMain.pdf?attredirects=0&d=1) by Lars Lochstoer and Tyler Muir. They propose a novel behavioral explanation of some weird patterns in the VIX, realized volatility, returns, and the variance risk premium. Essentially, if investors use too much of past variance to form their expectations about current variance, you can explain many strange effects in markets. 

The problem with behavioral papers is that they don't quite site right with finance folks, because it's very easy to say that some arbitrageur should have removed this anomaly. Rob Ready (here at the University of Oregon) asked how strong your priors would have to be on using old observations of variance for this effect to matter, and we can test this! Build a model of stoachastic volatility and conditional expectations, and you should be able to fiddle with your model priors until something cool comes out.

## Latent variables

Bayesian methods are interesting when you apply them to inferring latent variables. In finance, these might be things like managerial skill, expected return, volatility, etc. We've got all kinds of things we don't directly observe but have models to explain how they interact when other stuff. When you know that X goes up when Y does, you can start to run inference on the relationships between X and Y even when you can't observe Y, though as always, it helps to have lots of data.

# Conclusion

This was a bit of a rambling post, but I'm trying to get some thoughts on paper. What a time to be alive.