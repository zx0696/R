# 아파트 실거래가를 지도에 표시
# 특정지역의 특정 지하철 호선을 기준으로 실거래가 표시
# 2호선을 기준으로 마포구 아파트 실거래가를 구글맵에 표시

# 지하철역 주소/아파트 실거래가 정보
# 서울 열린데이터 광장/국토교통부 실거래가 공개시스템
# http://rt.molit.go.kr

############################################
# 지하철역 데이터 가공
# 데이터 가져오기
station_data <- read.csv("data/역별_주소_및_전화번호.csv")

# 변수 속성 확인
str(station_data) # 문자열은 factor형인지를 확인해야 함

# 주소를 지도에 표현하기 위해 위/경도 수집
# ggmap의 geocdoe(지역명/주소) 함수

library(ggmap)

# Google API 키 등록 : 내컴퓨터에 레지스터에 등록(저장)
# 스크립트 실행시 최초 등록 해야 함
register_google(key='AIzaSyBwtK8Jtq-zMImXwQqm_nxi98q1Ea7T5F4')

# 명칭보다는 주소로 수집하는 것이 정황
# 구주소 필드 사용 : 지번
station_code <- station_data$구주소

# geo_code(집합자료) : 집합자료내의 모든데이터를 벡터화 연산(호출)
station_code <- geocode(station_code)
station_code

# 역정보 df와 역위경도 df를 결합해서 1개의 df로 생성
# 위경도 추출시 순서 맞춰 추출 : df끼리 결합
# cbind() : 데이터 프레임 열방향 결합
station_code_fin <- cbind(station_data,station_code)
head(station_code_fin)
############################################################
# 아파트 실거래가 데이터 가공

# 파일 읽어오기
apart_data <- read.csv("data/아파트_실거래가.csv")
head(apart_data)
dim(apart_data)

# 가장 거래가 많은 평형을 추출해서 지도에 표현
# 전용면적이 소수점 이하 2자리까지 있어서 집단화가 어렵기때문에
# 소수점이하 반올림 후 정수로 표현
# 거래금액의 중간에 천단위 구분자가 있음(문자열처리되어있음)
class(apart_data$거래금액)
# , 제거하고 수치화해서 계산해야 함

# 전용면적 정리
# round(값, 소수자리수) : 반올림
# ceiling():올림/floor():내림/abs():절대값
apart_data$전용면적<- round(apart_data$전용면적)
head(apart_data$전용면적)

# 거래빈도가 가장 높은 전용면적 확인
# count() 함수 사용
library(dplyr)
count(apart_data,전용면적) %>% arrange(desc(n))
# 전용면적 85가 가장 거래빈도가 높기때문에 85에 해당하는 데이터만 사용
str(apart_data)


# 전용면적이 85인 데이터만 추출
head(subset(apart_data,전용면적==85)) #기존 df의 행 인덱스가 유지됨
head(filter(apart_data,전용면적==85)) #새로 행 인덱스를 부여함

apart_data_85 <- subset(apart_data,전용면적==85)
View(apart_data_85)

# 아파트 가격을 동일 단지내에서도 여러 상황에 따라 차이가 있음
# 대표값을 사용해서 지도에 표현 : 동일 단지의 동일 평형 가격은 평균으로 정리

# 동일 단지의 거래금액의 평균 구하기
# 거래금액 문자(,) -> 수치로 변환

# , 제거 후 변환함수 사용
# gsub(원문자열, 변경문자열, 데이터)

gsub(",","","9,500")
as.integer(gsub(",","",apart_data_85$거래금액))

apart_data_85$거래금액<-gsub(",","",apart_data_85$거래금액)
head(apart_data_85)

# 같은 단지내 아파트는 평균으로 계산
# aggregate(계산열~기준열, 데이터세트, 연산함수)

aggregate(as.integer(거래금액)~단지명,apart_data_85,mean) %>% 
rename("거래금액"="as.integer(거래금액)")

# %>% 연산자는 dplyr패키지 함수 여부와는 상관 없음
apart_data_85 %>% 
aggregate(as.integer(거래금액)~단지명,mean) %>% # dplyr 패키지가 아님
  rename("거래금액"="as.integer(거래금액)") # dplyr 패키지

# 거래 금액 데이터 저장
apart_data_85_cost <- aggregate(as.integer(거래금액)~단지명,apart_data_85,mean) %>% 
  rename("거래금액"="as.integer(거래금액)")

#############################################
# 준비된 데이터
apart_data_85 # 85전용면적 전체 데이터
ls(apart_data_85) #[1] "거래금액" "단지명"   "번지"     "시군구"   "전용면적"
# 단지명이 중복이 됨

apart_data_85_cost # 85전용면적에 대한 단지별 평균 데이터
ls(apart_data_85_cost) #[1] "거래금액" "단지명" 
# 단지명이 중복되지 않음

# 위 두 데이터를 결합을 해서 
# 번지, 시군구, 전용면적, 거래금액, 단지명
# 단지명은 한번씩, 거래금액은 평균 거래금액만 남게 처리


