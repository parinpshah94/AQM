#Fundamentals of Google's PageRank Algorithm

library(pracma, lib.loc="~/R/win-library/3.0")

nonNalicefv <- c(0,1,1,0)
nonNbobfv <- c(1,0,1,1)
nonNcarolfv <- c(1,1,0,1)
nonNdavefv <- c(1,0,1,0)

#normalizing
alicefv <- nonNalicefv/sum(nonNalicefv)
bobfv <- nonNbobfv/sum(nonNbobfv)
carolfv <- nonNcarolfv/sum(nonNcarolfv)
davefv <- nonNdavefv/sum(nonNdavefv)

#combining by columns
fm<- cbind(alicefv,bobfv,carolfv,davefv)

#creating a identitiy matrix of size 4
i4 <- diag(4)

augfm<-cbind((fm-i4),c(0,0,0,0))

#row reducing using pracma package

rref(augfm)
