#########################################
# 데이터 프레임 연습문제
#########################################

# 1 다음과 같은 데이터 프레임 df_ex1 생성
  # NO NAME     PRICE
  # 1  monitor  300000
  # 2  mouse    25000
  # 3  keyboard 35000

NO <- c(1,2,3)
NAME <- c('monitor','mouse','keyboard')
PRICE <- c(300000,25000,35000)
df_ex1 <- data.frame(NO,NAME,PRICE)
df_ex1

# 2 다음과 같은 데이터 프레임 생성 : de_student
  # NAME   KOR MATH ENG
  # 홍길동 100 90   80
  # 이몽룡 90  95   98
  # 성춘향 85  98   100

NAME <- c("홍길동","이몽룡","성춘향")
KOR <- c(100,90,85)
MATH <- c(90,95,98)
ENG <- c(80,98,100)
df_student <- data.frame(NAME,KOR,MATH,ENG)
df_student

# 2-1 열 이름 모두 출력
colnames(df_student)
# 2-2 행의 개수 출력
NROW(df_student)
# 2-3 1,2 열 출력
df_student[,c(1,2)]
# 2-4 1,3 열 출력
df_student[,c(1,3)]
# 2-5 KOR 열 출력 / NAME 열 출력
subset(df_student,select=KOR)
subset(df_student,select=NAME)
# 2-6 국어 점수가 90점 이상인 행만 출력
subset(df_student,KOR > 90)
# 2-7 '이몽룡'이 포함된 행 출력
subset(df_student,NAME=='이몽룡')
# 2-8 데이터 [변학도,80,90,93]인 행 추가
df_student <- rbind(df_student,data.frame(NAME='변학도',KOR=80,MATH=90,ENG=95))

# 3 다음과 같은 데이터 프레임 생성 : df_eval
  # NAME   TOEIC JLPT
  # 이몽룡 500   N1
  # 박길동 600   N4
  # 홍길동 700   N5
  # 김길동 650   N2

NAME <- c("이몽룡","박길동","홍길동","김길동")
TOEIC <- c(500,600,700,650)
JLPT <- c("N1","N4","N5","N2")
df_eval <- data.frame(NAME,TOEIC,JLPT)
df_eval

# 3-1 데이터 [SCI,88,80,94,70]인 열 추가
df_eval$SCI <- c(88,80,94,70)
# 3-2 열의 개수 출력
NCOL(df_eval)
# 3-3 2행만 제외하고 출력
df_eval[-2,]
# 3-4 1열을 제외하고 출력
df_eval[,-1]
# 3-5 1,4,2,3 열의 순서로 출력
df_eval[,c(1,4,2,3)]

# 4 다음과 같이 작성
# 4-1 df_student, df_eval를 merge
merge(df_student,df_eval) # inner join(name의 교집합 데이터만 조회)
# 4-2 df_student, df_eval를 모든 데이터가 다 나오도록 merge
merge(df_student,df_eval,all=T) # outer join(name의 합집합 데이터)
# 4-3 df_student, df_eval를 cbind
cbind(df_student,df_eval)
# 4-4 df_eval, df_student 순서로 cbind
cbind(df_eval,df_student)
# 4-5 df_eval에서 NAME, TOEIC, JLPT 열만 선택해 df_eval2로 생성
df_eval2 <- subset(df_eval,select=c("NAME","TOEIC","JLPT"))
# 4-6 df_student에서 이름, 국어, 수학 열만 선택해 df_student2로 생성
df_student2 <- subset(df_student,select=c("NAME","KOR","MATH"))
colnames(df_student2) <- c("이름","국어","수학")
