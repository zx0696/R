#데이터 분석에는 다양한 통함수 활용
#기술통계량
#데이터를 요약한 값, 데이터의 특성을 파악할 수 있는 정보

#기본 기술 통계 함수
#mean()평균, median()중앙값(중위수),max(), min(),
#range()최대값에서 최소값의 구간
#quantile()분위수, var()분산, sd() 표준편차
#kurtosi()첨도, skew()왜도


# 기초통계량을 보여주는 함수
# summary()/describe:psych 패키지의 내장 함수
score <- c(78,90,64,83,95,70)
summary(score)
# 67,70,78,83,90,95

install.packages("psych")
library(psych)

describe(score)
# trimmed : 절삭평균 -> 상위 하위 특정 % 비율의 데이터는 제외하고 구하는 평균
# 평균이 극한값에 영향을 받는걸 배제하기 위함
# mad : 중위값의 절대편차
# se : 표준오차
# 모집단 100,000개에서 100개의 표본을 10번 추출해서 각 표본의 평균 산출
# 모집단의 평균가 표본의 평균의 차이

#############################################
# 1. 사분위수 : quantile()
score
a <- c(64,70,78,83,90,95)
a

quantile(a)
#   0%   25%   50%   75%  100% 
# 64.00 72.00 80.50 88.25 95.00

# 0% : 최소값, 100% : 최대값
# 50% : 데이터 개수가 홀수면 위치적으로 중앙에 있는 값 
#     : 데이터 개수가 짝수면 가운데 2개의 위치 원소의 평균을
(78+83)/2
# 80.5

# 25% / 75%
# 데이터 그룹을 2 그룹으로 나누어서 계산 
# 25 % -> 64,70,78 위치적 중앙값 K -> 70    
# k +((k+1)-k) * 0.25 여기서 +1이란 중앙값 다음으로 오는 값
70 + (78-70)*0.25
# 75% ->  83,90,95 위치적 중앙값 K -> 90
# k-1 + (k -(k-1)) * 0.75  여기서 -1이란 중앙값 전에 오는 값
83 + (90-83) * 0.75


mean(score)
median(score)

min(score)
max(score)

var(score)
sd(score)

range(score)


# quantile(데이터, probs=) : 특정 분위 수 추출
quantile(score,probs = 0.25)
quantile(score,probs = 0.80) # 하위 80%
quantile(score,probs = 0.40)

kurtosi(a)

skew(a)

######################################################
# 빈도 비율 생성 함수
# 데이터 분포를 파악할 때 가장 많이 사용하는 기법
# table() : 범주형 변수의 빈도표를 생성
# freq() : 범주형 변수의 빈도표를 생성, 빈도 비율표도 같이 생성 
# descr 패키지에 포함되어 있음

install.packages("descr")
library(descr)

# 
library(readxl)
exdata1 <- read_excel("./data_/sample1.xlsx")
exdata1


# 회원들의 거주지 분포 확인
table(exdata1$AREA)
# 3    5    1    1 


f_test <- freq(exdata1$AREA, plot = F)
f_test
class(f_test)

freq(exdata1$AREA)

# 연속형 변수의 빈도 분석
freq(exdata1$AMT17)
# 의미없는 데이터 반환
# 구간을 설정해 구간 빈도 분석을 진행
hist()
hist(exdata1$AMT17)


exdata1

exdata1$AGE

#########
# 줄기-잎-그림(stem-and-leaf plot)
# stem()함수
# 연속형 수치의 자리수로 분류 결과 시각화
# 큰 자리수 값은 줄기에 표현
# 작은 자리수 값은 잎에 표현
stem(exdata1$AGE)
# 2 | 0378
# 3 | 8
# 4 | 07
# 5 | 006

################################
# 히스토 그램 : 도수분포 상태를 기둥 모양으로 표현한 그래프
# 구간별 관측치의 분포상태를 빠르게 확인 가능하다

hist(exdata1$AGE, main="AGE 분포", ylim = c(0,5), xlim = c(0,60))

###################
# 막대그래프 : 수량의 많고 적음을 확인 
# 범주형 데이터의 빈도 차이를 비교할 때 적합함
# 범주형 DATA의 빈도표를 이용해서 그래프 생성

# 범주형: 성별이나 지역같이 연속성이 없는 데이터
# 제주시의 A업체에서 16년도 17년도에 사용된 신용카드 데이터를 기준으로
# 사용 회원의 성별 빈도를 비교

j_s <- table(exdata1$SEX)
j_s

barplot(j_s)
barplot(j_s,
        ylim = c(0,8),
        main="남여 빈도 비교",
        xlab='성별',
        ylab='빈도수',
        names=c('여','남'),
        col=c('pink','navy'))

###########################################
#boxplot : 분포의 차이 및 이상치를 확인

# 17년도/16년도 신용카드 이용 건수의 분포비교
boxplot(exdata1$Y17_CNT, exdata1$Y16_CNT,
        names = c("2017","2016"),
        col = c("green","yellow"))

y1 <- c(1,2,3,4,5,6,7,8,9,10,25)
boxplot(y1)
