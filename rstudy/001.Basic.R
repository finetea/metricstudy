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

## b) ??΄

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


## c) λ²‘ν°? ?? ?? ? ?

d<-1:20
d[1]
d[20]
d[3:5]
d[c(1,3,5)]
d[-1]
d[-c(1:15)]

# μ‘°κ±΄λ¬Έμ ??[]?μ? ?΄?Ή vectorλͺμ ?£κ³? μ§? ?λ©? ?΄?Ή μ‘°κ±΄? λ§μ‘±?? κ°μ κ°? Έ?¬ ? ??
d<10
d[d<10]

d%%2==0 # %%? μ£Όμ΄μ§? ?«?λ‘? ?? ?λ¨Έμ?
d[d%%2==0]

d[d>=5 & d<15] # &? and
d[d<=5 | d>15] # |? or

# index λΆ?¬ 
n<-letters[1:20]
n

names(d)<-n
d

d["a"]
d[c("a","t")]



## d) Data Typeκ³? object

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

# Substr(λ¬Έμ?΄, ??, ?)
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

# ?Όλ¦¬μ°?°?
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

mat[1,] #μ²«μ§Έ ?
mat[,3] #?μ§? ?΄

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

# list κ²°ν©
lst_4<-c(lst_2,lst_3)
lst_4

# unlist
unlist(lst_4)


### data frame

a=c(1,2,2,3)
b=c(4.1,3,2,1.1)
c=data.frame(a,b)
c

# μ‘°ν
c[1,2]
c[,"a"]
c$a
c[c$a==2,]

# rbind, cbind
data(iris)
head(iris) # μ²μ 6κ°? observation μ‘°ν
?iris
summary(iris)
str(iris)
new_R<-data.frame(Sepal.Length=3.5, Sepal.Width=4.1, Petal.Length=2.1, Petal.Width=0.5, Species= "newversicolor" )
new_R

tail(iris,2) # λ§μ?λ§? 2κ°? observation μ‘°ν
nR_iris<-rbind(iris,new_R)
tail(nR_iris,2)
dim(nR_iris,2)

new_C<-1:151
nRC_iris<-cbind(nR_iris,new_C)
head(nRC_iris,2) # μ²μ 2κ°? observation μ‘°ν
str(nRC_iris)

# subset
subset(iris,select=Species,subset=(Petal.Length>5.0))
subset(iris,subset=c(Sepal.Width==3.0 & Petal.Width==0.2),select=c(Sepal.Length,Petal.Length,Species))

# merge(df1, df2, by="df1?? df1? κ³΅ν΅? ?΄? ?΄λ¦?")
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

# grep(μ‘°ν?  λ¬Έμ?¨?΄, data)
install.packages("ggplot2")
data(movies,package="ggplot2") # ggplot2 ?¨?€μ§?? movies dataλ₯? κ°? Έ?€?Ό? λͺλ Ή?΄
head(movies,2)
head(movies[grep("main",movies$title, ignore.case=F),"title"])
grep("main",movies$title)
head(movies[grep("Main ",movies$title, ignore.case=F),"title"])
grep("Main ",movies$title)


## e) ?λ£ν, ?°?΄?° κ΅¬μ‘° λ³??κΈ?

a<-"2.78"
a
class(a)
as.numeric(a)

as.numeric("a")

* λ¬Έμλ₯? ?«?λ‘? λ³??? € ??????Ό? λΆκ???¬ NAλ‘? ?? €μ€?.


b<-2.78
b
class(b)
as.character(b)

as.numeric(TRUE)
as.numeric(F)


### ? μ§λ‘ λ³?(as.Date)

c<-"2020-01-01"
c
class(c)
c1<-as.Date(c)
c1
class(c1)

d<-"01/31/2020"
d1<-as.Date(d,format="%m/%d/%Y")
d1

# format(? μ§?,?¬λ§?)
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


## g) λ²‘ν°? κΈ°λ³Έ ?°?°

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


## h) ??Ό ?½κΈ? ?±

v4<-as.data.frame(v1)

# write.csv(λ³??΄λ¦?, ?μ?? ?  ??Ό?΄λ¦?.csv??)
# read.csv("???₯? ??Ό?΄λ¦?.csv")
write.csv(v4,"v4.csv")
v5<-read.csv("v4.csv")
v5

v6<-as.vector(v4)
v7<-as.vector(v5$v1)

v6==v7

# save(λ³??΄λ¦?, file="μ§? ?  ?°?΄?° ??Ό?΄λ¦?.Rdata")
# load("???₯? ??Ό?΄λ¦?.Rdata")
save(v4,v5,file="v.rdata")
load("v.rdata")

(v8<-as.list(v4))
(v9<-as.list(v5))
v8$v1==v9$v1
v8[[1]]==v9[[2]]

# rm(object λͺ?)
rm(v4,v5)
rm(list=ls()) # λͺ¨λ μ§?°κΈ?

# summary
data(iris)
summary(iris) # ?΄λ³? data ??½

# install.packages("packageλͺ?"): package?€μΉ?
install.packages("party")

# library(packageλͺ?): packageλ₯? memory? load
library(party)

# vignette(?μκ³ μΆ?? package?΄λ¦β?): party? ??? tutorial pdf??Ό
vignette("party")

# q(): R μ’λ£

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

#castΈ¦ ΐΜΏλΗΨ ΗΡΉψΏ‘ Ώ©·― varΐ» »ύΌΊΗΤ. very useful.
tmp2 <- cast(aqm, Month ~ variable, c(var, mean, min, max))
attributes(tmp2)
attributes(aqm)





ga.data <- read.csv('http://babelgraph.org/data/ga_edgelist.csv', header = T)
plot(ga.data)

library(igraph)
g<-graph.adjacency(ga.data, mode="undirected")
