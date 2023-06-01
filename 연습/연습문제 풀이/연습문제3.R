######
# 데이터 입출력 연습문제
######

getwd()
setwd('data')
getwd()

# ex1.txt
ex1 <- scan('ex1.txt', what="")
ex1

# ex2.txt
ex2 <- scan('ex2.txt')
ex2

ex2 <- read.table('ex2.txt')
ex2
class(ex2)

kor <-  scan(what="")

kor <-readline("국어점수 입력 : ")
class(kor)

kor <-as.double(readline("국어점수 입력 : "))
class(kor)

# 열이름 변경해서 읽어오기
mem <- read.table('mem.txt',
                  header=T,
                  col.names = c("name","tel","address"))
mem

# 주석을 제외하고 데이터프레임으로 저장
baseball <- read.table('baseball_player.txt',
                       sep=",",
                       header=T)
baseball

baseball <- read.table('baseball_player.txt',
                       sep=",",
                       header=T)
baseball

# 3~6 행
player <- read.table('baseball_player.txt',
                       sep=",",
                       skip=3,
                       nrows=4,
                       col.names=c("순위","타율","홈런","ops"))
player

# 파일로 저장
library(writexl)
write_xlsx(player, path = "players.xlsx") # 행인덱스 내보냄
write_xlsx(player, path = "players.xlsx", row.names=F) # 행 인덱스 내보내지 않음 

library(readxl)
apt_info <- read_excel('아파트_실거래가.xlsx')
View(apt_info)
class(apt_info)

apt_sub <- subset(apt_info, 거래금액>=100000)
View(apt_sub)

cat("거래금액이 100,000 이상인 행수 : ", nrow(apt_sub))

write.csv(apt_sub, file='apt_sub_100000.csv',
          quote=FALSE)
setwd("../")
getwd()
