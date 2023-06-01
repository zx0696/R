View(mpg) #자동차관련 데이터 셋
View(midwest) #미국 지역별 인구 통계 정보
midwest$poptotal #미국 전체 인구
midwest$popasian #미국 지역별 아시아인 수


#Q1. mpg 데이터를 이용해 자동차의 도시연비와 고속도로 연비의 관계를 산점도로 표현하시오
ggplot(mpg,aes(cty,hwy)) + geom_point()


#Q2.midwest 데이터를 이용해 지역 인구와 각 지역의 아시아인수의 관계를 산점도로 표현하시오

# 단 전체인구는 50만명 이하까지만 표현하고 아시아인수는 1만명 이하까지 표현
midwest %>% 
  filter(poptotal<=500000 & popasian<=10000) %>% 
  ggplot(aes(poptotal,popasian)) +
  geom_point()

#Q3. mpg 데이터에서 suv 차량의 도시연비 평균이 높은 상위 5개의 제조사들의 
# 평균 도시연비를 막대그래프로 표현하여 비교하시오. 단 도시연비평균이 높은
# 제조사순으로 그래프를 표현할 것
mpg %>% 
  filter(class=="suv") %>%
  group_by(manufacturer) %>% 
  summarise(avg_cty=mean(cty)) %>% 
  arrange(desc(avg_cty)) %>% 
  head(5) %>% 
  ggplot(aes(reorder(manufacturer,-avg_cty),avg_cty)) +
  geom_bar(stat='identity')



#Q4. mpg 데이터를 이용해 자동차의 클래스별 빈도막대그래프를 표현해 자동차 클래스 차이를 비교하시오.
mpg %>% 
  ggplot(aes(class)) + geom_bar()

#==========================
# economics 데이터 사용

#Q5. 날짜별 개인저축률의 추세를 그래프로 확인하시오.
ggplot(economics,aes(date,psavert)) + geom_line()

#Q6. mpg 데이터에서 "compact","subcompact","suv" 3 종류의 class에 해당하는
# 자동차들의 도시연비 분포를 boxplot으로 비교 확인하시오.
mpg %>%
  filter(class==c("compact","subcompact","suv")) %>%
  ggplot(aes(model,cty)) +
  geom_boxplot()
