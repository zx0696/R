
##############################################
# 기초문법_조건_반복_함수 연습문제
##############################################

# 1
  # 변수 x의 값을 설정하고 출력한 다음
  # 변수 값이 홀수이면 "홀수" 출력, 아니면 "짝수" 출력
  # 출력 x : 15        x : 8
  #     [1] "홀수"    [1] "짝수"

x <- scan()

if(x %% 2 == 1) {
  "홀수"
} else {
  "짝수"
}


# 2 아이디와 비밀번호를 다음과 같이 설정하고
  # id : abcd
  # pass : 1234
  # 아이디와 비밀번호가 일치하면 "로그인 성공"
  # 일치하지 않으면 "로그인 실패" 출력

id <- "abcd"
pass <- "1234"

if(id=="abcd" && pass=="1234") {
  "로그인 성공"
} else {
  "로그인 실패"
}


# 3 변수 3개에 숫자 저장하고, 3개의 변수를 비교하여 가장 큰 값 출력
  # a : 5
  # b : 9
  # c : 7
  # max : 9

a <- 5; b <- 9; c <- 7

if(a>b & a>c) {
  max <- a
} else if(b>c) {
  max <- b
} else {
  max <- c
}

cat("max :",max)


# 4 1~10 수 중에서 홀수만 출력

for(i in 1:10) {
  if(i %% 2 == 1)
    print(i) }


# 5 1~100에서 짝수의 합 구하기

even_n <- 0
for(i in 1:100) {
  if(i %% 2 == 0) {
    even_n <- even_n + i } 
}
even_n


# 6 while문 사용, 1~100에서 짝수의 합을 구하여 출력

i <- 1
even_n <- 0
while(i <= 100) {
  if(i %% 2 == 0) {
    even_n <- even_n + i
  }
  i <- i + 1
}
even_n


# 7 repeat문 사용, 1~20 수 중에서 3의 배수만 출력

i <- 0
repeat{
  i <- i + 1
  if(i %% 3 == 0)
    print(i)
  if(i == 20)  break
}


# 9 함수로 입력된 숫자가 양수이든 음수이든 양수로 출력하는 함수(f_abs)

f_abs <- function(x) {
  if(x < 0) x <- -x
  return(x)
}


# 10 1~10 값을 갖는 벡터를 만들고 다음과 같은 함수 작성(sub_n)
  # 시작 위치와 마지막 위치 값을 입력 받아서
  # 해당 범위의 벡터 요소를 출력

vec <- c(1:10)

sub_n <- function(s,e) {
  vec[s:e]
}


# 11 아이디와 비밀번호를 입력 받아서 입력 받은 값이 id가 "abcd"이고 pass가 "1234"이면 "로그인 성공" 출력 아니면 "로그인 실패" 출력

check_login <- function(id,pass) {
  id <- readline("id :")
  pass <- readline("pass :")
  if(id=="abcd" & pass=="1234"){
    "로그인 성공"
  } else {
    "로그인 실패"
  }
}

check_login()


################################################
# 연습문제 part2
################################################

# 1 구구단 입력 받은 단 출력(gugudan())

gugudan <- function(n) {
  for (i in 1:9) {
    cat(n,"x",i,"=",n*i,"\n")
  }
}
gugudan(7)
gugudan(5)


# 2
  # ifelse() 사용
  # 다음과 같은 데이터 프레임을 생성한후
  # RESULT 열을 추가하고 값을 다음과 같이 저장
    # 점수가 80 이상이면 "합격"으로
    # 80 미만이면 "불합격"으로

df_test <- data.frame(NAME=c("홍길동","이몽룡","성춘향"),
                      SCORE=c(75,89,90))
df_test$RESULT <- ifelse(df_test$SCORE >= 80,"합격","불합격")
df_test


# 3 다음의 수 중에서 양수, 음수, 0의 개수를 출력
  # c(5,-10,2,0,7,0,-4,1,0,8)

n <- c(5,-10,2,0,7,0,-4,1,0,8)
count_pos <- 0
count_neg <- 0
count_zero <- 0
for(i in n) {
  if(i == 0) {
    count_zero <- count_zero + 1
  } else if(i > 0) {
    count_pos <- count_pos + 1
  } else {
    count_neg <- count_neg + 1
  }
}

cat("양수 :",count_pos,"\n","음수 :",count_neg,"\n","0 :",count_zero)


# 4 다음과 같이 함수 작성(f_multiple)
  # 함수로 입력된 숫자가 0보다 크면 2를 곱하고
  # 0일 경우 0 그대로이고
  # 0보다 작을 경우 2를 나눈 값을 반환하는 함수

f_multiple <- function(n) {
  if(n>0) {
    return(n*2)
  } else if(n==0) {
    return(n)
  } else {
    return(n/2)
  }
}

f_multiple(3)
f_multiple(0)
f_multiple(-3)


# 5
  # 다음과 같은 데이터 프레임을 s 생성하고
    # name   kor mat eng
    # 김길동 100 90  80
    # 강길동 90  95  98
    # 박길동 85  98  100

s <- data.frame(name=c("김길동","강길동","박길동"),
                kor=c(100,90,85),
                mat=c(90,95,98),
                eng=c(80,98,100))

  # s변수에 함수 인수로 입력된 학생 data가 있는지 확인하는 함수 작성
    # 함수명 srch(변수명, 이름인수)
    # 함수로 s와 찾고자 하는 이름 전달하면
    # 함수에서 찾고 결과 출력 TRUE/FALSE

srch <- function(df,name) {
  lst <- as.list(df)
  vec <- unlist(lst)
  if(name %in% vec == TRUE) {
    TRUE
  } else {
    FALSE
  }
}

srch1 <- function(df,name) {
  for(i in df$name) {
    if(i == name) {
      result <- TRUE # 파라미터로 전달된 이름이 전달된 df에 있다
      break
    } else {
      result <- FALSE # 파라미터로 전달된 이름이 현재까지 df에 없다
    }
  }
  return(result)
}

srch(s,"홍길동")
srch(s,"박길동")


##########################################
# 그래프 기본함수 연습문제
##########################################

# 1 
  # 1-1 y축 값이 (3,4,5,6,7)이 되도록 기본 그래프를 그리시오.
plot(c(3,4,5,6,7))

  # 1-2 y축 값이 (3,3,4,4)가 되도록 기본 그래프를 그리시오.
plot(c(3,3,4,4))

  # 1-3 x : (3,3,3), y : (2,3,4)가 되도록 그래프를 그리시오.
plot(c(3,3,3), c(2,3,4))

  # 1-4 x : (10,20,30,40,50,60,70,80,90), y : (10,9,8,7,6,5,4,3,2)가 되도록 그래프를 그리시오.
x <- c(10,20,30,40,50,60,70,80,90)
y <- c(10,9,8,7,6,5,4,3,2)
plot(x,y)

  # 1-5 x,y축의 한계값을 조정하여 그림과 같은 그래프를 만드시오.(축 제목은 임의로)
x <- c(2,4,6,8)
y <- c(16,17,19,18)
plot(x,y,ylab='yyy',xlab='xxx',ylim=c(15,20),xlim=c(0,10))


# 2 그래프 제목, 축 제목과 범위 등을 보고 두 그래프를 각각 그리시오.(y 값은 모두 정수임)

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
     axes=F)
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


# 5 앞의 두 그래프를 한 화면에 표시하시오.(화면을 1행 2열로 설정)

par(mfrow=c(1,2))

stu_cnt <- c(5,7,7,6,1)
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