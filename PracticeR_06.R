
##########################################
# 기본분석함수 연습문제
##########################################


##########################################
# aggregate() 연습문제 1
##########################################
library(googleVis)
Fruits

# 1. 과일별 판매액의 평균을 구하시오.
aggregate(Sales~Fruit,Fruits,mean)
# 2. 과일별 비용의 최대값을 구하시오.
aggregate(Expenses~Fruit,Fruits,max)
# 3. 과일별 수익의 최소값을 구하시오.
aggregate(Profit~Fruit,Fruits,min)
# 4. 위치별 판매금액의 평균을 구하시오.
aggregate(Sales~Location,Fruits,mean)
# 5. 과일별 수익의 합계를 구하시오.
aggregate(Profit~Fruit,Fruits,sum)
# 6. 년도별 판매금액의 합계를 구하시오.
aggregate(Sales~Year,Fruits,sum)
# 7. 과일별 평균 비용을 구하시오.
aggregate(Expenses~Fruit,Fruits,mean)
# 8. 지역+과일별 수익의 평균을 구하시오.
aggregate(Profit~Location+Fruit,Fruits,mean)
# 9. 지역+연도별 판매액의 합계를 구하시오.
aggregate(Sales~Location+Year,Fruits,sum)
# 10. 지역+과일별 비용의 합계를 구하시오.
aggregate(Expenses~Location+Fruit,Fruits,sum)
# 11. 지역+연도별 수익의 최대값을 구하시오.
aggregate(Profit~Location+Year,Fruits,max)


##########################################
# aggregate() 연습문제 2
##########################################

# 1. 1-4호선승하차승객수.csv 파일을 df_subway로 불러오세요. View()로 확인
df_subway <- read.csv("data/1-4호선승하차승객수.csv")
View(df_subway)
# 2. 노선 번호별 총 승차 인원수를 구하시오.
aggregate(승차~노선번호,df_subway,sum)
# 3. 노선 번호별 총 하차 인원수를 구하시오.
aggregate(하차~노선번호,df_subway,sum)
# 4. 노선 번호별 승차 인원수 평균을 구하시오.
aggregate(승차~노선번호,df_subway,mean)
# 5. 노선 번호별 하차 인원수 최소값을 구하시오.
aggregate(하차~노선번호,df_subway,min)
# 6. 노선 번호별 승차, 하차 각 최대값을 구하시오.
aggregate(cbind(승차,하차)~노선번호,df_subway,max)
# 7. 노선 번호별 승차, 하차 각 최소값을 구하시오.
aggregate(cbind(승차,하차)~노선번호,df_subway,min)
# 8. 노선 번호별 승하차 총 인원수를 구하시오.
aggregate(cbind(승차,하차)~노선번호,df_subway,sum)


##########################################
# apply() 연습문제
##########################################

# 1. data1.csv 파일을 data1으로 불러오세요.
data1 <- read.csv("data/data1.csv")
# 2. 연도별 합계를 모두 구하시오.
apply(data1[-1],2,sum)
# 3. 연령별 합계를 모두 구하시오.
apply(data1[-1],1,sum)
# 4. 2008년부터 2012년까지 연도별 합계를 각각 구하시오.
apply(data1[10:14],2,sum)
# 5. 2008년부터 2012년까지 연령별 합계를 각각 구하시오.
apply(data1[10:14],1,sum)
# 6. 2000년, 2005년, 2010년의 연도별 합계를 각각 구해 d1에 대입하시오.
d1 <- apply(data1[c(2,7,12)],2,sum)
# 7. 2000년, 2005년, 2010년의 연령별 합계를 각각 구해 d2에 대입하시오.
d2 <- apply(data1[c(2,7,12)],1,sum)


##########################################
# sapply() 연습문제
##########################################

# 1. 연도별 합계를 모두 구하시오.
sapply(data1[-1],sum)
# 2. 2008년부터 2012년까지 연도별 합계를 각각 구하시오.
sapply(data1[10:14],sum)
# 3. 2000년, 2005년, 2010년의 연도별 합계를 각각 구하시오.
sapply(data1[c(2,7,12)],sum)


##########################################
# apply() / sapply() / tapply() 연습문제
##########################################

# 1. 1-4호선승하차승객수.csv 파일을 data2로 불러오세요.
data2 <- read.csv("data/1-4호선승하차승객수.csv")
View(data2)
# 2. 노선 번호별 총 승차 인원수를 구하시오.
tapply(data2$승차,data2$노선번호,sum)
# 3. 노선 번호별 총 하차 인원수를 구하시오.
tapply(data2$하차,data2$노선번호,sum)
# 4. 노선 번호에 상관없이 총 승차 인원수 및 총 하차 인원수를 구하시오.
sapply(data2[c(3,4)],sum)
# 5. 노선 번호별 총 승차 인원수 및 총 하차 인원수의 평균을 각각 구하시오.
tapply(data2$승차,data2$노선번호,mean)
tapply(data2$하차,data2$노선번호,mean)
# 6. 노선 번호에 상관없이 승차 및 하차 인원수 최소값을 각각 구하시오.
sapply(data2[c(-1,-2)],min)
# 7. 노선 번호별 인원수의 최소값을 구하시오.
tapply(data2$승차,data2$노선번호,min)
tapply(data2$하차,data2$노선번호,min)


