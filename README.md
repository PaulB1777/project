# Anime Rating and Popularity Analysis (MyAnimeList)
## Dataset:
-	Kaggle: https://www.kaggle.com/datasets/patelris/anime-and-manga-dataset-2026 
-	Source: MyAnimeList via Jikan API
## Objective:
I aim to find what variables are associated with a higher score and higher levels of popularity of an anime on MyAnimeList.
## I plan to investigate:
-	What variables are associated with a higher score?
-	What variables are associated with an anime being more popular?
-	How are an anime’s popularity and average score related?
## Note:
-	MyAnimeList captures popularity and ratings based on its user base, which may introduce bias. Therefore, results may not fully generalize to global audiences.
-	For all of the data exploration related to “Popularity,” the “scored_by” variable will be used instead of the “popularity” variable. This is because “popularity” only records the popularity rank of an anime. For the purposes of this project, I want to compare the relative popularity of anime by size, not only rank.
## Removing Variables:
-	“mal_id”, “title_japanese”, and “title_english” were removed because they do not provide any additional information relevant to this project. The title variable can be used to identify each anime. 
-	The “synopsis” variable was removed because it provides a brief description of the anime. As this project does not deal with text sentiment analysis models, the synopsis variable is outside the scope of this project.
-	The “episodes” and “duration” variables were removed because they describe how many episodes an anime has, and how long each episode is. This is outside of the scope of the project.
-	“status” and “airing” describe if a show is currently airing, finished airing, or yet to be aired. Because this project deals with the score of an anime, anime that are yet to be aired will not be usable. Because only about 50 anime are currently airing at once, that is not a large enough sample size to justify investigation.
-	“aired_from”, “aired_to”, and “season” describe when a show aired. Although it would be more specific, and possibly provide more insight, these variables have many more missing values than the “year” variable.  
-	“members” describes how many accounts have an anime on their “list.” This is not useful for determining the popularity of an anime because it includes users who have dropped the show and users who are only planning to watch the show.
-	“favorites” describes how many users favorited an anime. This is not included in the scope of the project.
-	“producers” and “licensors” track sponsors and other corporate entities behind an anime. They are not included in this project in favor of the animation studio, as they have a more direct impact on an anime’s production quality and the resulting audience opinions. 
-	“image_url” is a web link to the cover art of an anime. It does not provide any useful information to this project.
## Removing Rows:
-	Rows where the “score” variable was missing were removed. This is because the target variable is missing, so these rows are unable to be used for this project. 
## Missing Values:
-	Several variables have a notable number of missing values, including the “aired_to”, “season”, “year”, “studios”, “producers”, “licensors”, “genres”, “themes”, and “demographics” columns. As many of these are important for the analysis in this project, they will be kept. The data will be filtered to exclude these missing values only while analyzing the specific variable.  
## Score Distribution
![Score Distribution Graph](./ graphs/Score_distribution.png)
-	The scores follow a roughly normal distribution. 
## Popularity vs. Score
![Score vs. Popularity Graph](./ graphs/Popularity_scatter_normal.png) 
![Score vs. Popularity Graph (Logarithmic Scale)](./ graphs/Popularity_scatter_log.png
### Analysis and Insight
There is an evident positive correlation (Correlation Coefficient$\approx 0.336$) between an anime’s score and its popularity (“scored_by”). A linear regression model yields an $R^2 = 0.113$, indicating that popularity is responsible for approximately 11.3% of the variance in the score.
•	Because the “scored_by” variable has a heavy right-skew, the logarithmic transformation is used to help readability. The right skew is caused by a minority of anime that have millions of reviews logged. Using the logarithmic transformation, the less popular anime’s data points become more readable. 
•	Where highly scored anime can be incredibly popular or an obscure indie gem, anime with low scores have the tendency to have a lower popularity. Essentially, anime with a high score may not always be more popular, but an anime with a low score is likely to never become very popular. 
•	Dividing the popularity quartiles supports the positive correlation. Each quartile has a higher mean and median than its respective prior quartile. 
•	Interestingly, the second quartile has the highest standard deviation. This is clearly represented in the logarithmic scale plot, where the low-middle popularity has a tall vertical range. This is likely the region where niche, highly regarded anime and forgotten, lowly regarded anime are.  
•	The positive correlation is driven by a feedback loop. A high score gives an anime critical acclaim, which can act as an organic marketing mechanism. The prestige an anime receives from a high score can help drive an anime into the eyes of the masses, attracting more viewers and, in turn, more reviews. 


