+++
title= "Shitty beer statistics"
date= Date(2024,10,20)
+++

My girlfriend Grace threw a "Shitty beer off" party, where participants were tasked with drinking a shitty beer and then rating it on a scale of 1 to 10. We provided 5 beers and double-blindly asked participants to rate them. 

Beers available were 

- PBR
- Coors
- Miller
- Hamms
- Bud

We asked participants to rate each beer on the following dimensions:

- Drinkability
- Bubble
- America Fuck Yeah-ness
- Mouthfeel
- Overall

Here's the data on the [actual beers](/assets/data/beer/actual.csv) and the participant's ratings on the [shitty beers](/assets/data/beer/shitty-beer.csv).

```
using CSV, DataFrames, Plots


```

## Average ratings

```
 Row │ beer_name  overall  drinkability  bubble   america  mouthfeel 
     │ String15?  Float64  Float64       Float64  Float64  Float64   
─────┼───────────────────────────────────────────────────────────────
   1 │ PBR        6.83333       7.46667  6.33333  5.66667    6.28571
   2 │ Budweiser  6.53846       7.15385  5.26923  7.76923    6.38462
   3 │ Hamms      6.375         6.75     5.4375   6.75       6.375
   4 │ Coors      4.43333       5.66667  3.93333  6.8        4.2
   5 │ Miller     4.33333       5.33333  4.33333  6.0        3.6
```

Takeaways:

- Budweiser is a drinkable beer, and also has the most America fuck-yeah-ness. *eagle noise*
- PBR is the best beer, but it is also has the least America fuck-yeah-ness. It's the shitty beer of the landed gentry.
- Coors and Miller are tied for the worst beers overall. Awful.

## Variance in ratings

```
 Row │ beer_name  overall_var  drinkability_var  bubble_var  america_var  mouthfeel_var 
     │ String15?  Float64      Float64           Float64     Float64      Float64       
─────┼──────────────────────────────────────────────────────────────────────────────────
   1 │ PBR            2.84524           3.98095     3.38095      3.95238        3.91209
   2 │ Budweiser      5.9359            5.47436     5.19231      2.69231        3.25641
   3 │ Hamms          3.58333           3.26667     4.39583      5.4            4.11667
   4 │ Coors          4.3881            9.52381     7.78095      2.74286        7.31429
   5 │ Miller         2.66667           7.66667     3.95238      4.61538        3.97143
```

Takeaways:

- Most people agree that PBR is the best beer.
- Most people agree that Miller is the worst beer.
- Bud is pretty controversial, with some people liking it and some people hating it, but overall it had a very high score.
- Coors has a lot of variance in ratings, as well as a low average rating.

## Correlation between attributes

![Correlation between attributes](/assets/data/beer/beer_attribute_correlation.png)

Takeaways:

- Overall and drinkability are the most correlated, perhaps this is obvious.
- Bubble also seemed to be an important attribute for the overall score, but to a lesser extent than drinkability.
- America fuck-yeah-ness seems to be correlated with _worse_ beers -- this is unsurprising. America-fuck-yeah-ness is about being on a speedboat on a lake, holding a rifle, waving a flag, and shooting at things with a tepid Coors Light in your hand.

## Guessing statistics

Participants were not good at guessing the correct beer. Total accuracy was 20.37%.

This did however vary by beer. Some beers were easier to guess than others.

```
 Row │ beer_name  accuracy 
     │ String15   Float64  
─────┼─────────────────────
   1 │ PBR        0.636364
   2 │ Miller     0.363636
   3 │ Budweiser  0.0
   4 │ Hamms      0.0
   5 │ Coors      0.0
```

Most participants identified PBR quickly, which was surprising. Miller was the only other beer that was guessed correctly. Coors, Bud, and Hamms were all guessed incorrectly by everyone, though this may have been due to the fact that the participants slowly became drunker the longer they were at the party.

We can also break this down by participant. We have several observations where no name was available, so this is restricted to the participants who provided a name.

```
 Row │ name     accuracy 
     │ String7  Float64  
─────┼───────────────────
   1 │ anna     0.5
   2 │ emily    0.4
   3 │ david    0.333333
   4 │ conner   0.25
   5 │ ashley   0.25
   6 │ andrew   0.2
   7 │ mark     0.2
   8 │ summer   0.2
   9 │ max      0.0
  10 │ pranay   0.0
```

Takeaways:

- Pranay and Max are idiots.
- Anna and Emily have classy, refined palates.
- David, Conner, and Ashley are not very good at guessing.
- Mark and Summer are somewhere in the middle.

## Conclusion

This was a fun party! Really great idea. I strongly recommend hosting a shitty-beer off.

Go buy some PBR. 

Or, well, basically any of the American craft beers, which are excellent. 

-- Cameron
