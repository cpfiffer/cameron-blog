+++
title= "MD&A Paper Summary"
date= Date(2018,10,13)
+++

__This was written as a summary for an interesting paper I read for a class on whether or not the MD&A section of financial statements can be predictive of bankruptcy.__[^a]

[^a]: Mayew, William J., Mani Sethuraman, and Mohan Venkatachalam. _MD&A Disclosure and the Firm’s Ability to Continue as a Going Concern_. The Accounting Review 90, no. 4 (July 2015): 1621–51. https://doi.org/10.2308/accr-50983.

Mayew, Sethuraman and Venkatachalam (2015) present a study on the role that the textual properties of a firm's MD&A section plays in predicting bankruptcy. The research topic came about primarily to inform the debate on whether or not the FASB should require management to assess if the firm is a going concern, though it is more interesting in general for the methodology by which they analyze the MD&A text.

Prior to this paper, literature focused on small samples to determine whether MD&A was predictive of bankruptcy. Mayew et al. use a fairly substantial sample size to broadly describe the predictive capacity of MD&A disclosures. They include numerous other predictive factors, such as the auditor's opinion and the financials. They were able to accomplish this by using almost entirely automated techniques[^automated], a contribution to the literature in itself. This paper also joins a litany of others in the bankruptcy prediction space.

[^automated]: Much of the manual work seems to have been related to manually coding whether or not the management had expressed a going concern.

Given a collection of textual data (MD&A) can one predict the likelihood of a firm entering bankruptcy? Mayew et al. answer this in a straightforward manner. The probability of a firm going bankrupt next year is determined by estimating a hazard model, which can be used to estimate the probability of a firm failing in a given time frame. I found it interesting (based on my limited knowledge of hazard models) that their hazard model can be reduced so succintly to a simple regression.[^laugh]

[^laugh]: Loughran, Tim and McDonald, Bill, _When is a Liability not a Liability? Textual Analysis, Dictionaries, and 10-Ks_ (March 4, 2010). Journal of Finance, Forthcoming. Available at SSRN: https://ssrn.com/abstract=1331573

Mayew et al. use three primary variables sourced from the MD&A text. *GC_MGMT* is coded as a 1 when the management has expressed a going concern. This coding was performed manually, and the appendix provides some examples of what was considered to be an expression of going concern. *POSMDA(%)* represents the percentage of positive words in the MD&A, and *NEGMDA(%)* represents the percentage of negative words in the MD&A. Words are determined to be positive or negative as provided in Loughran and McDonald (2011) who created an alternative list of positive and negative words that are applicable in financial contexts.

The above MD&A independent variables are used to predict _BRUPT_, which is coded as a one when a firm goes bankrupt the following year and zero otherwise. Mayew et al. use numerous other variables, such as the auditor's going concern opinion or sales to total assets. In my opinion, these are not exceptionally important to the main finding of the paper, except insofar as they demonstrate the incremental predictive ability of the MD&A text.

The sample includes 460 bankrupt firms between 1995 and 2012, as well as the accompanying MD&A, auditor's reports, and financial variables for each firm-year. There is an additional 42,265 non-bankrupt firm-years as a baseline. This sample would appear to be soundly assembled. 460 bankrupt firms is a fairly substantial sample size to estimate on.

Mayew et al. present striking results for models constructed only on *GC_MGMT*, *POSMDA(%)*, and *NEGMDA(%)*. The model has a pseudo-R$^2$ of 14.58%, with very high significance for each variable. The highest parameter estimate was on *GC_MGMT* with -2.880[^gc], which indicates that an expression of going concern is highly explanatory of a firm's future bankruptcy. Perhaps more importantly, the parameters estimate declines to only 2.096 when all the financial variables are included.

[^gc]: Sourced from Table 3, column 4.

The author's paper generally well supports the idea that MD&A disclosures contain information relevant to predicting a bankruptcy, even using fairly simlistic methods. Taking the percentage of positive and negative words and determining whether the management has expressed a going concern have proved to be powerful predictors. The model inclusive of the auditor's opinion, the MD&A variables, and financial variables proved to be well-fit with a Pseudo-R$^2$ of 21.13%.

While this is an interesting finding, there is much more that could be done in this space. The natural-language processing space in machine learning has experienced tremendous growth in the past several years[^nlp], and I suspect that applications from that space would apply well to MD&A analysis.

[^nlp]: Kraus, Mathias, and Stefan Feuerriegel. _Decision Support from Financial Disclosures with Deep Neural Networks and Transfer Learning_. Decision Support Systems 104 (December 2017): 38–48. https://doi.org/10.1016/j.dss.2017.10.001.

For example, Kraus et al. apply a variety of deep learning techniques traditionally used to model arbitrary text sequences, such as recurrent (RNN) and long-term short-memory (LTSM) neural networks. These architectures may address issues that Mayew et al. generate with their modeling technique.

A key issue with Mayew et al. is that using *POSMDA(%)* and *NEGMDA(%)* discard any possibility of understanding the _context_ of a word and the context of the words around it. The phrase "Our performance was spectacular" and "Our performance was not spectacular" are nearly identical, but have radically different meanings. LTSM and RNN networks can model the relationship between words for exceptionally long sentences, paragraphs, and documents, and better improve on Mayew et al.'s predictive variables. Kraus et al. demonstrated a test sample accuracy of 57%[^kraus-table] on classifying the direction of a stock return after the release of a financial disclosure. With some modifications, the entirety of the model could be used to predict Mayew et al.'s bankruptcy variable.

[^kraus-table]: This is located in Table 2, column 2.

Additionally, it is possible to include the text of the auditor's opinion in the same model type to increase predictive power. It would be interesting to see if there was additional information that could be gathered from the opinion that was more comprehensive than whether or not the auditor had expressed a material going concern.

Financial variables as well could be included, though in a less straightforward manner. An optimal solution would be to design a deep learning architecture such that the relationship between the lexical structure of the MD&A and the entire time-series of current and previous financial variables could be discerned. This is a markedly more complex topic as it would seem to require numerous compositional models.

Mayew et al. demonstrate using pleasantly straightforward methods the fact that brankrupcty can be predicted by the content of the MD&A. This confirms an intuitive understanding of the paper's topic, which is that management often knows more about the firm than do average investors, and that financial variables do not necessarily contain all the information necessary to get a holistic understanding of the firm.
