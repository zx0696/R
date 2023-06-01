#mkm0515@naver.com으로 제출

# 아래 패키지 설치
install.packages("ggplot2")
library(ggplot2)

mpg<-as.data.frame(ggplot2::mpg)

# mpg data를 data 프레임 형태로 변환해서 mpg변수 data에 저장
mpg<-as.data.frame(ggplot2::mpg)

# mpg data의 앞부분을 확인한다. (20line 확인)
head(mpg,20)

# mpg data의 뒷부분을 확인한다. (20line 확인)
tail(mpg,20)

# View 창을 통해 전체 data를 확인한다.
View(mpg)

# mpg data의 관측치와 변수의 수(크기)를 한번에 확인한다.
dim(mpg)

# mpg data의 data 속성을 확인해서 전반적인 구조를 본다.
str(mpg)

# mpg data의 요약 통계량을 출력해 본다.
summary(mpg)


# cty 변수는 city로 hwy는 highway로 변수명을 변경한다. (복사본 new_mpg 사용)
new_mpg <- mpg
library(dplyr)
new_mpg <- rename(new_mpg,city=cty,highway=hwy)
head(new_mpg,2)

# city와 highway 변수를 이용해 total이라는 통합연비 변수를 추가한다.
new_mpg$total <- new_mpg$city + new_mpg$highway
head(new_mpg,2)

# total 변수의 요약 통계량을 확인하고 히스토그램을 출력하여 total 변수의 구간별 빈도수를 확인하시오.
summary(new_mpg$total)
hist(new_mpg$total)

# 히스토그램을 확인 해서 빈도수가 높은 구간을 연비의 합격으로 규정하고 해당 구간보다 total 연비가 낮은 자동차는 fail  같거나 높은 자동차는 pass 값을 갖는 test 변수를 추가하시오.
new_mpg$test <- ifelse(new_mpg$total>=40,"pass","fail")

# 추가가 제대로 이루어졌는지 mpg 데이터의 일부를 확인하시오.
head(new_mpg,5)

# 연비 test에 해당하는 빈도표를 생성하시오.
table(new_mpg$test)

# 위 빈도표를 막대그래프로 표현하시오.
barplot(table(new_mpg$test),ylim=c(0,150))

# 위에서 출력한 히스토그램을 확인하여 자동차의 연비를 3 등급으로 분류하시오. 
#해당 분류 기준에 따라 각 자동차를 A,B,C 등급으로 표현하는 greade 변수를 추가하시오.
new_mpg$grade <- ifelse(new_mpg$total>=60,"A",ifelse(new_mpg$total>=40,"B","C"))

# 추가된 내용을 확인하시오
View(head(new_mpg,5))

# grade의 빈도표를 작성하고 해당 빈도표를 이용해 막대 그래프로 빈도를 표현하시오.
grade_fqc <- table(new_mpg$grade)
barplot(grade_fqc,ylim=c(0,120))

# grade를 좀 더 세부적으로 구분하여 A,B,C,D 등급으로 분류하는 grade2 변수를 추가하시오.
new_mpg$grade2 <- ifelse(new_mpg$total>=75,"A",
                         ifelse(new_mpg$total>=50,"B",
                                ifelse(new_mpg$total>=35,"C","D")))


# grade2의 빈도표를 작성하고 해당 빈도표를 이용해 막대 그래프로 빈도를 표현 하시오.
grade2_fqc <- table(new_mpg$grade2)
barplot(grade2_fqc,ylim=c(0,120))

# 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다. 
# displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 
# 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 알아보세요.
# 어떤 함수를 사용할지 생각해서 각 배기량에 따른 고속도로 평균값을 출력하세요
library(dplyr)
mpg<- as.data.frame(ggplot2::mpg)
mpg

displ_low <- mpg %>% filter(displ<5) %>%
  summarise(mean_low=mean(hwy)) %>% 
  select(mean_low)
displ_high <- mpg %>% filter(displ>=5) %>% 
  summarise(mean_high=mean(hwy)) %>% 
  select(mean_high)
mean_displ <- merge(displ_low,displ_high)

# 배기량 4이하인 자동차와 5이상인 자동차의 고속도로 연비 평균을 막대그래프로 표현하여
# 두 값을 비교하세요
barplot(as.matrix(mean_displ),ylim=c(0,25))

# 자동차 제조 회사에 따라 
# 도시 연비가 다른지 알아보려고 합니다. 
# "audi"와 "toyota" 중 
# 어느 manufacturer(자동차 제조 회사)의 cty(도시 연비)가 
# 평균적으로 더 높은지 알아보세요.
mean_audi <- mpg %>% filter(manufacturer %in% 'audi') %>%
  summarise(mean_audi=mean(cty)) %>% 
  select(mean_audi)
mean_toyota <- mpg %>% filter(manufacturer %in% 'toyota') %>%
  summarise(mean_toyota=mean(cty)) %>% 
  select(mean_toyota)
mean_cty <- merge(mean_audi,mean_toyota)
mean_cty

#    mean_audi mean_toyota
# 1  17.61111    18.52941

# "chevrolet", "ford", "honda" 자동차의 
# 고속도로 연비 평균을 알아보려고 합니다. 
# 이 회사들의 자동차를 추출한 뒤 
# hwy 전체 평균을 구해보세요.
mpg %>% filter(manufacturer %in% c("chevrolet","ford","honda")) %>% 
  summarise(mean_hwy=mean(hwy))



