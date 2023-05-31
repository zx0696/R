##############################
#aggregate() 함수
# 특정 열을 기준으로 통계량을 계산해 주는 함수
# 데이터 프레임을 대상 통계 함수 사용

install.packages('googleVis')
library(googleVis)
Fruits

# 년도별 판매량의 합계 구하시오 
# aggregate(계산될 열 ~ 기준 열, 데이터셋, 함수)
aggregate(Sales~Year, Fruits, sum)


#과일 별 판매 수량의 합계
aggregate(Sales~Fruit,Fruits,sum)

#가장 적게 판매된 과일별 수량
aggregate(Sales~Fruit,Fruits,min)


# 가장 많이 판매된 과일별 수량
aggregate(Sales~Fruit,Fruits,max)









# 1, data1.csv : ANTI -> UTF8
data1 <- read.csv('data_/data1.csv')
View(data1)
ls(data1)
# [1] "X2000년" "X2001년" "X2002년" "X2003년" "X2004년" "X2005년" "X2006년" "X2007년" "X2008년" "X2009년"
# [11] "X2010년" "X2011년" "X2012년" "X2013년" "연령별" 


#2. 연도별 합계를 모두 구하시오,
# 연령별 제외 후 연산
#data[-1] : 1열 제외 모든 열
apply(data1[-1],2,sum) # 1-행, 2-열 
class(apply(data1[-1],2,sum)) #vector형 반환 
# 3. 연령별 합계를 출력 
apply(data1[-1],1,sum)
# apply() 모든 함수에 적용가능(사용자 정의 함수)

#######################################################################
# lapply() : 반환값이 list 형태 
# list인 경우 대부분 unlist 해서 사용하는 것이 일반적이라 활용도가 높지는 않음

ls_s <- list(Fruits$Sales)
ls_p <- list(Fruits$Profit)

# ls_s, ls_p에 max 값을 추출 
lapply(c(ls_s, ls_p), max)
# 반환형태 : list

sapply(c(ls_s, ls_p), max)
#반환형태 : vector

df_ab <- data.frame(a = c(1,7,3), b  = c(5,7,8))
sapply(df_ab,max)
lapply(df_ab,max)

#############################################
# tapply(계산열, 기준열, 적용함수) : 특정 요소를 기준으로 그룹화 하여 수행
# group_by 효과 : ~별로 ~ 수행
Fruits
tapply(Fruits$Sales,Fruits$Fruit, sum) #벡터반환

attach(Fruits) #df 각 속성을 계산에 용이하게 사용하기 위해  현 스크립트에 포함
# df를 attach하면 df명 없이 컬럼만 변수(객체)처럼 사용가능  
Sales;Fruit
tapply(Sales, Fruit, sum)

#attach() : 데이터를 R 탐색 경로에 추가
#detach() : 데이터를 R 탐색 경로에서 제거

###########################################
# mapply(함수,벡터1, 벡터2, 벡터3,........)
# 여러개의 벡터 또는 리스트를 인자로 받아
# 지정된 함수에 데이터의 동일 위치요소들을 적용시킨 결과를 반환
# 데이터 프레임이 아닌 데이터에 대해 데이터프레임처럼 연산해주는 기능

v1 <- c(1,2,3,4,5)
v2 <- c(10,20,30,40,50)
v3 <- c(100,200,300,400,500)
 
mapply(sum, v1, v2, v3)

v4 <- c(1000,2000,3000,4000)
mapply(sum, v1, v2, v3,v4)
# longer argument not a multiple of length of shorter
# v4의 요소수가 다른 벡터보다 짧다.
# mapply에 사용할 벡터들은 같은 길이여야 함

#######################################################
#sweep() 함수 
#행렬, 배열, 데이터프레임에 연산자를 적용하는 함수 
mat1 <- matrix(c(1,2,3,4),2,2)
mat1

a <- c(1,3)

sweep(mat1,2, a) # 빼기연산(디폴트), mat1의 각 행에 대해서 a벡터 값을 뺀 결과
sweep(mat1,2,a,'+') # 더하기 연산

#length() : 요소의 개수나 행수 파악
Fruits # 데이터 프레임
Fruit # 열 이름(attach(Fruits) 실행했음)

length(Fruits) #df의 열의 수 
length(Fruit) # 백터의 요소 수

# sort(벡터,[decreasing=])함수 : 데이터 정렬 함수
sort(Fruits, Fruit)
# 벡터 등 1차원 데이터의 정렬에 주로 사용
sort(Sales) #오름차순 정렬
sort(Sales, decreasing = T) #내림차순 정렬

