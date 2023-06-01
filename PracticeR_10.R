#######################################################################
# ggplot 연습문제2
#######################################################################
library(ggplot2)
library(MASS)
library(scales)

# 1. Cars93을 이용해 아래와 같은 그래프를 그리시오.
# geom_point(shape=15,size=3,colour='blue')

ggplot(Cars93,
       aes(EngineSize,MPG.highway)) +
  geom_point(shape=15,size=3,colour='blue')

# 2. Cars93을 이용해 아래와 같은 그래프를 그리시오.
# geom_point(shape=19,...)

ggplot(Cars93,
       aes(EngineSize,MPG.highway)) +
  geom_point(shape=19,color='red')

# 3. Cars93을 이용해 아래와 같은 그래프를 그리시오.
# geom_point(shape=24,...)

ggplot(Cars93,
       aes(EngineSize,MPG.highway)) +
  geom_point(shape=24) +
  ggtitle("Scatter Plot: MPG.highway vs Length") +
  theme(plot.title=element_text(hjust=0.5))

# 4. Cars93을 이용해 아래와 같은 그래프를 그리시오.
# aes(...,colour=Type)

ggplot(Cars93,
       aes(EngineSize,MPG.highway)) +
  geom_point(aes(EngineSize,MPG.highway,colour=Type)) +
  ggtitle("Scatter Plot by Type, using different Colours") +
  theme(plot.title=element_text(hjust=0.5))

# 5. Cars93을 이용해 아래와 같은 그래프를 그리시오.
# aes(...,shape=Type)

ggplot(Cars93,
       aes(EngineSize,MPG.highway)) +
  geom_point(aes(EngineSize,MPG.highway,shape=Type)) +
  ggtitle("Scatter Plot by Type, using different Colours") +
  theme(plot.title=element_text(hjust=0.5))

# 6. BOD 테이블을 이용해 아래와 같은 그래프를 그리시오.
BOD

ggplot(BOD,aes(Time,demand)) +
  geom_line() +
  ylim(c(0,20))

# 7. 선 그래프에 점을 추가하여 아래와 같이 그리시오.

ggplot(BOD,aes(Time,demand)) +
  geom_line() +
  geom_point(size=5,color='red')

# 8. demand 값에 따라 점의 크기를 다르게 설정하시오.

ggplot(BOD,aes(Time,demand)) +
  geom_line() +
  geom_point(aes(size=demand),color='violet') +
  labs(x='시간',
       y='평균 요구건수(개)')
  
# 9. geom_line(linetype='dashed',size=1,colour='blue')로 설정하시오.

ggplot(BOD,aes(Time,demand)) +
  geom_line(linetype='dashed',size=1,colour='blue')

# 10. geom_point(size=4,shape=22,colour='darkred',fill='pink')로 설정하시오.

ggplot(BOD,aes(Time,demand)) +
  geom_line() + 
  geom_point(size=4,shape=22,colour='darkred',fill='pink')

# 11. 다음과 같은 내용의 tg 데이터프레임을 생성하시오.
# color=supp 설정을 한 후 선 그래프를 그리시오.

supp <- c("OJ","OJ","OJ","VC","VC","VC")
dose <- c(0.5,1.0,2.0,0.5,1.0,2.0)
length <- c(13.23,22.70,26.06,7.98,16.77,26.14)
tg <- data.frame(supp,dose,length)

ggplot(tg,aes(dose,length)) +
  geom_line(aes(color=supp))

ggplot(tg,aes(dose,length)) +
  geom_line(aes(linetype=supp))

# 12. shape=supp 설정을 한 후 선과 점 그래프를 그리시오.
ggplot(tg,aes(dose,length,fill=supp)) +
  geom_line() +
  geom_point(aes(shape=supp),size=4)

ggplot(tg,aes(dose,length,fill=supp)) +
  geom_line() +
  geom_point(size=4,shape=21)

# 16. 앞의 BOD 데이터를 이용해 다음과 같이 그리시오.

ggplot(BOD,aes(Time,demand)) +
  geom_line() +
  geom_area()

ggplot(BOD,aes(Time,demand)) +
  geom_line(color='pink',size=2) +
  geom_area(alpha=0.5,fill='pink')
  
# 17. tg데이터를 이용해 다음과 같이 그리시오.
ex_supp <- factor(tg$supp,level=c('VC','OJ'))

ggplot(tg,aes(dose,length,fill=supp)) +
  geom_line() +
  geom_area(aes(fill=ex_supp))
