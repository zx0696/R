#############################################################################
# 데이터 개념 및 변수와의 관계 연습문제 - 풀이
#############################################################################

## 1 한개의 범주형 변수
# table(), xtabs(~)
blood = c("B","A","B","A","A","B","O","A","A","A","O","B","AB","B","AB",
          "AB","A","A","O","AB","O","A","B","O","B","B","A","A","O","A",
          "A","AB","B","B","O","B","B","B","A","AB","A","A","B","O","B",
          "B","O","B","O","B","A","A","AB","A","A")

table(blood)
xtabs(~blood)


## 2 한개의 범주형 변수의 시각화
barplot(table(blood))
pie(table(blood))


## 3
height = c(170,178,171,168,173,178,171,174,170,170,175,
           170,169,166,162,170,171,175,175,171,171,170,
           172,179,164,170,181,178,180,177,166,169,168,
           165,163,175,166,178,165,168,167,177,168,177,
           174,174,176,179,169,173,167,170,173,170,162)
cut(height,breaks=5)
range <- max(height) - min(height)
range/5 # 3.8

df <- data.frame(height,gugn=cut(height,breaks=5))
View(df)

table(df$gugn)
# (162,166] (166,170] (170,173] (173,177] (177,181] 
#         6        12        18        11         8 

# 3-1 히스토그램
hist(height,breaks=5)
temp <- hist(height,breaks=5)
temp


## 4 수치형 자료의 요약
score <- c(89,78,91,86,76,84)

# 표본평균과 중위수
s_mean <- sum(score)/length(score)
mean(score)
s_median <- median(score)
# 4-1. 42점이 추가되었을 때 평균과 중앙값의 변화
score_p <- c(score,42)
mean(score_p)
median(score_p)
# 평균의 변화가 중앙값의 변화보다 크다
# 기존데이터의 최소값과 차이가 큰 값이 들어옴

# 4-2 표본분산과 표준편차
# 표본분산
sum((score_p-mean(score_p))**2)/(length(score_p)-1)
var(score_p)
# 표준편차
sd(score_p)

# 4-3 사분위범위와 50 백분위수
IQR <- quantile(score_p,0.75) - quantile(score_p,0.25)
names(IQR) <- "IQR"
IQR
quantile(score_p,0.5)


## 5 boxplot
noise = c(55.9,63.8,57.2,59.8,65.7,62.7,60.8,51.3,61.8,56.0,
          66.9,56.8,66.2,64.6,59.5,63.1,60.6,62.0,59.4,67.2,
          63.6,60.5,66.8,61.8,64.8,55.8,55.7,77.1,62.1,61.0,
          58.9,60.0,66.9,61.7,60.3,51.5,67.0,60.2,56.2,59.4,
          67.9,64.9,55.7,61.4,62.6,56.4,56.4,69.4,57.6,63.8)
boxplot(noise)


## 6 상대빈도
birth <- c('봄','봄','가을','여름','가을','가을','봄','가을','여름',
           '여름','가을','봄','여름','겨울','가을','여름','봄','겨울',
           '여름','가을','가을','가을','여름','겨울','봄','겨울','가을',
           '가을','봄','여름','봄','겨울','여름','겨울')

# 6-1 도수분포표 작성
table(birth)
# 6-2 도수에 대한 막대도표
barplot(table(birth))
# 6-3 원도표를 그리기 위해 계산된 가을에 대한 중심각
prop.table(table(birth)) # 상대빈도표
prop.table(table(birth))["가을"] * 360 # 116.4706


## 7 IQR 함수
iqr_f <- function(x){
  IQR <- quantile(x,0.75) - quantile(x,0.25)
  names(IQR) <- "IQR"
  return(IQR)
}

math_s <- c(77,78,76,81,86,51,79,82,84,99)
gagu <- c(1,5,2,3,2,1,4,1,3)

mean(math_s); mean(gagu)
median(math_s);median(gagu)

# 7-1
var(math_score); var(gagu)
sd(math_score); sd(gagu)

# 7-2
iqr_f(math_s); iqr_f(gagu)


## 8
students <- c(64,15,21,93,218,43,59,57,28,20,54,52,58,27,
              100,63,270,94,76,32,175,92,73,183,65,137,177,74,
              27,28,12,72,281,50,116)
sort(students)
# 8-1
# 계급의 개수를 5개로 했을 때 계급구간의 폭 계산
# 연속형자료, 도수분포표의 계급구간 폭 설정은 범위를 계급의 개수로 나누어서 결정
range <- max(students)-min(students)
interval <- ceiling(range/5) # 54

# 8-2 수기작성
cut <- c(11.5,11.5+interval,11.5+interval*2,11.5+interval*3,11.5+interval*4,
         11.5+interval*5)
cut


## 9
age <- c(18,21,22,25,26,27,29,30,31,33,36,37,41,42,42,47,52,55,57,58,62,
         64,67,69,71,72,73,74,76,77)

# 9-1
quantile(age,0.4) # 39.4
# 9-2
quantile(age,0.78) # 68.24

quantile(age,probs=c(0.4,0.78))


## 10
changes <- c(3,8,-1,2,0,5,-3,1,-1,6,5,-2)
# 10-1 표본평균
mean(changes) # 1.916667
# 10-2 표본 표준편차
sd(changes) # 3.502164
# 10-3 중위수
median(changes) # 1.5


## 11 - 아직 풀이 안함
USA_football_w <- c(101,177,178,184,185,185,185,185,188,190,
                    200,205,205,206,210,210,210,212,212,215,
                    215,220,223,228,230,232,241,241,242,245,
                    247,250,250,259,260,260,265,265,270,272,
                    273,275,276,278,280,280,285,285,286,290,
                    290,295,302)
# 11-1 표본평균
mean(USA_football_w) # 234.9623
# 11-2 중위수
median(USA_football_w)
# 11-3 제1사분위수와 제3사분위수
Q1 <- quantile(USA_football_w,0.25)
Q3 <- quantile(USA_football_w,0.75)
# 11-4 중앙에 위치한 전체의 50%를 차지하는 자료들의 범위
IQR <- Q3 - Q1
# 11-5 상자그림을 그리기 위하여 아래쪽과 위쪽 울타리의 경계값 계산
lo_whisker <- Q1 - 1.5 * IQR
lo_whisker # 107
up_whisker <- Q3 + 1.5 * IQR
up_whisker # 371
# 11-6 이상값 존재 여부 판단 # 이상값 존재
u_out <- ifelse(USA_football_w > up_whisker,"존재","존재하지않음")
factor(u_out)
l_out <- ifelse(USA_football_w < lo_whisker,"존재","존재하지않음")
factor(l_out)
# 11-7 상자그림 그리기
boxplot(USA_football_w)
