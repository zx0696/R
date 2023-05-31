# 데이터 가공 작업
# 1. 데이터 다루는 기초작업

# (1) 데이터 파악하기(원시데이터 확인)
getwd()
# [1] "C:/Rstudy"
# 원시데이터 불러오기
exam <- read.csv("data/csv_exam.csv")
exam



ott <- read.csv("C:/Users/82107/PythonStudy/데이터수집/추가요금_OTT.csv", header = T)
ott
ggplot(data=ott,aes(x=Time,y=weight))+geom_line()+geom_point()

# 데이터를 파악할 때 사용하는 함수들
# head()함수 : 첫번재 데이터부터 설정된 데이터 만큼 보여주는 함수
#  - 기본 6행을 출력

# 앞에서부터 6행 출력
head(exam)

# 원하는 만큼의 행 수 출력
# head(데이터 세트, 출력행수)
head(exam,10)

# tail(데이터세트) 함수 : 입력된 마지막 데이터부터 6행을 출력
# tail(데이터세트, 출력행수)
tail(exam)
tail(exam,2)

# 많은양의 전체 데이터를 시트에서 확인
# View(데이터세트) : 주의 V 대문자
View(exam)
# 10행만 View 창에서 확인
View(head(exam,10))

# dim() : 데이터 세트의 전체 행/전체 열 수를 출력
dim(exam)
# [1] 20  5 : 행 열 벡터로 반환

# str(데이터세트) : 속성, 전체 행/렬 구성, 각 컬럼의 정보
str(exam)

# summary(데이터세트) 함수 : 데이터세트의 각 열별 요약통계량 산출 후 출력
# 컬럼 속성이 수치형인 경우만 산출
summary(exam)
# 결과에 나온 id, class의 요약통계량은 무의미함
# 수학점수 평균 : 57.45인 반면에 중간값은 54.00
# 수학점수는 54점을 중심으로 45.75~75.75 사이에 몰려있다

# (2) 변수명 변경
# names(), colnames() R 내장 함수 사용
# test 데이터
df_raw <- data.frame(var1=c(1,2,1),
                     var2=c(2,3,2))

# 원본 원시데이터는 보관하는 것이 좋다
# 원본 보관하는 이유
# 작업 중 오류가 발생하더라도 원상태 복귀 가능
# 원시데이터와 비교하면서 변형되는 과정을 검토할 수 있음

df_new <- df_raw

# 변수명 변경
names(df_new) <- c("a","b")
colnames(df_new)<- c("n1","n2")
df_new
# 전체 변수명을 변경할 때 주로 사용

############
# dplyr 패키지 : 데이터 가공 및 추출과 관련된 여러 함수를 갖고 있음
# rename(데이터변수명, 새변수명1=기존변수명1) df의 일부 변수명을 수정할 수 있다
# - df의 원본을 변경하지 않는다. 저장해야 함
# 주의! 변수명 순서가 바뀌면 에러 새변수명1=기존변수명1

# install.packages("dplyr")
library(dplyr)

exam_test <- exam
head(exam_test,1)
exam_test <-rename(exam_test,no=id ) 
head(exam_test,1)

##################################
# 파생변수 생성하기
# 수집된 변수를 활용하여 추가로 생성하는 변수
# 데이터 연산 방식 : 총점, 평균
# 변수 변환 방식 : 평점
##################################

# 데이터프레임에 대한 사칙연산(벡터화연산진행)
# 열 + 열 -> 열간의 각 행 요소들끼리 연산
exam
exam$math + exam$english # 각열의 같은 행들끼리 연산진행

df_raw <- data.frame(var1=c(1,2,1),
                     var2=c(2,3,2))
# 파생변수 생성
df <- df_raw
df$var1 + df$var2
# df에 추가
df$var_sum <- df$var1 + df$var2
df
df$var_mean <- df$var_sum/2
df
# 조건문을 활요해 파생변수 만들기
# result 파생변수 : var_mean이 2이상이면 pass, 미만이면 fail
df$result <- ifelse(df$var_mean >=2,"pass","fail")
df


# exam df에 대하여 학생별 모든과목의 총점, 평균, 
# 평균을 비교하여 60이상이면 합격 아니면 불합격을 나타내는
# result 변수를 추가하시오

