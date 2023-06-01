
#####################################################
# 다음과 같이 변수 생성하고 변수 값 출력
#####################################################

# 1 변수에 10,20,30 저장하고 출력
num1 <- c(10,20,30)
num1

# 2 11~15 범위의 수를 변수에 저장하고 출력
num2 <- c(11:15)
num2

# 3 1~10 범위에서 홀수만 저장하고 출력
num3 <- seq(1,10,2)
num3

# 4 1~30 범위에서 3의 배수만 저장하고 출력
num4 <- seq(1,30)
cnt3 <- seq(num4[3], num4[30], 3)
cnt3

cnt3 <- num4[which(num4 %% 3 == 0)]
cnt3

# 5 5명의 학생 이름 저장하고 출력
student <- c("김진권","권묘선","김아형","김윤정","이성용")
student

# 6 국어점수, 영어점수, 수학점수를 각 변수에 저장하고, 
# 총점과 평균을 구해서 변수에 저장하고 출력
ko_score <- 95
en_score <- 70
mt_score <- 80
score <- c(ko_score, en_score, mt_score)
total_score <- sum(score)
total_score
total_avg <- mean(score)
total_avg


##############################################################
# 벡터 연습문제
##############################################################

# 1 vec_ex에 1부터 10까지 대입 후 출력
vec_ex <- c(1:10)
vec_ex

# 2 vec_ex에서 1번째부터 5번째까지의 데이터 출력
vec_ex[1:5]

# 3 3번째부터 7번째까지 데이터 출력
vec_ex[3:7]

# 4 1번째부터 5번째까지의 데이터만 빼고 출력
vec_ex[-1:-5]

# 5 3번째부터 7번째가지의 데이터만 빼고 출력
vec_ex[-3:-7]

# 6 3번째 0으로 변경 후 출력
vec_ex[3] <- 0
vec_ex

# 7 맨 앞에 0을 추가하고 출력
vec_ex <- append(vec_ex, 0, after=0)
vec_ex

# 8 12번째에 11을 추가하고 출력
vec_ex <- append(vec_ex, 11, after=11)
vec_ex

# 9 맨 뒤에 14~20을 추가하고 출력
add_num <- c(14:20)
vec_ex <- append(vec_ex, add_num, after=length(vec_ex))
vec_ex

# 10 11과 14 사이에 12, 13을 추가하고 출력
add_num2 <- c(12,13)
vec_ex <- append(vec_ex, add_num2, after=12)
vec_ex

# 11 vec_ex에 7이 있는지 검색
7 %in% vec_ex

# 12 vec_ex에 0이 있는지 검색한 결과를 변수 vec_ex_result에 저장하고 출력
vec_ex_result <- 0 %in% vec_ex
vec_ex_result

# 13 vec_ex1에 100, 200, 300 저장하고 열 이름을 A,B,C로 지정
vec_ex1 <- c(100,200,300)
names(vec_ex1) <- c("A","B","C")
vec_ex1

# 14 seq() 함수를 사용하여 date 변수에 2020년 1월 1일부터 2020년 5월 31일까지 1개월씩 증가하는 날짜 저장하고 출력
month_cnt <- seq(as.Date("2020-01-01"), as.Date("2020-05-31"), by="month")
month_cnt

# 15 "사과","배","감","버섯","고구마"를 포함하는 vec_ex1을 생성하고, vec_ex1에서 3번째 요소인 "감"을 제외한 값 출력
vec_ex1 <- c("사과","배","감","버섯","고구마")
vec_ex1[-3]

# 16 다음과 같이 vec_ex2와 vec_ex3을 만들고
# - vec_ex2 : 봄, 여름, 가을, 겨울
# - vec_ex3 : 봄, 여름, 늦여름, 초가을
vec_ex2 <- c("봄","여름","가을","겨울")
vec_ex3 <- c("봄","여름","늦여름","초가을")

# 16-1 vec_ex2와 vec_ex3 내용을 모두 합친 결과 출력
union(vec_ex2, vec_ex3)

# 16-2 vec_ex2에는 있는데 vec_ex3에 없는 결과 출력
setdiff(vec_ex2, vec_ex3)

# 16-3 vec_ex2와 vec_ex3에 모두 들어 있는 결과 출력
intersect(vec_ex2, vec_ex3)


##############################################################
# 행렬 연습문제
##############################################################

# 1 다음과 같은 형태의 행렬 생성 : seasons1, seasons2
# 봄   가을
# 여름 겨울
#
# 봄   여름
# 가을 겨울
season <- c("봄","여름","가을","겨울")
seasons1 <- matrix(season, nrow=2)
seasons2 <- matrix(season, nrow=2, byrow=T)

# 2 seasons1 행렬에서 여름과 겨울만 조회
seasons1[2,]

# 3 seasons2 행렬에 3행 추가(초봄 초가을) : seasons3
seasons3 <- rbind(seasons2, c("초봄","초가을"))

# 4 seasons3 행렬에 열 추가(초봄, 초가을, 한겨울)
seasons3 <- cbind(seasons3, c("초봄","초가을","한겨울"))

# 5 다음과 같은 행렬 생성 : n
# 1 2 3 4
# 5 6 7 8
n <- matrix(c(1,2,3,4,5,6,7,8),nrow=2,byrow=T)

# 6 n의 1행 출력
n[1,]

# 7 n의 4열 출력
n[,4]

# 8 n에 마지막 행(9,10,11,12) 추가하여 nn 행렬을 만들고 확인
nn <- rbind(n, c(9,10,11,12))
nn

# 9 행렬 nn의 열 이름을 A,B,C,D로 설정
colnames(nn) <- c("A","B","C","D")


##############################################################
# 배열 연습문제
##############################################################

# 1 다음과 같은 array(배열)를 arr1에 대입하시오.
# O A L S R E
# R C E E V R
ch1 <- c("O","R","A","C","L","E","S","E","R","V","E","R")
arr1 <- array(ch1, dim=c(2,6,1))

# 2 arr1 의 x:1,y:3인 데이터를 검색하시오.
arr1[1,3,]


##############################################################
# 리스트 연습문제
##############################################################

# 1 다음과 같이 key=value인 리스트 list_score 생성
# ko=90, ma=100, en=98
list_score <- list(ko=90,
                   ma=100,
                   en=98)

# 2 sc=100인 요소를 리스트에 추가
list_score$sc <- 100

# 3 리스트의 en 값 확인
list_score$en

# 4 리스트의 2,3번째 요소 값 확인
list_score[2:3]

# 5 리스트의 en값을 95점으로 변경
list_score$en <- 95

# 6 sc 요소 삭제
list_score$sc <- NULL
