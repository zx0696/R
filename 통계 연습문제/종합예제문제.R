setwd('c:/RStudy/통계')
# 1.
###############################
# 60명 대상자에 대해 A,B 그룹별로 대장암에 걸렸는지 검사한 
# 결과는 아래와 같다. 
# 그룹과 대장암 발생 여부 사이의 관련성을 검증하시오
group <- c("A", "A", "B", "B")
cancer <- c("1.Yes", "2.No","1.Yes", "2.No")
count <- c(2, 28, 5, 25)
dat <- data.frame(group, cancer, count)





# 2. 
############################################
# 교육수준(education)과 흡연율(smoking) 간의 관련성을 분석하기 위한 연구가설을 수립하고, 
# 각 단계별로 가설을 검정하시오. [독립성 검정]
# 귀무가설(H0) : 교육수준과 흡연율 간의 관련성은 없다. 
# 연구가설(H1) : 교육수준과 흡연율 간의 관련성은 있다.

smoke <- read.csv("data/smoke.csv", header=TRUE)
head(smoke)

# 변수 리코딩
# education(독립변수) : 1:대졸, 2:고졸, 3:중졸
smoke$education <- ifelse(smoke$education==1,'대졸',
                          ifelse(smoke$education==2,'고졸','중졸')) 
# smoke(종속변수): 1:과다흡연, 2:보통흡연, 3:비흡연
smoke$smoking <- ifelse(smoke$smoking==1,'과다흡연',
                          ifelse(smoke$smoking==2,'보통흡연','비흡연'))
unique(smoke)

library(gmodels)
smoke_chi <- CrossTable(smoke$education,smoke$smoking,chisq=TRUE)

# p-value = 0.0008183 으로 유의수준 0.05보다 작다.
# 귀무가설 기각
# 따라서, 교육수준과 흡연율 간의 관련성은 있다.


# 3. 
#####################################
# 나이(age3)와 직위(position) 간의 관련성을 단계별로 분석하시오. 
# [독립성 검정] 
# 단계1: 파일 가져오기

data <- read.csv("data/cleanData.csv", header=TRUE) 
head(data)

posi_age <- data.frame(data$age3,data$position)
names(posi_age) <- c('age3','position')
posi_age <- posi_age[!is.na(posi_age$position),]

unique(posi_age)

posi_age_tbl <- table(posi_age$age3,posi_age$position)
posi_age_df <- data.frame(posi_age_tbl)


# 4.
#########################################
# 직업유형에 따른 응답정도에 차이가 있는가를 단계별로 검정하시오.[동질성 검정]
# 단계1: 파일 가져오기 
result <- read.csv("data/response.csv", header=TRUE) 
head(result)
# 단계2: 코딩 변경 - 리코딩
# job : 1:학생, 2:직장인, 3:주부 
# response : 1:무응답, 2:낮음, 3:높음 

# 5.
###########################################
# 중소기업에서 생산한 HDTV 판매율을 높이기 위해서 프로모션을 진행한 결과 기존 구매비율 보다 15% 향상되었는지를 각 단계별로 분석을 수행하여 검정하시오.
# 연구가설(H1) : 기존 구매비율과 차이가 있다.
# 귀무가설(H0) : 기존 구매비율과 차이가 없다.
# 조건) 구매여부 변수 : buy (1: 구매하지 않음, 2: 구매) 

# 단계1: 데이터셋 가져오기

hdtv <- read.csv("data/hdtv.csv", header=TRUE) 


# 6.
#################################################
# 우리나라 전체 중학교 2학년 여학생 평균 키가 
# 148.5cm로 알려져 있는 상태에서  
# A중 학교 2학년 전체 500명을 대상으로 
# 10%인 50명을 표본으로 선정하여 표본평균신장을 계산하고 
# 모집단의 평균과 차이가 있는지를 
# 각 단계별로 분석을 수행하여 검정하시오. 

# 단계1: 데이터셋 가져오기

stheight<- read.csv("data/student_height.csv", header=TRUE) 
stheight

# 7.
#############################################################
# 대학에 진학한 남학생과 여학생을 대상으로 진학한 대학에 대해서 
# 만족도에 차이가 있 는가를 검정하시오.
# # 힌트) 두 집단 비율 차이 검정
# # 조건1) 파일명 : two_sample.csv
# # 조건2, 변수명 : gender(1,2), survey(0,1) 
# 
# 
# # 단계1: 실습데이터 가져오기
# 
data <- read.csv("data/two_sample.csv", header=TRUE)
data
head(data) # 변수명 확인


# 8. 
#################################
# 교육방법에 따라 시험성적에 차이가 있는지 검정하시오. 
# 힌트) 두 집단 평균 차이 검정
# 조건1) 파일 : twomethod.csv
# 조건2) 변수 : method(교육방법), score(시험성적) 
# 조건3) 모델 : 교육방법(명목)  ->  시험성적(비율) 
# 조건4) 전처리 : 결측치 제거

# 단계1: 실습파일 가져오기  
edumethod <- read.csv("data/twomethod.csv", header=TRUE) 
head(edumethod) #3개 변수 확인 -> id method score












