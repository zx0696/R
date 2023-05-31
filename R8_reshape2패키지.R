######################################
# reshape2 패키지
# 데이터의 행을 열로, 열을 행으로 변경 

install.packages("reshape2")
library(reshape2)
??melt

# melt( 
#   data, # 데이터세트
#   id.vars, # 기준열
#   measure.vars, #변환열
#   variable.name = "variable", #변수명
#   ...,
#   na.rm = FALSE, #변환시 생성되는 결측 포함 여부 
#   value.name = "value", # 저장할 값과 변수명
#   factorsAsStrings = TRUE
# )

# DF 생성
name <- c("민철", "지수", "지영")
kor <- c(100,70,50)
eng <- c(80,70,100)
computer = c(85,100,80)
eval_df <- data.frame(name,kor,eng,computer)
eval_df



# melt() 함수 사용하여 데이터 구조 변경
#wide형 -> long형
#melt(데이터세트, id.var="기준열", "measure.vars='변환열')
melt(eval_df,
     id.vars = "name",
     measure.vars = c("kor","computer"))

melt(eval_df,
     id.vars = "name",
     measure.vars = c("kor","computer"),
     variable.name = "subject" ,
     value.name = "score")

# R 내장 데이터 세트 활용
data() #: wd 내 데이터 셋트 포함 R 내장 데이터 셋트 출력

# airquality 데이터 세트
# 1973년 5월부터 9월까지의 뉴욕 대기질 정보

# 01. 데이터 세트 구조 파악 
head(airquality) 
# 컬럼명 대소문자 섞여 있음 - 소문자로 변경 
names(airquality) <- tolower(names(airquality))
head(airquality)


# 02. melt() wide -> long
View(airquality)
melt(airquality)
#No id variables; using all as measure variables
#모든 컬럼을 변수와 값으로 변환
tail(melt(airquality))

# 월과 바람에 따라 오존 양 확인
# 기준열 : month, wind 
# 변환열 : ozone
melt_test2 <- melt(airquality,
                   id.vars = c("month","wind"),
                   measure.vars = "ozone")

View(melt_test2) # 결측치  (NA) 포함 결과

melt_test2 <- melt(airquality,
                   id.vars = c("month","wind"),
                   measure.vars = "ozone", na.rm = TRUE) # 결측치 제거

View(melt_test2) # 결측치  (NA) 포함 결과

############################################################
#cast() 함수 : 세로로 길게 늘어진 데이터를 가로로 변형할 때 사용
# 데이터 요약 기능 포함 가능
# melt() 함수에 비해 다소 복잡함

??cast
# 데이터 구조에 따라 사용하는 함수 2가지
# dcast(데이터세트, 기준열 ~ 변환열) : 데이터프레임 형태를 변환, reshape2 패키지에 포함됨
# acast() : 벡터, 행렬, 배열 형태를 변환할 때 사용

# airquality 데이터 사용 
# airquality는 wide 형 -> long  형으로 변경
# 기준열 지정, 변환열이 없으면 기준열을 제외나 나머지 모든 열을 변환
aq_melt <- melt(airquality,
                id.vars = c("month","day"),
                na.rm = FALSE)
View(airquality)
View(aq_melt)

# dcast() 함수 사용하여 aq_melt를 wide형으로 변환
# 기준열을 유일한 식별이 가능한 형태로 컬럼을 조합해야 함, 조합기호 + 
head(aq_melt)
aq_dcast <- dcast(aq_melt,  month+day ~ variable)
View(aq_dcast)

# acast(데이터세트, 기준열~ 변환열~ 분리기준열) 함수 : 행열, 배열로 반환
# acast(데이터세트, 기준열~ 변환열~ 분리기준열,요약기능)
# 리스트로 정리해서 항목별로 출력

aq_melt

acast_air <- acast(aq_melt, day ~ month~variable)
acast_air

acast_air[,,'ozone']
class(acast_air)

# acast 사용 시 기준열 ~ 변환열 만 사용한다면 요약함수를 전달해야 함
acast(aq_melt,month~variable,mean) # mean() 사용시 NA 값 때문에 처리가 불가


aq_melt <- melt(airquality,
                id.vars = c('month','day'),
                na.rm = TRUE) # na제외
acast(aq_melt, month~ variable, mean)#na가 제외된 연산
class(acast(aq_meltm, month~variable,mean)) # array반환

####
# d cast 함수에서 기준열이 유일하게 식별되지 않는 경우 요약 기능을 사용
dcast(aq_melt, month~variable, mean) df반환



## 
baseball_l <- read.csv('data_/baseball.csv')
View(baseball_l )
basevall_w <- dcast(baseball_l, month~pytpe)
basevall_w


library(reshape2)
subway_line <- read.csv("data_/1-4호선승하차승객수.csv")

View(subway_line)
View(subway_line_dcast_up)
View(subway_line_down)
