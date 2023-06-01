
#########################################
# 그래프 기본 연습문제
#########################################

# 2 그래프 제목, 축 제목과 범위 등을 보고 두 그래프를 각각 그리시오.(y값은 모두 정수임)

plot(c(12:18),c(30,31,33,32,28,27,30),
     xlab="7월의 날짜(일)",
     ylab="최고 기온",
     xlim=c(10,20),
     ylim=c(26,34),
     main="일주일간 최고 기온변화")
plot(c(1.0,2.0,2.0),c(99,100,98),
     xlab="4학년(반)",
     ylab="점수(점)",
     xlim=c(0.0,3.0),
     ylim=c(95,100),
     main="4학년 1~3등 반 분포")


# 3 그래프, 축 표시, 축 제목 등을 각각 설정하여 다음 그래프를 그리시오.

stu_cnt <- c(5,7,7,6,1)
plot(stu_cnt,
     ylim=c(0,8),
     type='o',
     col='red',
     axes=F,ann=F)
axis(1,at=c(1:5),
     lab=c("A","B","C","D","F"))
axis(2,ylim=c(0,8))
title(main="학점별 학생수",
      col.main='red',
      font.main=4)
title(xlab="학점(점)",col.lab='black')
title(ylab="학생수(명)",col.lab='blue')

child_cnt <- c(12,13,20,23)
plot(child_cnt,
     ylim=c(10,24),
     type='o',
     col='red',
     axes=F)
axis(1,at=c(1:4),
     lab=c("나리","구슬","송이","난초"))
axis(2,ylim=c(10,24))
title(main="반별 어린이수",
      col.main='blue',
      font.main=4)
title(xlab="반이름",col.lab='black')
title(ylab="인원수(명)",col.lab='black')


# 4 그래프, 축 표시, 축 제목 등을 각각 설정하여 다음 그래프를 그리시오.
# (함수를 사용하여 코드를 보관하시오.)

stu_cnt <- c(5,7,7,6,1)
student_score <- function(stu_cnt) {
  plot(stu_cnt,
       ylim=c(0,8),
       type='o',
       col='red',
       axes=F)
  axis(1,at=c(1:5),
       lab=c("A","B","C","D","F"))
  axis(2,ylim=c(0,8))
  title(main="학점별 학생수",
        col.main='red',
        font.main=4)
  title(xlab="학점(점)",col.lab='black')
  title(ylab="학생수(명)",col.lab='blue')
}

child_cnt <- c(12,13,20,23)
class_childcnt <- function(child_cnt) {
  plot(child_cnt,
       ylim=c(10,24),
       type='o',
       col='red',
       axes=F)
  axis(1,at=c(1:4),
       lab=c("나리","구슬","송이","난초"))
  axis(2,ylim=c(10,24))
  title(main="반별 어린이수",
        col.main='blue',
        font.main=4)
  title(xlab="반이름",col.lab='black')
  title(ylab="인원수(명)",col.lab='black')
}


# 5 앞의 두 그래프를 한 화면에 표시하시오.(화면을 1행 2열로 설정)

par(mfrow=c(1,2))
stu_cnt <- c(5,7,7,6,1)
child_cnt <- c(12,13,20,23)
student_score(stu_cnt)
class_childcnt(child_cnt)


# 6

x <- c(2,4,6,8)
y <- c(16,17,19,18)
plot(x,y,ylab='yyy',xlab='xxx',ylim=c(15,20),xlim=c(0,10))

# x,y축 제목 서식을 설정하는 mgp=c() 값의 수치를 (2,1,0), (4,2,0), (4,2,1)로 각각 조정하면서 그래프를 그려보시오.
par(mgp=c(2,1,0))
plot(x,y,ylab='yyy',xlab='xxx',ylim=c(15,20),xlim=c(0,10))
par(mgp=c(4,2,0))
plot(x,y,ylab='yyy',xlab='xxx',ylim=c(15,20),xlim=c(0,10))
par(mgp=c(4,2,1))
plot(x,y,ylab='yyy',xlab='xxx',ylim=c(15,20),xlim=c(0,10))

# 그래프의 여백을 아래쪽을 4로 조정하시오.
par(oma=c(4,0,0,0))
plot(x,y,ylab='yyy',xlab='xxx',ylim=c(15,20),xlim=c(0,10))

# 그래프의 여백을 왼쪽을 4로 조정하시오.
par(oma=c(0,4,0,0))
plot(x,y,ylab='yyy',xlab='xxx',ylim=c(15,20),xlim=c(0,10))

