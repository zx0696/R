# 서울시 지역별 미세먼지 농도 현황 분포를 비교 
# 지역별 차이가 있는지 평균검정을 통해 확인(특정 2개의 지역)

# 전 지역의 미세먼지에 대한 비교 그래프
# 미세먼지 농도의 평균을 활용해서 서울시 구 별의 차이를 단계그래프로 표시

# 데이터 준비 
# 서울시 대기 환경 정보 

# 필요 패키지 추가
library(dplyr)
library(readxl)
library(ggplot2)
library(reshape2)

# raw 데이터 읽어오기 
data <- read_excel('data_/period.xlsx',skip = 3)
View(data)
dim(data)
str(data)
ls(data)
#필요 데이터 추출(날짜, 측정소명, 미세먼지)
dustdata <- select(data,날짜, 측정소명,`미세먼지 PM10\n(㎍/m3)`)
head(dustdata)

# 컬럼명 변경
names(dustdata) <- c('yyyymmdd', 'area', 'finedust')
head(dustdata)
#---------------------------------------------------------
# 검증 : 성북구와 중구의 미세먼지 농도는 차이가 있는가?
# 가설 : 두 지역에 미세먼지 농도의 차이가 난다.
# - 평균의 차이가 있나? 


#가설을 검증하는데 필요한 데이터만 추출 
# area이 성북구거나 중구인 데이터

dust_anal <- dustdata %>% 
  filter(area %in% c('성북구','중구'))
head(dust_anal)

# 데이터 현황 파악하기 
# 모든 날짜에 성북구와 중구가 다 포함되어 있는지 확인
View(count(dust_anal,yyyymmdd))

#지역별 데이터 수 확인 
count(dust_anal,area)

# 미세먼지 관측 여부 - 결측치는 없음 
table(is.na(dust_anal$finedust))

# 성북구와 중구 데이터 분리 후 사용
dust_sb <- dust_anal %>%  filter(area=='성북구')
dust_jg <- subset(dust_anal, area=='중구')

head(dust_sb)
head(dust_jg)

#기초 통계량 확인
summary(dust_jg$finedust)
summary(dust_sb$finedust)

#-------------------------------------
# boxplot() 활용 분포 차이 확인
boxplot(dust_jg$finedust,dust_sb$finedust,
        main = 'finedust_compare',
        xlab='AREA', ylab = 'FINEDUST_PM',
        names=c('중구', '성북구'),
        col = c('blue', 'green' ))

# t검정을 통한 평균차이 검정 
# t검정 : 많이 알려진 평균 차이 검정의 통계적 모형, t분포 활용 
# t.test(data=데이터세트, 변수2(관측치) ~ 변수1(기준), var.equal = T )
# var.equal = : 두 비교 집단에 분산동질성 여부(같다라고 가정)
# 결과 : p-value가 0.05보다 작으면 대립가설 채택 
# 귀무가설 : 평균이 같다. 
# 대립가설 : 평균이 같이 않다.
t.test(data=dust_anal,finedust ~ area, var.equal= T)
# p-value = 0.1406
# sample estimates:
# mean in group 성북구   mean in group 중구 
# 41.91667             48.13333 
# 두 집단간의 평균 차이가 없다. 

###################################################################
# 시각화 작업 
# 서울시 자치구별 미세먼지  데이터의 시각화 

View(dustdata)
# 서울시 25개구의 60일 관측 데이터 
table(dustdata$area)
#area 컬럼에 평균이라는 이상치 데이터 존재
#이상치 -> NA로 변경 후 다음작업
#평균데이터값을 NA로 대체

# 원본 보관
dustdata_NA <- dustdata

dustdata_NA$area <- ifelse(dustdata_NA$area=='평균', 
                           NA,
                           dustdata_NA$area)
#데이터 확인
head(dustdata_NA)

# 결측치 처리 

# 전체 데이터에서 NA 빈도수 확인
table(is.na(dustdata_NA))

#  area 컬럼에서 NA 빈도수 - 지자체명이 없으면 데이터 사용불가 
# 행제거 (지자체와 상관없는 관측일의 평균과 전체평균 데이터 이므로 
# 사용할 필요가 없음)

table(is.na(dustdata_NA$area))

# finedust 컬럼 (실제 관측치) NA의 빈도수
 
# 미세먼지 관측이 안된 데이터가 12개 -비율이 크지 않으면
# 제거하지 않고 대표값으로 대체해서 사용 
table(is.na(dustdata_NA$finedust))


#area 컬럼의 값이 NA인 행 제거
dustdata_NA <- dustdata_NA %>%  filter(!is.na(area))
table(is.na(dustdata_NA$area))

#---------------------------------------------------------
View(dustdata_NA)
#long형 구성이므로 wide형으로 변경 
#기준열 : yyyymmdd
# 변환열 : area
dustdata_w <- dcast(dustdata_NA,yyyymmdd~area)
View(dustdata_w)
# NA값을 갖고 있는 지역 확인 통계량 산출
summary(dustdata_w)

# 용산구가 NA값이 4개로 가장 많지만 비율이 작으므로 
# 지자체의 평균값으로 NA값을 대체 

# 용산구의 finedust 항목의 NA값을 평균값으로 대체 
table(is.na(ifelse(is.na(dustdata_w$용산구),
       mean(dustdata_w$용산구,na.rm = TRUE),
       dustdata_w$용산구)))


