View(mpg) #자동차관련 데이터 셋
View(midwest) #미국 지역별 인구 통계 정보
midwest$poptotal #미국 전체 인구
midwest$popasian #미국 지역별 아시아인 수

library(ggplot2)

#Q1. mpg 데이터를 이용해 자동차의 도시연비와 고속도로 연비의 관계를 산점도로 표현하시오
ggplot(data=mpg,aes(x=cty,y=hwy)) + geom_point()


#Q2.midwest 데이터를 이용해 지역 인구와 각 지역의 아시아인수의 관계를 산점도로 표현하시오

# 단 전체인구는 50만명 이하까지만 표현하고 아시아인수는 1만명 이하까지 표현
ggplot(data=midwest,aes(x=poptotal,y=popasian)) +
  geom_point() +
  xlim(0,500000) +
  ylim(0,10000)

#Q3. mpg 데이터에서 suv 차량의 도시연비 평균이 높은 상위 5개의 제조사들의 
# 평균 도시연비를 막대그래프로 표현하여 비교하시오. 단 도시연비평균이 높은
# 제조사순으로 그래프를 표현할 것
library(dplyr)

# reorder(정렬할 값, 정렬기준)
mpg %>% 
  filter(class=='suv') %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty=mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5) %>% 
  ggplot(aes(x=reorder(manufacturer,-mean_cty),
             y=mean_cty)) +
  geom_col()



#Q4. mpg 데이터를 이용해 자동차의 클래스별 빈도막대그래프를 표현해 자동차 클래스 차이를 비교하시오.
ggplot(data=mpg,aes(x=class)) + geom_bar()

#==========================
# economics 데이터 사용

#Q5. 날짜별 개인저축률의 추세를 그래프로 확인하시오.


#Q6. mpg 데이터에서 "compact","subcompact","suv" 3 종류의 class에 해당하는
# 자동차들의 도시연비 분포를 boxplot으로 비교 확인하시오.
mpg %>% 
  filter(class %in% c("compact","subcompact","suv")) %>% 
  ggplot(aes(x=class,y=cty)) +
  geom_boxplot()
