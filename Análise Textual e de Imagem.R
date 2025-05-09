##############################  QUESTÃO 1  ##################################


#### PACOTES 

install.packages("pdftools")
library(pdftools) 
library(igraph)
library(ggraph)
library(rvest)
library(httr)
library(stringr)
library(wordcloud)
library(tm)
library(tidytext)
library(dplyr)
library(ggplot2)
library(tidyr)
library(raster)
library(sf)





setwd("/cloud/project")
pdf <- pdf_text("Palido-Ponto-Azul.pdf") ## Lendo o arquivo pdf

teste <- pdf[7:25] 


(len_teste <- str_length(teste))

## Apresentar texto como o original

(teste2<-strsplit(teste, split = "\n"))

## Nuvem de palavras

wordcloud(teste2,scale=c(8,1), max.words = 50)

### Palavras em minusculo
(teste3 <- tolower(teste2))

### Removendo pontuacao
(teste3<- removePunctuation(teste3))

### Removendo numeros
teste3<-removeNumbers(teste3)

### Palavras irrelevantes
stopwords("pt")

### Removendo palavras irrelevantes
(teste3 <- removeWords(teste3, stopwords("pt")))

wordcloud(teste3,scale=c(5,0.5), max.words = 50)

## Espaços em branco

teste3<-stripWhitespace(teste3)
wordcloud(teste3, max.words = 50)

## Retirando palavras
stopwords_pt <- c(stopwords("pt"))

teste3 <- removeWords(teste3, stopwords_pt)
wordcloud(teste3, max.words = 50)

## pequenos conjuntos de palavras

tokens <- str_split(teste3, " ")
unlist(tokens)

teste_dados<-DocumentTermMatrix(teste3)

findFreqTerms(teste_dados, lowfreq=5)



## Construindo o banco de dados 
teste_df <- data_frame(
  id_teste = 1:length(teste), 
  text = teste)
glimpse(teste_df)

## Transformando em Tokens
teste_token <- teste_df %>%
  unnest_tokens(word, text)
glimpse(teste_token)

## Retirando palavras
stopwords_pt <- c(stopwords("pt"), "é")

(stopwords_pt_df <- data.frame(word = stopwords_pt))

## Removendo palavras irrelevantes
(teste_token <- teste_token %>%
    anti_join(stopwords_pt_df, by = "word"))

## Ordenando palavras mais repetidas
teste_token %>%
  count(word, sort = TRUE)



## Bigrams - palavras associadas duas a duas
teste_bigrams <- teste_df %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)

teste_bigrams %>%
  count(bigram, sort = TRUE)

## Bigrams - palavras separadas em colunas
bigrams_separated <- teste_bigrams %>%
  separate(bigram, c("word1", "word2"), sep = " ")

## Bigrams - retirando palavras irrelevantes
bigrams_filtered <- bigrams_separated %>%
  filter(!word1 %in% stopwords_pt) %>%
  filter(!word2 %in% stopwords_pt)

(bigram_counts <- bigrams_filtered %>% 
    count(word1, word2, sort = TRUE))

## Unindo as palavras apos a retirada das palavras irrelevantes  
(bigrams_united <- bigrams_filtered %>%
    unite(bigram, word1, word2, sep = " "))

## Filtrando palavras
bigrams_filtered %>%
  filter(word1 == "terra") %>%
  count(word2, sort = TRUE)

bigrams_filtered %>%
  filter(word2 == "terra") %>%
  count(word1, sort = TRUE)

## Ngrans - pode-se organizar em mais de duas palavras 
teste_df %>%
  unnest_tokens(trigram, text, token = "ngrams", n = 3) %>%
  separate(trigram, c("word1", "word2", "word3"), sep = " ") %>%
  anti_join(stopwords_pt_df, by = c("word1" = "word")) %>%
  anti_join(stopwords_pt_df, by = c("word2" = "word")) %>%
  anti_join(stopwords_pt_df, by = c("word3" = "word")) %>%
  count(word1, word2, word3, sort = TRUE)


## Organizando bigrans que mais ocorreram 
bigram_graph <- bigram_counts %>%
  filter(n > 1) %>%
  graph_from_data_frame()
bigram_graph

