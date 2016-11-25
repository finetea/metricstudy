z <- 1
z
print(z)
(z<-1)

y<-c("ECG","Eric","Tim","Joshua")
y

c(1+2,2-3,3*4,4/5)

x1<-c(0,1,1,2,3)
x2<-c(5,8,13,21,34)
(x3<-c(x1,x2))

## b) ?ˆ˜?—´

1:5
9:0
b <- 2:10
b


n <- 0
10:n

seq(from=0,to=20,by=2)
seq(from=0,to=20,length.out=5)
seq(from=1.0,to=2.0,length.out=5)

rep(1,times=5)
rep(1:2,each=2)

c<- 1:5
rep(c,5)
rep(c,each=5)


## c) ë²¡í„°?— ?ˆ?Š” ?›?†Œ ?„ ?ƒ

d<-1:20
d[1]
d[20]
d[3:5]
d[c(1,3,5)]
d[-1]
d[-c(1:15)]

# ì¡°ê±´ë¬¸ì„ ?€?[]?€ì•ˆ?— ?•´?‹¹ vectorëª…ì„ ?„£ê³? ì§€? •?•˜ë©? ?•´?‹¹ ì¡°ê±´?„ ë§Œì¡±?•˜?Š” ê°’ì„ ê°€? ¸?˜¬ ?ˆ˜ ?ˆ?Œ
d<10
d[d<10]

d%%2==0 # %%?Š” ì£¼ì–´ì§? ?ˆ«?ë¡? ?‚˜?ˆˆ ?‚˜ë¨¸ì?€
d[d%%2==0]

d[d>=5 & d<15] # &?Š” and
d[d<=5 | d>15] # |?Š” or

# index ë¶€?—¬ 
n<-letters[1:20]
n

names(d)<-n
d

d["a"]
d[c("a","t")]



## d) Data Typeê³? object

# Numeric
a<-3
a

# Character
b<-"Charcter"
b

# Paste Characters
A <- c("a","b","c")
A
paste("a","b",sep="")
paste(A,c("d","e"))

f <- paste(A,10)
f

paste(A,10,sep="")
paste(A,1:10,sep="")

paste("Everybody","loves","cats.")
paste("Everybody","loves","cats.",sep="-")
paste("Everybody","loves","cats.",sep="")

# Substr(ë¬¸ì?—´, ?‹œ?‘, ?)
substr("BigDataAnalysis",1,4)

ss<-c("Moe","Larry","Curly")
substr(ss,1,3)

# Logical
c<-TRUE
c

d<-T
d

e<-FALSE
e

f<-T
f

# ?…¼ë¦¬ì—°?‚°?
a<-3
a==pi
a!=pi

a<pi
a>pi
a<=pi
a>=pi


### Matrix

m<-c(1.1,1.2,2.1,2.2,3.1,3.2)
mat<-matrix(m,2,3)
mat 

dim(mat)

t(mat)
mat%*%t(mat)
diag(mat) 

colnames(mat)<-c("IBM","MSFT","GOOG")
rownames(mat)<-c("IBM","MSFT")
mat

mat[1,] #ì²«ì§¸ ?–‰
mat[,3] #?…‹ì§? ?—´

A <- matrix(0,4,5)
A

A <- matrix(1:20,4,5)
A

A[c(1,4),c(2,3)]
A[c(1,4),c(2,3)] <- 1
A

A + 1


### list

lst_1<-list(3.14,"Moe",c(1,1,2,3),mean)
lst_1

a <- 1:10
b <- matrix(1:10,2,5)
c <- c("name1","name2")
lst_2<-list(a=a,b=b,c=c)
lst_2
lst_2$a

lst_3<-list(d=2:10*10)
lst_3

# list ê²°í•©
lst_4<-c(lst_2,lst_3)
lst_4

# unlist
unlist(lst_4)


### data frame

a=c(1,2,2,3)
b=c(4.1,3,2,1.1)
c=data.frame(a,b)
c

# ì¡°íšŒ
c[1,2]
c[,"a"]
c$a
c[c$a==2,]

# rbind, cbind
data(iris)
head(iris) # ì²˜ìŒ 6ê°? observation ì¡°íšŒ
?iris
summary(iris)
str(iris)
new_R<-data.frame(Sepal.Length=3.5, Sepal.Width=4.1, Petal.Length=2.1, Petal.Width=0.5, Species= "newversicolor" )
new_R