#아래 코드를 모든 자치구에 적용 (반복문으로 구성)
table(is.na(ifelse(is.na(dustdata_w$용산구),
                   mean(dustdata_w$용산구,na.rm = TRUE),
                   dustdata_w$용산구)))

#동일결과
dustdata_w[,'용산구']
dustdata_w$용산구
gu <- '용산구'
dustdata_w[,gu]

# 반복문을 이용해서 NA -> 평균값 
# 자치구 이름 추출 
gus <- names(dustdata_w[-1])
gus

for(gu in gus){
dustdata_w[,gu] <- ifelse(is.na(dustdata_w[,gu]),
                          mean(dustdata_w[,gu],na.rm = TRUE),
                          dustdata_w[,gu])
  # cat(gu,'',table(is.na(dustdata_w[gu])))
}

# na값 처리 확인 
table(is.na(dustdata_w))

# 서울시 구별 미세먼지 변화 그래프 
ggplot(dustdata_w,aes(x=yyyymmdd, y=성북구)) + 
  geom_line(group=1,colour='red') +
  theme(axis.text.x=element_blank(),
        axis.line.x =element_blank(),
        axis.ticks.x = element_blank())
# 서울시 25개구의 특정 기간에 따른 미세먼지 농도 변화 
# 여러 구의 미세먼지 농도 시각화는 wide형보다 long형 데이터가 더 유용함.
ggplot(dustdata_NA,aes(yyyymmdd,finedust)) +
  geom_point(aes(color=area)) +
  theme(axis.text.x=element_blank(),
        axis.line.x =element_blank(),
        axis.ticks.x = element_blank()) +
  theme(legend.position = 'bottom')

##################################
#각 구별 미세먼지 농도 평균을 활용 차이비교
# 단계 구분도
# 구글 지도에 도형을 이용해 표시

# 구별 미세먼지 농도 평균표 작성
# 전처리 완료 data : dustdata_w
View(dustdata_w)
ls(dustdata_w)
#날짜 컬럼이 있으므로 제와 후 평균계산
mean(dustdata_w[,-1])
# 각 구의 평균
class(apply(dustdata_w[-1],2,mean)) # 벡터형 반환
class(data.frame(dust_mean=apply(dustdata_w[-1],2,mean)))
test <- data.frame(dust_mean=apply(dustdata_w[-1],2,mean))
ls(test)
library(tibble)
rownames_to_column(test)

# wide -> long형으로 변경
dust_NArm <- melt(dustdata_w,
                  id.vars = 'yyyymmdd',
                  variable.name = 'area',
                  value.name = 'finedust')
View(dust_NArm)

# long형 데이터 이용 각 구별 평균 구하기
# aggregate(계산열~기준열, 데이터셋, 통계함수)
# 구별 미세먼지 농도 평균표
gu_dust_mean <- aggregate(finedust~area,dust_NArm,mean)

# 구별 농도평균 비교 그래프 
ggplot(gu_dust_mean,
       aes(x=reorder(area,-finedust),
           y=finedust)) +
  geom_col(aes(fill=area)) + 
  theme(legend.position = "none") +
  coord_flip()

#################
# 서울시 미세먼지 농도평균 단계구분도
library(ggiraphExtra)

# 평균표 : 서울시 각 자치구 - area
View(gu_dust_mean) 

# 지도데이터 
seoul_map <- read_excel('data_/서울_map.xlsx')
names(seoul_map)

View(seoul_map)

# 지도데이터와 수치데이터의 공통열을 생성하기 위해
# 지도데이터의 코드를 활용해서 수치데이터의 구별 행정코드 추가 

s_map_code <- seoul_map %>%  select(code,name)
View(s_map_code)

#행정코드와 자치구명이 중복됭 여러번 나타나므로 자치구별 1개씩 만
#추출
# duplicated(값) -> 중복된 값이면 True/ 중복된 값이 아니면 False
s_code <- s_map_code[!duplicated(s_map_code$name),]
View(s_code) 

#양쪽 파일의 키 변수명 일치
s_code <- rename(s_code,area=name)
head(s_code,1)

# 조인 
gu_dust_gg <- left_join(gu_dust_mean,s_code,by='area')
View(gu_dust_gg)

# 지도 data : seoul_map
# 수치 data : gu_dust__gg

ggChoropleth(data = gu_dust_gg,
           aes(map_id=code,
               fill=finedust,
               tooltip=area),
           map=seoul_map,
           interactive = T)


###############################################################
# 구글 맵 위에 미세먼지 농도 point로 표시 
gu_dust_gg #미세먼지 평균 

library(ggmap)
gu_names <- gu_dust_gg$area
gu_names

register_google(key = '본인 API')
# 구명으로 위경도 조회
gu_geo <- geocode(gu_names)
gu_geo

#############################
# 데이터 결합
gu_dust_geo <- cbind(gu_dust_gg, gu_geo)
View(gu_dust_geo)

# 지도에 표시
dust_map <- get_googlemap('서울시', zoom = 11, maptype = 'roadmap')

ggmap(dust_map) + geom_point(data=gu_dust_geo,
                              aes(x=lon,
                                  y=lat,
                                  size=finedust * 3,
                                  color=finedust),
                              alpha=0.5) +
  theme(legend.position = 'none') +
  scale_color_gradient(low='blue',high = 'red')
