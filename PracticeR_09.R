#########################################
# ggplot2 연습문제 1
#########################################
library(ggplot2)
library(dplyr)

# 1. 아래 BOD 테이블을 생성하고 ggplot()을 이용해 그래프 2개를 그리시오.
BOD

ggplot(BOD,aes(Time,demand)) + geom_col()
ggplot(BOD,aes(factor(Time),demand)) + geom_col()

# 2. 앞의 그래프에서 막대의 선을 파랑, 채우기를 노랑으로 설정하시오.
ggplot(BOD,aes(factor(Time),demand)) + geom_col(color='blue',fill='yellow')

# 3. 앞의 그래프에서 막대의 선을 노랑, 채우기를 보라로 설정하시오.
ggplot(BOD,aes(factor(Time),demand)) + geom_col(color='yellow',fill='purple')

# 4. 다음과 같이 cabbage_exp.txt 문서를 만드시오.
  # position="dodge"

# 5. 파일을 읽어 아래와 같은 그래프를 작성하시오.
cabbage <- read.table('data/cabbage_exp.txt',header=T,sep=",")
ggplot(cabbage,aes(Date,Weight,fill=Cultivar)) + geom_bar(stat='identity',position='dodge')
# 그래프의 범례 순서, 그래프의 요소항목 순서를 변경하고, 범례 제목, x축 제목을 변경하시오.

factor(cabbage$Date, level=c('d21','d20','d16'))
# [1] <NA> <NA> <NA> <NA> <NA> <NA>
# Levels: d21 d20 d16
# factor 변경 후 level 바꿨는데 NA가 나오는 경우, level을 명시할 때 실제 data와 다른 data를 명시한 것
# data 앞에 공백이 있어서 생기는 문제
factor(cabbage$Date, level=c(' d21',' d20',' d16'))

ggplot(cabbage,
       aes(factor(Date,level=c(' d21',' d20',' d16')),
           Weight,
           fill=factor(Cultivar,level=c('c52','c39')))) +
  geom_bar(stat='identity',position='dodge') +
  labs(x="Date",fill='Cultivar')

# 6. 앞의 자료에 팔레트를 추가하여 색상을 변경하시오.
# 팔레트 : Pastel1
ggplot(cabbage,
       aes(Date,Weight,fill=Cultivar)) +
  geom_bar(stat='identity',position='dodge',color='black') +
  scale_fill_brewer(palette="Pastel1") +
  labs(x="Date",fill='Cultivar')

# 팔레트 : Accent
ggplot(cabbage,
       aes(Date,Weight,fill=Cultivar)) +
  geom_bar(stat='identity',position='dodge',color='black') +
  scale_fill_brewer(palette="Accent") +
  labs(x="Date",fill='Cultivar')

# 7. 다음과 같이 누적그래프를 그리고 범례의 순서도 바꾸시오.
ggplot(cabbage,
       aes(factor(Date),
           Weight,
           fill=factor(Cultivar,level=c('c52','c39')))) +
  geom_bar(stat='identity') +
  labs(x="Date",fill='Cultivar')

# 8. 7번 오른쪽 그래프의 막대 중앙에 수치를 표시하시오.
ggplot(cabbage,
       aes(factor(Date),
           Weight,
           fill=factor(Cultivar,level=c('c52','c39')))) +
  geom_bar(stat='identity') +
  geom_text(aes(label=Weight),
            position=position_stack(vjust=0.5)) +
  labs(x="Date",fill='Cultivar')

# 9. "MASS" 패키지를 인스톨하고 Cars93 테이블을 이용해 아래 그래프를 그리시오.
# (x축은 Type 열로, y축은 설정하지 않음)
# 제목: ggtitle() 함수 사용
library(MASS)
View(Cars93)

ggplot(Cars93,aes(Type)) +
  geom_bar(fill='white',
           color='black') +
  ggtitle("Bar Chart of Frequency by Car Type") +
  theme(plot.title=element_text(face='bold',
                                hjust=0.5,
                                color='red'))

# 10. Cars93 테이블을 이용해 자동차 타입별 원산지 수를 아래와 같이 그리시오. (fill 추가)
# palette='Blues' 적용

ggplot(Cars93,aes(Type,fill=Origin)) +
  geom_bar(position='dodge',color='black') +
  ggtitle("Bar Chart of Frequency by Car Type") +
  theme(plot.title=element_text(hjust=0.5,
                                color='black')) +
  scale_fill_brewer(palette="Blues")
