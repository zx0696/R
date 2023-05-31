##########################################
# 단계 구분도
# 지역별 통계치를 색상의 차이로 표현한 지도 
# 인구나 소득 같은 특성이 지역별로 얼마나 다른지 쉽게 전달 가능 

# 패키지 인스톨 
install.packages('ggiraphExtra')
library(ggiraphExtra)


###############################3
# 미국 주별 범죄 데이터 : USArrests

# 1. 미국 주별 강력 범죄율을 단계 구분도로 표시
str(USArrests)
head(USArrests)

# 주별 변수가 따로 없고 rownames에 지역명으로 되어 있음 
# rownames를 컬럼으로 변환해서 사용해야 함 : tibble 패키지 
# rownames_to_column(data, var='새로 생성될 변수명')
# tlbble 패키지 : dplyr 패키지 설치시 같이 설치 됨
library(tibble)
crime <- rownames_to_column(USArrests, var = 'state')
head(crime)

# state 컬럼값을 소문자로 변경
# 지도 데이터에 포함되어 있는 state 정보가 전부 소문자임
crime$state <- tolower(crime$state)
head(crime)

###################################3
# 지도 데이터 준비 
# 미국 주별 경계선 위경도 정보가 있는 데이터 
# R 내장 패키지인 maps 패키지에 지도 정보 포함되어 있음
# maps 패키지의 state 데이터
# ggplot2패키지의 mpa_data() 함수를 이용해서 state 데이터 읽어옴

install.packages('maps')
library(ggplot2)
library(maps)
states_map <- map_data('state')
ls(states_map)

#############################
# 단계 구분도 생성
# ggChoropleth() 사용
# states_map(region), crime(state) df 사용
# ggChoropleth(data는 '지도에 표현할 수치 데이터 세트',
              # aes(fill = 색상으로 표현 할 컬럼명,
              #     map_id = 지역 기준 변수),
              # map = 지도 데이터 세트)
ggChoropleth(data=crime,
             aes(fill=Murder,
                 map_id=state),
             map = states_map)

# 제목추가
ggChoropleth(data=crime,
             aes(fill=Murder,
                 map_id=state),
             map = states_map) +
  ggtitle('미국 주별 강력 범죄') +
  theme(plot.title = element_text(face='bold',
                                  size=20,
                                  hjust = 0.5),
        legend.position = 'bottom')

# 반응형 단계 구분도 
# 그래프가 아닌 웹코드가 생성됨 
# ggplot2 패키지의 꾸미기 함수 사용불가 
# interactive = T 추가 
ggChoropleth(data=crime,
             aes(fill=Murder,
                 map_id=state),
             map = states_map,
             interactive = T,
             palette = "Blues")

# 두 개의 데이터로 단계 구분도 생성

ggChoropleth(data=crime,
             aes(fill=c(Murder, Rape),
                 map_id=state),
             map = states_map,
             interactive = T,
             palette = "Blues")


#########################################################
# 대한민국 시도별 인구 차이에 대한 단계 구분도 
# kormaps2014 패키지 
install.packages('devtools')
devtools::install_github('cardiomoon/kormaps2014')


library(kormaps2014)

# 대한민국 시도별 인구데이터 준비
# kormaps2014패키지에는 몇가지 종류의 지역별 인구통계 데이터와 지역별 지도 데이터가 있음
# 대한민국 지도 데이터
# kormap1 : 시도별 지도데이터    
# kormap2 : 시군구별 지도 데이터
# kormap3 : 읍면동별 지도 데이터
# 지역별 인구통계 데이터
# korpop1 : 시도별 인구통계                                
# korpop2 : 시군구별 인구통계         
# korpop3 : 읍면동별 인구통계
# 인구 데이터
View(korpop1)
library(dplyr)
korpop1 <- rename(korpop1,
                  pop=총인구_명,
                  name=행정구역별_읍면동)
select(korpop1,c(pop,name))

# 지도 데이터
View(kormap1)

# 지역 기준열로 사용 가능한 열이 여러개 
# 수치 코드화 되어있는 code 컬럼을 기준으로 설정

ggChoropleth(data=korpop1,
             aes(fill = pop,
                 map_id = code),
             map=kormap1)

# 툴 팁에 지역명이 아닌 지역 코드가 출력 
ggChoropleth(data=korpop1,
             aes(fill = pop,
                 map_id = code),
             map=kormap1,
             interactive = T)

# 툴팁을 지역명으로 변경 
# tooltip= 파라미터 
  
ggChoropleth(data=korpop1,
             aes(fill = pop,
                 map_id = code,
                 tooltip=name),
             map=kormap1,
             interactive = T)

#########################
# tbc
View(tbc)
ggChoropleth(data=korpop1,
             aes(fill = Newpts,
                 map_id = code,
                 tooltip=name1),
             map=kormap1,
             interactive = T)

##############################33
# 시군구 단위 남자 인구수를 단계구분도로 표현
# 지도 : kormap2
# 인구 : korpop2 

View(korpop2)
ggChoropleth(data = korpop2,
             aes(fill=남자_명,
                 map_id=code),
             map=kormap2)

############################################
# 
library(readxl)
seoul <- read_excel('data_/서울.xlsx')

seoul_map <- read_excel('data_/서울_map.xlsx')

ggChoropleth(data=seoul,
             aes(fill = 점포수,
                 map_id=code,
                 tooltip='행정구역별_읍면동'),
             map = seoul_map,
             interactive =  T)

