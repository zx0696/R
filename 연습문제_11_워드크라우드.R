# jeju.txt 파일을 활용하여 문장을 수치화 처리(빈도를 이요한 정형데이터)
# 워드크라우드 그리기
# 관용어구, 불용어 제거해서 정제 후 워드크라우드 그리기

library(KoNLP)
library(wordcloud)
library(wordcloud2)
library(RColorBrewer)
useSejongDic()

jeju_raw <- readLines('data/jeju.txt')
jeju_raw

jeju_word_raw <- extractNoun(jeju_raw)
jeju_word_raw <- unlist(jeju_word_raw)

jeju_table <- table(jeju_word_raw)
View(sort(jeju_table,decreasing=T))

jeju_word <- Filter(function(x) {nchar(x)>=2},jeju_word_raw)

jeju_table2 <- table(jeju_word)
View(sort(jeju_table2,decreasing=T))

jeju_word <- gsub("\\d+","",jeju_word)
jeju_word <- gsub("숙소","",jeju_word)
jeju_word <- gsub("시간","",jeju_word)
jeju_word <- gsub("하시","",jeju_word)
jeju_word <- gsub("경유","",jeju_word)
jeju_word <- gsub("공항","",jeju_word)
jeju_word <- gsub("이용","",jeju_word)
jeju_word <- gsub("추천","",jeju_word)
jeju_word <- gsub("도착","",jeju_word)
jeju_word <- gsub("사진","",jeju_word)
jeju_word <- gsub("하게","",jeju_word)
jeju_word <- gsub("하루","",jeju_word)
jeju_word <- gsub("위치","",jeju_word)
jeju_word <- gsub("다양","",jeju_word)
jeju_word <- gsub("소요","",jeju_word)
jeju_word <- gsub("예약","",jeju_word)
jeju_word <- gsub("중간","",jeju_word)
jeju_word <- gsub("첫날","",jeju_word)
jeju_word <- gsub("가능","",jeju_word)
jeju_word <- gsub("근처","",jeju_word)
jeju_word <- gsub("둘째","",jeju_word)
jeju_word <- gsub("랜드","",jeju_word)
jeju_word <- gsub("일정","",jeju_word)
jeju_word <- gsub("정도","",jeju_word)
jeju_word <- gsub("할인","",jeju_word)
jeju_word <- gsub("구석","",jeju_word)
jeju_word <- gsub("도움","",jeju_word)
jeju_word <- gsub("야간","",jeju_word)
jeju_word <- gsub("이곳","",jeju_word)
jeju_word <- gsub("정보","",jeju_word)
jeju_word <- gsub("출발","",jeju_word)
jeju_word <- gsub("항공","",jeju_word)
jeju_word <- gsub("가운데","",jeju_word)
jeju_word <- gsub("경우","",jeju_word)
jeju_word <- gsub("깨끗","",jeju_word)
jeju_word <- gsub("다음","",jeju_word)
jeju_word <- gsub("분위기","",jeju_word)
jeju_word <- gsub("신기","",jeju_word)
jeju_word <- gsub("있습니","",jeju_word)
jeju_word <- gsub("있었구요","",jeju_word)
jeju_word <- gsub("자세","",jeju_word)
jeju_word <- gsub("주변","",jeju_word)
jeju_word <- gsub("첫째","",jeju_word)
jeju_word <- gsub("플러스","",jeju_word)
jeju_word <- gsub("하기","",jeju_word)
jeju_word <- gsub("화장실","",jeju_word)
jeju_word <- gsub("요금","",jeju_word)
jeju_word <- gsub("입장료","",jeju_word)
jeju_word <- gsub("청결","",jeju_word)
jeju_word <- gsub("쿠폰","",jeju_word)
jeju_word <- gsub("유명","",jeju_word)
jeju_word <- gsub("바랍니","",jeju_word)

write(jeju_word,'data/jeju_count.txt')
jeju_count_w <- read.table('data/jeju_count.txt')
jeju_wordcount <- table(jeju_count_w)

display.brewer.all(n=10,exact.n=TRUE)
jeju_color <- brewer.pal(9,'Paired')

wordcloud(names(jeju_wordcount),
          freq=jeju_wordcount,
          scale=c(5,1),
          rot.per=0.25,
          min.freq=4,
          random.order=F,
          random.color=T,
          color=jeju_color)


# 강사님 풀이
library(KoNLP)
library(wordcloud)
library(stringr)

useSejongDic()


##############################################################################
# 사전에 새로운 명사 추가하기
# 추가되는 단어는 ncn 품사로 추가 : 카이스트 품사 태그 기준 비서술성 명사

# 사전에 추가할 단어목록 생성
add_words <- readLines('data/제주도여행지.txt')
add_words

buildDictionary(user_dic=data.frame(add_words,
                                    rep("ncn",length(add_words))),
                replace_usr_dic=T)

# 추가된 명사 확인 : 사용자가 직접 추가한 내용
get_dictionary('user_dic')

#------------------------------------------------------------------------------
data1 <- readLines('data/jeju.txt')
# 명사 추출
data2 <- extractNoun(data1)
data2

##############################################################################
# 추출된 명사 저장 - 리스트형태 그대로 저장(rda 파일로 저장)
save(data2,file='jeju.rda')
rm(data2)
data2
##############################################################################

# list -> vector 변환
data3 <- unlist(data2)
data3

# 문자만 남기기
# [:alpha:] -> 문자(한글,영어)를 의미하는 정규식
# [^[:alpha:]] -> 문자를 제외한 나머지

data4 <- str_replace_all(data3,"[^[:alpha:]]","")
data4

# " "
data4 <- gsub(" ","",data4)

# 2글자 이상만 추출
data4 <- Filter(function(x){nchar(x)>=2}, data4)
data4

# 빈도 확인
wordcount <- table(data4)
View(sort(wordcount,decreasing=T))
# 관용적인 단어의 빈도가 높으므로 제거 후 진행

# 제거할 단어 리스트 활용
my_list <- readLines('data/제주도여행코스gsub.txt')
my_list

for(i in 1:length(my_list)) {
  data4 <- gsub(my_list[i],"",data4)
}
data4

# 2글자 이상만 추출
data4 <- Filter(function(x){nchar(x)>=2}, data4)
data4

# 빈도수 확인
wordcount <- table(data4)
View(sort(wordcount,decreasing=T))

data4 <- gsub("까지","",data4)

#-----------------------------------------------------------------------------
palete <- brewer.pal(9,'Set3')

wordcloud(names(wordcount),
          freq=wordcount,
          scale=c(3,1),
          rot.per=0.5,
          min.freq=5,
          random.order=F,
          random.color=T,
          color=palete)
