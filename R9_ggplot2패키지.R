# ggplot2 패키지 : 시각화 패키지 
# 기본 그래프 기능보다 더 다양한 방식의 그래프 작도가 가능
# 산점도 : geom_point()
# 꺾은선 그래프 : geom_line()
# 막대 그래프 : geom_bar
# boxplot, 히스토그램
# + 연산자를 활용해 겹쳐 그릴 수 있다.
# 다른 객체 추가 가능(직선, 텍스트, 도형)

#패키지 설치 및 로드
# install.packages("ggplot2")
library(ggplot2)

#1단계 : 그래프 기본 틀 생성
# ggplot(데이터세트, aes(속성)) 함수 사용- 그래프의 좌표 생성 위해 틀을 만드는  함수
# aes() : awcv  ax축 / y축에 맵핑되는 데이터(속성) 설정

#mpg 사용
head(mpg)
ggplot(data=mpg,mapping = aes(x=displ,y=hwy))
#2. 그래프 추가 ( +연산자 사용)
#배경도에 산점도 추가
ggplot(mpg,aes(displ,hwy)) + geom_point()
 
#3. 그래프 관련 설정 변경 (+ 연산자 사용)
ggplot(mpg,aes(displ,hwy)) + geom_point() + xlim(3,6)
ggplot(mpg,aes(displ,hwy)) + geom_point() + xlim(3,6) + ylim(10,30)
# 여러 라인으로 표현 : + 뒤에서 줄 바꾸기 , + 연산자가 행 앞으로 오면 에러
ggplot(mpg,aes(displ,hwy)) + 
  geom_point() +
  xlim(3,6) +
  ylim(10,30)

# mpg 데이터의 각 자동차들에 대해 고속도로 연비와 도시연비의 관계를 시각화로
# 확인하시오

ggplot(data = mpg, aes(x=cty, y=hwy)) +
  geom_point()

# 막대그래프 1 - 집단가 차이 표현
# 데이터의 크기를 막대의 길이로 표현

# mpg 데이터의 각 자동차 구동방식별 고속도로 연비 차이를 시각화 하시오
# 1. 집단별 평균표 만들기
library(dplyr)
df_mpg <- mpg %>% group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))
df_mpg

# 2. 그래프 생성하기 
ggplot(data=df_mpg,aes(x=drv, y=mean_hwy)) +
  geom_col()

# 막대를 크기 순으로 정렬하기 
# 배경도에서 정렬 완료
ggplot(data=df_mpg, aes(x=reorder(drv,-mean_hwy),y=mean_hwy)) +
  geom_col()

# 막대 그래프2 - 빈도 막대 그래프
# 값의 개수(빈도)로 막대의 길이를 표현
# 범주형 변수인 경우 값의 빈도를 세서 그래프를 표현
# geom_bar() : 빈도는 자동 계산 함(y축 데이터로 사용)
ggplot(data=mpg, aes(x=drv)) + geom_bar()
#drv 속성
class(mpg$drv) # 범주형 변수
table(mpg$drv)

# ggplot(data=mpg, aes(x=drv)) + geom_col() -> x,y축 값이 모두 필요
# geom_col()` requires the following missing aesthetics: y

#연속형 변수로 geom_bar()를 사용하면 
#x축 : 연속변수, y축 : 빈도
# 고속도로 연비: hwy
ggplot(data=mpg, aes(x=hwy)) + geom_bar()
# hwy 데이터의 빈도를 세서 막대 그래프 생성
table(mpg$hwy)
#연속형 데이터 각각의 빈도는 별다른 의미가 없다.
# 구간의 빈도를 주로 사용 - 히스토그램

###########################################
# geom_bar() 그래프의 stat 옵션
# start : statistic의 약자
#y축값 사용 방법을 설정하는 파라미터
# 빈도수 계산
#x축 값만 지정

#stat= 'identity'
# y축 값을 데이터 기반으로 정해줄때
# y축 값을 명시 : geom_col()과 같은 의미를 갖는다

#diamonds 데이터 세트
View(diamonds)
ggplot(data=diamonds, aes(cut)) + geom_bar()
ggplot(data=diamonds, aes(x = cut)) + geom_bar()
ggplot(data=diamonds, aes(x = cut)) + geom_bar(stat = 'count')

#sleep 데이터 세트 
View(sleep)
ggplot(data = sleep, aes(x=ID,y=extra)) + 
  geom_bar(stat='identity')

