# 변수 : 객체
# 값을 저장하기 위한 공간(메모리내의 임시 기억 장소)
# 변수의 특성
# 이름이 있다
# 변수의 값은 수정할 수 있다
# 변수명 <- 값 : 오른쪽에 있는 값을 왼쪽 변수에 저장할 것 
# 변수명 <- 연산식 : 오른쪽에 연산식을 계산해서 결과를 왼쪽 변수에 저장
# -< / = (할당 연산자, 대입 연산자)
x <- 10
x = 100
x # 변수 저장 값 조회 

# 숫자 3개(10,20,30)을 x1 변수에 저장
# c() 함수 사용
x1 <- c(10,20,30)
x1
# 연속 값을 저장할 때는 : 이용
x2 <- c(10:15)
x2

# 데이터 타입 확인 : typeof(변수명)
typeof(x1) #double
typeof(x2) #int

# 여러개의 개별값을 한 변수에 저장할 때 정수형으로 저장하려면 L을 사용
x1 <- c(10L,20L,30L)
typeof(x1) #  integer

typeof(1)
typeof(1L)

# seq(초기값,마지막값) 함수사용
# 연속된 숫자를 생성 해내는 함수
x3 <- seq(10,15)
x3

#: 이용해서 연속값 생성 시 1부터 시작하면 문제 없음
a <- seq(1:7)
a
# 1 이외에 수부터 시작하면 안됨
b <- seq(10:15) #1 2 3 4 5 6이 생성됨
b

#by = +/- 간격
x4 <- seq(1,10, by=4) #1부터 10까지 4 간격에 숫자 생성 
x4  #1 5 9

x4 <- seq(10,1, by=-4) #10부터 1까지 4씩 감소 숫자 생성 
x4  #10 6 2

# rep(값,each=반복횟수) 함수 사용하여
#반복되는 값으로 변수 생성
x5 <-rep(1:5,3)
x5

# letters  상수로 "a","b","C"를 3번 반복 생성
x6 <- rep(letters[1:3],each=3) #each를 쓰는 것과 안 쓰는 것이 달라짐
x6

# 문자열 데이터 "",'' 사용 
name <- '홍길동'
name

name <- c('1','2','3')
name

typeof(name) #character

test <- c("서울","홍길동",23) #숫자를 문자로  저장함 문자가 더 크기에 올바르지 않은 표현
test

# 변수값을 사용하여 연산
n1 <- 10
n2 <- 20
n3 <- n1+n2
n3

#주의: 문자 더하기 연산 -오류 파이썬과 다름
ch1 <- "abc"
ch2  <- "def"
ch3 <- ch1 + ch2
ch3

# 문자열 연결 : paste(문자열1,문자열2,sep="") 함수 사용(sep : 구분자)
ch3 <- paste(ch1,ch2)
ch3

ch3 <- paste(ch1,ch2,sep ="") #공백 구분자 없이 연결 
ch3

# 여러 값으로 구성된 변수들간의 연산
# 같은 순서에 위치한 (인덱스)값끼리 연산
n1 <- c(1,3,5,7,9)
n2 <- c(2,4,6,8,10)
n1 + n2

# 두 변수의 값의 길이가 다를 경우 짧은 길이의 변수가 반복 
n1 <- c(1,3,5,7)
n2 <- c(2,4,6,8,10)
n1 + n2

# 생성된 변수 모두 확인하기 
objects()
ls()
# 변수 제거하기 (rm(변수명))
rm(a)
a

#생성된 모든 변수 한번에 제거 : rm(list = ls())
rm(list = ls())
ch2

##############################
#R의 기본 자료형 
##############################
# 숫자의 기본 형은 double형
x <- 5; y <- 3
x / y
typeof(x) ; typeof(y)

# integer 형 : L을 붙인다
x <- 5L
y <- 3L
x/y
typeof(x) ; typeof(y)

# 실수 : double 형
f <- 3.14
typeof(f)

# f <- 3.14L L은 정수형 뒤에만 붙일 수 있다 에러 남 

# 문자(열) : character 형
a <- 'a'
b <- '홍길동'
typeof(a) ; typeof(b)

# 논리형 : logical 형
t1 <- TRUE 
typeof(t1)

t1 <- T 
typeof(t1)


t1 <- FALSE 
typeof(t1)

t1 <- F 
typeof(t1)

t1

#특수한 상태를 나타내는 상수
#NULL : 비어있는 값(정의되지 않은 값)
student #student 객체 존재 하지 않음
student <- c()
student
typeof(student)


# NaN : 수학적으로 정의가 불가능한 값.
# 연산을(0/0)을 진행하면 type은 결정이 됨
div <- 0/0
div #NaN
typeof(div)

# 무한대: Inf/ -Inf
x_inf <- Inf
x_inf
typeof(x_inf)