exam_tot <- exam
# sum() 사용 : 다른 결과가 나옴
exam_tot$total <- sum(exam_tot$math, exam_tot$english, exam_tot$science)
exam_tot

exam_tot$total <- exam_tot$math+exam_tot$english+exam_tot$science
exam_tot

exam_tot$mean <- exam_tot$total/3
exam_tot

exam_tot$result <- ifelse(exam_tot$mean >= 60,"합격","불합격")
head(exam_tot)

#############################################
# dplyr 패키지를 사용한 데이터 전처리
# dplyr 패키지 : 전처리 작업에 가장 많이 사용되는 패키지
#############################################

head(exam)

# filter(df,조건) : 조건에 맞는 행 추출

# 1반 학생들 정보를 조회
filter(exam, class==1)

# %>% : 파이프 연산(ctrl+shift+m) %>% 
# 앞 연산의 결과값을 뒤에 따라오는 연산의 입력값으로 전달
exam %>% filter(class==1) %>% select(math)

# 1반 학생들의 점수 정보
exam %>% filter(class==1)

# 1반이 아닌 학생들의 점수 정보
exam %>% filter(class!=1)

# 수학점수가 50을 초과하는 학생 정보
exam %>% filter(math>50)

# 1반 학생들 중 수학 점수가 60점 이상인 학생 정보
exam %>%  filter(class==1 & math>60)

# 수학점수가 90점 이상 이거나 영어점수가 90점 이상인 학생 정보
exam %>%  filter(math >= 90 | english >=90)

# 1,3,5 반 학생 정보 추출
exam %>% filter(class == 1 | class == 3 | class == 5)
# 또는
exam %>% filter(class %in% c(1,3,5))

# 1반 학생들의 정보를 저장하는 변수 class1을 생성
class1 <- exam %>% filter(class==1)
mean(class1$english) # 1반 학생들의 영어 평균

# select() 함수 : 열(변수) 추출
# select(df,변수명1, 변수명2,...,변수명n)
# 제외조건 : (- 기호)
exam

# 변수명 확인
names(exam)

# 학생id와 영어점수 조회
select(exam, id, english)
exam %>% select(id,english)

# 영어점수를 제외한 데이터 조회
exam %>% select(-english)

# 수학, 영어점수를 제외한 데이터 조회
exam %>% select(-math,-english)

# 1반 학생들의 과학 점수 조회(filter, select 함수를 연결해서 사용)
exam %>% filter(class==1) %>% select(science)

# 여러 행으로 코드 작성 가능
exam %>% # %>% 는 이전 수식과 연결되어 있어야 한다
  filter(class==1) %>% 
  select(english)

# %>% 는 이전 수식과 연결되어 있어야 한다
# exam
#  %>% filter(class==1) %>% 
#   select(english)

# 필요한 만큼 함수연산은 확장 가능
exam %>% filter(class %in% c(1,5)) %>% 
  select(class,math,english) %>% 
  head(3)

exam %>% filter(class %in% c(1,5)) %>% 
  select(class,math,english) %>% 
  tail(5)

# arrange(데이터세트, 기준열) : 데이터 정렬(오름차순)
# arrange(데이터세트, desc(기준열)) : 데이터 정렬(내림차순)

# 수학점수 기준 오름차순 정렬 후 조회
arrange(exam, math)

#수학점수 기준 내림차순 정렬 후 조회
exam %>%  arrange(desc(math))

# 기준열의 값이 동일하면 2차 기준을 적용
# 수학점수를 기준으로 내림차순 정렬 후 수학 점수가 동일한 학생들은 
# 영어점수가 높은 순으로 배치
exam %>% arrange(desc(math), desc(english))

# 파생변수 추가 함수
# mutate(데이터세트, 새로운파생변수명=파생변수생성식,새로운파생변수명2=파생변수생성식2)
# 원본 데이터세트에 반영되지는 않는다. 저장해야함

# 학생별 점수 총점 total변수 추가
exam %>% 
  mutate(total = math+english+science) %>% 
  head