####################################################################################33
#문자열 처리 
#문자열은 데이터의 많은 부분을 차지함
# string 패키지 : 문자열(캐릭터형) 을 가능한 쉽게 처리하도록 설계된 함수 제공

install.packages('stringr')
library(stringr)

fruits <- c('apple','Apple','banana','pineapple','kp','p1')
fruits

#str_detect(data, 특정문자)
# data의 각 요소에 특정문자가 포함되어 있는지의 여부 T/F로 반환
#각 문자열에 대문자 A 포함여부 출력
str_detect(fruits,'A') #[1] FALSE  TRUE FALSE FALSE FALSE FALSE
fruits[str_detect(fruits,'A')] # 논리값 인덱싱

# ^ / [] 이용한 정규식 표현
# ^ : 첫 문자의 의미

# 소문자 a로 시작하는지(^a)의 여부 출력
str_detect(fruits, '^a')

# p로 시작 하는지 여부
str_detect(fruits, '^[p]')
str_detect(fruits, '^p')

# [a,b,c,d,e] : a거나 b거나 c거나 ....
# ^[a,b] - a또는 b로 시작하는
str_detect(fruits,'^[a,p]')

# $ : 마지막 문자의 의미
# 문자열의 마지막 문자가 소문자 e인지 여부 출력
str_detect(fruits, 'e$')
fruits[str_detect(fruits, 'e$')]

#[pk] : 문자열에 p 또는  k가 포함되어 있는지의 여부
str_detect(fruits,'[pk]')
#[p,k] : 문자열에 p 또는  k또는  쉼표가(,) 포함되어 있는지의 여부
str_detect(fruits,'[p,k]') #쉼표가 있는지도 구분하기에 모두 트루


fruits <- c('apple','Apple','ban,ana','pineapple','kp','p1')
fruits


# . : 문자 1개를 의미
stri <- c('ABB','aaB','aa.b','aAb')
str_detect(stri, 'a.b')
# 패턴문자 a.b  소문자 a가 한번 나오고 어떤문자든 1번(.) 나오고 소문자 b가 나타나는 패턴

# ... : 3개의 문자를 포함하는 
pt <- '...'
str_detect(stri, pt)

stri <- c('AB','aaB','aa.b','aAb')
str_detect(stri, 'pt')



##########################
#str_count() : 특정 문자 출현 횟수 세는 함수
fruits
str_count(fruits,'a')

#대소문자 변환

#대문자로
str_to_upper(fruits)

# 소문자로
str_to_lower(fruits)

#단어의 첫 문자를 대문자로
str_to_title(fruits)

str_to_title('aPPLE') #"Apple" 첫문자는 대문자로 나머지 문자는 소문자로
# 단어의 구분 ' '(공백), ','(쉼표), ....


# str_C(): 문자열 합치기 
str_c("apple", "banana")
fruits
str_c(fruits)
str_c('Fruits : ', fruits)


#벡터 집합의 모든 요소를 하나의 문자열로 결합
#collapse : 구분자 사용
str_c(fruits, collapse = "")
str_c(fruits, collapse = " ")
str_c(fruits, collapse = "-")

#str_dup() : 반복 출력
str_dup(fruits, 3)

# 문자열 길이 반환
str_length(fruits) #벡터의 각 요소의 길이
length(fruits) # 벡터의 요소의 개수

#str_locate(): (데이터, 특정문자) : 특정 문자의 위치값 반환
str_locate('pineapple', 'e')
str_locate('pineapple', 'p') # 첫번째 찾은 문자의 위치 
# 집합 데이터에 대입하면 행열 반환
str_locate(fruits, 'a')

str_locate('서울시 강남구 역삼동', '강남구')
# start end
# [1,]     5   7

str_apple = 'apple'

#str_replace(전체 문자열, 대상, 교체될 문자)
str_replace(str_apple, 'p', '*')
# [1] "a*ple" : 문자열 내에서 첫번째 만난 p를 * 로 변환


# 포함된 모든 문자 변경 
str_replace_all(str_apple, 'p','*')
str_replace_all(fruits,'p','*')

fruits2 <- str_c('apple', '/', 'orange','/','banana')
fruits2

#str_split() 특정 문자를 기준으로 문자열을 분리 
str_split(fruits2,'/') # 리스트로 반환

# str_sub(데이터, start=시작인덱스, end = 끝 인덱스) : 부분 문자열 추출
str_sub('apple', start=1, end=3)

str_sub(fruits, start=1, end=3)

#start만 사용도 가능 end가 생략이므로 start부터 끝까지 의미
str_sub(fruits, start=2)

