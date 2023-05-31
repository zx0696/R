# 그래프 출력은 R 스튜디오 plot창에 나타남
# 새로운 plot 창을 생성할때는
plot.new()

# 단독 PLOT 창 (시스템에 종속)

dev.new()


# 옵션없이 x,y 축만 있는 그래프
# plot(y축데이터): 산점도(기본그래프 종류)
plot(1:15)
# plot(x축 데이터, y축 데이터) : x,y 축 데이터의 개수는 동일해야 함
plot(1:5,c(5,3,2,6,10))
#plot() 함수의 주요옵션
# xlab : x 축 이름
# ylab : y 축 이름
# xlim : x축 값의 범위
# ylim : y축 값의 범위
# main : 그래프 제목
# pch : 점의 종류
# cex : 점의 크기
# col : 색상
# type : 그래프의 유형

x<-c(1,2,3); y<-c(4,5,6)
plot(x,y,
     xlab="x축 이름",
     ylab="y축 이름",
     main="그래프 제목")

#점의 크기/ 색상
plot(x,y,cex=3,col='red')

# 축 생략
v1 <- c(100,130,120,160,150)

#x,y축 생략, y축 범위 (0~200):c(시작값,끝값)
plot(v1,type='o', #표식(점)이 있는 꺾은선 그래프
     col='red',
     ylim=c(0,200),
     axes = FALSE,# x,y축 표시 여부
     ann = FALSE)# 축 제목 표시 여부

#축 추가 : axis(축 종류,축범위, 축값)함수 사용
#x축 추가:1 
axis(1,at=c(1:5),
     lab=c('MON','TUE','WED','THU','FRI'))

#y축 추가 : 2
axis(2,ylim=c(0,200))

#그래프 제목(title(main=그래프 제목,col.main=제목색상,font.main=제목폰트크기)사용)

title(main = "FRUIT",
      col.main="red",
      font.main=4)

#축 제목(title(xlab=축 제목,
#             col..lab=제목색상)사용)

title(xlab='DAY',col.lab='black')
title(ylab='PRICE',col.lab='blue')

# title 함수 옵션
x <- c(1,2,3);y<-c(4,5,6)

plot(x,y,ann=FALSE)
title(main='그래프제목',
      xlab='x축제목',
      ylab='y축제목',
      cex.main=3, #그래프 제목 크기
      cex.lab=1.5, #x,y축 제목 크기
      col.main="red", #제목 색상
      col.lab="blue" #축제목 색상
      )


##########################################
#plot 화면 분할
#par(mfrow=c(행,열))

plot.new()
#1행 3열로 화면 분할
v1
par(mfrow=c(1,3))
plot(v1,type = 'o') # 표식이 있는 꺾은선
plot(v1,type='s') #v1값을 기초로 계단 모양으로 연결
plot(v1,type='l') #꺾은 선 

# 2행3열로 화면분할
par(mfrow=c(2,3)) # 분할설정을 변경하기 전까지 유지
plot(v1,type = 'o') # 표식이 있는 꺾은선
plot(v1,type='s') #v1값을 기초로 계단 모양으로 연결
plot(v1,type='l') #꺾은 선 
pie(v1)
plot(v1,type='o')
barplot(v1)


#하나의 화면으로 복귀
par(mfrow=c(1,1))
plot(v1,type='o')

###########################
# 축제목/지표값/지표선 위치 설정
# par(mgp=c(제목위치,지표값위치,시표선위치))
a
par(mgp=c(1,1,1))
plot(a, xlab='aaa')
# 제목,지표,지표선 동일한 위치에 겹쳐서 나옴

par(mgp=c(2,1,0)) #기본값
plot(a, xlab='aaa')

#그래프의 여백 조정하기
a<- c(1,2,3,4,5)
plot(a,xlab = 'aaa')

# par(oma=c(아래,왼쪽,위,오른쪽))
# par(oma=c(0,0,0,0)) -기본 설정값


par(oma = c(2,1,0,0))
plot(a,xlab='aaa')



#########################################
# 그래프 겹쳐 그리기 
# par(new=T) : 중복 허용 옵션
par(mfrow=c(1,1))


v1<-c(1,2,3,4,5)
v2<-c(5,4,3,2,1)
v3<-c(3,4,5,6,7)


# 각 plot창에 출력
plot(v1,type='s',col='red',ylim=c(1,5))
plot(v2,type='o',col='blue',ylim=c(1,5))
plot(v3,type='l',col='green',ylim=c(1,7))



