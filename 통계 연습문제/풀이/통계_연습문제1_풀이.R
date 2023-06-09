#############################################################################
# 데이터 개념 및 변수와의 관계 연습문제
#############################################################################

## 1
blood = c("B","A","B","A","A","B","O","A","A","A","O","B","AB","B","AB",
          "AB","A","A","O","AB","O","A","B","O","B","B","A","A","O","A",
          "A","AB","B","B","O","B","B","B","A","AB","A","A","B","O","B",
          "B","O","B","O","B","A","A","AB","A","A")
stu_blood <- table(blood)
stu_blood_df <- data.frame(stu_blood)

## 2 
pie(stu_blood)
barplot(stu_blood)

## 3 - 수기 작성

height = c(170,178,171,168,173,178,171,174,170,170,175,
           170,169,166,162,170,171,175,175,171,171,170,
           172,179,164,170,181,178,180,177,166,169,168,
           165,163,175,166,178,165,168,167,177,168,177,
           174,174,176,179,169,173,167,170,173,170,162)
sort(height)
# 3-1 히스토그램
hist(height,xlim=c(160,185),ylim=c(0,14))

## 4
stu_score <- c(89,78,91,86,76,84)
mean(stu_score) # 84
median(stu_score) # 85
# 4-1
p_stu_score <- c(stu_score,42)
mean(p_stu_score) # 78
median(p_stu_score) # 84
# 4-2
var(p_stu_score) # 281.6667
sd(p_stu_score) # 16.78293
# 4-3
quantile(p_stu_score,0.75) - quantile(p_stu_score,0.25) # 10.5
quantile(p_stu_score,0.5) # 84

## 5
noise = c(55.9,63.8,57.2,59.8,65.7,62.7,60.8,51.3,61.8,56.0,
          66.9,56.8,66.2,64.6,59.5,63.1,60.6,62.0,59.4,67.2,
          63.6,60.5,66.8,61.8,64.8,55.8,55.7,77.1,62.1,61.0,
          58.9,60.0,66.9,61.7,60.3,51.5,67.0,60.2,56.2,59.4,
          67.9,64.9,55.7,61.4,62.6,56.4,56.4,69.4,57.6,63.8)
boxplot(noise)

## 6
stu_birth <- c('봄','봄','가을','여름','가을','가을','봄','가을','여름',
               '여름','가을','봄','여름','겨울','가을','여름','봄','겨울',
               '여름','가을','가을','가을','여름','겨울','봄','겨울','가을',
               '가을','봄','여름','봄','겨울','여름','겨울')
# 6-1 도수분포표 작성
tbl_birth <- table(stu_birth)
# 6-2 도수에 대한 막대도표
barplot(tbl_birth, ylim=c(0,12))
# 6-3 원도표를 그리기 위해 계산된 가을에 대한 중심각
360*11/34

## 7
math_score <- c(77,78,76,81,86,51,79,82,84,99)
A_apt_num <- c(1,5,2,3,2,1,4,1,3)
mean(math_score) # 79.3
median(math_score) # 80
mean(A_apt_num) # 2.444444
median(A_apt_num) # 2
# 7-1
var(math_score) # 142.6778
sd(math_score) # 11.94478
var(A_apt_num) # 2.027778
sd(A_apt_num) # 1.424001
# 7-2
quantile(math_score,0.75) - quantile(math_score,0.25) # 6.25 
quantile(A_apt_num,0.75) - quantile(A_apt_num,0.25) # 2

## 8
busan_eng_stu <- c(64,15,21,93,218,43,59,57,28,20,54,52,58,27,
                   100,63,270,94,76,32,175,92,73,183,65,137,177,74,
                   27,28,12,72,281,50,116)
length(busan_eng_stu) # 35
sort(busan_eng_stu)
# 8-1

# 8-2 수기작성

## 9
actor_age <- c(18,21,22,25,26,27,29,30,31,33,36,37,41,42,42,47,52,55,57,58,62,
               64,67,69,71,72,73,74,76,77)
# 9-1
quantile(actor_age,0.4) # 39.4
# 9-2
quantile(actor_age,0.78) # 68.24

## 10
pro_cog <- c(3,8,-1,2,0,5,-3,1,-1,6,5,-2)
# 10-1 표본평균
mean(pro_cog) # 1.916667
# 10-2 표본 표준편차
sd(pro_cog) # 3.502164
# 10-3 중위수
median(pro_cog) # 1.5

## 11
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
