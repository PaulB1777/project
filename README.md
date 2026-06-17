# Anime Rating and Popularity Analysis (MyAnimeList)
# Dataset:
-	Kaggle: https://www.kaggle.com/datasets/patelris/anime-and-manga-dataset-2026 
-	Source: MyAnimeList via Jikan API
# Objective:
I aim to find what variables are associated with a higher score and higher levels of popularity of an anime on MyAnimeList.
I plan to investigate:
-	What variables are associated with a higher score?
-	What variables are associated with an anime being more popular?
-	How are an anime’s popularity and average score related?
# Note:
-	MyAnimeList captures popularity and ratings based on its user base, which may introduce bias. Therefore, results may not fully generalize to global audiences.
# Removing Variables:
-	“mal_id”, “title_japanese”, and “title_english” were removed because they do not provide any additional information relevant to this project. The title variable can be used to identify each anime. 
-	The “synopsis” variable was removed because it provides a brief description of the anime. As this project does not deal with text sentiment analysis models, the synopsis variable is outside the scope of this project.
# Removing Rows:
-	Rows where the “score” variable was missing were removed. This is because the target variable is missing, so these rows are unable to be used for this project. 
Missing Values:
-	Several variables have a notable number of missing values, including the “aired_to”, “season”, “year”, “studios”, “producers”, “licensors”, “genres”, “themes”, and “demographics” columns. As many of these are important for the analysis in this project, they will be kept. The data will be filtered to exclude these missing values only while analyzing the specific variable.  

