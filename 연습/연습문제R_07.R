#########################################
# RESHAPE 연습문제
#########################################
library(reshape2)

# 1
baseball <- read.csv("data/baseball.csv")
baseball
baseball_w <- dcast(baseball,month ~ pytpe)
baseball_w

# 2
unemploy_age <- read.csv("data/2000-2013년 연령별실업율_연령별평균.csv")

unemploy_age_l <- melt(unemploy_age,id.vars="연령별",
                       variable.name="년도",
                       value.name="실업율")
unemploy_age_w <- dcast(unemploy_age_l,년도~연령별)

# 3
library(MASS)
Cars93
# Type(자동차 종류)이 Compact(경차)와 van(밴)만 추출
# 변수명으로는 자동차종류, 생산지, 도시연비, 고속도로연비만 추출
# Type, Origin, MPG.city, MPG.highway

car_wide <- subset(Cars93,
                   select=c(Type,Origin,MPG.city,MPG.highway),
                   subset=(Type %in% c("Compact","Van")))
car_long <- melt(car_wide,id.vars=c("Type","Origin"))


# 4
##=== lines
library(reshape2)
        
subway_line <- read.csv("data/1-4호선승하차승객수.csv")

View(subway_line)

subway_line_dcast_up <- melt(subway_line, id.vars=c("시간","노선번호"),
                             measure.vars="승차")
subway_line_dcast_up <- dcast(subway_line_dcast_up,시간~노선번호)
View(subway_line_dcast_up)

subway_line_dcast_down <- melt(subway_line, id.vars=c("시간","노선번호"),
                             measure.vars="하차")
subway_line_dcast_down <- dcast(subway_line_dcast_down,시간~노선번호)
View(subway_line_dcast_down)

# 강사님 풀이
sub_line <- read.csv('data/1-4호선승하차승객수.csv')
temp <- melt(sub_line, id.vars=c("시간","노선번호"),
             measure.vars="승차")
subway_line_dcast_up <- dcast(temp,시간~노선번호)
View(subway_line_dcast_up)
temp <- melt(sub_line, id.vars=c("시간","노선번호"),
             measure.vars="하차")
subway_line_dcast_down <- dcast(temp,시간~노선번호)
View(subway_line_dcast_down)

library(ggplot2)

# 앞에서 재구성한 data를 이용하여 각 지하철 라인에 대하여 승차 및 하차 인원의 변화를 확인할 수 있는 그래프를 작성한다.
# 각 라인에 대해 승차변화/하차변화를 확인할 수 있어야 하고
# 그래프 형식은 임의로 설정하고 가급적 전달력이 높게 그래프를 여러 형태로 작성

ggplot(subway_line) + geom_bar(aes(factor(시간),승차,fill=노선번호),stat='identity',position='dodge') +
  geom_line(aes(factor(시간),하차,color=노선번호),stat='identity')

ggplot() + geom_bar(subway_line_dcast_up,mapping=aes(시간,line_1,fill=line_1),stat='identity',position='dodge') +
  geom_line(subway_line_dcast_down,mapping=aes(시간,line_1,color='red'),stat='identity')

ggplot() + geom_bar(subway_line_dcast_up,mapping=aes(시간,line_2,fill=line_2),stat='identity',position='dodge') +
  geom_line(subway_line_dcast_down,mapping=aes(시간,line_2,color='red'),stat='identity')

ggplot() + geom_bar(subway_line_dcast_up,mapping=aes(시간,line_3,fill=line_3),stat='identity',position='dodge') +
  geom_line(subway_line_dcast_down,mapping=aes(시간,line_3,color='red'),stat='identity')

ggplot() + geom_bar(subway_line_dcast_up,mapping=aes(시간,line_4,fill=line_4),stat='identity',position='dodge') +
  geom_line(subway_line_dcast_down,mapping=aes(시간,line_4,color='red'),stat='identity')

# 강사님 풀이