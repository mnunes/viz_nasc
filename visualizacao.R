# pacotes necessarios

library(tidyverse)
library(viridis)

# leitura dos dados

load("dados/nascimento.RData")

dias <- substr(nascimento, 1, 2)

meses <- substr(nascimento, 3, 4)

datas <- substr(nascimento, 1, 4)

datas <- datas[datas != "0000"]

datas_tabela <- table(datas)

datas_tabela_proporcao <- as.vector(datas_tabela/mean(datas_tabela)-1)*100

summary(datas_tabela_proporcao)

# criacao da malha de datas

meses <- c("Janeiro", "Fevereiro", "Março",
					 "Abril", "Maio", "Junho",
					 "Julho", "Agosto", "Setembro",
					 "Outubro", "Novembro", "Dezembro")

malha <- expand.grid(x = meses, y = 1:31)

malha <- malha %>%
	arrange(y)

# retirar dias que nao existem

malha <- malha %>%
	#filter(!(x == "Fevereiro" & y >= 29)) %>%
	filter(!(x %in% c("Abril", "Junho", "Setembro", "Novembro") & y > 30)) %>%
	mutate(x = factor(x, levels = c("Janeiro", "Fevereiro", "Março",
																	"Abril", "Maio", "Junho",
																	"Julho", "Agosto", "Setembro",
																	"Outubro", "Novembro", "Dezembro")))

# colocar as porcentagens dos nascimentos

#malha <- data.frame(malha, prop = datas_tabela_proporcao[-338])
malha <- data.frame(malha, prop = datas_tabela_proporcao)

ggplot(malha, aes(x = y, y = fct_rev(x), fill = prop)) + 
	geom_tile(colour = "white") +
	scale_fill_viridis() +
	scale_x_continuous(breaks = 1:31) +
	coord_equal() +
	theme_minimal() +
	theme(panel.grid.major = element_blank(), 
				panel.grid.minor = element_blank()) + 
	labs(x = "", 
			 y = "", 
			 fill = "Comparação\ncom a Média", 
			 title = "As datas de aniversário mais comuns no Brasil: 1996-2018",
			 caption = "https://marcusnunes.me")

