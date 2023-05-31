# 실습 사용 excel 파일 읽어오기(Sample1.xlsx)

# 패키지 로드
library(readxl)
exdata1 <- read_excel("data/Sample1.xlsx")
exdata1

# tibble
# 데이터 프레임을 업그레이드 한 형태
# Data Science를 위해 개발된 R 패키지 중 tidyverse 패키지에서 사용하는 데이터 형태

# 원시 데이터 구조 확인
str(exdata1)
# 데이터 형태 : tbl, data.frame
# 관측치 10 / 변수 8개
# 데이터 형태 : num(실수), chr(문자)

dim(exdata1)
# 10행 8열의 구조

ls(exdata1) # df의 변수명 출력
# [1] "AGE"     "AMT16"   "AMT17"   "AREA"    "ID"      "SEX"     "Y16_CNT" "Y17_CNT"
# 2016년 2017년 신용카드 사용 현황 데이터
# AMTxx : 사용금액, xx_CNT : 사용건수
# 금액은 AMT먼저 나오고 건수는 연도가 먼저나옴
# 변수명은 건수에 맞게 금액의 변수명 변수 : Yxx_AMT

# 변수명 변경(일부변경)
library(dplyr)

# rename() 이용 - 원본 저장 필요
exdata1 <- rename(exdata1, Y17_AMT = AMT17, Y16_AMT=AMT16)
head(exdata1,2)

# AMT/CNT/AVG_AMT 파생변수
exdata1$Y17_AMT + exdata1$Y16_AMT

exdata1 <- exdata1 %>% mutate(AMT = Y17_AMT + Y16_AMT,
                   CNT = Y17_CNT + Y16_CNT,
                   AVG_AMT = AMT/CNT)
View(exdata1)

# 회원들을 50대 이상과 미만으로 구분하는 변수 50_YN 생성
ifelse(exdata1$AGE >=50,"Y","N")
exdata1$AGE50_YN = ifelse(exdata1$AGE >=50,"Y","N")

View(exdata1 %>% mutate(AGE50_YN =ifelse(AGE >=50,"Y","N") ))
exdata1 <- exdata1 %>% mutate(AGE50_YN =ifelse(AGE >=50,"Y","N") )

# 10살 단위로 나이 구분 파생변수 : AGE_GR10
exdata1 <- exdata1 %>% mutate(AGE_GR10 = ifelse(AGE >= 50, "50++",
                                     ifelse(AGE >= 40,"4049+",
                                            ifelse(AGE >= 30,"3039+",
                                                   ifelse(AGE >= 20,"2029+","0019+")))))
##################################
# select()/filter()
##################################

# 모든 회원의 17년도 사용 금액 확인
exdata1 %>% select(Y17_AMT) #컬럼 1개를 추출해도 df 형태로 반환
# 지역을 제외한 모든 데이터 추출
exdata1 %>% select(-AREA)

# 지역이 서울인 회원의 데이터 추출
exdata1 %>% filter(AREA == '서울')

# 지역이 서울인 회원중 2017년 사용건수가 10건 이상인 회원 정보
exdata1 %>% filter(AREA =='서울' & Y17_CNT >= 10)

# 지역이 서울인 회원중 평균 사용금액이 50000 이상인 회원의 연령을 추출하시오
exdata1 %>%  filter(AREA =='서울' & AVG_AMT >= 5000) %>% select(ID,AGE)

# 지역이 서울인 회원중 평균 사용금액이 50000 이상인 회원의 ID와 연령을 추출하시오
# 연령으로 내림차순 정렬 필요
exdata1 %>%  filter(AREA =='서울' & AVG_AMT >= 5000) %>% select(ID,AGE) %>% 
  arrange(desc(AGE),desc(ID))

# 데이터 요약
# 그룹화 : group_by()
# summarise() : 요약 통계함수를 적용 시켜주는 
# n()-그룹의 빈도 / min()/max()/quantile()-변수의 분위수/sum()/mean()

# 17년도 이용 금액 합계 확인
sum(exdata1$Y17_AMT)#벡터 반환
exdata1 %>% summarise(TOT_Y17_AMT=sum(Y17_AMT)) #df형 반환(tibble)

# 지역별 17년도 이용금액 확인
exdata1 %>% group_by(AREA) %>% 
  summarise(TOT_Y17_AMT=sum(Y17_AMT))
  
ls(exdata1)

exdata1 %>% group_by(AGE_GR10) %>% 
  summarise(AVG_AGE_AMT = mean(AMT))

exdata1 %>% group_by(AGE_GR10) %>% 
  summarise(AGE_CNT = n())

exdata1 %>% summarise(p_cnt = n())


###############
# 결합과 조인
# 남성 신용카드 사용 data와 여성 신용카드 사용 data의 결합
###############
library(readxl)
m_history <- read_excel("data/Sample2_m_history.xlsx")
f_history <- read_excel("data/Sample3_f_history.xlsx")

View(m_history)
View(f_history)

ls(m_history)
ls(f_history)

history_tot <- bind_rows(m_history,f_history)


his_17 <- read_excel("data/Sample4_y17_history.xlsx")
his_16 <- read_excel("data/Sample5_y16_history.xlsx")

ls(his_17)
ls(his_16)
# 공통 컬럼 ID

res <- inner_join(his_17, his_16, by='ID')
res

res_full <- full_join(his_17, his_16, by="ID")
res_full

left_res <- left_join(his_17, his_16, by="ID")
left_res

right_res <- right_join(his_17, his_16, by="ID")
right_res


