# A/B테스트 수행
# 임의로 나눈 둘 이상의 집단에 서로 다른 컨텐츠 제시한 뒤 가설검정을 이용하여 어느 컨텐츠에 대한 반응이 효과적인지를 파악

# 데이터  AB테스트 폴더내에 있는 데이터를 활용
setwd('통계')
library(readxl)
library(dplyr)
library(reshape2)
library(ggplot2)
library(car)
library(lubridate)

btn_type <- read_xlsx('data/AB테스트/구매여부_버튼타입_통계.xlsx')

SM_A <- read.csv('data/AB테스트/사이트맵_A.csv',header=T)
SM_B <- read.csv('data/AB테스트/사이트맵_B.csv',header=T)
SM_C <- read.csv('data/AB테스트/사이트맵_C.csv',header=T)

PA_A <- read.csv('data/AB테스트/상품배치_A.csv',header=T)
PA_B <- read.csv('data/AB테스트/상품배치_B.csv',header=T)
PA_C <- read.csv('data/AB테스트/상품배치_C.csv',header=T)

days_con <- read.csv('data/AB테스트/일별현황데이터.csv',header=T)
stay_cost <- read.csv('data/AB테스트/체류시간_구매금액.csv',header=T)
sale_ef <- read.csv('data/AB테스트/할인쿠폰발행효과.csv',header=T)

# 주어진 데이터는 쇼핑몰 사이트에서 회원들을 집단으로 나누어 서로 다른 구성을 노출시킨 후 결과를 관측한 데이터 입니다.
# 이 데이터를 기준으로 해서 개별 시각화 및 분석 작업을 진행한 후 해당 코드를 평가사이트 수행평가에 제출하시기 바랍니다.

# 문제 상황
# -온라인 쇼핑몰 페이지 구성에 따른 다양한 실험 결과를 바탕으로 전환율이 최대가 되는 구성을 찾는다
# 
# 현황 파악
View(days_con)

# 구매자수, 방문자수, 총판매금에 대한 기술 통계

# 일자별 방문자수 추이 파악
summary(days_con$방문자수)

# 일자별 구매자수 추이 파악
summary(days_con$구매자수)

# 일자별 총 판매 금액 추이 파악 등등
summary(days_con$총.판매.금액)

# 방문자수와 총판매금액의 관계 : 상관이 없다.
ggplot(days_con,aes(방문자수,총.판매.금액)) +
  geom_point() +
  ggtitle('방문자수와 총판매금액의 관계') +
  xlab('방문자수') +
  ylab('총판매금액') +
  theme(plot.title=element_text(face='bold',
                                size=20,
                                hjust=0.5,
                                color='darkgreen'))

# 구매자수와 총판매금액의 관계 : 강한 양의상관을 보인다.
ggplot(days_con,aes(구매자수,총.판매.금액)) +
  geom_point() +
  ggtitle('구매자수와 총판매금액의 관계') +
  xlab('구매자수') +
  ylab('총판매금액') +
  theme(plot.title=element_text(face='bold',
                                size=20,
                                hjust=0.5,
                                color='darkgreen'))

# 방문자수와 구매자수의 관계 : 상관이 없다.
ggplot(days_con,aes(방문자수,구매자수)) +
  geom_point() +
  ggtitle('방문자수와 구매자수의 관계') +
  xlab('방문자수') +
  ylab('구매자수') +
  theme(plot.title=element_text(face='bold',
                                size=20,
                                hjust=0.5,
                                color='darkgreen'))


############################################################
# 분석 예시 - 아래 내용을 참고해서 각자 데이터를 활용한 분석 및 시각화를 진행해 보세요

#------------------------------------------------------------------------------
# 상품배치와 상품 구매 금액에 따른 관계 분석

summary(PA_A$구매금액)
summary(PA_B$구매금액)
summary(PA_C$구매금액)

length(PA_A$구매금액) # 198
length(PA_A$구매금액[PA_A$구매금액==0]) # 96
length(PA_B$구매금액) # 160
length(PA_B$구매금액[PA_B$구매금액==0]) # 92
length(PA_C$구매금액) # 148
length(PA_C$구매금액[PA_C$구매금액==0]) # 89

# 구매금액 중 0이 차지하는 비율이 너무 크기 때문에 0을 제외하고 진행
PA_A_rmz <- PA_A[PA_A$구매금액 > 0,]
PA_B_rmz <- PA_B[PA_B$구매금액 > 0,]
PA_C_rmz <- PA_C[PA_C$구매금액 > 0,]

summary(PA_A_rmz$구매금액)
  #  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  # 16556   19413   20063   19988   20662   22338 