# geom_bar(stat=, position='dodge'/'fill)
# dodge : 묶음막대, fill : 비율로 표시
# position을 사용하기 위해서는 aes(fill=group) : 각 막대의 색상 표현
ggplot(data = sleep, aes(x=ID,y=extra, fill = group)) + 
  geom_bar(stat='identity', position = 'dodge')

ggplot(data = sleep, aes(x=ID,y=extra, fill = group)) + 
  geom_bar(stat='identity', position = 'fill')

ggplot(data = diamonds, aes(x=color,fill = cut)) + 
  geom_bar(stat='count', position = 'fill')


###############################
# 가로 막대 그래프

# 세로막대그래프를 그린 후 x축과 y축의 구성을 뒤집어 표현
# coord_flip()
#가로 누적 막대 그래프

ggplot(sleep,
       aes(ID, extra, fill = group)) +
  geom_bar(stat = 'identity') +
  coord_flip()


#가로 비율 막대 그래프
ggplot(sleep,
       aes(ID, extra, fill = group)) +
  geom_bar(stat = 'identity', position = 'fill') +
  coord_flip()

#가로 묶음 막대 그래프
ggplot(sleep,
       aes(ID, extra, fill = group)) +
  geom_bar(stat = 'identity', position = 'dodge') +
  coord_flip()

############################################
# 선그래프 - 시계열 그래프 
# : 시간에 따라 데이터의 변화를 표현 

# 시계열 데이터 economics 
View(economics)
str(economics)
# 일자에 따른 실업자 수의 변화
ggplot(data=economics, aes(x=date,y=unemploy)) +
  geom_line()


ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_line()

##########################################################3
# boxplot 
# 데이터의 분포를 확인하기 위한 그래프
# 평균을 비교하는 막대 그래프보다 데이터 특성을 좀 더 
# 자세히 이해할 수 있다.
#geom_boxplot()

ggplot(data=df_mpg,aes(x=drv, y=mean_hwy)) +
  geom_col() #평균 차이 비교

ggplot(data=mpg,aes(x=drv, y=hwy)) +
  geom_boxplot()

#######################################################
### 그래프의 모양(선/색상/크기)
# color/colour = '색상' 
#shape = 모양 
#size = 크기 
ggplot(mpg, aes(x=displ, y=hwy)) +
  geom_point(color = 'red',
             shape=5,
             size=2)
#fill = : 도형에 색을  채워줄때(막대그래프)
Orange %>% 
  group_by(Tree) %>% 
  summarize(Sum.circumference=sum(circumference)) %>% 
  ggplot(aes(Tree,Sum.circumference)) +
  geom_bar(stat = 'identity', fill='red') 


Orange %>% 
  group_by(Tree) %>% 
  summarize(Sum.circumference=sum(circumference)) %>% 
  ggplot(aes(Tree,Sum.circumference,fill=Tree)) +
  geom_bar(stat = 'identity')


Orange %>% 
  group_by(Tree) %>% 
  summarize(Sum.circumference=sum(circumference)) %>% 
  ggplot(aes(Tree,Sum.circumference,fill='red')) +
  geom_bar(stat = 'identity')

# fill파라미터의 값으로 변수를 전달할때는 aes()안에 있어야 함
# Orange %>% 
#   group_by(Tree) %>% 
#   summarize(Sum.circumference=sum(circumference)) %>% 
#   ggplot(aes(Tree,Sum.circumference)) +
#   geom_bar(stat = 'identity',fill=Tree)
#Error in list2(just = just, width = width, na.rm = na.rm, orientation = orientation,  : 
# object 'Tree' not found

#좋은 방법은 아님 
Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference=sum(circumference)) %>%
  ggplot(aes(Tree,Sum.circumference)) +
  geom_bar(stat = 'identity',aes(fill=Tree))

# 선의 색상 지정 : color 
Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference=sum(circumference)) %>%
  ggplot(aes(Tree,Sum.circumference)) +
  geom_bar(stat = 'identity',fill='white',color='red')

Orange %>%
  group_by(Tree) %>%
  summarize(Sum.circumference=sum(circumference)) %>%
  ggplot(aes(Tree,Sum.circumference,color=Tree)) +
  geom_bar(stat = 'identity',fill='white')
  
# geom_line() 선 그래프 : color 옵션으로 선 색상 설정
Orange %>% 
  filter(Tree==1) %>% 
  ggplot(aes(age, circumference)) + # 나이, 둘레
  geom_line(color='red')



Orange %>% 
  filter(Tree==1) %>%  
  ggplot(aes(age, circumference)) + # 나이, 둘레
  geom_line(color='red') +  
  geom_point(size=2) # 점과 라인 같이


