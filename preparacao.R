# preparacao dos dados

arquivos <- list.files("dados")

library(read.dbc)

dados <- read.dbc(file = paste0("dados/", arquivos[1]))

nascimento <- as.character(dados$DTNASC)

for (j in arquivos[-1]) {
	dados <- read.dbc(file = paste0("dados/", j))
	nascimento <- c(nascimento, as.character(dados$DTNASC))
}

length(nascimento)

save(nascimento, file = "dados/nascimento.RData")
