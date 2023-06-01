
##############################################
# 연습문제3
##############################################

# 1 ex1.txt 파일을 원본 그대로 읽어 오기
scan('ex1.txt',what="")

# 2 메모장을 열어 아래 내용을 입력 후 ex2.txt로 저장
  # 1  3  5
  # 7  9  10
  # 11 12 16

  # 숫자와 숫자 사이는 스페이스로 구분
  # ex2.txt 파일을 원본 그대로 가져오기
scan('ex2.txt')

# 3 ex2.txt 파일을 테이블 형태로 읽어오기
read.table('ex2.txt',header=FALSE)

# 4 사용자로부터 국어 점수를 입력 받아 벡터로 저장
kor <- readline("국어 점수 입력 : ")
kor

# 5 사용자로부터 주소를 입력 받아 벡터로 저장
address <- readline("주소 입력 : ")
address

# 6 메모장을 열어 아래 내용을 입력해 mem.txt로 저장(인코딩:ANSI)

# 구분자는 공백으로 설정
  # 이름   전화          주소
  # 김영희 010-1234-0000 경기도
  # 박철수 010-1111-1111 서울
# mem.txt 파일을 데이터프레임으로 저장
mem <- as.data.frame(read.table("mem.txt",header=T))
mem
class(mem)
# 열이름은 name, tel, address로 변경해서 읽어오기
var_name <- c('name','tel','address')
mem <- as.data.frame(read.table('mem.txt',header=T,col.names=var_name))
mem
class(mem)

# 8 baseball_player.txt 파일을 주석을 제외하고 데이터프레임으로 가져와서 View() 함수로 확인
df_baseball <- read.table(file="baseball_player.txt",header=T,sep=",")
View(df_baseball)

# 9 baseball_player.txt 파일의 3행부터 6행까지 데이터프레임(players)으로 가져와서(변수명 지정)
  # 변수명 : 순위, 타율, 홈런, OPS
var_bp <- c("순위","타율","홈런","OPS")
players <- read.table(file="baseball_player.txt",header=F,sep=",",skip=3,nrows=4,col.names=var_bp)
  # players.xlsx 파일로 저장(행 번호 제거하고 저장)
library(writexl)
write_xlsx(players,path="players.xlsx")

# 10 아파트_실거래가.xlsx 파일을 데이터프레임으로 가져와서 View() 함수로 확인하고
library(readxl)
apt_price <- read_excel("아파트_실거래가.xlsx")
View(apt_price)
  # 거래금액이 100,000 이상인 행만 추출해서 View() 함수로 확인하고,
apt_sub_100000 <- apt_price[which(apt_price$거래금액 >= 100000),]
View(apt_sub_100000)
  # 거래금액이 100,000 이상인 행 수 출력하고
cat("거래금액이 100,000 이상인 행수 : ", nrow(apt_sub_100000))
nrow(apt_sub_100000)
  # "apt_sub_100000.csv"로 저장(따옴표 제외)
write.csv(apt_sub_100000,file='apt_sub_100000.csv',quote=FALSE)

# 11 치킨집_가공.xlsx 파일을 열어 열이름 제외하고 일부분을 복사하여
  # 열이름 추가해서 데이터 프레임으로 저장하고
chicken_info <- read.delim("clipboard",header=F)
  # 열이름 : 주소, 사업장명
col_name <- c("주소","사업장명")
chicken_info <- read.delim("clipboard",col.names=col_name)
  # chicken_info.csv 파일로 저장(따옴표, 행이름 제거)
write.csv(chicken_info,file='chicken_info.csv',row.names=F)

# 12 아래 표의 내용을 데이터 프레임으로 작성
  # 변수명 : df_member
    # NAME   TEL           ADDRESS
    # 김영희 010-1234-0000 경기도
    # 박철수 010-1111-1111 서울
NAME <- c("김영희","박철수")
TEL <- c("010-1234-0000","010-1111-1111")
ADDRESS <- c("경기도","서울")
df_member <- data.frame(NAME,TEL,ADDRESS)
  # 위에서 만든 데이터프레임을 df_member.rda 파일로 저장
save(df_member,file='df_member.rda')
  # df_member 변수를 삭제하고
rm(df_member)
  # df_member.rda 파일을 읽어오기
load(file='df_member.rda')

# 13 "서울_강동구_공영주차장_위경도.csv" 파일을 읽어 와서 데이터프레임으로 저장한 후 View()로 확인하고
pub_parking <- read.csv("서울_강동구_공영주차장_위경도.csv")
View(pub_parking)
  # '주차장명','LAT','LON' 열만 추출해서 데이터프레임을 생성한 후
parking_lot_lat_lot <- subset(pub_parking,select=-주소)
  # "parking_lot_lat_lot.csv" 파일로 저장
write.csv(parking_lot_lat_lot,file='parking_lot_lat_lot.csv')
