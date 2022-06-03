# 1. 텍스트마이닝 ---------------------------------------------------------------
# Install package NLP, tm, wordcloud

setwd("C:/Users/goong/OneDrive - postech.ac.kr/바탕 화면/Postech/학교, 학사/1학년 1학기/데이터 분석을 위한 R프로그래밍/wk15")

install.packages('NLP')
install.packages('tm')
install.packages('wordcloud')
install.packages("RColBrewer")

library(NLP)
library(tm)
library(RColorBrewer)
library(wordcloud)

data(crude) # tm에 포함된 데이터 crude 사용 / 로이터 통신의 20개의 뉴스기사
str(crude[[1]])
content(crude[[1]])
meta(crude[[1]])
lapply(crude, content) # 파일의 내용을 보여줌

# inspect 함수
inspect(crude[1:3]) # 1~3번째 문서에 대한 정보
inspect(crude[[1]]) # 1번째 파일의 내용

# 텍스트 전처리
str(crude[[1]])
content(crude[[1]])

# 1. remove punctuation in document
crude <- tm_map(crude, removePunctuation)
content(crude[[1]])
# 문장 중간중간에 . 이 사라진 것을 확인할 수 있음.

# 2. remove numbers
crude <- tm_map(crude, removeNumbers)
content(crude[[1]])
# 문장 중간중간에 숫자들이 사라진 것을 확인할 수 있음.

# 3. remove stopwords
crude <- tm_map(crude, function(x) removeWords(x, stopwords()))
content(crude[[1]])
# that, it, had, its, for, by, The 제거

stopwords() # stopwords의 list 보기

# 4. construct term-document matrix
# 문서행렬을 구성
tdm <- TermDocumentMatrix(crude)
inspect(tdm)

# 5. read tdm as a matrix
# 문서행렬을 행렬로 변환
m <- as.matrix(tdm)
head(m)
dim(m)

# 6. sorting in high frequency to low
# 단어의 빈도 순으로 정렬
v <- sort(rowSums(m), decreasing = T)
v[1:10] # 상위 등장빈도 10개 단어
head(v)
# 7. match with freq and word names
d <- data.frame(word = names(v), freq = v )
head(d)

d[957:962, ] # 가장 빈도가 낮은 단어 6개

# 7-1. Now lets try it with frequent words plotted first
wordcloud(d$word, d$freq, c(8, 0.5), 2,,F,0.1)

# 7-2. color plot with frequent words plotted first
pal <- brewer.pal(9, "BuGn")
pal <- pal[-(1:4)]
wordcloud(d$word, d$freq, c(8,0.3),2,,F,,.15,pal)


# 2. 웹문서 텍스트마이닝 -----------------------------------------------------------
#install.packages("rJava")
#library(rJava)
#install.packages("KoNLP")

library("remotes")
install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts = c("--nomultiarch"))
library(KoNLP)
extractNoun("포항공대에는 이민구가 있다") # konlp 테스트

t <- "즐겁게 텍스트 분석을 해봅시다!"
SimplePos09(t)

#install.packages("stringr")
library(stringr)
tt <- SimplePos09(t)
tt
t_n <- str_match(tt, '([가-힣]+)/N')
t_n

t_p <- str_match(tt, '([가-힣]+)/P')
t_n

# 웹 문서의 텍스트마이닝 실습

# install packages
# install.packages("NLP")
# install.packages("xml2") # to read html
# install.packages("rvest") # to use 'html_nodes'
# install.packages("KoNLP") # korean natural language processing
# install.packages("tm") # corpus, term-document matrix, etc.
# install.packages("stringr") # to use 'str_match'
# install.packages("wordcloud") # word cloud
# install.packages("rvest")
# install.packages("stringr")
# install.packages("qgraph") # qgraph of co-occurence matrix

# use packages
library(NLP)
library(xml2)
library(rvest)
#KoNLP not install
library(KoNLP)
library(tm)
library(stringr)
library(wordcloud)
library(ggplot2)
library(stringr)
library(rvest)

# crawling base URL
url_base <- 'http://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=51786&type=after&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page='

# make a vector to contain comments
reviews <- c()

# start crawling
for(page in 1:10){
  url <- paste(url_base, page, sep='') # from page 1 to 70
  htxt <- read_html(url)
  comment <- html_nodes(htxt, 'div')%>%html_nodes('div.input_netizen')%>%
    html_nodes('div.score_result')%>%html_nodes('ul')%>%html_nodes('li')%>%
    html_nodes('div.score_reple')%>%html_nodes('p') # exact location of comments
  review <- html_text(comment) # extract only texts from comments
  review <- repair_encoding(review, from = 'utf-8') # repair faulty encoding
  review <- str_trim(review) # 앞뒤 공백 문자 제거
  reviews <- c(reviews, review) # 결과값 저장
}

head(reviews)

#문장부호 제거
reviews1 <- str_replace_all(reviews, "\\W", " ")
head(reviews1)

# extract nouns(N) and predicates(P)
ext_func <- function(doc){
  doc_char <- as.character(doc)
  ext1 <- paste(SimplePos09(doc_char))
  ext2 <- str_match(ext1, '([A-Z가-힣]+)/[NP]')
  keyword <- ext2[,2]
  keyword[!is.na(keyword)]
}

# 1. term-document matrix
library(tm)
corp <- Corpus(VectorSource(reviews1)) # generate a corpus
corp

tdm<-TermDocumentMatrix(corp)

# tdm <- TermDocumentMatrix(corp,
#                           control = list(
#                             tokenize = ext_func,
#                             removePunctuation = T,
#                             removeNumbers = T,
#                             wordLengths = c(4,8)))

inspect(tdm)

tdm_matrix <- as.matrix(tdm) # 행렬로 변환
Encoding(rownames(tdm_matrix)) <- "UTF-8" # 인코딩

word_count <- rowSums(tdm_matrix) # 각 단어별 총 출현 빈도 계산
word_order <- word_count[order(word_count, decreasing = T)] # 내림차순 정렬

doc <- as.data.frame(word_order) # 데이터프레임으로 변환
doc

# 워드 클라우드 구현
windowsFonts(font = windowsFont("맑은고딕"))
set.seed(1234)

wordcloud(names(word_count), # 키워드
          freq = word_count, # 빈도
          min.freq = 2, # 최소출현 빈도
          max.words = 30, # 출력 키워드 수
          random.order = F,# 고빈도 키워드 중앙 배치
          scale = c(5,1), # 키워드 크기 범위
          rot.per = 0.35, #회전 키워드 비율
          family = "font", colors = brewer.pal(8, "Dark2")
          )