summary(PA_B_rmz$구매금액)
  #  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  # 15673   17444   18128   18105   18870   20944
summary(PA_C_rmz$구매금액)
  #  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  # 17275   19431   20273   20055   20711   22352

boxplot(PA_A_rmz$구매금액,PA_B_rmz$구매금액,
        PA_C_rmz$구매금액,col=c('red','blue','green'),
        main='상품배치와 구매금액',xlab='배치',ylab='구매금액',
        names=c('A','B','C'))

#### 상품 배치에 따른 상품 구매 금액 평균 차이 분석

PA_A_rmz$배치 <- "A"
PA_B_rmz$배치 <- "B"
PA_C_rmz$배치 <- "C"

# 정규성 검정 - 정규성을 가정
shapiro.test(PA_A_rmz[,2])
  #         Shapiro-Wilk normality test
  # 
  # data:  PA_A_rmz[, 2]
  # W = 0.98737, p-value = 0.4481
shapiro.test(PA_B_rmz[,2])
  #         Shapiro-Wilk normality test
  # 
  # data:  PA_B_rmz[, 2]
  # W = 0.98884, p-value = 0.8067
shapiro.test(PA_C_rmz[,2])
  #         Shapiro-Wilk normality test
  # 
  # data:  PA_C_rmz[, 2]
  # W = 0.96113, p-value = 0.05686

PA_all <- rbind(PA_A_rmz,PA_B_rmz,PA_C_rmz)

# 등분산성검정 - 배치 A,B,C는 등분산성을 갖는다고 가정할 수 있다.
leveneTest(y=PA_all$구매금액,as.factor(PA_all$배치))
  # Levene's Test for Homogeneity of Variance (center = median)
  #        Df F value Pr(>F)
  # group   2  0.0127 0.9874
  #       226  

# 일원분산분석 : A,B,C 각 배치의 구매금액 평균은 유의한 차이가 있다.
PA_aov <- aov(구매금액~as.factor(배치),data=PA_all)
summary(PA_aov)
  #                  Df    Sum Sq  Mean Sq F value Pr(>F)    
  # as.factor(배치)   2 174146444 87073222   76.88 <2e-16 ***
  # Residuals       226 255958061  1132558                   
  # ---
  # Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# TukeyHSD
compare_PA <- TukeyHSD(PA_aov)
  # Tukey multiple comparisons of means
  # 95% family-wise confidence level
  # 
  # Fit: aov(formula = 구매금액 ~ as.factor(배치), data = PA_all)
  # 
  # $`as.factor(배치)`
  #            diff        lwr        upr     p adj
  # B-A -1883.17647 -2276.2519 -1490.1010 0.0000000
  # C-A    66.79462  -343.8753   477.4645 0.9220762
  # C-B  1949.97109  1503.2593  2396.6829 0.0000000
plot(compare_PA,col="darkblue",las=1)
# 상품배치 B와 A,C는 평균판매금액의 차이가 있다.

#### 구매여부와 상품배치 간 독립성 파악

PA_A1 <- as.data.frame(PA_A$구매금액)
PA_A1$배치 <- "A"
names(PA_A1) <- c('구매금액','배치')
PA_B1 <- as.data.frame(PA_B$구매금액)
PA_B1$배치 <- "B"
names(PA_B1) <- c('구매금액','배치')
PA_C1 <- as.data.frame(PA_C$구매금액)
PA_C1$배치 <- "C"
names(PA_C1) <- c('구매금액','배치')

PA_all1 <- rbind(PA_A1,PA_B1,PA_C1)

PA_all1 <- PA_all1 %>% 
  mutate('구매여부'=ifelse(구매금액==0,'미구매','구매')) %>% 
  select(-구매금액)

PA_tbl <- table(PA_all1)

# 독립성검정
chisq.test(PA_tbl,correct=FALSE)
  #         Pearson's Chi-squared test
  # 
  # data:  PA_tbl
  # X-squared = 5.3578, df = 2, p-value = 0.06864

# p-value가 0.06864로 유의수준 0.05보다 크기 때문에 상품배치와 구매여부는 독립적이다.


#------------------------------------------------------------------------------
# 사이트맵 구성에 따른 체류 시간 차이 분석
SM_A1 <- SM_A
SM_B1 <- SM_B
SM_C1 <- SM_C

SM_A1$사이트맵 <- 'A'
SM_B1$사이트맵 <- 'B'
SM_C1$사이트맵 <- 'C'

names(SM_A1) <- c('고객ID','분','사이트맵')
names(SM_B1) <- c('고객ID','분','사이트맵')
names(SM_C1) <- c('고객ID','분','사이트맵')

