# 서울시 서대문구의 가장 치킨집이 많은 동네 찾기

# 아래 데이터 사용 
row_data <- read.csv("data/서울특별시_일반음식점.csv")
View(row_data)

# string 관련 패키지
# "소재지전체주소",  "영업 상태명", "위생업태명" 컬럼 사용
# 서대문구 데이터만 추출
# 위생업태명에 통닭이나 치킨이 들어있는 점포
# 동별로 분리 후 빈도
library(dplyr)
library(stringr)

data_fin <- row_data %>% 
  filter(영업상태명=='영업/정상' & 위생업태명 %in% c('호프/통닭','통닭(치킨)')) %>% 
  select(소재지전체주소, 위생업태명)
View(data_fin)

chi_seo <- data_fin[str_detect(chicken_raw$소재지전체주소,"서대문구"),]
View(chi_seo)

str_locate(chi_seo$소재지전체주소,"서대문구")
address <- substr(chi_seo$소재지전체주소,11,16)
head(address)
address_rmnum <- gsub("[0-9]","",address)
address_trim <- str_trim(address_rmnum)

chicken_count <- data.frame(table(address_trim))
names(chicken_count) <- c("상호명","빈도")

chicken_count <- chicken_count %>% arrange(desc(빈도))
View(chicken_count)

# 최종 결과
#     상호명 빈도
# 1    창천동   91
# 2  북가좌동   48
# 3    홍제동   48
# 4  남가좌동   47
# 5    홍은동   43
# 6    연희동   41
# 7  충정로가   21
# 8  북아현동   20
# 9    대현동   15
# 10   냉천동   10
# 11   미근동    6
# 12   옥천동    3
# 13   영천동    2
# 14   천연동    2
# 15     합동    2
# 16   대신동    1