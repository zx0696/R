#mkm0515@naver.com으로 제출

# 아래 패키지 설치
install.packages("ggplot2")
library(ggplot2)

# 패키지명::데이터명 -> 패키지내에 저장되어 있는 데이터를 불러온다
mpg<-as.data.frame(ggplot2::mpg)

# mpg data를 data 프레임 형태로 변환해서 mpg변수 data에 저장
mpg<-as.data.frame(ggplot2::mpg)
View(mpg)
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
library(dplyr)
new_mpg <- rename(mpg, city=cty, highway=hwy)
head(new_mpg,2)

# city와 highway 변수를 이용해 total이라는 통합연비 변수를 추가한다.
new_mpg <- new_mpg %>% mutate(total=(city+highway)/2)
head(new_mpg,2)


# total 변수의 요약 통계량을 확인하고 히스토그램을 출력하여 total 변수의 구간별 빈도수를 확인하시오.
summary(new_mpg$total)
hist(new_mpg$total)

# 히스토그램을 확인 해서 빈도수가 높은 구간을 연비의 합격으로 규정하고 해당 구간보다 
# total 연비가 낮은 자동차는 fail  같거나 높은 자동차는 pass 값을 갖는 test 변수를 추가하시오.

new_mpg$test <- ifelse(new_mpg$total >=20,'pass','fail')


# 추가가 제대로 이루어졌는지 mpg 데이터의 일부를 확인하시오.
head(new_mpg,2)

# 연비 test에 해당하는 빈도표를 생성하시오.
library(descr)
t1 <- table(new_mpg$test)
freq(new_mpg$test)
# 위 빈도표를 막대그래프로 표현하시오.
barplot(t1,
        ylim=c(0,140))


# 위에서 출력한 히스토그램을 확인하여 자동차의 
# 연비를 3 등급으로 분류하시오. 
# 해당 분류 기준에 따라 각 자동차를 A,B,C 등급으로 표현하는 
# greade 변수를 추가하시오.
new_mpg <- new_mpg %>%  mutate(grade = ifelse(total >= 25,'A',
                                   ifelse(total >= 20,'B','C')))

# 추가된 내용을 확인하시오
View(head(new_mpg,5))

# grade의 빈도표를 작성하고 해당 빈도표를 이용해 막대 그래프로 빈도를 표현하시오.
freq(new_mpg$grade)



# grade를 좀 더 세부적으로 구분하여 A,B,C,D 등급으로 분류하는 grade2 변수를 추가하시오.
new_mpg <- new_mpg %>%  mutate(grade2 = ifelse(total >= 30,'A',
                                              ifelse(total >= 20,'B',
                                                     ifelse(total>=15,"C","D"))))
View(new_mpg)
# grade2의 빈도표를 작성하고 해당 빈도표를 이용해 막대 그래프로 빈도를 표현 하시오.
g2 <- table(new_mpg$grade2)
g2
barplot(g2,
        ylim=c(0,120))


# 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다. 
# displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 
# 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 알아보세요.
# 어떤 함수를 사용할지 생각해서 각 배기량에 따른 고속도로 평균값을 출력하세요
library(dplyr)
mpg<- as.data.frame(ggplot2::mpg)

# 배기량 5미만인 자동차와 5이상인 자동차의 고속도로 연비 평균을 막대그래프로 표현하여
# 두 값을 비교하세요
mpg_a <- mpg %>% filter(displ >= 5)
mpg_b <- mpg %>% filter(displ < 5)

mean(mpg_a$hwy)
mean(mpg_b$hwy)

mpg_a <- mpg %>% filter(displ >= 5) %>%  summarise(mean_5 = mean(hwy))
mpg_b <- mpg %>% filter(displ < 5) %>% summarise(mean_less_5=mean(hwy))
class(mpg_a)

mpg_displ <- cbind(mpg_a, mpg_b)
mpg_displ

barplot(as.matrix(mpg_displ), ylim=c(0,25))
# 배기량이 적은 자동차의 평균 고속도로 연비가 더 좋다

# 자동차 제조 회사에 따라 
# 도시 연비가 다른지 알아보려고 합니다. 
# "audi"와 "toyota" 중 
# 어느 manufacturer(자동차 제조 회사)의 cty(도시 연비)가 
# 평균적으로 더 높은지 알아보세요.
mpg_audi <- mpg %>% 
  filter(manufacturer =="audi") %>% 
  summarise(mean_audi=mean(cty))

mpg_toyota <- mpg %>% 
  filter(manufacturer=='toyota') %>% 
  summarise(mean_to =mean(cty) )

res <- cbind(mpg_audi,mpg_toyota)
res
barplot(as.matrix(res),ylim=c(0,20))

#    mean_audi mean_toyota
# 1  17.61111    18.52941

# "chevrolet", "ford", "honda" 자동차의 
# 고속도로 연비 평균을 알아보려고 합니다. 
# 이 회사들의 자동차를 추출한 뒤 
# hwy 전체 평균을 구해보세요.

mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda")) %>% 
  summarise(avg_hwy=mean(hwy))



# mpg 데이터는 11개 변수로 구성되어 있습니다. 
# 이 중 일부만 추출해서 분석에 활용하려고 합니다.
# mpg 데이터에서 class(자동차 종류), cty(도시 연비) 변수를 추출해 
# 새로운 데이터를 만드세요. 
# 새로 만든 데이터의 일부를 출력해서 
# 두 변수로만 구성되어 있는지 확인하세요.

new_df <- mpg %>% select(class,cty)
head(new_df)


# 자동차 종류에 따라 도시 연비가 다른지 알아보려고 합니다. 
# 앞에서 추출한 데이터를 이용해서 
# class(자동차 종류)가 "suv"인 자동차와 "compact"인 자동차 중 
# 어떤 자동차의 cty(도시 연비)가 더 높은지 알아보세요.

