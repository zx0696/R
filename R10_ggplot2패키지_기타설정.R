#################################################################3
# 그래프에 기타 객체 추가하기
#################################################################
library(ggplot2)
### 막대 그래프에 수치 레이블 표시
# 빈도 계산된 값이 저장되는 변수 ..count..
# 빈도 막대 그래프에 텍스트를 출력하고자 하면
# - geom_text(stat = 'count') 설정해여 함

ggplot(mtcars, aes(x=factor(cyl))) +
  geom_bar(width=0.8, fill='red') +
  geom_text(stat = 'count' , # 출력 y좌표
              aes(label =..count..),
              vjust=-0.5)



# 묶음 막대 그래프에 텍스트(레이블)표시
# geom_text(posithoin=position_dodge(width=실제막대그래프 값과 동일))
ggplot(mtcars, aes(x=factor(cyl),fill=as.factor(am))) +
  geom_bar(position = 'dodge', width = 0.8) +
  geom_text(stat = 'count' , # 출력 y좌표
            aes(label =..count..),
            position = position_dodge(width=0.8),
            vjust=-0.5)


# 누적막대 그래프에 레이블 표시
# position = 'stack'

ggplot(mtcars, aes(x=factor(cyl),fill=as.factor(am))) +
  geom_bar(position = 'stack', width = 0.8) +
  geom_text(stat = 'count' , # 출력 y좌표
            aes(label =..count..),
            position = position_stack(vjust=-0.5))
# stat = 'identity'인 경우
# fill 파라미터로 그룹핑하면 결국 누적막대 그래프
# position = position_stack(vjust=0.5)
sleep
aes(ID,extra,fill=group)          
ggplot(sleep, aes(x = ID, y= extra,fill=group)) +
  geom_bar(stat = 'identity',position = 'stack') +
  geom_text(stat = 'identity' , # 출력 y좌표
            aes(label =extra),
            position = position_stack(vjust=-0.5))

##################################
setwd('data')
score <- read.csv('./학생별과목별성적_국영수_new.csv')
head(score)

ggplot(score,aes(이름,점수,fill=과목)) +
  geom_bar(stat='identity') + # stat="count"가 디폴트이므로 변경해서 사용
  geom_text(aes(label=점수), # stat = 'identity'가 디폴트 
            position=position_stack(vjust = 0.5))


            
###################################################################
g <- ggplot(mtcars,aes(hp,mpg))
g + geom_point(shape=15, size=3, color='blue')

# g + geom_point(shape=factor(gear),
#                color = factor(gear))
# Error in factor(gear) : object 'gear' not found
# gear 컬럼이 그래프 배경에 매핑되지 않음

#geom_point(aes()) 으로 필요 컬럼 매핑
g + geom_point(aes(shape=factor(gear),
               color =factor(gear)))



# 그래프는 변수값에 의해 서로 다른 모양과 색상으로
# 그려짐 : 변수명을 인식했음
# 보여주는 결과만 다르게 나옴
# 변수의 값에 따라 내부 그룹이 생성된 건 아님 
# 범례 생성이 안됨
g + geom_point(shape=factor(mtcars$gear),
               color = factor(mtcars$gear))



team <- c('ko','ko','ko','ch','ch','ch')
grade <- c(1,2,3,1,2,3)
points <- c(30,51,60,20,47,62) 
df_team <- data.frame(team,grade,points) 
View(df_team)

g <- ggplot(df_team, aes(grade, points))

g + geom_line(aes(color = team, linetype=team)) +
  geom_point(aes(sahpe=team))

# 모든 그래프에 동일한 모양 동일한 색상을 적용
# 꾸미기 파라미터 적용 없이 그룹만 분류
# aes(group=)
g + geom_line(aes(group=team), color = 'red') + 
  geom_point(aes(fill=team))


ggplot(df_team, aes(factor(grade), points)) +
  geom_line()


  ggplot(df_team, aes(factor(grade), points)) +
  geom_line(aes(group = team, color = team))

#######################################################
# geom_area() : 누적 영역 그래프 
# 선그래프에서 선 아래를 색상으로 채움
# 시간의 흐름에 따른 그룹/집단 별 관측 값 혹은
# 비율의 변화를 누적해서 볼 수 있는 그래프

# geom_area() 작도 순서
# line 그래프로 선을 그리고
# area 그래프로 영역 설정
# 데이터 추이 값을 추가
setwd()
subway <- read.csv("./1-4호선승하차승객수.csv")
head(subway)
library(dplyr)
# 노선 번호별 승차인원이 많은 순으로 영역 그래프 생성
subway %>%  group_by(노선번호) %>% 
  summarise(line_total = sum(승차)) %>% 
  arrange(desc(line_total))

ggplot(subway, aes(x=시간, y=승차)) +
geom_area(aes(group=노선번호,
              fill = 노선번호))

