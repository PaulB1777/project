library(readr)
library(ggplot2)
library(dplyr)
library(tidyr)

#importing data and looking at it
anime <- read_csv("C:/Users/paulb/OneDrive/Desktop/Anime Project/anime_dataset.csv")
dim(anime)
View(anime)

summary(anime)
str(anime)

# counting how many NA values there are in each column
colSums(is.na(anime))

#remove unnecessary columns
anime[, c("mal_id", "title_english", "title_japanese", "synopsis")] <- list(NULL)


#removing any rows where the score value is not present
anime <- anime[!is.na(anime$score), ]   

#check how many rows have an N/A value
sum(rowSums(is.na(anime)) > 0)
# counting how many NA values there are left in each column
colSums(is.na(anime))
dim(anime)

#checking information about the score variable
score_summary <- summary(anime$score)
score_var <- var(anime$score)
print(score_var)
print(score_summary)

#Creating a histogram of the score variable
ggplot(anime, aes(score)) + 
  geom_histogram(aes(y = after_stat(density)),
                 bins = 30,
                 fill = "lightgreen", col = "black",) +
  geom_density(
    aes(color = "Density Curve"), 
    lwd = 0.7) +
  stat_function(fun=dnorm, 
                args = list(mean = score_summary["Mean"], sd = sqrt(score_var)),
                aes(color = "Normal Curve"),
                lwd = 0.7) +
  xlim(0,10) +
  labs(
    title = "Distribution of Anime Scores on MyAnimeList",
    x = "MyAnimeList Score",
    y = "Density",
    color = "Legend"
  ) +
  scale_x_continuous(
    limits = c(0, 10),
    breaks = seq(0, 10, by = 1)
  )
  


# Popularity vs. Score
# Making a subset only including the relevant columns
anime_popularity <- subset(anime, select = c(title, score, scored_by))
View(anime_popularity)

# Calculating the correlation
popularity_correlation <- cor(anime_popularity$score, anime_popularity$scored_by)
print(popularity_correlation)

# Calculating R squared
model <- lm(score ~ scored_by, data = anime_popularity)
summary(model)
summary(model)$r.squared

# Creating a scatterplot (numerical scale)
ggplot(anime_popularity, aes(x = scored_by, y = score)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE) +
  ggtitle("Scatterplot of Popularity (scored_by) vs. Score") 

#scatterplot with a logrithimic scale
ggplot(anime_popularity, aes(x = scored_by, y = score)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE) +
  ggtitle("Scatterplot of Popularity (scored_by) vs. Score") + 
  scale_x_log10()

# Comparing the different quartiles
# Finding which quartile each anime is in
anime_popularity$quartile <- ntile(x = anime_popularity$scored_by, 4)
# Calculating the mean, median, and standard deviation of the score based on which quartile it is in
popularity_quartile <- data.frame(
  Quartile = levels(factor(anime_popularity$quartile)),
  Mean = tapply(anime_popularity$score, anime_popularity$quartile, mean),
  Median = tapply(anime_popularity$score, anime_popularity$quartile, median),
  SD = tapply(anime_popularity$score, anime_popularity$quartile, sd)
)

View(popularity_quartile)


#Score vs. Year
#Creating a subset for popularity (scored_by) and score with year, making sure to only include rows where the "year" value is present
anime_year <- anime[!is.na(anime$year),
                    c("title", "score", "scored_by", "year")]
# Calculating the decade
anime_year$decade <- paste0((anime_year$year %/% 10) * 10, "s")

# Calculating the correlation
Year_score_correlation <- cor(anime_year$score, anime_year$year)
print(Year_score_correlation)

# Calculating R squared
model2 <- lm(score ~ year, data = anime_year)
summary(model2)
summary(model2)$r.squared

#Creating a scatterplot of year vs. Score
ggplot(anime_year, aes(x = year, y = score)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE) +
  ggtitle("Scatterplot of Year Released vs. Score") +
  labs(x = "Release Year", y = "Score")

score_decade <- data.frame(
  Decade = levels(factor(anime_year$decade)),
  Mean = tapply(anime_year$score, anime_year$decade, mean),
  Median = tapply(anime_year$score, anime_year$decade, median),
  SD = tapply(anime_year$score, anime_year$decade, sd)
)

View(score_decade)


#Popularity (scored_by) vs. Year
# Calculating the correlation
Year_popularity_correlation <- cor(anime_year$scored_by, anime_year$year)
print(Year_popularity_correlation)

# Calculating R squared
model3 <- lm(scored_by ~ year, data = anime_year)
summary(model3)
summary(model3)$r.squared

#Creating a scatterplot of year vs. popularity (scored_by) (normal scale)
ggplot(anime_year, aes(x = year, y = scored_by)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE) +
  ggtitle("Scatterplot of Year Released vs. Popularity (Scored_by)") +
  labs(x = "Release Year", y = "Popularity (scored_by)")