# par(new=T) 사용
plot(v1,type='s',col='red',ylim=c(1,5))
par(new=T)
plot(v2,type='o',col='blue',ylim=c(1,5))
par(new=T)
plot(v3,type='l',col='green',ylim=c(1,7))
#중복허용시 축의 중복도 허용되어서 그래프 구분이 어려움


###########################################
# plot()과 lines() 함수를 사용하여 겹쳐서 출력
# par(new=T) 사용
plot(v1,type='s',col='red',ylim=c(1,10))
lines(v2,type='o',col='blue',ylim=c(1,5))
lines(v3,type='l',col='green',ylim=c(1,15))
#lines(): 그래프 위에 선을 추가하는 함수

points(3,5,cex=5, pch='+', col='red')
points(4,5,cex=5, pch=2, col='red')


#대각선 그리기
#abline() 함수사용
#a: 절편
#b: 기울기
#col : 색상
#lty : 선스타일
abline(a=0,b=1,col='black',lty=6)

#수평선 : h값 사용
#수직선 : v값을 사용
abline(h=6,col='red',lty=3)
abline(v=3,col='red',lty=2)

######################################
#legend(x,y,범례내용,크기,색상,선 타입): 범례 생성
plot.new()
plot(v1,type='s',col='red',ylim=c(1,10))
lines(v2,type='o',col='blue',ylim=c(1,5))
lines(v3,type='l',col='green',ylim=c(1,15))

legend(4,5,
       c("v1","v2","v3"),
       cex=0.2,
       col=c("red","blue","green"),
       lty=1)

legend('topleft',
       c("v1","v2","v3"),
       cex=0.2,
       col=c("red","blue","green"),
       lty=1)

 
###############################################################
#barplot() 함수
#범주형 자료의 빈도수를 기둥의 높이로 표현하는 그래프
#수치형 자료의 크기를 높이로 비교 표현하는 그래프

#barplot(height,인수,....,)
#height
#각 기둥의 높이에 해당하는 값(벡터 또는 행렬)
#벡터일 경우 각 기둥의 높이는 x의 원소들로 결정
#행렬일 경우 열의 개수 만큼 기둥이 만들어지고 
#기둥의 높이는 열에 해당되는 행값의 누적값으로 높이가 결정됨

# 벡터 이용
x <- c(1,2,3,4,5)
barplot(x)
barplot(x,names=c(1:5))

#빈도값을 생성 후 막대그래프 그리기
a <- c(1,2,3,3,1)
table(a)
barplot(a_t)

#가로 막대 그래프
barplot(x,horiz=T)

# 행렬 값으로 barplot() 그리기
x <- matrix(c(5,4,3,2),2,2)
x

# 행열의 각 열에 대한 누적막대그래프
barplot(x,
        names=c('1열','2열'),
        col=c("green",'yellow'),
        ylim=c(0,12))

# 묶음 막대 그래프
barplot(x,
        beside=T,
        names=c('1열','2열'),
        col=c("green",'yellow'),
        ylim=c(0,6))

#여백 설정 :oma옵션
par(oma=c(1,0.5,1,0.5))

barplot(x,
        beside=T,
        names=c('1열','2열'),
        col=c("green",'yellow'),
        horiz = T)

#가로 누적 막대 그래프
barplot(x,
        names=c('1열','2열'),
        col= c("green",'yellow'),
        horiz = T,
        ylim=c(0,12))
# dataframe으로 막대 그래프 그리기
v1 = c(100,120,140,160,180)
v2 = c(120,130,150,140,170)
v3 = c(140,170,120,110,160)


# 'height'는 반드시 벡터 또는 행렬이어야 하므로 형변환 진행
# 누적막대 그래프
qty <- data.frame(BANANA=v1,CHERRT=v2,ORANGE=v3)
barplot(as.matrix(qty),
        main = "Fruits's Sales QTY",
        col = rainbow(nrow(qty)),
        ylim=c(0,300))


# 묶음 막대 그래프
barplot(as.matrix(qty),
        main = "Fruits's Sales QTY",
        beside = T,
        col = rainbow(nrow(qty)),
        ylim=c(0,300))

legend(14,300,
  c('MON','TUE','WED','THU','FRI'),
  cex = 0.8,
  fill = rainbow(nrow(qty)))

rainbow(7)
rainbow(7)
rainbow(4)
rainbow(100)