# 학생별 점수 총점 total변수, 평균 mean 변수 추가
exam %>% 
  mutate(total = math+english+science,
         mean = total/3) %>% 
  head

# 학생별 점수 총점 total변수, 평균 mean 변수 추가
exam %>% 
  mutate(total = math+english+science,
         mean = total/3,
         result = ifelse(mean>=60,"합격","불합격")) %>% 
  head

# 3과목의 점수를 합한 총점 total 변수를 추가하고 
# total을 기준으로 오름 차순 정렬 후
# 최저 10명의 정보를 조회하시오
exam %>% 
  mutate(total=math+english+science) %>% 
  arrange(total) %>% 
  head(10)

# summarise(출력되는 열이름 = 통계함수(변수)) 함수 : 통계치 산출(집단함수를 사용하게 해주는 함수)
# 통계관련 함수를 사용할 수 있음
# 데이터 요약시 사용

# exam 데이터셋의 수학점수 평균을 구하시오
mean(exam$math)
exam %>% summarise(mean_math=mean(math))

exam %>% summarise(mean_math=mean(math),
                   mean_eng=mean(english),
                   mean_sci=mean(science))

# 그룹별로 데이터 분리 후 요약
# group_by(데이터셋, 기준열) : 기준별로 데이터를 분리
group_by(exam,class)
# 각 반별 수학점수의 평균
exam %>% group_by(class) %>% 
  summarise(mean_math=mean(math),
            mean_eng=mean(english),
            mean_sci=mean(science))

# 반별 학생수
# 그룹의 크기를 반환하는 함수 : n() -> 그룹별 행수 반환
exam %>% 
  group_by(class) %>% 
  summarise(student_cnt = n() )

exam %>% summarise(n=n()) # 데이터셋의 전체 행 수 반환

##############################################
# 데이터 합치기
##############################################
# 세로 결합 : bind_rows()함수 사용
# 결합하는 데이터셋의 공통 키가 있어야 되는 건 아님

# 학생 1~5 번의 시험 데이터
group_a <- data.frame(id=c(1,2,3,4,5),
                      test=c(60,80,70,90,85))

# 학생 6~10 번의 시험 데이터
group_b <- data.frame(id=c(6,7,8,9,10),
                      test=c(80,83,65,95,83))

# 같은 의미를 갖는 두 집단의 데이터를 한번에 분석하기 위해 결합
# 단순 세로 결합
group_all <- bind_rows(group_a,group_b)
group_all

rbind(group_a, group_b)


# 학생 1~5 번의 시험1 데이터
group_a <- data.frame(id=c(1,2,3,4,5),
                      test1=c(60,80,70,90,85))

# 학생 6~10 번의 시험2 데이터
group_b <- data.frame(id=c(6,7,8,9,10),
                      test2=c(80,83,65,95,83))

bind_rows(group_a, group_b)

# 가로 결합 : left_join()/inner_join()/full_join()
info_a <- data.frame(id=c(1,2,3),
                     address=c("서울","부산","제주"))
info_b <- data.frame(id=c(1,2,4),
                     sex=c("남","여","남"))

# inner_join() : 기준열의 공통된 값에 해당되는 데이터를 결합 후 반환
inner_join(info_a,info_b,by="id")

# left_join() : 조인 수식에서 먼저나오는 데이터셋 기준열의 모든 정보를 반환하고 
# 뒤에 나오는 데이터 셋은 기준열의 공통된 값의 정보만 반환
# 어떤 데이터셋이 먼저 기술되느냐에 따라 결과가 달라짐
left_join(info_a, info_b, by="id")
left_join(info_b, info_a, by="id")

# right_join() : 조인 수식에서 나중에 나오는 데이터셋 기준열의 모든 정보를 반환
right_join(info_a, info_b, by="id")
right_join(info_b, info_a, by="id")

# full_join() : 모든 id에 해당되는 값을 출력
full_join(info_a, info_b, by="id")

