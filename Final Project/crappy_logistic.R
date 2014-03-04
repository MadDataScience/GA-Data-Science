setwd("~/Documents")
english_tweets <- file.path("FinalProject", "english_tweets.txt")
english_tweets <- file.path("GA-Data-Science/Final Project", "english_tweets.txt")
spanish_tweets <- file.path("GA-Data-Science/Final Project", "spanish_tweets.txt")

get.msg <- function(path)
{
  con <- file(path, open = "rt", encoding = "latin1")
  text <- readLines(con)
  close(con)
  return(text)
}



get.tdm <- function(doc.vec)
{
  control <- list(stopwords = TRUE,
                  removePunctuation = TRUE,
                  removeNumbers = TRUE,
                  minDocFreq = 2)
  doc.corpus <- Corpus(VectorSource(doc.vec))
  doc.dtm <- TermDocumentMatrix(doc.corpus, control)
  return(doc.dtm)
}

english.tweets <- get.msg(english_tweets)
english.tdm <- get.tdm(english.tweets)
english.matrix <- as.matrix(english.tdm)
english.counts <- rowSums(english.matrix)

spanish.tweets <- get.msg(spanish_tweets)
spanish.tdm <- get.tdm(spanish.tweets)
spanish.matrix <- as.matrix(spanish.tdm)
spanish.counts <- rowSums(spanish.matrix)

common_terms <- intersect(names(spanish.counts), names(english.counts))
X <- rbind(t(english.matrix)[,common_terms], t(spanish.matrix)[,common_terms])

eng_span.glm <- glm(c(rep(FALSE, length(english.tweets)), rep(TRUE, length(spanish.tweets))) ~ X)
table(predict(eng_span.glm, data.frame(X)) > .5, c(rep(FALSE, length(english.tweets)), rep(TRUE, length(spanish.tweets))))