#영역이 채워지는 순서를 변경하기 위해서는 
#기준열의 순서를 factor로 변환 후 직접 설정해여 함
#순서 자체가 사전적 의미가 필요하면 factor화 필요없음
# 새로운 변수 생성 
# factor 설정
line <- factor(subway$노선번호,
       level = c('line_2','line_4','line_3','line_1'))
# 영역 그래프 영역 설정

ggplot(subway, aes(x=시간, y=승차)) +
  geom_line(aes(group=노선번호,color=노선번호)) +
  geom_area(aes(group=line,
                fill = line))

ggplot(subway, aes(x=시간, y=승차)) +
  geom_area(aes(group=line,
                fill = line),alpha=0.5) +
scale_fill_brewer(palette='Blues')



###############################
#축(axis) 모양 변경
library(axis)

#나이에 따른 오렌지 나무 성장 데이터
View(Orange)
#line,text,ticks,title : 축의 세부 객체
# x,y 축선
#theme(axis.line=)

g1 <- ggplot(Orange, aes(age,circumference)) +
  geom_point(aes(color=Tree,shape=Tree)) +
  ggtitle('오렌지 나무 성장 분포') 

#x,y축 모두 변경
g1 + theme(axis.line =element_line(size=2,#굵기
                     color='red',
                     linetype='dashed'))


g1 + theme(axis.line.x =element_line(color='red'
                                    )) +
theme(axis.line.y =element_line(color='black'))

#축 레이블의 간격 설정 
#축 레이블 변경 (labels=)
g1 + scale_x_continuous(breaks = seq(0,2000,by=200)) +
  scale_y_continuous(breaks = seq(0,300,by=30))

# breaks에 대입되는 값의 개수와 labels에 대입되는 값의 개수가
# 동일해야함.
g1 + scale_x_continuous(breaks = seq(0,2000,by=200),
labels = paste(seq(0,2000,by=200),'세')) +
  scale_y_continuous(breaks = seq(0,300,by=30)) +
  theme(axis.text.x = element_text(colour = 'red',size=10,angle = 90),
        axis.text.y = element_text(colour = 'blue',size=10))

#theme()
#축 axis.text / axis.text.x /axis.text.y
g1 + theme(axis.text = element_text(colour = 'red',size=10))

g1 + theme(axis.text.x = element_text(colour = 'red',size=10))
g1 + theme(axis.text.y = element_text(colour = 'red',size=10))

g1 + theme(axis.text.x = element_text(colour = 'red',size=10)) +
  theme(axis.text.y = element_text(colour = 'blue',size=10))


g1 + theme(axis.text.x = element_text(colour = 'red',size=10),
           axis.text.y = element_text(colour = 'blue',size=10))


# 기본축선
g1 + theme(axis.line = element_line())

#축선 제거
g1 + theme(axis.line = element_blank())

#표식선(ticks) 제거
g1 + theme(axis.ticks= element_blank())

# 축값 제거
g1 + theme(axis.text = element_blank())


###############################################
# 직선 그리기
# 사선 : geom_abline()
# 평행선 : geom_hline()
# 수직선 : geom_vline()

str(economics)

ggplot(economics, aes(date, psavert)) +
  geom_point()

#회귀분석을 통해 직선값을 추출했다고 가정 
# 절편 : 12.18671, 기울기 : -0.0005444


ggplot(economics, aes(date, psavert)) +
  geom_point() +
  geom_abline(intercept = 12.18671, slope=-0.000544)
# 개인 저축율은 날짜가 지남에 따라 0.0005444만큼 감소


# 평행선 : geom_hline(yintercept=)
ggplot(economics, aes(date, psavert)) +
  geom_point() +
  geom_hline(yintercept = mean(economics$psavert))

# 수직선 : geom_vline()
# x축 절편 : xintercept = 
# 개인 저축률이 가장 낮은 날짜에 수직선을 표시

x_inter <- filter(economics, psavert == min(economics$psavert))$date
ggplot(economics, aes(date, psavert)) +
  geom_point() +
  geom_hline(yintercept = mean(economics$psavert)) +
  geom_vline(xintercept = x_inter)
# 날짜를 직접지정하여 수직선 그리기 
# 1980년 1월 1일  : 1980-01-01

ggplot(economics, aes(date, psavert)) +
  geom_point() +
  geom_hline(yintercept = mean(economics$psavert)) +
  geom_vline(xintercept = '1980-01-01')

class(economics$date)
# x축 데이터와 x절편값의 형식이 맞지 않음

# x절편값을 날짜형으로 변경 해서 사용
ggplot(economics, aes(date, psavert)) +
  geom_point() +
  geom_hline(yintercept = mean(economics$psavert)) +
  geom_vline(xintercept =as.Date('1980-01-01'))