# -는 뒤애서부터 시작
str_sub('apple', start=-2)


# str_trim(문자열, [side=right/left]) 문자열의 앞/뒤 공백을 제거
str_trim('apple banana berry') # 문자 사이의 공백을 제거할 수는 없다.
str_trim('             apple banana berry               ') #앞뒤 공백 모두 제거
str_trim('             apple banana berry          ', side = 'left') #뒤 공백  제거
str_trim('             apple banana berry          ', side = 'right') #앞 공백  제거

#########################################################33
# 문자열 처리 함수 : R 내장함수
#gsub(변경전 문자(패턴 사용가능), 변경 후 문자, 데이터, 옵션) 함수
# : 문자를 정제하는 함수, 불필요한 문자를 제거할 때 사용 
# : 태그, 특수문자 등을 제거할 때 사용

gsub('ABC', '***', 'ABCabcABCBC')

gsub('ABC', '***', 'ABCabcABCBC', ignore.case = T)
# ignore.case = T : 대소문자를 무시하고 패턴문자를 찾아 변경
# 'ABCABCABCBC' - 문자열을 대문자 또는 소문자로 변경 후 패턴 매칭
# ABC

gsub('b.n', '***', 'i love banana')

gsub('[^ple]','*','pineapple apple people')
# p/l/e로 시작하는 ^[ple] : []밖에 있는 ^
# p/l/e를 제외한 나머지 [^ple] [] 안에 있는 ^는 제외의 의미

#'010-[0-9]{4}-[0-9]{4}'
# 010-로 시작 0부터 9까지의 문자가 하나가 4번 반복되고 - 문자가 와야하고 
# 0부터 9까지의 문자가 하나가 4번 반복
# [0-9] [] 안에 있는 문자중의 하나 , - 범위 
# [0123456789]
#{n} 앞의 문자가 n번 반복
# [0-9] {4}
# 0{4}
gsub("010-[0-9]{4}-[0-9]{4}",
     "010-****-****",
     "내 폰번호는 010-1234-1234")


data <- "010으로 시작하고 0부터 9까지의 문자 중 하나가 반복"
gsub('\\d', '*', data) # '\\d' 숫자 전체

test_data <- readLines('data_/test1.txt')
test_data 
res <- str_split(test_data, ' ') #list로 반환
res <- unlist(res)
res


gsub('\\W', '*', res) # '\\W' _제외한 특수문자

########################################
# sqldf 패키지 
# sql 문법을 df에 적용시키는 함수

install.packages('sqldf')
library(sqldf)

# select 문 활용 : 행반환
# * : 모든 열
#select 열 이름1, 열이름2, ....., 열 이름 n from df명(테이블명) [where 조건문]
#sqldf('쿼리구문')
sqldf('select * from Fruits')
Fruits

#sql 쿼리문은 대소문자구분하지 않는다.
sqldf('Select * From Fruits')

# Apples 데이터만 출력 
#sql 쿼리의 문법 중 문자열 표시는 '' 사용
sqldf("select * from Fruits where Fruit = 'Apples'")
sqldf("select year,Sales,Profit from Fruits where Fruit = 'Apples'")
sqldf("select year,Sales,Profit from Fruits where Fruit = 'Apples' AND Sales >= 100")

#출력되는 행 수 제어 : limit 사용
sqldf('select * from Fruits limit 5')


#정렬해서 출력 : ORDER BY 컬럼명 [DESC]
Sqldf("select year,Sales,Profit from Fruits Order by year")
Sqldf("select year,Sales,Profit from Fruits Order by year desc")

#select 문장에 그룹(집계)함수 적용
#sum()/avg()/max()/min() 

sqldf('select sum(Sales), avg(Sales), avg(Sales), max(Sales) from Fruits')

#전체 행(data, 레코드:관측치) 수 파악 
sqldf('select count(*) from Fruits')

# group by 기준열
sqldf("select sum (Sales) from Fruits group by Fruit")
#sql 쿼리구문의 group by 적용시 주의 점
#select 되눈 열은 group by의 기준열과 집계함수를 적용시킨 열만 표현해야함.
sqldf("select sum (Sales), Profit from Fruits group by Fruit")

Fruits

##########################################
library(ggplot2)
# mpg df의 최대 고속도로 연비(hwy)를 갖는 자동차의 정보를 조회하시오
sqldf('select max(hwy) from mpg')
# sub 쿼리 사용
sqldf('select * from mpg where hwy=44')

# sub 쿼리
# 'select * from table where hwy=(select max(hwy) from mpg)')
sqldf('select * from mpg where hwy=(select max(hwy) from mpg)')