summary(SM_A1$분)
  #  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  # 6.000   9.000   9.000   9.404  10.000  12.000 
summary(SM_B1$분)
  #  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  # 5.000   8.000  10.000   9.831  11.000  14.000
summary(SM_C1$분)
  #  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  # 2.000   7.000   9.000   9.514  12.000  16.000 

boxplot(SM_A1$분,SM_B1$분,SM_C1$분,col=c('red','blue','green'),
        main='사이트맵 구성과 체류시간',
        xlab='사이트맵',ylab='체류시간(분)',
        names=c('A','B','C'))

#### 사이트맵별 체류시간 평균 계산
mean(SM_A1$분) # 9.404255
mean(SM_B1$분) # 9.830645
mean(SM_C1$분) # 9.514286

#### 사이트맵에 따른 체류 시간 평균 차이 분석
# 정규성검정 : 사이트맵_A, 사이트맵_B는 정규성을 보이지 않음
shapiro.test(SM_A1$분)
  # Shapiro-Wilk normality test
  # 
  # data:  SM_A1$분
  # W = 0.91572, p-value = 6.612e-09
shapiro.test(SM_B1$분)
  # Shapiro-Wilk normality test
  # 
  # data:  SM_B1$분
  # W = 0.97124, p-value = 0.009464
shapiro.test(SM_C1$분)
  # Shapiro-Wilk normality test
  # 
  # data:  SM_C1$분
  # W = 0.98039, p-value = 0.1224

SM_all <- rbind(SM_A1,SM_B1,SM_C1)

# 등분산성검정 : 사이트맵 A,B,C는 등분산성을 보인다.
leveneTest(y=SM_all$분,as.factor(SM_all$사이트맵))
  # Levene's Test for Homogeneity of Variance (center = median)
  #        Df F value    Pr(>F)    
  # group   2  60.293 < 2.2e-16 ***
  #       414                      
  # ---
  # Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#### 평균차이 분석 시각화
# 일원분산분석 : 사이트맵별 체류시간의 평균의 차이는 유의한 차이가 없다.
SM_aov <- aov(분~사이트맵,data=SM_all)
summary(SM_aov)
  #              Df Sum Sq Mean Sq F value Pr(>F)
  # 사이트맵      2   13.9   6.931   1.654  0.193
  # Residuals   414 1734.9   4.191

# TukeyHSD
compare_SM <- TukeyHSD(SM_aov)
  #   Tukey multiple comparisons of means
  #     95% family-wise confidence level
  # 
  # Fit: aov(formula = 분 ~ 사이트맵, data = SM_all)
  # 
  # $사이트맵
  #           diff        lwr       upr     p adj
  # B-A  0.4263898 -0.1306676 0.9834473 0.1706924
  # C-A  0.1100304 -0.4766109 0.6966717 0.8983143
  # C-B -0.3163594 -0.9549532 0.3222343 0.4746568
plot(compare_SM,col="darkblue",las=1)
# 사이트맵별 체류시간 평균의 차이는 유의한 차이가 없다


#------------------------------------------------------------------------------
# 할인 쿠폰의 효과 분석
sale_ef
#### 발행후와 전의 구매 횟수 차이에 대한 기술 통계
sale_ef1 <- sale_ef[2:3]
sale_ef1[sale_ef1$발행전.구매.횟수==0 & sale_ef1$발행후.구매.횟수==0,]
sale_ef1[sale_ef1$발행전.구매.횟수==0 & sale_ef1$발행후.구매.횟수>0,]
sale_ef1[sale_ef1$발행전.구매.횟수>0 & sale_ef1$발행후.구매.횟수==0,]
sale_ef1[sale_ef1$발행전.구매.횟수 > sale_ef1$발행후.구매.횟수,]
sale_ef1[sale_ef1$발행전.구매.횟수 < sale_ef1$발행후.구매.횟수,]
summary(sale_ef1)
  # 발행전.구매.횟수 발행후.구매.횟수
  #   Min.   :0.000    Min.   :0.000   
  #   1st Qu.:0.000    1st Qu.:1.000   
  #   Median :1.000    Median :3.000   
  #   Mean   :1.286    Mean   :2.545   
  #   3rd Qu.:3.000    3rd Qu.:4.000   
  #   Max.   :4.000    Max.   :6.000

#### 발행전, 발행후의 구매 횟수에 대한 시각화
boxplot(sale_ef1$발행전.구매.횟수,sale_ef1$발행후.구매.횟수,
        col=c('red','blue'),
        main='쿠폰발행과 구매횟수의 관계',
        xlab='쿠폰발행여부',ylab='구매횟수',
        names=c('발행전','발행후'))

