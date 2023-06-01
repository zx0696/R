### 사용자 정의 함수 연습문제
# 다음과 같이 함수 작성 (f_multiple)
# 함수로 전달된 숫자가 0보다 크면 2를 곱하고
# 0일 경우 0 그대로이고
# 0보다 작을 경우 2를 나눈 값을 
# 반환하는 함수

f_multiple <- function(x){
  if(x > 0){
    x<-x*2
  }else if(x == 0){
    x <- 0
  }else {
    x <- x/2
  }
  
  return(x)
}

f_multiple(3)
f_multiple(0)
f_multiple(-3)

# 다음과 같은 데이터 프레임을  s 생성하고
# name  kor   mat  eng
# 김길동  100   90    80
# 강길동   90    95    98
# 박길동   85    98    100

# s변수에 함수 인수로 입력된 학생 data가 있는지 확인하는 함수 작성
# 함수명 srch(변수명, 이름인수)
# 함수로 s와 찾고자 하는 이름 전달하면
# 함수에서 찾고 결과 출력  TRUE / FALSE
# 함수 srch()에 전달되는 변수는 df 이다
# 전달되는 df의 컬럼명은 위 s 변수와 동일하다고 가정
srch <- function(df, name){
  for(i in df$name){
    if(i == name){
      # 파라미터로 전달된 이름이 전달된 df에 있다
      result <- TRUE
      break # 전달된 이름이 df에 있으면 반복을 종료
    } else {
      # 파라미터로 전달된 이름이 현재까지 df에 없다
      result <- FALSE
    }
  }
  return(result)
}
# srch함수에 df s를 전달하면 함수내부의 for문의 실행 횟수는?

name <- c('김길동','강길동','박길동')
kor <- c(100,90,85)
mat <- c(90,95,85)
eng <- c(85,98,100)
s <- data.frame(name=name,kor=kor,mat=mat,eng=eng)

srch(s,"홍길동")
srch(s,"박길동")
srch(s,"김길동")

####################
# 그래프 기본 함수 연습문제
####################

getwd()
setwd('data')

# 연습문제2
x<-c(12:18)
y<-c(30,31,33,32,28,27,30)

plot(x,y,
     xlim=c(10,20),
     ylim=c(26,34),
     main="일주일간 최고 기온 변화",
     ylab="최고기온",
     xlab="7월의 날짜(일)")

x<-c(1.0,2.0,2.0)
y<-c(99,98,100)

plot(x,y,
     ylim=c(95,100),
     xlim=c(0,3.0),
     main='4학년 1~3등 반 분포',
     ylab='점수(점)',xlab='4학년(반)')

# 연습문제 3
# 그래프 1
y <- c(5,7,7,6,0)

# x,y축 삭제
plot(y, type='o', col='red', ylim=c(0,8),
     axes=FALSE,ann=FALSE)

# x축 생성
axis(1, at=1:5, lab=c("A","B","C","D","F"))
# y축 생성 : ylim은 plot 생성시 설정한 ylim과 일치시켜야 한다
axis(2,ylim=c(0,8))

title(main="학점별 학생수", col.main='red')
title(xlab = "학점(점)", col.lab="black")
title(ylab = "학생수(명))", col.lab="blue")

### 모든 코드를 함수화 시킬 수 있음

grp1 <- function(v){
# x,y축 삭제
plot(v, type='o', col='red', ylim=c(0,8),
     axes=FALSE,ann=FALSE)
# x축 생성
axis(1, at=1:5, lab=c("A","B","C","D","F"))
# y축 생성 : ylim은 plot 생성시 설정한 ylim과 일치시켜야 한다
axis(2,ylim=c(0,8))
title(main="학점별 학생수", col.main='red')
title(xlab = "학점(점)", col.lab="black")
title(ylab = "학생수(명))", col.lab="blue")
}

y <- c(5,7,7,6,0)
grp1(y)

# 연습문제 5
# 화면 분할 후 그래프 그리기
par(mfrow=c(1,2))
y <- c(5,7,7,6,0)
grp1(y)

y <- c(4,5,6,7,4)
grp1(y)

par(mfrow=c(1,1))

# 연습문제 8
v1 <- c(37.4, 50.3, 63.6, 67.2, 81.1)
v2 <- c(82.2, 88.1, 84.7, 77.2, 56.3)

plot(v1, type='o',col='red',ylim=c(40,100))
lines(v2,type='o',col='blue',ylim=c(40,100))

title(main="연령대별 TV,스마트폰 이용율",col.main="red")
# 범례추가
legend(4,95,c("TV","스마트폰"),cex=0.9,col=c("red","blue"),lty=1)

##############
# barplot()
##############

# 벡터나 matrix 구조로 그릴 수 있음
x<-matrix(c(40,52,33,51),2,2)
x
# 묶음막대그래프
barplot(x,
        names=c("가족도중요하지만\n 나를 먼저 생각한다",
                "물건을 충동적으로\n 구매하는 경우가 많다."),
        main="나를 중시하는 경향",
        beside = T,
        col=c("Magenta1","gray"),
        ylim=c(0,60),
        ylab="(%)")
legend(3.5,60, c("2009","2014"),cex=0.7,
       fill=c("Magenta1","gray"))

#누적막대그래프
barplot(x,
        names=c("가족도중요하지만\n 나를 먼저 생각한다",
                "물건을 충동적으로\n 구매하는 경우가 많다."),
        main="나를 중시하는 경향",
        col=c("Magenta1","gray"),
        ylim=c(0,100),
        ylab="(%)")

# 가로막대그래프

barplot(x,
        names=c("가족도중요하지만\n 나를 먼저 생각한다",
                "물건을 충동적으로\n 구매하는 경우가 많다."),
        main="나를 중시하는 경향",
        col=c("Magenta1","gray"),
        horiz=T,
        xlim=c(0,100),
        xlab="(%)")


