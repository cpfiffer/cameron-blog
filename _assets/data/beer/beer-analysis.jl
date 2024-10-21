using CSV, DataFrames, Plots
using Statistics

# Shitty beer has fields:
# - id
# - participant name (often missing)
# - beer_name
# - drinkability
# - bubble
# - america
# - mouthfeel
# - overall
# - participant guess

shitty_beer = CSV.read(
    "shitty-beer.csv", 
    DataFrame
)

actual_beer = CSV.read(
    "actual.csv", 
    DataFrame
)

beer = leftjoin(
    shitty_beer,
    actual_beer,
    on = :id
)

# Headline numbers
cmean(x) = mean(skipmissing(x))
let
    g = groupby(beer, :beer_name)
    combine(
        g, 
        :overall => cmean => :overall,
        :drinkability => cmean => :drinkability,
        :bubble => cmean => :bubble,
        :america => cmean => :america,
        :mouthfeel => cmean => :mouthfeel,
    )
end |> display

# Variance in ratings
cvar(x) = var(skipmissing(x))
let
    g = groupby(beer, :beer_name)
    combine(
        g, 
        :overall => cvar => :overall_var,
        :drinkability => cvar => :drinkability_var,
        :bubble => cvar => :bubble_var,
        :america => cvar => :america_var,
        :mouthfeel => cvar => :mouthfeel_var,
    )
end |> display

# Correlation between attributes
let
    attributes = [:drinkability, :bubble, :america, :mouthfeel, :overall]
    # Remove rows with any missing values for the selected attributes
    complete_cases = dropmissing(beer[:, attributes])
    
    if nrow(complete_cases) > 0
        cor_matrix = cor(Matrix(complete_cases))
        heatmap(String.(attributes), String.(attributes), cor_matrix, 
                title="Correlation between beer attributes",
                color=:viridis)
        savefig("beer_attribute_correlation.png")
        
        println("Correlation matrix calculated using $(nrow(complete_cases)) complete observations out of $(nrow(beer)) total.")
    else
        println("Warning: No complete cases found for the selected attributes. Unable to calculate correlation matrix.")
    end
end

# Distribution of overall ratings
histogram(beer.overall, 
          bins=20, 
          title="Distribution of Overall Ratings",
          xlabel="Rating", 
          ylabel="Frequency")
savefig("overall_ratings_distribution.png")

# Comparison of actual vs. participant guess
let
    # Remove rows with any missing values for the guess column
    complete_cases = dropmissing(beer, :guess)
    correct_guesses = sum(complete_cases.beer_name .== complete_cases.guess)
    total_guesses = nrow(complete_cases)
    accuracy = correct_guesses / total_guesses
    println("Guess accuracy: $(round(accuracy * 100, digits=2))%")
end

# Top 5 beers by overall rating
let
    top_beers = combine(groupby(beer, :beer_name), :overall => mean => :avg_overall)
    sort!(top_beers, :avg_overall, rev=true)
    println("Top 5 beers by overall rating:")
    display(first(top_beers, 5))
end

# Which participant is the best?
println("Average overall rating by participant:")
let
    # Remove rows with missing names or guesses
    complete_cases = dropmissing(beer, [:name])

    g = groupby(complete_cases, :name)
    c = combine(
        g, 
        :overall => cmean => :avg_overall
    )
    sort!(c, :avg_overall, rev=true)
    display(c)
end

# Average correct guesses by participant
println("Average correct guesses by participant:")
let
    complete_cases = dropmissing(beer, [:name, :guess])
    complete_cases[!, :correct] = complete_cases.beer_name .== complete_cases.guess
    g = groupby(complete_cases, :name)
    c = combine(g, :correct => cmean => :accuracy)
    sort!(c, :accuracy, rev=true)
    display(c)
end

# Average correct guesses by beer
println("Average correct guesses by beer:")
let
    complete_cases = dropmissing(beer, [:beer_name, :guess])
    complete_cases[!, :correct] = complete_cases.beer_name .== complete_cases.guess
    g = groupby(complete_cases, :beer_name)
    c = combine(g, :correct => cmean => :accuracy)
    sort!(c, :accuracy, rev=true)
    display(c)
end