## Criando um grafo ligando as palavras
ggraph(bigram_graph, layout = "fr") +
  geom_edge_link() +
  geom_node_point() +
  geom_node_text(aes(label = name), vjust = 1, 
                 hjust = 1)+
  theme_void()

## Criando um grafo mais bonito

## Tipo de seta e tamanho
a <- grid::arrow(type = "closed", 
                 length = unit(.3, "cm"))

## Criando o grafo
ggraph(bigram_graph, layout = "fr") +
  geom_edge_link(aes(edge_alpha = n),
                 show.legend = FALSE,
                 arrow = a, 
                 end_cap = circle(.2, 'cm')) +
  geom_node_point(color = "lightblue", size = 5) +
  geom_node_text(aes(label = name), 
                 vjust = 1, hjust = 1) +
  theme_void()


library(echarts4r)

## 10 palavras mais faladas
palavras<-teste_token %>%
  count(word, sort = TRUE) %>%
  head(10)

## Criando Grafico de barras
palavras %>%
  e_charts(word) %>%
  e_bar(n, name="Palavras",label=list(show=TRUE)) %>%
  e_flip_coords()%>%
  e_grid(left = "25%")%>%
  e_toolbox_feature(
    feature = "saveAsImage",
    title = "Download")

## 50 palavras mais faladas
palavras2<-teste_token %>%
  count(word, sort = TRUE) %>%
  head(50)

## Nuvem de palavras
palavras2 %>% 
  e_color_range(n, color) %>%
  e_charts() %>% 
  e_cloud(word, n, color,
          shape = "circle", 
          rotationRange = c(0, 0),
          sizeRange = c(8, 110)) %>%
  e_tooltip() %>% 
  e_title("Nuvem de Palavras",
          "Capítulos 1 ao 3 do livro Pálido Ponto Azul")%>%
  e_toolbox_feature(
    feature = "saveAsImage",
    title = "Download")







###################### 2- Questão  #############################



## Banda Coastal aersol - observação da água costeira e da cor do oceano
banda1 <- raster("img_sentinel.tif", band =1)

## Banda Azul
banda2 <- raster("img_sentinel.tif", band =2) 

## Banda Verde
banda3 <- raster("img_sentinel.tif", band =3)

## Banda Vermelha
banda4 <- raster("img_sentinel.tif", band =4)

## Banda Infravermelho próximo
banda5 <- raster("img_sentinel.tif", band =5)




plot(banda1)
plot(banda2)
plot(banda3)
plot(banda4)
plot(banda5)

## Empilhando todas as bandas
image <- stack(banda1, banda2, banda3, banda4, banda5)
plot(image)

## Numero de Camadas
nlayers(image)

## Sistema de coordenadas
crs(image)

## Plotando as cores verdadeiras 
plotRGB(image, r = 4, g = 3, b = 2, axes = F,
        stretch = "lin", 
        main = "Cores verdadeiras")

## Plotando as cores falsas 
plotRGB(image, r = 5, g = 4, b = 3, axes = F,
        stretch = "lin", main = "Cores Falsas")

## Analisando o histograma dos pixels
hist(image)

##  Índice de Vegetação por Diferença Normalizada

ndvi <- (image[[5]] - image[[4]])/(image[[5]] + image[[4]])

min(ndvi@data@values, na.rm = T)

max(ndvi@data@values, na.rm = T)

## Plotando o NDVI

as(ndvi, "SpatialPixelsDataFrame") %>%
  as.data.frame() %>%
  ggplot(data = .) +
  geom_tile(aes(x = x, y = y, fill = layer)) +
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.background = element_blank(),
        panel.grid.minor = element_blank()) +
  labs(title = "NDVI para Aracaju-SE - Brasil",
       x = " ",
       y = " ") +
  scale_fill_gradient(high = "#CEE50E",
                      low = "#087F28",
                      name = "NDVI")

## Visualizando a imagem no mapa
library(mapview)

viewRGB(image, r = 4, g = 3, b = 2)

## Visualizando a imagem ndvi
library(RColorBrewer)
cor <- colorRampPalette(brewer.pal(9, "YlGn")) # color palette


## Mapa
mapview(ndvi,col.regions = cor,legend=TRUE)