tail(iris,2) # ë§ˆì?€ë§? 2ê°? observation ì¡°íšŒ
nR_iris<-rbind(iris,new_R)
tail(nR_iris,2)
dim(nR_iris,2)

new_C<-1:151
nRC_iris<-cbind(nR_iris,new_C)
head(nRC_iris,2) # ì²˜ìŒ 2ê°? observation ì¡°íšŒ
str(nRC_iris)

# subset
subset(iris,select=Species,subset=(Petal.Length>5.0))
subset(iris,subset=c(Sepal.Width==3.0 & Petal.Width==0.2),select=c(Sepal.Length,Petal.Length,Species))

# merge(df1, df2, by="df1??€ df1?˜ ê³µí†µ?œ ?—´?˜ ?´ë¦?")
mrg_iris_org<-cbind(no=1:30,iris[c(1:10,51:60,101:110),])
head(mrg_iris_org,2)
tail(mrg_iris_org,2)
mrg_iris_1<-mrg_iris_org[,c(1,2,3)]
head(mrg_iris_1,2)
mrg_iris_2<-mrg_iris_org[,c(1,4,5,6)]
head(mrg_iris_2,2)

mrg_iris_12<-merge(mrg_iris_1,mrg_iris_2,by="no")
head(mrg_iris_12,2)
head(mrg_iris_org,2)

mrg_iris_12==mrg_iris_org
table(mrg_iris_12==mrg_iris_org)

# grep(ì¡°íšŒ?•  ë¬¸ì?Œ¨?„´, data)
install.packages("ggplot2")
data(movies,package="ggplot2") # ggplot2 ?Œ¨?‚¤ì§€?—?„œ movies dataë¥? ê°€? ¸?˜¤?¼?Š” ëª…ë ¹?–´
head(movies,2)
head(movies[grep("main",movies$title, ignore.case=F),"title"])
grep("main",movies$title)
head(movies[grep("Main ",movies$title, ignore.case=F),"title"])
grep("Main ",movies$title)


## e) ?ë£Œí˜•, ?°?´?„° êµ¬ì¡° ë³€?™˜?•˜ê¸?

a<-"2.78"
a
class(a)
as.numeric(a)

as.numeric("a")

* ë¬¸ìë¥? ?ˆ«?ë¡? ë³€?™˜?•˜? ¤ ?‹œ?„?•˜??€?œ¼?‚˜ ë¶ˆê?€?•˜?—¬ NAë¡? ?Œ? ¤ì¤?.


b<-2.78
b
class(b)
as.character(b)

as.numeric(TRUE)
as.numeric(F)


### ?‚ ì§œë¡œ ë³€?™˜(as.Date)

c<-"2020-01-01"
c
class(c)
c1<-as.Date(c)
c1
class(c1)

d<-"01/31/2020"
d1<-as.Date(d,format="%m/%d/%Y")
d1

# format(?‚ ì§?,?¬ë§?)
# as.character()

as.Date("31/01/2020",format="%d/%m/%Y")
format(Sys.Date(),format="%d/%m/%Y")
format(Sys.Date(),'%a')
format(Sys.Date(),'%b')
format(Sys.Date(),'%B')
format(Sys.Date(),'%d')
format(Sys.Date(),'%m')
format(Sys.Date(),'%y')
format(Sys.Date(),'%Y')


## f) Missing data

a<-0/0
a
is.nan(a)
is.na(a)

b<-log(0)
b
is.finite(b)
is.nan(b)
is.na(b)

c<-NA
is.na(c)
is.nan(c)

d<-c(1:3,NA)
d
is.na(d)


## g) ë²¡í„°?˜ ê¸°ë³¸ ?—°?‚°

v1<-c(1,3,5,7,9,11,20)
v1*v1

(v2<-v1+v1^2)
(v3<-1+v1+v1^3)

mean(v1)
median(v1)
sd(v1)
var(v1)
sum((v1-mean(v1))^2)/(length(v1)-1)

cor(v1,v2)
cor(v1,v3)


## h) ?ŒŒ?¼ ?½ê¸? ?“±

v4<-as.data.frame(v1)