#### 차이 유의성 검정
sale_before <- sale_ef1$발행전.구매.횟수
sale_after <- sale_ef1$발행후.구매.횟수
# 정규성검정 - 정규성을 가정하지 않는다
sale_d <-  sale_before -sale_after

shapiro.test(sale_d)
  #         Shapiro-Wilk normality test
  # 
  # data:  sale_d
  # W = 0.96264, p-value = 0.0003527

t.test(sale_before,sale_after,paired=TRUE,alternative='less')
  #         Paired t-test
  # 
  # data:  sale_before and sale_after
  # t = -7.0721, df = 153, p-value = 2.552e-11
  # alternative hypothesis: true mean difference is less than 0
  # 95 percent confidence interval:
  #        -Inf -0.9649613
  # sample estimates:
  # mean difference 
  #        -1.25974 
# p-value가 2.552e-11로 유의수준 0.05보다 현저히 작음
# 쿠폰 발행전보다 발행후에 구매횟수가 올라갔다


#------------------------------------------------------------------------------
# 체류 시간과 구매 금액 간 관계 분석
stay_cost
stay_cost1 <- stay_cost[2:3]
# 구매금액에 0이 너무 많으므로 0을 제거한 후 진행
length(stay_cost1$구매금액) # 122
length(stay_cost1$구매금액[stay_cost1$구매금액==0]) # 64

stay_c0 <- stay_cost1[stay_cost1$구매금액 > 0,]

#### 구매 금액과 체류 시간의 관계 시각화
ggplot(stay_c0,aes(구매금액,체류시간)) +
  geom_point() +
  ggtitle('구매금액과 체류시간의 관계') +
  theme(plot.title=element_text(face='bold',
                                size=20,
                                hjust=0.5,
                                color='darkgreen'))

#### 구매 금액과 체류 시간 간 관계 분석
# 상관분석(pearson)
cor(stay_c0,use="all.obs",method="pearson")
  #           구매금액  체류시간
  # 구매금액 1.0000000 0.9245259
  # 체류시간 0.9245259 1.0000000
cor.test(stay_c0$구매금액,stay_c0$체류시간,method='pearson')
  #         Pearson's product-moment correlation
  # 
  # data:  stay_c0$구매금액 and stay_c0$체류시간
  # t = 18.153, df = 56, p-value < 2.2e-16
  # alternative hypothesis: true correlation is not equal to 0
  # 95 percent confidence interval:
  #  0.8752379 0.9548116
  # sample estimates:
  #       cor 
  # 0.9245259 
# 구매금액과 체류시간은 자기상관에 가까운 강한 양의 상관관계를 보인다


#------------------------------------------------------------------------------
# 구매 버튼배치에 따른 구매율 차이분석
btn_type
# 구매 버튼 배치와 구매율 간의 독립성 검정
unique(btn_type)

A <- c(9,93)
B <- c(9,85)
C <- c(15,89)
btn_all <- rbind(A,B,C)
prop.table(btn_all,1)
  #         구매여부
  # 버튼배치       구매    비구매
  #        A 0.08823529 0.9117647
  #        B 0.09574468 0.9042553
  #        C 0.14423077 0.8557692

dimnames(btn_all) <- list('버튼배치' = c('A','B','C'),
                          '구매여부' = c('구매','비구매'))

# 독립성검정
chisq.test(btn_all,correct=FALSE)
  #         Pearson's Chi-squared test
  # 
  # data:  btn_all
  # X-squared = 1.9334, df = 2, p-value = 0.3803
# 구매버튼배치와 구매율은 서로 독립적이다.

#------------------------------------------------------------------------------
# 월별 평균 구매자수, 방문자수, 판매금액 관계
days_con1 <- days_con %>% mutate('월'=as.factor(month(일자)))

days_mean <- days_con1 %>% 
  group_by(월) %>% 
  summarise(mean_customer=mean(방문자수),
            mean_buyer=mean(구매자수),
            mean_income=mean(총.판매.금액))
days_mean

ggplot(days_mean,aes(월,mean_customer)) +
  geom_line(group='월') +
  geom_point(colour='darkblue',size=2) +
  ggtitle('월별 방문자수 평균') +
  xlab('월') +
  ylab('방문자수 평균(명)') +
  theme(plot.title=element_text(face='bold',
                                size=20,
                                hjust=0.5,
                                color='darkgreen'))
