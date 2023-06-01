# 아파트 실거래가를 지도에 표시
# 특정지역의 특정 지하철 호선을 기준으로 실거래가 표시
# 2호선을 기준으로 마포구 아파트 실거래가를 구글맵에 표시

# 지하철역 주소/아파트 실거래가 정보
# 서울 열린데이터 광장/국토교통부 실거래가 공개시스템
# http://rt.molit.go.kr

############################################
# 지하철역 데이터 가공
# 데이터 가져오기
station_data <- read.csv("data_/역별_주소_및_전화번호.csv")

# 변수 속성 확인
str(station_data) # 문자열은 factor형인지를 확인해야 함

# 주소를 지도에 표현하기 위해 위/경도 수집
# ggmap의 geocdoe(지역명/주소) 함수

library(ggmap)

# Google API 키 등록 : 내컴퓨터에 레지스터에 등록(저장)
# 스크립트 실행시 최초 등록 해야 함
register_google(key='AIzaSyAO_zX_9AMinovtwZ6HCrO_fG3Pwc1HvB0')

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
apart_data <- read.csv("data_/아파트_실거래가.csv")
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
View(apart_data_85)

apart_data_85_cost # 85전용면적에 대한 단지별 평균 데이터
ls(apart_data_85_cost) #[1] "거래금액" "단지명" 
# 단지명이 중복되지 않음

# 위 두 데이터를 결합을 해서 
# 번지, 시군구, 전용면적, 거래금액, 단지명
# 단지명은 한번씩, 거래금액은 평균 거래금액만 남게 처리

View(inner_join(apart_data_85,apart_data_85_cost,by='단지명'))
# 그냥 inner_join을 하면 단지가 여러번 중복되므로 
# apart_data_85 df의 중복된 단지명 행을 제거 
# 작업시 같이 제거되는 실거래가 데이터는 사용하지 않음(구해놓은 평균 거래가를 사용)
# 단지명의 중복여부를 T/F로 반환
duplicated(apart_data_85$단지명)
# False: 중복되지 않은, 최초로 나온 
# TRUE : 중복된, 현 데이터 이전에 같은 데이터가 있었음
# 위 결과를 이용해서 인덱싱 

# 논리 인덱싱(인덱스 값이 TRUE인 요소만 추출 )
test = c(1,2,3,4,5)
test[c(TRUE,FALSE,FALSE,TRUE,TRUE)]

apart_data_85 <- apart_data_85[!duplicated(apart_data_85$단지명),]
View(apart_data_85)

# 단지별 평균 거래금액을  갖고 있는 데이터 세트와 합치기 
# left_join()실행 
apart_data_85 <- left_join(apart_data_85,apart_data_85_cost,by='단지명')

# 거래금액.y 사용 
View(apart_data_85)

apart_data_85 <- apart_data_85 %>% select(-거래금액.x) # 거래금액 x를 없애줌

apart_data_85<- apart_data_85 %>%  rename(거래금액=거래금액.y) #이름 변경
head(apart_data_85)

###########거래금액등 아파트 기본 정보 가공 완료
# 단지 위경도 구집 위해 주소 정보 보정 
# 시군구 /번지 열이 구분되어 있음  -> 합쳐서 주소 컬럼을 추가 

# 문자열의 결합 : paste()
apart_address <- paste(apart_data_85$시군구, apart_data_85$번지)
apart_address
class(apart_address) # 벡터형 

apart_address <-paste(apart_data_85$시군구, apart_data_85$번지) %>% 
                data.frame() %>% 
                rename('주소'='.')
View(apart_address)

# 위경도  얻어오기 
apart_address_code <- geocode(apart_address$주소)


################################
dim(apart_data_85)
head(apart_address)
head(apart_address_code)

apart_data_final <- cbind(apart_data_85,apart_address, apart_address_code) %>% 
  select('단지명', '전용면적','거래금액','주소','lon','lat')
head(apart_data_final)
ls(apart_data_final)


#######################################################
#  지하철 역 정보와 실거래가 정보를 구글 지도에 표시 (시각화)

# 지하철역 정보(2호선)
# station_code_fin

# 아파트 실거래가 정보 (마포구 전용면적 85형 아파트의 평균 실거래가)
# apart_data_final

#ggmap 시각화
library(ggmap)

# 특정 위치를 기준으로 지도 데이터 전송받기
# get_googlemap('기준위치', maptype = '지도형태', zoom=) - 넷 연결필요
mapo_map <- get_googlemap('mapogu', maptype = 'roadmap',zoom=12)

# 시각화 - 그래프 그리기 
# ggmap(지도정보)
ggmap(mapo_map)

# 지도위에 객체(점,선,텍스트) 표시 - ggplot2 함수 사용
library(ggplot2)
ggmap(mapo_map) +
  geom_point(data = station_code_fin, aes(x=lon, y=lat),
             color = 'red', size=3) + 
  geom_text(data = station_code_fin, aes(label=역명,vjust=-1))
# hjust : +값 점의 왼쪽/-값 점의 오른쪽 
# vjust : +값 점의 아래/-값 점의 윗쪽 

# 아파트 정보 표시
# 홍대입구역 부근을 더 세밀하게 표시 
# 지도 기준을 홍대입구역으로 
hongdae_map <- get_googlemap("hongdae station",
                             maptype="roadmap",
                             zoom=15)
View(apart_data_final)
ggmap(hongdae_map) + 
  geom_point(data=station_code_fin, aes(x=lon,y=lat),
             color='red', size=3) +
  geom_text(data=station_code_fin, aes(label=역명, vjust=-1)) +
  geom_point(data=apart_data_final, aes(x=lon,y=lat))+
  geom_text(data=apart_data_final, aes(label=단지명, vjust=-1))+
  geom_text(data=apart_data_final, aes(label=거래금액,vjust=1))


ggmap(mapo_map) + 
  geom_point(data=station_code_fin, aes(x=lon,y=lat),
             color='red', size=3) +
  geom_text(data=station_code_fin, aes(label=역명, vjust=-1)) +
  geom_point(data=apart_data_final, aes(x=lon,y=lat))+
  geom_text(data=apart_data_final, aes(label=단지명, vjust=-1))+
  geom_text(data=apart_data_final, aes(label=거래금액,vjust=1))

ggmap(mapo_map)
