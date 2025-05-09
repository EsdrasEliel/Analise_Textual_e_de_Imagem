
# 💻 Projeto de Mineração de Dados — 2024  
**Disciplina:** Mineração de Dados  
**Universidade:** Universidade Federal de Sergipe  
**Autor:** Esdras Eliel Menezes Santos  
**Professor:** Dr. Cleber Martins Xavier  

## 📌 Descrição
Este repositório documenta o trabalho final da disciplina de Mineração de Dados (2024), que foi dividido em dois grandes blocos:  
1. **Mineração de Texto** (Text Mining) a partir dos capítulos iniciais do livro *Pálido Ponto Azul* de Carl Sagan.  
2. **Mineração de Imagem de Satélite** com base em dados multiespectrais da missão Sentinel.

---

## 🧠 Problema 1: Mineração de Texto

### 🗂 Fonte de Dados
O arquivo em PDF com os três primeiros capítulos do livro *Pálido Ponto Azul* foi utilizado como base textual para a análise.

### 🧰 Ferramentas e Bibliotecas Utilizadas (R)
- `pdftools`: leitura de arquivos PDF.
- `tm`, `tidytext`, `stringr`, `dplyr`, `tidyr`: pré-processamento e manipulação textual.
- `wordcloud`: visualização em nuvem de palavras.
- `igraph`, `ggraph`: análise e visualização de grafos de bigramas.
- `ggplot2`: gráficos estatísticos.
- `echarts4r`: visualizações interativas (gráficos de barras e nuvens de palavras).

### ⚙️ Etapas Executadas

1. **Leitura e seleção do texto**:
   - Leitura das páginas relevantes do PDF com `pdf_text()`.
   - Seleção dos capítulos 1 a 3 para análise.

2. **Pré-processamento textual**:
   - Conversão para minúsculas (`tolower`).
   - Remoção de pontuação, números e palavras irrelevantes (stopwords em português).
   - Eliminação de espaços em branco e tokens muito curtos.

3. **Visualização de frequências**:
   - Criação de nuvens de palavras com `wordcloud`.
   - Gráfico de barras das palavras mais frequentes com `echarts4r`.

4. **Tokenização e análise semântica**:
   - Geração de tokens e remoção de stopwords.
   - Cálculo das frequências absolutas.

5. **N-grams (Bigramas e Trigramas)**:
   - Geração de bigramas e trigramas com `unnest_tokens()`.
   - Filtro de palavras irrelevantes.
   - Construção de grafos com `igraph` e visualização com `ggraph`.

6. **Insights**:
   - As palavras mais frequentes foram “terra”, “universo” e “sol”.
   - Foi possível identificar padrões de associação textual relevantes.

---

## 🛰️ Problema 2: Mineração de Imagem de Satélite

### 🗂 Fonte de Dados
Imagem multibanda da missão Sentinel-2 (`img_sentinel.tif`), representando a região da Grande Aracaju (SE).

### 🧰 Ferramentas e Bibliotecas Utilizadas (R)
- `raster`, `sf`: manipulação de imagens raster e análise geoespacial.
- `ggplot2`: visualização da análise NDVI.
- `mapview`, `RColorBrewer`: visualização interativa no mapa.

### ⚙️ Etapas Executadas

1. **Leitura das bandas espectrais**:
   - Bandas extraídas: coastal, azul, verde, vermelho e infravermelho próximo.

2. **Visualização RGB**:
   - Composição de cores verdadeiras (RGB) e cores falsas (infravermelho).

3. **Análise espectral e espacial**:
   - Extração de histograma de pixels.
   - Cálculo do índice NDVI para medir a densidade de vegetação.

4. **Visualização geográfica**:
   - Geração de mapas temáticos com `mapview`.
   - Identificação de áreas urbanas, vegetação e corpos hídricos.

5. **Resultado**:
   - A imagem corresponde à Grande Aracaju (Aracaju, São Cristóvão, Socorro e Barra dos Coqueiros).
   - O NDVI evidenciou alta concentração de vegetação em áreas não urbanizadas.

---

## 📌 Conclusão

Este projeto demonstra a aplicação de técnicas práticas de **Mineração de Texto** e **Mineração de Imagens** utilizando R, bibliotecas estatísticas e de visualização. As análises realizadas permitiram extrair conhecimento tanto de textos quanto de dados espaciais, combinando **ciência de dados** com **interpretação semântica e geoespacial**.

---

## 📁 Organização do Repositório
```
📂 data/
   └── Palido-Ponto-Azul.pdf
   └── img_sentinel.tif

📂 scripts/
   └── Mineração3.R

📄 README.md (este arquivo)
```