days_mean$mean_customer
  # 2월의 평균 방문자수가 가장 많고, 7월의 평균 방문자수가 가장 적다.
  # 2 > 10 > 6 > 3 > 11 > 4 > 8 > 9 > 12 > 5 > 1 > 7

ggplot(days_mean,aes(월,mean_buyer)) +
  geom_line(group='월') +
  geom_point(colour='darkblue',size=2) +
  ggtitle('월별 구매자수 평균') +
  xlab('월') +
  ylab('구매자수 평균(명)') +
  theme(plot.title=element_text(face='bold',
                                size=20,
                                hjust=0.5,
                                color='darkgreen'))
days_mean$mean_buyer
  # 12월의 평균 구매자수가 가장 많고, 9월의 평균 구매자수가 가장 적다.
  # 12 > 4 > 2 > 3 > 11 > 10 > 1 = 5 > 8 > 6 > 7 > 9

ggplot(days_mean,aes(월,mean_income)) +
  geom_line(group='월') +
  geom_point(colour='darkblue',size=2) +
  ggtitle('월별 판매금액 평균') +
  xlab('월') +
  ylab('판매금액 평균') +
  theme(plot.title=element_text(face='bold',
                                size=20,
                                hjust=0.5,
                                color='darkgreen'))
days_mean$mean_income
  # 12월의 평균 판매금액이 가장 높고, 9월의 평균 판매금액이 가장 낮다.
  # 12 > 4 > 3 > 2 > 10 > 11 > 1 > 5 > 6 > 8 > 7 > 9

#-----------------------------------------------------------------------------
  # 2월의 평균 방문자수가 가장 많고, 7월의 평균 방문자수가 가장 적다.
  # 2 > 10 > 6 > 3 > 11 > 4 > 8 > 9 > 12 > 5 > 1 > 7
  # 12월의 평균 구매자수가 가장 많고, 9월의 평균 구매자수가 가장 적다.
  # 12 > 4 > 2 > 3 > 11 > 10 > 1 = 5 > 8 > 6 > 7 > 9
  # 12월의 평균 판매금액이 가장 높고, 9월의 평균 판매금액이 가장 낮다.
  # 12 > 4 > 3 > 2 > 10 > 11 > 1 > 5 > 6 > 8 > 7 > 9

# 방문자수와 구매자수, 판매금액 서로 유의한 상관이 없거나, 상관이 낮을것으로 예상된다.
# 구매자수와 판매금액 사이에는 높은 상관관계를 보여줄 것으로 예상된다.
#-----------------------------------------------------------------------------


###############################################################################

# 1. 구매자수가 증가해야 총판매금액이 증가한다.
  # 1-1. 방문자수가 늘어나도 구매자수가 유의하게 증가하지 않는다.
  # 1-2. 방문자수가 늘어나도 총판매금액이 유의하게 증가하지 않는다.
# 2. 상품배치는 구매여부에 영향을 미치지 않는다.
  # 2-1. 최소값, 최대값, 평균이 가장 높은 C배치를 사용하는 것이 합리적이다.
# 3. 쿠폰 발행후 구매횟수가 증가한다.
# 4. 사이트맵별 체류시간의 평균은 큰 차이를 보이지 않는다.
  # 4-1. 하지만 체류시간이 길어질수록 구매금액이 커지는 경향이 있다.
  # 4-2. 따라서 평균 체류시간이 긴 B 사이트맵을 사용하는 것이 합리적이다.
# 5. 구매버튼배치별로 구매율에는 거의 영향을 주지 않는다.
  # 5-1. 따라서 가장 구매율이 높은 C버튼을 사용하는 것이 합리적이다.
# 6. 월별 평균 방문자수, 평균 구매자수, 평균 판매금액은 다음과 같다.
  # 6-1. 평균 방문자수 : 2 > 10 > 6 > 3 > 11 > 4 > 8 > 9 > 12 > 5 > 1 > 7
  # 6-2. 평균 구매자수 : 12 > 4 > 2 > 3 > 11 > 10 > 1 = 5 > 8 > 6 > 7 > 9
  # 6-3. 평균 판매금액 : 12 > 4 > 3 > 2 > 10 > 11 > 1 > 5 > 6 > 8 > 7 > 9

# 따라서, 상품배치는 C, 사이트맵은 B, 버튼은 C를 사용하는 것이
# 구매자수와 구매율을 올려 총판매금액을 올리는 데에 합리적이라고 생각된다.
# 쿠폰발행을 하면 구매횟수가 증가하지만,
# 쿠폰발행으로 인한 구매횟수 증가가 총판매금액의 증가로 이어진다고 확신할 수 없다.

###############################################################################