##############################
# 데이터 정제
# 잘못된 데이터를 찾아서 수정
# 이상치 : 정상 범주에서 크게 벗어난 값
# - 현장에서 만들어진 실제 데이터에는 이상치가 포함 될 수 있음
# - 성별 변수 : 1(남), 2(여), 999(수집불가) 규정된 상황에서 3 데이터가 나타나면
# 일반적으로 발생하는 값의 범위를 벗어나는 극단적인 값
# 어떤 제품의 하루 생산량 : -5000 값이면 이상치
# 이상치가 포함되어지면 분석결과가 왜곡되므로 이상치는 찾아서 제거

# 결측치 : 데이터가 없는 것
# 수집시 오류로 데이터가 수집되지 않은 상태
# NA로 표시
# 결측치가 있는 데이터를 연산하면 결과는 NA로 나타남
# 결측치 제외 후 연산 진행 해야 함
# 결측치의 양에 따라 제외하고 연산을 할 수 있음
# 많은 함수에는 결측치 값을 제외하는 na.rm=T 파라미터를 갖고 있음

# NA 값 확인
# is.na(변수)
# 변수가 na값을 포함하고 있는지 확인후 포함하면 TRUE반환

# df 각 열에 결측치가 얼마나 되는지 확인
# table(data) : 데이터 빈도를 데이터 세트 형태로 출력하는 함수
# table(is.na(변수))
# 결측치 건수 출력

# 데이터 정제 
# 결측치 포함시켜서 데이터프레임 생성

df <- data.frame(team=c("A","B",NA,"A","B"),
                 score=c(5,3,4,4,NA))

# 결측치 확인
# df 의 모든값을 순회하면서 na인지 검사
is.na(df)
#      team score
# [1,] FALSE FALSE
# [2,] FALSE FALSE
# [3,]  TRUE FALSE
# [4,] FALSE FALSE
# [5,] FALSE  TRUE

# 결측치 빈도 출력
table(is.na(df))

# team 컬럼의 결측치 빈도
table(is.na(df$team))

# 결측치 포함 시 연산 불가(결과: NA)
mean(df$score)
sum(df$score)

# 결측치 제거
# 결측치 있는 행만 추출
# score가 NA인 행을 추출
df %>% filter(is.na(score))

# score가 NA가 아닌 행을 추출
df %>% filter(!is.na(score))

# score 컬럼의 결측치 행을 제거한 데이터
df_nomiss <- df %>% filter(!is.na(score))
df_nomiss

# 결측치 제거 후 산술연산
mean(df_nomiss$score)
sum(df_nomiss$score)

# 여러 컬럼에 결측치 없는 데이터 추출
df_nomiss2 <- df %>% filter(!is.na(score) & !is.na(team))
df_nomiss2

# na.omit(df) : df 모든컬럼에서 na가 있는 행은 제거 후 결과를 반환
# 결측치 없는 데이터로 추출
df_nomiss3 <- na.omit(df)
df_nomiss3

# 모든 컬럼에 결측치가 있는 행을 제거하면 데이터에 따라서
# 많은 관측치가 제거될 수 있다

# 결측치가 있는 행을 모두 제거하기 보다 연산시 결측은 제거하고 연산
mean(df$score)
mean(df$score, na.rm=T)

# 모든 함수가 na.rm을 지원하는 것은 아님

# summarise() 함수 : 요약 통계량 산출 시 na.rm 적용 가능

exam

# 결측치 제외 연습을 위해서 NA 삽입
# 3,8,15 행의 수학점수에 NA 할당
exam[c(3,8,15),"math"] <- NA
exam

exam  %>% 
  summarise(mean_math = mean(math,na.rm=T))

# 이상치 정제하기

# 이상치 제거 방법
# 1. 발견한 이상치 값을 NA(결측치)로 변경
# 2. 결측치 제거

# 예제df 생성
outlier <- data.frame(sex=c(1,2,1,3,2,1),
                      score = c(5,4,3,4,2,6))

# 성별은 남, 여 : 1,2만 존재하는것으로 간주하고
# 3은 이상치
# scores는 1점부터 5점까지만 부여한다로 간주하면 6은 이상치

# 1. 이상치값을 NA로 변경
outlier$sex <-  ifelse(outlier$sex == 3, NA, outlier$sex)
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier

# 2. 결측치 제거
outlier_nomiss <- outlier %>% filter(!is.na(score) & !is.na(sex))
outlier_nomiss