Orange %>% 
  ggplot(aes(age,circumference,color=Tree)) +
  geom_line()

#
Orange %>% 
  group_by(Tree) %>% 
  summarize(sum.circumference=sum(circumference)) %>% 
  ggplot(aes(Tree,sum.circumference)) + 
  geom_line(color='red')
# geom_line()`: Each group consists of only one observation.
# ℹ Do you need to adjust the group aesthetic?

#x축 데이터가 factor면 geom_line() 안그려짐 
str(Orange)  # Ord.factor

str(Orange %>% 
      group_by(Tree) %>% 
      summarize(sum.circumference=sum(circumference)))

# group에 대해 명시 : group 1로 하나의 그룹으로 처리 
Orange %>% 
  group_by(Tree) %>% 
  summarize(sum.circumference=sum(circumference)) %>% 
  ggplot(aes(Tree,sum.circumference)) + 
  geom_col() + 
  geom_line(group=1,color='red')

# point 그래프 : 점 표시
Orange %>% 
  group_by(Tree) %>% 
  summarize(sum.circumference=sum(circumference)) %>% 
  ggplot(aes(Tree,sum.circumference)) +
  geom_point(size=6, color='red')

ggplot(Orange, aes(x=age, y=circumference,color=Tree)) +
  geom_point()

ggplot(Orange, aes(x=age, y=circumference,fill=Tree)) +
  geom_bar(stat='identity', position = 'dodge')


####################################
# 죄표계 : 직교 좌표계 (카테시안 좌표계/데카르트 좌표계)
# coord_cartesian() 함수 :
#xlim, ylim, expand(축과 그래프의 여백 유무) 파라미터를 주로 사용


faithful 
# 옐로스톤 국립공원의 간헐천의 분화와 분화사이의 대기시간 기록

ggplot(faithful, aes(waiting, eruptions)) +
  geom_point() +
  coord_cartesian(xlim = c(50,90))



ggplot(faithful, aes(waiting, eruptions)) +
  geom_point() +
  coord_cartesian(xlim = c(min(faithful$waiting)-5,
                  max(faithful$waiting)+5))


ggplot(faithful, aes(waiting, eruptions)) +
  geom_point() +
  xlim(50,90)


ggplot(faithful, aes(waiting, eruptions)) +
  geom_point() +
  coord_cartesian(expand = FALSE)
# expand = 그래프와 축간의 상하좌우 여백의 유무를 결정

######################################
# scale 패키지 관련 함수

ggplot(Orange, aes(x=age, y=circumference,fill=Tree)) +
  geom_bar(stat='identity', position = 'dodge')
# 위 그래프는 Tree 종류에 따라 다른 색상으로 막대 그래프가 그려짐 
# 채워지는 색상은 내부 설정 색상을 사용

# scale 패키지의 scale_xxx_manual() 함수 사용하면 
# 채워지는 색상 변경 가능
# 기존의 색상 위에 다른 색상을 입혀주는 함수 
# 주의점 : scale_xxx_manual() 적용 전에 fill, color 파라미터를 먼저 설정해야 함
# scale_color_manual() - line 그래프 / scale_fill_manual() - bar 그래프 
library(scales)
p <- Orange %>% 
  group_by(Tree) %>% 
  summarize(sum.circum = sum(circumference)) %>% 
  ggplot(aes(Tree, sum.circum,fill=Tree)) +
  geom_bar(stat = 'identity')
p  

# scales 패키지의 scale_fill_manual() 함수를 통해
# 각 막대그래프의 색상을 지정 
p + scale_fill_manual(values = c('#ffffff',
                                 '#ffcc00',
                                 '#ff9900',
                                 '#ff6600',
                                 '#ff3300'))
# scale_fill_brewer(palette=)
p + scale_fill_brewer(palette = 'Greens')
p + scale_fill_brewer(palette = 'Reds')
p + scale_fill_brewer(palette = 'Blues')
p + scale_fill_brewer(palette = 'Spectral')

#direction = -1  : 파레트에서 적용되는 색상의 순서를 반대로 적용
p + scale_fill_brewer(palette = 'Reds')
p + scale_fill_brewer(palette = 'Reds', direction = -1 )

#####################################
# 그래프를 그릴 때 범주형 변수의 처리

View(mtcars)

str(mtcars)

# 데이터에서 cyl 별 자동차 대수를 그래프로 비교 확인하시오 
table(mtcars$cyl)
ggplot(mtcars, aes(x=cyl)) + geom_bar()