s <- new_df %>%  filter(class=="suv") %>%  summarise(suv_mean = mean(cty))
c <- new_df %>%  filter(class=="compact") %>%  summarise(comp_mean=mean(cty))
cbind(s,c)

# "audi"에서 생산한 자동차 중에 
# 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 합니다. 
# "audi"에서 생산한 자동차 중 
# hwy가 1~5위에 해당하는 자동차의 데이터를 출력하세요.

mpg %>%  filter(manufacturer=='audi') %>% 
  arrange(desc(hwy)) %>% head(5)



#mpg 데이터는 연비를 나타내는 변수가 
# hwy(고속도로 연비), cty(도시 연비) 두 종류로 분리되어 있습니다. 
# 두 변수를 각각 활용하는 대신 
# 하나의 통합 연비 변수를 만들어 분석하려고 합니다. 

# 1.
# mpg 데이터 복사본을 만들고, 
# cty 와 hwy 를 더한 '합산 연비 변수'를 추가하세요. 
mpg <- as.data.frame(ggplot2::mpg)
new_mpg <- mpg

new_mpg <- new_mpg %>%  mutate(합산연비 = cty+hwy)

# 2.
#앞에서 만든 '합산 연비 변수'를 2 로 나눠 
# '평균 연비 변수'를 추가세요.
new_mpg <- new_mpg %>%  mutate(평균연비 = 합산연비/2)


new_mpg <- new_mpg %>%  mutate( 합산연비 = cty+hwy,
                                평균연비 = 합산연비/2)
head(new_mpg)
# 3.
#'평균 연비 변수'가 가장 높은 자동차 3 종의 데이터를 출력하세요. 
new_mpg %>% 
  arrange(desc(평균연비)) %>% 
  head(3)



# 위 1~3 번 문제를 해결할 수 있는 
# 하나로 연결된 dplyr 구문을 만들어 출력하세요. 
# 데이터는 복사본 대신 mpg 원본을 이용하세요. 
mpg %>%  mutate( 합산연비 = cty+hwy,
                  평균연비 = 합산연비/2)  %>% 
         arrange(desc(평균연비)) %>% head(3) %>% select(manufacturer,model,평균연비)


# dplyr 조합하기 
# 회사별로 "suv" 자동차의 도시 및 고속도로 통합 연비 평균을 구해 
# 내림차순으로 정렬하고, 1~5위까지 출력하기
mpg %>% group_by(manufacturer) %>% #회사별로
  filter(class=='suv') %>% #suv 자동차의
  mutate(tot=(cty+hwy)/2) %>%  # 통합연비 변수 생성
  summarise(mean_tot=mean(tot)) %>% # 제조사별 suv 통합연비의 평균 산출
  arrange(desc(mean_tot)) %>% # 산출된 연비 평균으로 내림차순 정렬
  head(5) # 상위5개 정보 출력


# mpg 데이터의 class 는 "suv", "compact" 등 
# 자동차를 특징에 따라 일곱 종류로 분류한 변수입니다.
# 어떤 차종의 연비가 높은지 비교해보려고 합니다. 
# class 별 cty 평균을 구해보세요. 
mpg %>% group_by(class) %>% 
  summarise(mean_class_cty = mean(cty))


# 앞 문제의 출력 결과는
# class 값 알파벳 순으로 정렬되어 있습니다. 
# 어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록 
# cty 평균이 높은 순으로 정렬해 출력하세요. 

mpg %>% group_by(class) %>% 
  summarise(mean_class_cty = mean(cty)) %>% 
  arrange(desc(mean_class_cty))


# 어떤 회사 자동차의 hwy(고속도로 연비)가 
# 가장 높은지 알아보려고 합니다. 
# hwy 평균이 가장 높은 회사 세 곳을 출력하세요.
mpg %>% group_by(manufacturer) %>% 
  summarise(hwy_mean=mean(hwy)) %>% 
  arrange(desc(hwy_mean)) %>% 
  head(3) %>% select(manufacturer)


# 어떤 회사에서 "compact"(경차) 차종을 
# 가장 많이 생산하는지 알아보려고 합니다. 
# 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.
mpg %>% filter(class=='compact') %>%  #compact 추출
  group_by(manufacturer) %>%  #제조사별로 그룹
  summarise(count=n()) %>% # 제조사별 빈도
  arrange(desc(count)) %>% head(1) %>% select(manufacturer)



# mpg 데이터의 fl 변수는 
# 자동차에 사용하는 연료(fuel)를 의미합니다. 
# 아래는 자동차 연료별 가격을 나타낸 표입니다. 
# 우선 이 정보를 이용해서 연료와 가격으로 구성된 
# 데이터 프레임을 만들어 보세요. 
#   fl   price_fl
# 1  c     2.35
# 2  d     2.38
# 3  e     2.11
# 4  p     2.76
# 5  r     2.22
fuel <- data.frame(fl=c('c','d','e','p','r'),
                   price_fl=c(2.35,2.38,2.11,2.76,2.22))
View(fuel)

View(mpg)

# mpg 데이터에는 연료 종류를 나타낸 fl 변수는 있지만 
# 연료 가격을 나타낸 변수는 없습니다. 
# 위에서 만든 fuel 데이터를 이용해서 
# mpg 데이터에 price_fl(연료 가격) 변수를 추가하세요
mpg <- left_join(mpg, fuel, by='fl')


# 연료 가격 변수가 잘 추가됐는지 확인하기 위해서 
# model, fl, price_fl 변수를 추출해 
# 앞부분 5 행을 출력해 보세요. 
mpg %>% select(model, fl, price_fl) %>% head(5)