# e : 지수표현(0이 5개 부터 )
10000
100000 #1e+05
1000000#1e+06
# 소수점 4째자리부터 지수표현
0.001
0.0001 #1e-04 1 뒤로 4번 움직여라
########
# 자료형 정보 함수 
########
# class() : 객체의 유형반환
# typeof() : 요소의 유형반환
# mode() : 메모리에 올려질 때의 유형 반환(물리적관점)

nums <- c(1,2,3)
typeof(nums)
class(nums)
mode(nums)

nums <- c('1','2','3')
typeof(nums)
class(nums)
mode(nums)

# 행렬(matrix)의 경우 자료형 정보
x <- c(1,2,3,4,5,6)
mt <- matrix(x,nrow = 2, ncol = 3)
mt

typeof(mt)
class(mt)
mode(mt)

###############
# 자료형 확인 함수(T/F로 반환)
# is.xxx(data) : xxx는 자료형 이름
# is.integer(x) : x가 정수형이냐?
###############

nums
is.integer(nums)
is.double(nums)
is.numeric(nums)
is.character(nums)

#################
# 데이터 강제 형변환: 데이터 유형을 다른 유형으로변환
# 문자 -> 숫자
# 문자 -> 날짜
# as.xxx()
#################
price <- "100"
qty <- 5
amount <- price * qty # 에러발생 문자와 숫자여서

price <- as.integer(price)
amount <- price * qty
amount
typeof(price)
typeof(amount)

####
# 문자형을 날짜형으로 변환 : as.Date(문자열)
####

today <- 2023-03-20 #숫자기 때문에 뺄셈이 됨
typeof(today)
today

today <- "2023-03-20" #문자열로 표시됨
typeof(today)
today

d_day <- "2023-08-20"

# 날짜형은 연산이 가능
days_left <- as.Date(today) - as.Date(d_day)
days_left


#######################
# 범주형 변수 : factor()로 생성
# 범주형 : 크기가 존재하지 않는 data
#######################
var_n <- c(1,2,3,1,2) # numeric 형 변수
var_f <- factor(c(1,2,3,1,2)) #factor형 변수 

var_n
var_f
# [1] 1 2 3 1 2 
# Levels: 1 2 3 - 해당 변수는 1,2,3의 3개의 범주(카테고리)

#factor.형 변수는 연산 불가
var_n + 2
var_f + 2 # 연산이 의미가 없음 (factor형 이므로 )
# [1] NA NA NA NA NA
#  Warning message:
#  In Ops.factor(var_f, 2) : 요인(factors)에 대하여 의미있는 ‘+’가 아닙니다.

class(var_n)
class(var_f)

typeof(var_n)
typeof(var_f)

# 문자로 구성된  factor형 변수 
var_c <- c("a","b","c","a","b")
var_fc <- factor(var_c)

var_c
var_fc # 따옴표가 없음 - 즉, 문자가 아니라는 의미 

class(var_fc)
typeof(var_fc)
mode(var_fc)

#levels: 범주값은 정렬되어 출력 (ㄱㄴㄷ 순으로)
var_fc2 <- factor(c("하나", "둘", "셋"))
var_fc2
# levles) 함수 : 범주값 출력
levels(var_c) # 문자형 변수
levels(var_fc) # factor 
levels(var_fc2) # facor 

# table() 함수 : 목록형 변수의 빈도표 작성
var_n <- c(1,2,3,1,2)
table(var_n)


var_fc
table(var_fc)


# R에서 기본으로 제공되는 상수
letters
LETTERS
month.name
month.abb
state.name
state.abb
pi

a <- c(month.abb)
a


####################
# 연산자
####################
# 산술연산
# 사칙연산 : + - * / 
# %/% : 나눈 몫을 반환
# %% : 나눈 나머지 반환
# ** ^ : 제곱(승수)

20 %/% 7
20 %% 7
6 ^ 2
6 ** 2


# 관계연산(비교연산) : T/F 반환
# > < >= <= == != 

5==5
5 != 5
5 > 3
5 < 3



# 변수의 각 요소 값 비교

v1 <- c(100,200,300)
v2 <- c(1,2,3)
v1 > v2 

v3 <- c(1,2)
v1 > v3

# 논리 연산 (&, |, !)
# T/F 반환
5 & 3
5 & 0
6 & 5
(5>3) & (10>3)

!(5>3)


# 함수 : 작업 수행(기능)
# 작업을 수행하고 결과 값을 반환하도록 만들어진 코드집합
# 변수 : 값을 저장

v1
sum(v1)
mean(v1)

# 패키지 : 유사한 기능의 함수 집합
# 설치: install.packages("설치할패키지명")
# load해서 사용해야 함 : library(로드할 패키지명)
