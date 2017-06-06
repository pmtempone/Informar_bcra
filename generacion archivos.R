#grabar archivos delimitados

library(gdata)

proveedores_campos <- c(4,5,6,2,11,55,2,14,1,1,1,1,1,4,8,1)

importes_campos <- c(4,5,6,2,11,2,12,1)

write.fwf(proveedores, file="PROVEEDORES.txt", width=proveedores_campos, colnames=FALSE,na="",sep = "")

write.fwf(importes, file="IMPORTES.txt", width=importes_campos, colnames=FALSE,na="",sep = "")