ggplot(mtcars, aes(x=cyl)) + geom_bar(width = 0.5)
# 빈 범주가 표시 
#cyl 데이터가 연속형 데이터로 되어 있음 

# 의미적으로 범주형 데이터임에도 형식이 연속형으로 되어 있으면, x 축값을 매핑
#할 때 factor형으로 바꿔서 매핑해야 한다.

ggplot(mtcars, aes(x=factor(cyl))) + geom_bar(width = 0.5)

# factor(x, level=) : 순서를 변경할 수 있음
ggplot(mtcars, aes(x=factor(cyl,levels = c('8','6','4')))) + geom_bar(width = 0.5) +
   geom_bar(width = 0.5)

#'fill = 범주값' 
ggplot(mtcars, aes(x=factor(cyl,levels = c('8','6','4')),
                   fill=as.factor(am))) +
  geom_bar(width = 0.5) + 
  labs(fill='am') # 범례의 제목 변경
############################################################################
# 범례 표시 위치 설정
# 범주형 데이터를 사용 할 경우 기본으로 범례 표시 
# 범례 위치 변경 : theme(legend.position='위치기호,값')
# top/bottom/right(디폴트)/left/none

# iris 
View(iris)
d1 <- ggplot(iris, aes(Petal.Length,Petal.Width)) +
  geom_point(aes(color=Species))
d1

d1 + theme(legend.position='top')
d1 + theme(legend.position='left')
d1 + theme(legend.position='right')
d1 + theme(legend.position='bottom')

d1 + theme(legend.position='none')

#x,y 좌표(위치)
d1 + theme(legend.justification =c(2,0.8))
d1 + theme(legend.justification =c("left","top"))

#legend.direction='horizontal'/'vertical
d1 + theme(legend.direction = 'horizontal')


d1 + theme(legend.direction = 'vertical',
           legend.position = 'bottom')
# 범례 영역은 사각형임 : 배경과 관련된 내용변경은 
# element_rect() 함수 이용해야 함
# legend.background = 

d1 + theme(legend.background = element_rect(fill='green'))
d1 + theme(legend.background = element_rect(color='green'))          
d1 + theme(legend.background = element_rect(color='green',
                                            size=1,
                                            linetype = 'dashed'))


###############################################
# scale_fill_manual() 함수 사용 범례 표시
# values : 색상
# limits : 실제 시각화 되는 범주 
# name : 범례 제목변경
# breaks : 범례에 표현할 변수 값 
# labels : 범례 설명 값

# mpg 데이터의 class 컬럼의 빈도 막대 그래프 

g <- ggplot(data=mpg, aes(x= class, fill = class)) +geom_bar()
g

g + scale_fill_manual(values = c("navy","blue",'royalblue',
                                 'skyblue','orange','gold','yellow'),
                        name= '자동차종류',
                      breaks = c('compact','suv'),
                      labels = c('경차','suv'),
                      limits = c('compact','suv'))


##############################################################################
# labs() : 그래프안의 제목들에 대해서 설정 할 수 있음
# x=x축 제목 / y=y축 제못
# title = 그래프 main 제목
# subtitle = 세부제목
# caption = 캡션 
# fill = 범례 제목


#x축의 값은 좌표값에 해당됨
ggplot(mtcars, aes(cyl,fill=as.factor(am))) + 
  geom_bar(position = 'dodge')



# x축의 값은 좌표값이 아닌 표식에 해당
ggplot(mtcars, aes(factor(cyl), fill=as.factor(am))) + 
  geom_bar(position = 'dodge') +
  labs(x='cyl(실린더)',
       y='am count(빈도)',
       title = 'cyl별 am 빈도 차이 분석',
       subtitle = '빈도막대 그래프 활용',
       caption = '출처 : 본인작성' ,
       fill = 'AM')
  theme(plot.title = element_text(face='bold',
                                  size=20,
                                  hjust = 0.5),
        legend.position = 'bottom')

############################################################################
# 각각의 함수 사용
# ggtitle(), xlab(), ylab(), labs()
  
  library(dplyr)
  
  ggplot(mtcars, aes(factor(cyl), fill=as.factor(am))) + 
    geom_bar(position = 'dodge') +
    ggtitle('cyl별 am 빈도 차이 분석') +
    xlab('cyl(실린더)') +
    ylab('am count(빈도)')
    labs(fil = 'AM')
  theme(plot.title = element_text(face='bold',
                                  size=20,
                                  hjust = 0.5),
        legend.position = 'bottom')