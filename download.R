# parametros para uf e anos

uf <- c("RO", "AC", "AM", "RR", "PA", "AP", "TO", "MA", "PI", "CE", "RN", "PB", "PE", "AL", "SE", "BA", "MG", "ES", "RJ", "SP", "PR", "SC", "RS", "MS", "MT", "GO", "DF")

ano <- 1996:2018

# loop para baixar os arquivos

for (i in uf){
	for (j in ano){
		
		# criacao das urls
		url <- paste0("ftp://ftp.datasus.gov.br/dissemin/publicos/SINASC/NOV/DNRES//DN", i, j, ".DBC")
		
		# download dos arquivos
		download.file(url, destfile = paste0("dados/", i, j, ".DBC"))
		
	}
}