###########################################
# stringr 패키지 연습문제1
###########################################
library(stringr)
mystr <- '홍길동15강감찬25이순신35김유신45'

# 1. mystr문자열의 길이를 구해 len 변수에 저장하고 변수를 확인하시오.
len <- str_length(mystr)
len
# 2. '김유신'의 위치를 파악한다.
str_locate(mystr,"김유신")
# 3. mystr의 앞에서 4글자를 추출한다.
str_sub(mystr,start=1,end=4)
# 4. mystr의 5번째부터 끝까지 추출한다.
str_sub(mystr,start=5)


###########################################
# stringr 패키지 연습문제2
###########################################
mystr <- 'hello world'
mystr

# 1. mystr 변수의 모든 글자를 대문자로 변환 후 mystr 변수에 저장하고 변수 내용을 출력하시오.
mystr <- str_to_upper(mystr)
mystr
# 2. mystr 변수의 모든 글자를 소문자로 변환 후 mystr 변수에 저장하고 변수 내용을 출력하시오.
mystr <- str_to_lower(mystr)
mystr
# 3. 문자열 변수 mystr의 값에 대해서 단어의 첫 글자를 대문자로 변환한다.
str_to_title(mystr)


###########################################
# stringr 패키지 연습문제3
###########################################
mystr = 'hong1234'

# 1. mystr변수의 값 중 hong을 kang으로 대체하시오.
mystr <- str_replace(mystr,'hong','kang')
# 2. mystr변수의 값 중 1234를 5678로 대체하시오.
mystr <- str_replace(mystr,'1234','5678')
# 3. mystr의 내용과 'choi9876'을 결합하시오.
str_c(mystr,'choi9876')


###########################################
# stringr 패키지 연습문제4
###########################################
mystr='kim,lee,choi,park'

# 1. mystr 내용을 쉼표(,)를 기준으로 분리하시오.
str_split(mystr,",")
# 2. human 목록들에 대하여 구분자를 /로 연결하시오.
human = c('홍길동10','박영희20','김철수30','이몽룡40')
str_c(human,collapse="/")


###########################################
# stringr 패키지 연습문제5
###########################################
fruits <- c('apple','Apple','banana','Pineapple',"Java","jungle")

# 1. 대문자 P가 있는 단어 여부 확인
str_detect(fruits,'P')
# 2. 첫 글자가 소문자 b인 단어 여부 확인
str_detect(fruits,'^b')
# 3. 끝나는 글자가 소문자 e인 단어 여부 확인
str_detect(fruits,'e$')
# 4. 시작하는 글자가 대문자 J나 소문자 j인 단어 여부 확인
str_detect(fruits,'^[Jj]')
# 5. 단어에 소문자 l와 대문자 P가 들어 있는 단어 여부 확인
str_detect(fruits,'[lP]')


###########################################
# stringr 패키지 연습문제6
###########################################

# 1. 아래 두 데이터를 연결하여 다음과 같은 문장을 완성하시오.
  # ex) A1 name is 홍길동
  # name1 <- c('홍길동','김철수','이몽룡','성춘향')
  # no <- c('A1','B1','C1','D1')
name1 <- c('홍길동','김철수','이몽룡','성춘향')
no <- c('A1','B1','C1','D1')
str_c(no[1]," ","name is"," ",name1[1])
# 2. no 데이터를 '-'기호로 연결하여 하나의 문장을 출력하시오.
str_c(no,collapse="-")


###########################################
# stringr 패키지 연습문제7
###########################################

# 1. "        abc         "문자열의 공백을 제거하시오.
str_trim("        abc         ")
# 2. "        abc         "문자열의 왼쪽 공백을 제거하시오.
str_trim("        abc         ",side='left')
# 3. "        abc         "문자열의 오른쪽 공백을 제거하시오.
str_trim("        abc         ",side='right')


###########################################
# sqldf 패키지 연습문제
###########################################
library(sqldf)
library(ggplot2)
mpg<-as.data.frame(ggplot2::mpg)

# 1. mpg의 모든 데이터를 출쳑하시오.
sqldf("select * from mpg")
# 2. cyl이 4개인 자동차만 추출하시오.
sqldf("select * from mpg where cyl=4")
# 3. mpg의 처음 3행만 추출하시오.
sqldf("select * from mpg limit 3")
# 4. mpg의 제조사를 기준으로 오름차순 정렬하시오.
sqldf("select * from mpg order by manufacturer")
# 5. mpg의 cyl을 기준으로 내림차순 정렬하시오.
sqldf("select * from mpg order by cyl desc")
# 6. mpg의 hwy 총 합을 구하시오.
sqldf("select sum(hwy) from mpg")
# 7. 고속도로 연비(hwy)가 가장 높은 자동차의 정보를 출력하시오.
sqldf("select class,hwy from mpg group by class order by hwy desc limit 1")
# 8. 제조사별로 고속도로 연비의 최대값을 구하시오.
sqldf("select manufacturer,max(hwy) from mpg group by manufacturer")
