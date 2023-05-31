#조건문:if문
x<-100

#x값이 80이상이면 "pass"출력
if(x >= 80)
print("pass")
print("quit")

#q. 위 코드  x 값이 95면 실행되는 문장번호를 쓰시오. 6,7번 문장 실행 7번은 if와 관련이 없기에 다 실행됨
#q. 위 코드  x 값이 70면 실행되는 문장번호를 쓰시오. 7번 문장만 실행

#if문이 참일때 실행해야될 문장이 2문장 이상이면 {}를 사용해야함
#{}코드 블럭화

# x변수값이 60 초과하면 x에 10을 더한 결과를 출력하시오
x <- 55
if(x > 60){
  x <- x + 10
  print(x)}

###if ~ else문
# if(조건식){
#   조건식의 결과가 TRUE 일때 수행되는 문장
# } else {
#   조건식의 결과가 FALSE 일때 수행되는 문장
# }

x <- 77

# x값이 80이상이면 pass 출력 아니면 fail 출력
if(x >= 80) print("pass") else print("fail")

# if(x >= 80) print("pass") else(x<80) print("fail") else 문에는 조건문을 쓰면 안됨

if(x >= 80) "pass" else "fail"

if(x >= 80) {
  "pass" } else {
    "fail"}


x <- c(1,2,3)
# 위 벡터 클래스가 문자형이면 벡터의 길이를 출력
# 수치형이면 합을 출력
# 문자형이 아니면 수치형이라고 가정

if(is.character(x)) {
  length(x)
} else {
  sum(x)
}


# id, pass 변수의 값이 abcd, 1234를 만족하면 로그인 성공 아니면 로그인 실패를 출력
id <- "abcd"
pass <- "1234"

if(id == "abcd" && pass == "1234"){
  print("로그인 성공")
}else{
  print("로그인 실패")
}


# ifelse( 조건식, TRUE일때 반환값, FALSE 일때 반환값) 함수
x <- 55
#x값이 홀수면 홀수를 짝수면 짝수를 출력
#ifelse()를 통해서 구현
ifelse(x %% 2 == 1, "홀수","짝수")

#x가 음수이면 x의 절대값 반환, 아니면 x값 그대로 반환
ifelse(x < 0, abs(x), x)


###if ~ else문
# if(조건식){
#   조건식의 결과가 TRUE 일때 수행되는 문장
# } else if(조건식2){
# 조건식의 결과는 FALSE 고
#   조건식2의 결과가 TRUE 일때 수행되는 문장
# } else if(조건식n) {
#이전 모든 조건에 대해서는 FALSE고
# 조건식n의 결과가 TRUE일때 수행되는 문장
#}else {
# 이전 모든 조건이 FALSE일때 수행되는 문장
#}

# 여러 조건 검사가 필요한 경우 사용
score <- 90
score <- scan()

if(score >= 90){
  grade = 'A'
} else if (score >= 80){
  grade = 'B'
} else if (score <= 70){
  grade = 'C'
} else if (score <= 60){
  grade = 'D'
} else {
  grade = 'F'
}

grade


# 아래와 같은 변수 생성
a <- 5 ; b <- 9; c <- 7

#위 세변수에서 가장 큰 값을 출력
#조건문을 활용할 것
#같은 값은 없다고 가정

if(a>b & a>c){ #a 변수가 가장 큰 경우
  max <- a
} else if (b>c){# 여기까지 실행 됐다는 것은 a는 가장 큰 변수가 아닌거임
  max <- b 
} else {
  max <- c
  } 

cat("max: ", max)

# switch()함수
# 조건에 따라 선택하여 반환
# switch(값 또는 수식, 경우1, 경우2,.....,나머지 경우)

area <- 3
# switch 함수의 경우를 판단할 때 판단값은 문자열로 처리해야함.
switch(area, '1'='서울','2'='인천','3'='부산','제주도')
#위 코드에서 '1'로 처리하지 않으면 에러가 남


switch(area,
       '1' = tyof(aread),
       '2' = '인천',
       '3' = ls(),
       '제주도')
area <- 'a'

# 경우의 값은 문자, 수식, 숫자등 올 수 있다
switch(area,
       '1' = tyof(aread),
       '2' = '인천',
       '3' = ls(),
       '제주도')
############################################
# 반복문
############################################
# 반복문 
# for문 : 반복의 수가 정해져 있는 경우 
# for(변수 in 범위) {
# 반복해야할 문장들 
#}
# 1부터 10까지 출력하는 코드 
for(i in 1:10){
  print(i)
}

# 1을 열번 출력하는 코드
for(i in 1:10){
  print(1)
}


for(i in c(1:10)){
  print(i)
}

for(i in seq(1,10)){
  print(i)
}


# 1부터 10까지 출력하는 코드
num = 0
for(i in 1:10) {
  num <- num + 1
  print(num)
}




names <- c('홍길동','이몽룡','성춘향')
#names 변수에 있는 값을 출력하시오
for (i in 1:3){
  print(names[i])
}

#자료구조를 활용하면 반복은 자료구조 내 요소 수 만큼 반복한다.
for(i in names) {
  print(i)
}


#1부터 10 수 중에서 홀수만 출력