#Creating a scatterplot of year vs. popularity (scored_by) (log scale)
ggplot(anime_year, aes(x = year, y = scored_by)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE) +
  ggtitle("Scatterplot of Year Released vs. Popularity (Scored_by)") +
  labs(x = "Release Year", y = "Popularity (scored_by)") +
  scale_y_log10()

#Calculations 
popularity_decade <- data.frame(
  Decade = levels(factor(anime_year$decade)),
  Mean = tapply(anime_year$scored_by, anime_year$decade, mean),
  Median = tapply(anime_year$scored_by, anime_year$decade, median),
  SD = tapply(anime_year$scored_by, anime_year$decade, sd),
  ReviewsTotal = tapply(anime_year$scored_by, anime_year$decade, sum)
)

View(popularity_decade)


# Score vs. Genre
#Creating a subset for popularity (scored_by) and score with genres, making sure to only include rows where the "genres" value is present
anime_genre <- anime[!is.na(anime$genres),
                    c("title", "score", "scored_by", "genres")]
#Separating the "genres" variable 
anime_genre <- anime_genre %>%
  separate_rows(genres, sep = "\\|")

View(anime_genre)

#calculations
score_genre <- data.frame(
  Genre = levels(factor(anime_genre$genres)),
  Mean = tapply(anime_genre$score, anime_genre$genres, mean),
  Median = tapply(anime_genre$score, anime_genre$genres, median),
  SD = tapply(anime_genre$score, anime_genre$genres, sd)
)

View(score_genre)

ggplot(score_genre, aes(x = reorder(Genre, Mean), y = Mean)) +
  geom_bar(stat = "identity", col = "black", fill = "lightgreen") +
  coord_flip() +
  labs(title = "Score vs. Genre", x = "Mean Score", y = "Genre")

#Boxplot
ggplot(anime_genre, 
       aes(
         x = reorder(genres, score, FUN = mean), 
         y = score)) +
  coord_flip() +
  stat_boxplot(geom="errorbar") +
  geom_boxplot(fill="lightgreen") +
  stat_summary(fun = mean, col = "black", geom = "point", size = 3) +
  xlab ("Genre") +
  ylab ("Score") +
  labs(title = "Score vs. Genre")


# Popularity (scored_by) vs. Genre
#calculations
popularity_genre <- data.frame(
  Genre = levels(factor(anime_genre$genres)),
  Mean = tapply(anime_genre$scored_by, anime_genre$genres, mean),
  Median = tapply(anime_genre$scored_by, anime_genre$genres, median),
  SD = tapply(anime_genre$scored_by, anime_genre$genres, sd)
)

View(popularity_genre)

#Bar Graph
ggplot(popularity_genre, aes(x = reorder(Genre, Mean), y = Mean)) +
  geom_bar(stat = "identity", col = "black", fill = "lightgreen") +
  coord_flip() +
  labs(title = "Popularity (scored_by) vs. Genre", x = "Mean Popularity (scored_by)", y = "Genre")


#Score vs. Type
# Creating a subset
anime_type <- anime[!is.na(anime$type),
                    c("title", "score", "scored_by", "type")]

View(anime_type)

score_type <- data.frame(
  Type = levels(factor(anime_type$type)),
  Mean = tapply(anime_type$score, anime_type$type, mean),
  Median = tapply(anime_type$score, anime_type$type, median),
  SD = tapply(anime_type$score, anime_type$type, sd),
  Count = tapply(anime_type$type, anime_type$type, length)
)

View(score_type)

#Bar graph
ggplot(anime_type, 
       aes(
         x = reorder(type, score, FUN = mean), 
         y = score)) +
  coord_flip() +
  stat_boxplot(geom="errorbar") +
  geom_boxplot(fill="lightgreen") +
  stat_summary(fun = mean, col = "black", geom = "point", size = 3) +
  xlab ("Type") +
  ylab ("Score") +
  labs(title = "Score vs. Type")


#Popularity (scored_by) vs. Type
popularity_type <- data.frame(
  Type = levels(factor(anime_type$type)),
  Mean = tapply(anime_type$scored_by, anime_type$type, mean),
  Median = tapply(anime_type$scored_by, anime_type$type, median),
  SD = tapply(anime_type$scored_by, anime_type$type, sd),
  Count = tapply(anime_type$type, anime_type$type, length)
)

View(popularity_type)

#Bar graph
ggplot(anime_type, 
       aes(
         x = reorder(type, scored_by, FUN = mean), 
         y = scored_by)) +
  coord_flip() +
  stat_boxplot(geom="errorbar") +
  geom_boxplot(fill="lightgreen") +
  stat_summary(fun = mean, col = "black", geom = "point", size = 3) +
  xlab ("Type") +
  ylab ("Popularity") +
  labs(title = "Popularity vs. Type")
