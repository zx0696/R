# txt/excel/csv/rda(R전용 파일) 파일의 입출력


#파일 관리 함수 정리
# 현재 작업 디렉토리
# C:\Rstudy
#파일저장 디렉토리- 작업 디렉토리로 설정 후 사용할 것
#C:\Rstudy\data_

# 현재작업 디렉처리내의 파일 확인
# list.files() 현 디렉터리의 파일명 (디렉터리명 포함 )을 출력
list.files()


#하위 디렉터리 정보까지 전부 출력
list.files(recursive = T)

# 숨김파일까지 출력
list.files(all.files = T)

list.files(all.files = T,recursive = T)

#작업 디렉터리 관련 함수
#현재 작업 디렉터리 조회
getwd() #[1] "C:/Rstudy"

#현재 작업 디렉터리; 변경(Rstudy\data_)
setwd("data_")
getwd() #"C:\Rstudy\data_"
list.files()

#현재 작업 디렉터리를 상위 디렉터리로 변경
setwd("../")
getwd()


#data 폴더를 현재 작업 디렉터리로 설정
setwd("data_")
getwd()

#######################################################
# 텍스트 파일 읽어오기
#scan(파일명)
######################################################
scan1 <- scan('scan_1.txt')
typeof(scan1)


scan2 <- scan('scan_2.txt')
typeof(scan2)


# 텍스트파일을 문자열로 지정: what=""

scan2 <- scan('scan_2.txt', what="")
typeof(scan2)

# 숫자모양이 아닌 문자 파일을 기본 파라미터로 읽으면 에러발생
scan3 <- scan('scan_3.txt', what = "")

#숫자와 문자가 혼용된 데이터는 문자로 읽어야 함
scan4 <- scan('scan_4.txt', what = "")


### scan()의 일반 사용은 사용자로부터 데이터를 입력 받을때 사용
###한개의 데이터 입력 후 enter
###데이터 입력 없이 enter 누르면 입력의 종료
###숫자 입력받기
input <- scan()
input


#문자 입력 받기
input2 <- scan(what="") # 문자의 구분을 띄어쓰기 또는 ENTER로 가능
input2


# 한줄 문자열 입력받기: readline() -> enter키 입력 전까지 한문장 처리
input3 <- readline()
input3

#입력 메시지 출력 가능
input4 <- readline("Are you OK? :")
input4


# readLines() 함수로 파일의 여러 줄 읽어오기
input5 <- readLines('scan_4.txt')
input5


###############################################
# 텍스트 파일을 dataset 형태로 읽어오기
# read.table("파일명")
# 파라미터
# header : 파일의 1행이 변수명인지의 여부 (T/F)
# skip : 1행부터 특정 행까지를 제외하고 데이터 가져오기
# (skip = 2,  3행부터 데이터 가져옴 )
# nrows : 특정 행까지 데이터 가져오기
# (nrows = 7 7행까지 데이터 가져옴)
# sep : 데이터 구분자 지정(열 구분)
# (sep = "," : 데이터 쉼표로 열 구분되어 있음, "\t" (탭키로 구분))
###############################################
#텍스트 파일의 한글 엔코딩 방식은 utf-8이 기본

ex_data <- read.table("data_ex.txt")
ex_data # 1행이 data값으로 인식 

# 첫 행을 변수명으로 설정
ex_data <- read.table("data_ex.txt", header = TRUE)
ex_data # 1행이 data값으로 인식 

#원시 데이터의 구분이 ,로 되어 있는 경우
#열 구분자 변경: sep=","
ex1_data2 <- read.table("data_ex1.txt", header = TRUE, sep = ",")
ex1_data2
str(ex1_data2)


#header 데이터가 없는 원시 파일인 경우: Vn 으로 기본 변수명 생성
ex2_data <- read.table("data_ex2.txt", sep =",")
ex2_data


# 파일 읽어오면서 변수명 생성
# 변수명으로 사용할 벡터 생성
var_name <- c("ID","SEX","AGE","AREA")

ex2_data <- read.table("data_ex2.txt",
                       sep=",",
                       col.names = var_name)
ex2_data

# skip 옵션 사용 : 우선 처리되는 파라미터
# 먼저 skip하고 header를 처리하게 됨
# skip=2
ex2_data2 <- read.table("data_ex.txt",header = TRUE, skip=2)
ex2_data2

ex2_data2 <- read.table("data_ex.txt", skip=2)
ex2_data2

ex_data2 <- read.table("data_ex.txt", skip = 2,
                       col.names = var_name)
ex_data2

