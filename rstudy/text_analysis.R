library(caret)
library(tm)

setwd("D:\\work\\metricstudy\\rstudy")

news <- system.file("text_news.txt", "crude", package="tm")
tdm <- TermDocumentMatrix()




library(KoNLP)
library(wordcloud)

data(crude)
inspect(crude)

crude <- tm_map(crude, removePunctuation)

crude <- tm_map(crude, function(x) removeWords(x, stopwords()))

tdm <- TermDocumentMatrix(crude)
tdm
m <- as.matrix(tdm)
m
m[1:10,1:10]
v<-sort(rowSums(m), decreasing = T)

head(v)
d <- data.frame(word = names(v), freq = v)
d

wordcloud(d$word, d$freq)
wordcloud(d$word, d$freq, c(5, 2))



m2 <- m[1:50,1:50]
m2[m2>=1] <- 1
termMatrix <- m2 %*% t(m2)
termMatrix[5:10, 5:10]

library(igraph)

g<-graph.adjacency(termMatrix, weight = T, mode = 'undirected')
g <- simplify(g)
V(g)$label <- V(g)$name
V(g)$degree <- degree(g)
V(g)$degree
layout1<-layout.fruchterman.reingold(g)
plot(g,layout=layout1)
.  
  
  
  
  
  
  

library(plyr)

tmp1 <- "나는 너를 사랑한다. 정말일까? 거짓말일까? 삼성 바보 "
tmp2 <- "스노든은 폭로 당시 29살의 나이로 미국가안보국의 계약업체인 부즈알렌해밀턴(Booz Allen Hamilton) 의 직원으로 하와이에서 근무하고 있었습니다. 미국가안보국의 감시프로그램에 직간접적으로 관여해서 일을 해오던 스노든은 이 프로그램이 상식적으로 용납되는 범위를 벗어났다고 느끼기 시작했습니다. 미국 시민을 테러의 위협으로부터 보호하기 위함이라는 명분에서 시작된 이 감시프로그램이 테러예방의 목적을 벗어나 개인의 사생활을 아무런 규제없이 들여다볼뿐만 아니라 정치적 목적에 의해 악용될 수 있는 괴물로 커가고 있음을 깨닫게 되었습니다."
tmp3 <- "그는 미국가안보국의 감시프로그램을 입증할 수 있는 증거들을 비밀리에 다운받기 시작했습니다. 그리고 2013년 5월 20일,스노든은 직장에 병가를 내고 미국에 돌아가겠다고 보고한채 모든 증거를 들고 하와이를 떠납니다. 하와이를 떠난 스노든, 10시간의 비행 후 그가 도착 한 곳은 미국이 아닌 홍콩이었습니다. 스노든은 홍콩에 도착하자마자 호텔방에 틀어박혀 한달간 이 충격적인 사실을 전세계에 폭로하기 위한 준비를 했습니다. 스노든이 선택한 가장 효과적인 폭로방법은 언론을 통해 이 사실을 단계적으로 알리는 것 이었습니다. 자신이 갖고 있는 기밀자료를 인터넷에 모두 올리는 것도 하나의 방법일 수 있었지만, 스노든은 이 방법이 효과적이지 않을 것이라는 것을 과거 줄리안아산지의 위키리크스 사례를 통해 알고 있었습니다. 일반 시민들은 수많은 기밀문서들의 내용을 이해할 만큼 똑똑하지 않고, 언론은 그러한 기밀문서를 분석해서 독자들에게 전달할만큼 부지런하지 않다는것을 알고 있었습니다. 만약 JTBC가 최순실씨의 타블렛PC에 들어있던 모든 자료를 한번에 다 보도했었더라면, 아마 국민들은 폭로 자체에만 관심을 가졌을 것이고, 다른 언론들은 타블렛PC의 입수 과정을 집중적으로 보도 했을 것이라 생각할 수 있는 것과 같은 맥락이지요. 손석희앵커가 그러했던 스노든은 수십만개의 파일을 하나하나 정리해가며 하나씩 순차적으로 시민과 언론이 이 이슈를 깨닳아 갈 수 있게 폭로할 준비를 해나갔습니다"
tmpNoun <- sapply(c(tmp1, tmp2, tmp3), extractNoun)
tmpNoun[1]



f <- file("rain.txt", blocking=F) #file must be stored as a ANSI file
txtLines <- readLines(f)
txtLines
txtLines <- gsub("[[:punct:]]", "", txtLines)
nouns <- sapply(txtLines, extractNoun, USE.NAMES=F)
close(f)
nouns
unlist(nouns)
wordcount <- table(unlist(nouns))
pal <- brewer.pal(12,"Set3")
pal <- pal[-c(1:2)]
wordcloud(names(wordcount),freq=wordcount,scale=c(6,0.3),min.freq=4,random.order=T,rot.per=.1,colors=pal)





mydata <- read.csv("text_test.txt")
mydata
str(mydata)
mydata$desc <- as.character(mydata$desc)
tmp1 <- lapply(mydata$desc, extractNoun)
tmp1
tmp2 <- gsub("[[:punct:]]", "", tmp1)
tmp2 <- gsub("\n", "", tmp2)
myCorpus <- Corpus(VectorSource(tmp2))
dtm <- DocumentTermMatrix(myCorpus)
inspect(dtm)











install.packages("tm")
install.packages("KoNLP")
install.packages("plyr")
install.packages("stringr")
install.packages("wordcloud")
library(tm)
library(KoNLP)
library(wordcloud)
mydata<-c("나는 너를 사랑 좋아 한다","나는 싫다","좋다가도 싫은 사람이 있다","아름다움","bad","bad 나쁜것이다","kind 좋은것이다","빠르기도한 성능이 좋은 자동차 좋아요. 저는 그런 차를 사고 싶어요", "코끼리 토끼 동물 좋아요","토끼도 동물이고 너무 좋아요", "성능이 좋은 BMW 같은 차를 사고 싶다. 차를 사고 싶어하는 사람들은 그런 사람들이다.","빠른차가 좋은 차라 이런 자동차는 누구나 사고 싶어한다.","사람의 선호도는 좋고, 나쁨에 따라 달라진다.", "개구리, 치타, 강아지, 고양이 동물들을 좋아한다.")
mydata
docs <- Map(extractNoun, mydata)
docs
docs <- unique(docs)
docs
# sentiment analysis
pos.word=scan("positive-words-ko-v3.txt",what="character",comment.char=";")
pos.word <- iconv(pos.word,"UTF8","CP949")
pos.word
neg.word=scan("negative-words-ko-v3.txt",what="character",comment.char=";")
neg.word <- iconv(neg.word,"UTF8","CP949")
word = unlist(docs)
word
pos.matches = match(word, pos.word)
pos.matches
neg.matches = match(word, neg.word)
neg.matches
pos.matches = !is.na(pos.matches)
neg.matches = !is.na(neg.matches)
pos.matches
neg.matches
score = sum(pos.matches) - sum(neg.matches)
score