# 그래프의 여백을 위쪽을 4로 조정하시오.
par(oma=c(0,0,4,0))
plot(x,y,ylab='yyy',xlab='xxx',ylim=c(15,20),xlim=c(0,10))

# 그래프의 여백을 오른쪽을 4로 조정하시오.
par(oma=c(0,0,0,4))
plot(x,y,ylab='yyy',xlab='xxx',ylim=c(15,20),xlim=c(0,10))


# 7 lines() 함수를 사용하여 두 개의 그래프를 차례로 표시하시오.

v1 <- c(75,74,80,75,78,94)
v2 <- c(74,71,77,71,70,76)

plot(v1,
     type='o', col='red', ylab="v1",
     xlim=c(1,6), ylim=c(70,95)
)
lines(v2,
      type='o', col='blue', ylab="v1",
      xlim=c(1,6), ylim=c(70,95)
)
legend(2,90,
       c('2003','2013'),
       col=c('red','blue'),
       cex=0.8,
       lty=1)

plot(v1,
     type='o', col='red',
     xlim=c(1,6), ylim=c(70,95),
     axes=F, ann=F
)
lines(v2,
      type='o', col='blue',
      xlim=c(1,6), ylim=c(70,95),
      axes=F
)
title(main="연령대별평균소비성향",
      col.main='blue',
      xlab="연령", ylab="가계소득대비소비율(%)",
)
axis(1,at=c(1:6),
     lab=c("20대","30대","40대","50대","60대","70대"))
axis(2,ylim=c(70,95))
legend(2,90,
       c('2003','2013'),
       col=c('red','blue'),
       cex=0.8,
       lty=1)


# 8 .lines() 함수를 사용하여 두 개 그래프를 차례로 표시하시오.

v1 <- c(37.4,50.3,63.6,67.2,81.1)
v2 <- c(82.2,88.1,84.7,77.2,56.3)

par(mgp=c(2,1,0))
plot(v1,
     type='o', col='red', ylab="v1",
     xlim=c(1,5), ylim=c(40,100)
)
lines(v2,
      type='o', col='blue', ylab="v1",
      xlim=c(1,5), ylim=c(40,100)
)
title(main="연령대별TV,스마트폰 이용률",
      col.main='red')
legend(4,90,
       c('TV','스마트폰'),
       col=c('red','blue'),
       cex=0.8,
       lty=1)

plot(v1,
     type='o', col='red',
     xlim=c(1,5), ylim=c(40,100),
     axes=F, ann=F
)
lines(v2,
      type='o', col='blue',
      xlim=c(1,5), ylim=c(40,100),
      axes=F
)
title(main="연령대별TV,스마트폰 이용률",
      col.main='blue',
      xlab="연령", ylab="data 이용률(%)",
)
axis(1,at=c(1:5),
     lab=c("10대","20대","30대","40대","50대"))
axis(2,ylim=c(40,100))
legend(4,90,
       c('TV','스마트폰'),
       col=c('red','blue'),
       cex=0.8,
       lty=1)


##############################################
# barplot() 연습문제
##############################################

# 1 barplot()을 이용해 다음 그래프를 순서대로 작성하시오.

x <- matrix(c(40,52,33,51),2,2)
barplot(x,
        beside=T,
        names=c('가족도 중요하지만\n 나를 먼저 생각한다',
                '물건을 충동적으로\n 구매하는 경우가 많다'),
        col=c('magenta1','grey'),
        ylim=c(0,60), ylab="(%)")
legend("top",
       c('2009년','2014년'),
       col=c('magenta1','grey'),
       cex=0.8, fill=c('magenta1','grey'))

barplot(x,
        names=c('가족도 중요하지만\n 나를 먼저 생각한다',
                '물건을 충동적으로\n 구매하는 경우가 많다'),
        col=c('magenta1','grey'),
        ylim=c(0,100), ylab="(%)")


# 2 앞의 그래프를 다음과 같이 수정하시오.

barplot(x,
        main="나를 중시하는 경향",
        names=c('가족보다\n 나를먼저',
                '충동구매\n확률'),
        col=c('magenta1','grey'),
        xlim=c(0,100), xlab="(%)",
        horiz=T)

barplot(x,
        main="나를 중시하는 경향",
        beside=T,
        names=c('가족보다\n 나를먼저',
                '충동구매\n확률'),
        col=c('magenta1','grey'),
        xlim=c(0,60), xlab="(%)",
        horiz=T)