# mpg 데이터는 11개 변수로 구성되어 있습니다. 
# 이 중 일부만 추출해서 분석에 활용하려고 합니다.
# mpg 데이터에서 class(자동차 종류), cty(도시 연비) 변수를 추출해 
# 새로운 데이터를 만드세요. 
# 새로 만든 데이터의 일부를 출력해서 
# 두 변수로만 구성되어 있는지 확인하세요.
new_mpg2 <- mpg %>% select(class,cty)
head(new_mpg2,3)

# 자동차 종류에 따라 도시 연비가 다른지 알아보려고 합니다. 
# 앞에서 추출한 데이터를 이용해서 
# class(자동차 종류)가 "suv"인 자동차와 "compact"인 자동차 중 
# 어떤 자동차의 cty(도시 연비)가 더 높은지 알아보세요.
new_mpg2 %>% group_by(class) %>% 
  filter(class=="suv" | class=="compact") %>% 
  summarise(mean_cty=mean(cty)) %>% 
  arrange(desc(mean_cty))

# "audi"에서 생산한 자동차 중에 
# 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 합니다. 
# "audi"에서 생산한 자동차 중 
# hwy가 1~5위에 해당하는 자동차의 데이터를 출력하세요.
mpg %>% filter(manufacturer == "audi") %>% 
  arrange(desc(hwy)) %>% 
  head(5)

#mpg 데이터는 연비를 나타내는 변수가 
# hwy(고속도로 연비), cty(도시 연비) 두 종류로 분리되어 있습니다. 
# 두 변수를 각각 활용하는 대신 
# 하나의 통합 연비 변수를 만들어 분석하려고 합니다. 

# 1.
# mpg 데이터 복사본을 만들고, 
# cty 와 hwy 를 더한 '합산 연비 변수'를 추가하세요. 
mpg <- as.data.frame(ggplot2::mpg)
new_mpg <- mpg

new_mpg$합산연비변수 <- new_mpg$cty + new_mpg$hwy

# 2.
#앞에서 만든 '합산 연비 변수'를 2 로 나눠 
# '평균 연비 변수'를 추가세요.
new_mpg$평균연비변수 <- new_mpg$합산연비변수/2

# 3.
#'평균 연비 변수'가 가장 높은 자동차 3 종의 데이터를 출력하세요. 
new_mpg %>% arrange(desc(평균연비변수)) %>% 
  head(3)



# 위 1~3 번 문제를 해결할 수 있는 
# 하나로 연결된 dplyr 구문을 만들어 출력하세요. 
# 데이터는 복사본 대신 mpg 원본을 이용하세요. 
mpg %>% mutate(합산연비변수=cty+hwy,
               평균연비변수=합산연비변수/2) %>% 
  arrange(desc(평균연비변수)) %>% 
  head(3)


# dplyr 조합하기 
# 회사별로 "suv" 자동차의 도시 및 고속도로 통합 연비 평균을 구해 
# 내림차순으로 정렬하고, 1~5위까지 출력하기
mpg %>% filter(class=="suv") %>% 
  group_by(manufacturer) %>% 
  mutate(sum_ch=cty+hwy) %>%
  summarise(mean_ch=mean(sum_ch)) %>% 
  arrange(desc(mean_ch)) %>% 
  head(5)

# mpg 데이터의 class 는 "suv", "compact" 등 
# 자동차를 특징에 따라 일곱 종류로 분류한 변수입니다.
# 어떤 차종의 연비가 높은지 비교해보려고 합니다. 
# class 별 cty 평균을 구해보세요. 
mpg %>% group_by(class) %>% 
  summarise(mean_cty=mean(cty))


# 앞 문제의 출력 결과는
# class 값 알파벳 순으로 정렬되어 있습니다. 
# 어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록 
# cty 평균이 높은 순으로 정렬해 출력하세요. 
mpg %>% group_by(class) %>% 
  summarise(mean_cty=mean(cty)) %>% 
  arrange(desc(mean_cty))

# 어떤 회사 자동차의 hwy(고속도로 연비)가 
# 가장 높은지 알아보려고 합니다. 
# hwy 평균이 가장 높은 회사 세 곳을 출력하세요.
mpg %>% group_by(manufacturer) %>% 
  summarise(sum_hwy=sum(hwy)) %>% 
  arrange(desc(sum_hwy)) %>% 
  head(3) %>% 
  select(manufacturer)

# 어떤 회사에서 "compact"(경차) 차종을 
# 가장 많이 생산하는지 알아보려고 합니다. 
# 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.
mpg %>% group_by(manufacturer, model) %>% 
  filter(class=="compact") %>% 
  summarise(cnt_compact=n()) %>% 
  arrange(desc(cnt_compact))

# mpg 데이터의 fl 변수는 
# 자동차에 사용하는 연료(fuel)를 의미합니다. 
# 아래는 자동차 연료별 가격을 나타낸 표입니다. 
# 우선 이 정보를 이용해서 연료와 가격으로 구성된 
# 데이터 프레임을 만들어 보세요. 





# mpg 데이터에는 연료 종류를 나타낸 fl 변수는 있지만 
# 연료 가격을 나타낸 변수는 없습니다. 
# 위에서 만든 fuel 데이터를 이용해서 
# mpg 데이터에 price_fl(연료 가격) 변수를 추가하세요



# 연료 가격 변수가 잘 추가됐는지 확인하기 위해서 
# model, fl, price_fl 변수를 추출해 
# 앞부분 5 행을 출력해 보세요. 