for (i in 1:10){
if(i %%2 ==1){
  print(i)
  }
}

for(i in seq(1,10,by=2)){
  print(i)
}


# 1부터 100까지 합 구하기 (누적 합구하기)
# 1+2+3+4+5+6
# 누적  합을 저장한 변수 및 초기화 

sum_i <- 0


for(i in seq(1,100)){
  sum_i <- i 
}  

for(i in seq(1,100)){
   sum_i <- sum_i + i
}  

sum_i

# 1부터 100까지 짝수 합 구하기 (누적합 구하기)
sum_i = 0
for(i in seq(1,100)){
  if( i %% 2 == 0){
  sum_i <- sum_i + i
  }  
}
sum_i


# 구구단 출력 
dan <- 2
for (i in seq(1,9))
  cat(dan, "x", i, "=", dan*i,"\n")

#cat()과 print()의 차이
#cat() 줄바꿈 없음 / print(): 줄 바꿈
for(i in 1:5)
  print('안녕')

for(i in 1:5)
  cat('안녕')



#for 문을 사용하여 아래 벡터의 요소 중 양수의 개수 출력
n <- c(0,-2,5,9,-7,1,3)
count <- 0
for(i in n){
  if(i>=0) count <- count+1 
}
count


 ########################################
#while문
# 주어진 조건이 참이면 반복 수행 (반복 횟수가 정해지지 않은 경우 사용)
#while(조건){
#  조건이 참이면 반복 수행할 문장
# }
# 주의사항!!!!
# 반드시 반복문이 종료되도록 하는 문장이 있어야 함
# 조건이 특정시점에 거짓이 되거나
# 반복문 내에서 강제로 종료할 수 있는 문장을 넣어야 한다.
########################################

# 1부터 10까지 출력하는 코드(WHILE문)
i <- 1 
while(i <= 10){
  print(i)
  i <- i+1
}


i <- 0
while(i < 10){
  i <- i+1
  print(i)
  
}


#무한반복문
#반복문을 종료시킬 조건문이 있어야 함
x <- 0
while(TRUE){
  print(1)
  x <- x+1
  if(x>10) break #강제 반복 종료
}


##################################################
# repeat 문
# repeat 다음에 나오는 부분을 무조건 반복
# 문장안에 반복문을 종료하기 위한 조건을 반드시 적어야 함
##################################################

i <- 0
repeat {
  i <= i+1
  if(i<=10)
    print(i)
  else
    break
}









##################################
# 사용자 정의 함수
# 개발자가 자주 반복되는 코드를 함수로 만들어 사용할 수 있다.
# 형식(매개변수 : 함수기능을 수행할 때 함수 사용자로부터 받아야될 값을 저장할 변수)
#  함수명 <- function(매개변수1,매개변수2,.....,매개변수n){
#   함수본문(수행기능)
#   return(반환값)
# }

# 함수사용: 함수 호출 => 함수명(파라미터1,파라미터2,....,파라미터n)

# 매개변수와 반환값이 없는 함수 
# 함수명 : hello
# 수행기능 : "hello!!" 출력

#함수정의
hello <- function(){
  print("hello")
}

#함수 호출
hello()

#매개변수는 없고 반환값이 있는 함수
#함수명 add
#기능: 값 10과 20을 더한 결과를 반환하는 함수

add <- function(){
return(10+20)
}
# 호출
result <- add()
result
# 기능: 함수 사용자가 전달하는 두 값을 전달받아(매개변수)
# 더한 결과를 반환하는 함수
# 함수명: : add2
add2 <- function(x,y){
  return(x+y)
}

# 함수호출
result <- add2(10,50)
result

#함수명 f_abs
# 매개변수로 값 하나를 전달받아 양수던 음수이든 양수로 반환하는 함수 

f_abs <- function(x){
  if(x < 0) x <- -x
  return(x)
}

f_abs(-7)

#함수명 : sub_n
# 아래 벡터에서 사용자가 추출하고자 하는 부분의 인덱스의 시작값과 종료값을
# 전달받아 해당 부분을 출력하는 함수
# 사용자는 숫자값을 전달하고 두 값은 1부터 10 사이에 먼저 전달되는 값은
# 두번째 전달되는 값보다 작다고 가정

n <- c(1:10)
n


sub_n <- function(s,e){
  n[s:e]
}


sub_n(2,5)
sub_n(8,10)
sub_n(10,8)

# 함수 내에서 만들어진 변수(지역 변수)
# 
play_music <- function(){
  music <- '소우주' # 함수 내에서 생성되었으므로 함수 외부에서는 사용할 수 없음
  print(music)
}

# 함수호출
play_music()
print(music)  #music 변수는 함수 내에서 생성된 지역 변수임.

music <- "곰세마리" #함수 외부에서 생성된 전역변수
play_music()
print(music) 

#사용자로부터 단가와 수량을 전달받아 주문액과 10% 할인을 계산 후 할인액을 
# 반환하는 prd_order 함수를 정의하고 사용 예를 보이시오

prd_order <- function(price,qty){
  amount <- price * qty
  discount <- amount * 0.1
  return(discount)
}

prd_order(3000,5)