# write.csv(ë³€?ˆ˜?´ë¦?, ?€œì?€? •?•  ?ŒŒ?¼?´ë¦?.csv?€?)
# read.csv("??€?¥?œ ?ŒŒ?¼?´ë¦?.csv")
write.csv(v4,"v4.csv")
v5<-read.csv("v4.csv")
v5

v6<-as.vector(v4)
v7<-as.vector(v5$v1)

v6==v7

# save(ë³€?ˆ˜?´ë¦?, file="ì§€? •?•  ?°?´?„° ?ŒŒ?¼?´ë¦?.Rdata")
# load("??€?¥?œ ?ŒŒ?¼?´ë¦?.Rdata")
save(v4,v5,file="v.rdata")
load("v.rdata")

(v8<-as.list(v4))
(v9<-as.list(v5))
v8$v1==v9$v1
v8[[1]]==v9[[2]]

# rm(object ëª?)
rm(v4,v5)
rm(list=ls()) # ëª¨ë‘ ì§€?š°ê¸?

# summary
data(iris)
summary(iris) # ?—´ë³? data ?š”?•½

# install.packages("packageëª?"): package?„¤ì¹?
install.packages("party")

# library(packageëª?): packageë¥? memory?— load
library(party)

# vignette(?€œì•Œê³ ì‹¶??€ package?´ë¦„â€?): party?— ??€?•œ tutorial pdf?ŒŒ?¼
vignette("party")

# q(): R ì¢…ë£Œ

library(ggplot2)
library(ggplot2movies)

data("movies", package="ggplot2movies")
summary(movies)


paste("a",'b','c', sep='|')
substr("teatlkjalsfj saf", 5,15)

ss<-c('af','asdf','fd')
substr(ss, 1,2)
rm(iris.mat)


authors <- data.frame(
  surname = I(c("Tukey", "Venables", "Tierney", "Ripley", "McNeil")),
  nationality = c("US", "Australia", "US", "UK", "Australia"),
  deceased = c("yes", rep("no", 4)))
books <- data.frame(
  name = I(c("Tukey", "Venables", "Tierney",
             "Ripley", "Ripley", "McNeil", "R Core")),
  title = c("Exploratory Data Analysis",
            "Modern Applied Statistics ...",
            "LISP-STAT",
            "Spatial Statistics", "Stochastic Simulation",
            "Interactive Data Analysis",
            "An Introduction to R"),
  other.author = c(NA, "Ripley", NA, NA, NA, NA,
                   "Venables & Smith"))

authors
books

m1 <- merge(authors, books, by.x = "surname", by.y = "name")
m1



library(tabplot)
tableplot(diamonds, cex=1.8)
tableplot(iris, cex=1.8)
?tableplot
tableplot(iris, sortCol = 5)



library(googleVis)
data(Fruits)
M1 <- gvisMotionChart(Fruits, idvar="Fruit", timevar = "Year")
plot(M1)


library(klaR)
data(iris)
gw_obj <- greedy.wilks(Species~., data=iris, niveau=0.1)
gw_obj
iris2 <- iris[,c(1,3,5)]
iris2
plineplot(Species~., data=iris2, method="lda", x=iris[,4], xlab="Petal.Width")



library(party)
iris$Petal.Width.c <- cut(iris$Petal.Width, 5)
?cut
a<-ctree(Species~.,data=iris)
plot(a)
a

newiris <- iris
newiris$Species <- NULL
kc <- kmeans(newiris, 3)

data("airquality")
airquality
colnames(airquality)
summary(airquality)
boxplot(airquality)
attributes(airquality)
aqm<-melt(airquality, id=c("Month","Day"), na.rm=T)
head(aqm)

library(reshape)
cast(aqm, Month ~ variable, mean)

#cast¸¦ ÀÌ¿ëÇØ ÇÑ¹ø¿¡ ¿©·¯ varÀ» »ı¼ºÇÔ. very useful.
tmp2 <- cast(aqm, Month ~ variable, c(var, mean, min, max))
attributes(tmp2)
attributes(aqm)





ga.data <- read.csv('http://babelgraph.org/data/ga_edgelist.csv', header = T)
plot(ga.data)

library(igraph)
g<-graph.adjacency(ga.data, mode="undirected")
