
############
# 연습문제 1
############

# 1. 변수에 10, 20, 30 저장하고 출력
n1 <- c(10,20,30)
n1 # "double"

# 2. 11 ~15 범위의 수를 변수에 저장하고 출력
n2 <- c(11:15)
n2
typeof(n2) #[1] "integer"

# 3. 1~ 10 범위에서 홀수만 저장하고 출력
odd_nums <- seq(1,10,by=2)
odd_nums

# 4. 1~ 30 범위에서 3의 배수만 저장하고 출력 
triple_nums <- seq(3, 30, by=3)
triple_nums

# 5. 5명의 학생 이름 저장하고 출력
std_names = c("김철수",'이영희','홍길동','박지성','김연아')
std_names

# 6. 국어 점수, 영어 점수, 수학 점수를 각 변수에 저장하고, 총점과 평균을 구해서 변수에 저장하고 출력
kor <- 90
eng <- 78
math <- 85

total <- kor + eng + math
avg <- total / 3

total
avg

#여러값을 한번에 출력하기 위한 cat() 함수 사용
cat("총점 : ", total, "\n평균 : ", avg)

# print() 함수 함수는 1개만 출력가능 
# print("총점 : ", total)
# Error in print.default("총점 : ", total) : invalid printing digits 253
# print(total, avg)
#Error in print.default(total, avg) : invalid printing digits 84
print(total)

###
# 벡터연습문제
###
# vec_ex에 1부터 10까지 대입 후 출력 
vec_ex <- seq(1,10)
vec_ex

# vec_ex에서 1번째부터  5번째까지의 데이터 출력
vec_ex[1:5]

# 3번째부터 7번째까지 데이터 출력
vec_ex[3:7]     

# 1번째부터  5번째까지의 데이터만 빼고 출력
vec_ex[-1:-5]

# 3번째부터 7번째까지의 데이터만 빼고 출력
vec_ex[-3:-7]

# 3번째 0으로 변경 후 출력
vec_ex[3] <- 0
vec_ex

# 맨 앞에 0을 추가하고 출력
vec_ex <- append(vec_ex, 0, after=0)
vec_ex

# 12번째에 11을 추가하고 출력
vec_ex <- append(vec_ex, 11, after=11)
vec_ex

# 맨 뒤에 14~20을 추가하고 출력
vec_ex <- append(vec_ex, 14:20)
vec_ex
# 11과 14사이에 12, 13을 추가하고 출력
vec_ex <- append(vec_ex, 12:13, after=12)
vec_ex

# vec_ex에 7이 있는지 검색
7 %in% vec_ex

# vec_ex에 0이 있는지 검색한 결과를 변수 vec_ex_result에 저장하고 출력
vec_ex_result <- 0 %in% vec_ex
vec_ex_result


# vec_ex1에 100, 200, 300 저장하고 열 이름을 A, B, C로 지정
vec_ex1 <- c(100,200,300)
names(vec_ex1) <- c('A','B','C')
vec_ex1

# seq() 함수를 사용하여 date 변수에 2020년 1월 1일 부터 2020년 5월 31일까지 1개월씩 증가하는 날짜 저장하고 출력
date <-seq(as.Date("2020-01-01"), as.Date("2020-5-31"), by='month')
date


# “사과”, “배”, “감”, “버섯”, “고구마”를 포함하는 vec_ex1을 생성하고, vec_ex1에서 3번째 요소인 “감”을 제외한 값 출력
vec_ex1 <- c("사과","배","감","버섯","고구마")
vec_ex1[-3]

####################
# 집합연산 문제
####################

# 다음과 같이 vec_ex2와 vec_ex3을 만들고
# vec_ex2 : 봄, 여름, 가을, 겨울
# vec_ex3 : 봄, 여름, 늦여름, 초가을
vec_ex2 <- c('봄','여름','가을','겨울')
vec_ex3 <- c('봄','여름','늦여름','초가을')

# vec_ex2와 vec_ex3 내용을 모두 합친 결과 출력
union(vec_ex2, vec_ex3)

# vec_ex2에는 있는데 vec_ex3에 없는 결과 출력
setdiff(vec_ex2 , vec_ex3)

# vec_ex2와 vec_ex3에 모두 들어 있는 결과 출력
intersect(vec_ex2, vec_ex3)

##########################################################
# 행렬 연습문제
##########################################################
# 다음과 같은 형태의 행렬 생성 : seasons1, seasons2
# 봄      가을
# 여름   겨울
# 
# 봄      여름
# 가을   겨울

# 행렬 생성
seasons <- c("봄", "여름", "가을","겨울")
seasons1 <- matrix(seasons,nrow =2)
seasons1

seasons2 <- matrix(seasons,nrow =2, byrow=T)
seasons2

# seasons1 행렬에서 여름과 겨울만 조회
seasons1[2,]
# 
# 다음과 같은 행렬 생성 : n
# 1 	2 	3	 4
# 5	  6	  7	 8
# n의 1행 출력  
# n의 4열 출력

n <- matrix(c(1,2,3,4,
              5,6,7,8), nrow = 2, byrow = T)
n

# 1행 출력
n[1,]

# 4열 출력
n[,4]





















