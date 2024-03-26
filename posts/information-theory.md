+++
title= "Information Theory"
date= Date(2018,06,25)
+++

# {{title}}, {{ pretty_date date }}

I've recently been perusing an introductory text of [information theory](https://en.wikipedia.org/wiki/Information_theory). Information theory is one of those things that I have always wanted to look into but never gotten around to -- but now I am an adult with real things to try not to do, so I figured what the hell.

Information theory is the scientific study of how information can be quantified, stored, and communicated efficiently. It's fascinating to read the version of the book I have as the author (and Claude Shannon, the father of information theory) all viewed everything as telephonic or telegraphic. Pierce mentions computers a handful of times, but often only to describe what they are incapable of doing[^1].


Much of the content regards speech and how we can predict, transmit, and describe it. It appears to be primarily based on probability theory, and for good reason -- if you know that **E** appears 13% of the time and **Z** appears almost never, you can make asusmptions about how you code letters by assigning easily transmitted values for common symbols and more complex values for infrequent symbols.

The primary reason I'm reading it is for the applications to financial markets. A lot of the reason why information theory came about was because there was a need for sophisticated *signal processing* techniques during World War II. [Signal processing](https://en.wikipedia.org/wiki/Signal_processing) is something commonly applied to finance. Trades indicate resources, desire, risk tolerance, what have you -- but there's also a lot of noise. How do you tell people who are *informed* from people who are *uninformed*? How do you know whether a trade is actually meaningful to the long-term price of the stock?

Dunno. Thought I'd read about it though.

## References

[*An Introduction to Information Theory*](https://www.thriftbooks.com/w/an-introduction-to-information-theory_john-robinson-pierce/294512/?mkwid=sbM6YJYtB%7cdc&pcrid=70112900832&pkw=&pmt=&plc=&gclid=Cj0KCQjwpcLZBRCnARIsAMPBgF28X1wNo0AKYjuBEjeeBKTk73gnywqwZUJWQFnZ9DQwigTTOEG7_R8aArg3EALw_wcB#isbn=0486240614&idiq=3821805) by John R. Pierce.

[^1]: He calls them "automata", which is such a lovely old-timey phrase.