#nrows 옵션 : 몇개의 행을 불러올지 지정 
#nrows 파라미터는 header 파라미터보다 우선순위가 뒤에 있음
#nrows=7
ex_data3 <- read.table("data_ex.txt", header = TRUE, nrows =7)
ex_data3  

#원본파일에 주석 기호가 포함되어 있는 경우 
#주석이나 공백이 있을 경우 자동 제외
fruit2 <- read.table('fruits_2.txt')
fruit2

# read.delim() 함수 사용해서 파일 읽어오기
# tab으로 구분되어져 있는 파일을 읽어올때 주로 사용 (구분자를 tab으로 인식)
ex_delim <- read.delim('data_ex.txt')
ex_delim


ex_delim1 <- read.delim('data_ex1.txt', sep=",")
ex_delim1

##########################
##################
# csv파일 읽어오기
# csv파일 범용 데이터 형식
# 값 사이를 쉼표로 구분
# 용량이 작고, 다양한 소프트웨어에서 구분자를 사용할 수 있음
# read.csv()
###########################################

fruit3 <- read.csv('fruits_3.csv')
fruit3

# 원본 파일에 header가 없는 경우
fruit4 <- read.csv('fruits_4.csv')
fruit4

#header = F
fruit4 <- read.csv('fruits_4.csv',header = F)
fruit4

#
var_name <- c('NO','NAME','PRICE','QTY')
fruit4 <- read.csv('fruits_4.csv',header = F,
                   col.names = var_name)
fruit4
str(fruit4)

#################################################
# 엑셀파일 읽어오기 
# 엑셀 관련된 패키지 설치하고 로드 후 사용해야 함
# readxl 패키지
################################################
 
#패키지 설치 (install.packages("패키지명")) - 한번 설치로 계속 사용 가능
# 로드 : library(패키지명) - 스크립트 열때마다 계속 실행해 줘야 함

# install.packages("readxl")
library(readxl)

# 엑셀 파일 읽어오기
#read_excel()사용
excel_data_ex <- read_excel("data_ex.xls")
excel_data_ex
str(excel_data_ex) # tibble 구조로 읽어옴(data.frame과 같은 구조)

# 1번 sheet가 아닌 다른 sheet 읽어올때 : sheet = sheet번호
excel_data_ex2 <- read_excel("data_ex.xls", sheet = 2)
excel_data_ex2

#header가 없는 원본 파일인 경우 : col_names= F
fruit_no_header <- read_excel('fruit_no_header.xlsx',                              col_names = F)
fruit_no_header

# 변수명 지정 후 읽어오기
var_name2 <- c('NO','FRUIT','PRICE','QTY')
fruit_no_header1 <- read_excel('fruit_no_header.xlsx',
                               col_names = var_name2)
fruit_no_header1
#clipboard에 복사해놓은 데이터 읽어오기

mid_exam <- read.delim("clipboard",header = T)
mid_exam

f_text <- read.delim("clipboard",header = T)
f_text


########################################################
#데이터 내보내기 
# csv와txt 파일로 저장
#write.csv() 사용
########################################################

name <- c("홍길동","이몽룡",'성춘향')
age <- c(23,30,25)
address <- c('서울', '부산', '남원')
df_member <- data.frame(NAME = name,
                        AGE=age,
                        ADDRESS=address)
df_member

write.csv(df_member, file= "mem_test.csv") 
# 외부 파일 저장 시 행/열 인덱스가 저장이됨
# 행 이름이 추가되지 않도록 설정 : row.names = FALSE
write.csv(df_member, file= "mem_test.csv",row.names = FALSE)


# 따옴표 제외 파라미터 : quote = FALSE
write.csv(df_member, file= "mem_test.csv",row.names = FALSE,
          quote = FALSE)

############################################################
# txt 파일로 저장: write.table() 함수 사용
############################################################
write.table(df_member, file = 'mem_text.txt', row.names = FALSE,
          quote = FALSE)

######################################################
# 엑셀 파일로 저장하기
# writexl 패키지 사용
# write_xlsx()
#write_xlsx(df, path='경로를 포함한 파일명')
######################################################
# install.packages("writexl")
library(writexl)

member
#format_headers=T/F (기본값 : T)
write_xlsx(member, path='mem_test.xlsx')
write_xlsx(member, path='mem_test.xlsx',format_headers= F)


###############################################
# rda 파일로 저장하기
# rda 파일: R 전용파일 (용량 작고 빠름)
# save(df, file = '저장파일명.rda') - 내보내기
#load('파일명.rda')- 읽어오기
##############################################
member
save(member, file = 'data_ex.rda')
rm(member)
member
# 읽어오기
load('data_ex.rda') # 기존에 저장했던 원본 df형태 그대로 load 됨
member

