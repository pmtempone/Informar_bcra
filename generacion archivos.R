#grabar archivos delimitados

library(gdata)

proveedores_campos <- c(4,5,6,2,11,55,2,14,1,1,1,1,1,4,8,1)

importes_campos <- c(4,5,6,2,11,2,12,1)

write.fwf(proveedores, file="PROVEEDORES.txt", width=proveedores_campos, colnames=FALSE,na="",sep = "")

write.fwf(importes, file="IMPORTES.txt", width=importes_campos, colnames=FALSE,na="",sep = "")

#archivos a incluir e el cd

#----generacion cup e ID_CD.TXT-----

cod_institucion <- codigo_entidad

#nro orden, 8 digitos no se pueden repetir en el año, arranca con 1 por ser CD
nro_orden <- 10000000+round((runif(1, 1,9999999)),0)


#fecha de generacion AAAAMMDD

fecha_generacion <- 20170601

codigo_cup_sinverificador <- paste(55099,nro_orden,fecha_generacion,sep = "")

codigo_to_vector <- as.numeric(strsplit(codigo_cup_sinverificador, "")[[1]])

factores <- c(2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2)

producto_cup <- codigo_to_vector*factores

acumulado_cup <- c()
  
for (i in 1:length(producto_cup)) {
  acumulado_cup[i] <- ifelse((nchar(as.character(producto_cup[i]))>1)==TRUE,sum(as.numeric(strsplit(as.character(producto_cup[i]), "")[[1]])),producto_cup[i])
}
  
digito_verificador <- ifelse((nchar(as.character(100-sum(acumulado_cup)))>1)==TRUE,sum(as.numeric(strsplit(as.character(100-sum(acumulado_cup)), "")[[1]])),100-sum(acumulado_cup))

codigo_cup_converificador <- paste(55099,nro_orden,fecha_generacion,digito_verificador,sep = "")

write.table(codigo_cup_converificador,"ID_CD.TXT",col.names = FALSE,row.names = FALSE,quote = FALSE)


#----generacion de archivo D_PRES.TXT-----


#regimenes a informar

regimen_informativo <- c(4304,4314)
requerimiento <- c()

ID_PRES <- data.frame(cod_regimen="00002",cod_req="00001",periodo=20170531,opera=0,tipo_pres="N")



write.table(ID_PRES,"ID_PRES.TXT",col.names = FALSE,row.names = FALSE,quote = FALSE,sep = "")
