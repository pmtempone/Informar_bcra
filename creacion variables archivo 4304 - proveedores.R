#archivo 4304 - proveedores.txt
library(dplyr)

codigo_diseño <- rep(4304,nrow(info_bcra_sdc))

codigo_entidad <- rep(55099,nrow(info_bcra_sdc))

fecha_informacion <- rep(201705,nrow(info_bcra_sdc))

tipo_identificacion <- rep(11,nrow(info_bcra_sdc))


cuit_clientes <- data.frame(clientes=(gsub("-","",info_bcra_sdc$Cliente_Cuit)))
cuit_clientes$clientes <- as.character(cuit_clientes$clientes)
cuit_clientes$cant_char <- nchar(trimws(cuit_clientes$clientes))
numero_identificacion <- ifelse(cuit_clientes$cant_char==11,trimws(cuit_clientes$clientes),
                                ifelse(cuit_clientes$cant_char<10,
                                       paste("00",trimws(cuit_clientes$clientes),sep = ""),
                                       paste("0",trimws(cuit_clientes$clientes),sep = "")))

denominacion <- c(info_bcra_sdc$AyN)

#ver situacion, porque pide poner dos digitos, y un numerico de 01 no existe

situacion <- info_bcra_sdc$sit_wenance_informar

#capital mas intereses (se sacan los punitorios)

total_deuda <- ifelse(round((info_bcra_sdc$`Total de deuda` - info_bcra_sdc$PunitoriosAdeudados)/1000,1)<0.5,
                      round((info_bcra_sdc$SaldoCuotasNoVencidas)/1000,1),
                      round((info_bcra_sdc$`Total de deuda` - info_bcra_sdc$PunitoriosAdeudados)/1000,1))*1000

Deudor_encuadrado <- rep(0,nrow(info_bcra_sdc))

refinanciaciones <- ifelse(grepl("REFINANCIACION",toupper(iconv(info_bcra_sdc$NombreLinea,"latin1")))==TRUE,1,0)

recateg_oblig <- rep(0,nrow(info_bcra_sdc))

sit_juridica <- rep(0,nrow(info_bcra_sdc))

irrecup_disp_tecnica <- rep(0,nrow(info_bcra_sdc))

dias_atraso <- info_bcra_sdc$DiasAtraso

fecha_ult_refi <- ifelse(refinanciaciones==1,as.numeric(paste(substr(info_bcra_sdc$fecha_otorgado,7,10),
                                                              substr(info_bcra_sdc$fecha_otorgado,4,5),
                                                              substr(info_bcra_sdc$fecha_otorgado,1,2))),0)

fecha_ult_refi <- ifelse(is.na(fecha_ult_refi)==TRUE,0,fecha_ult_refi)


Rectificativa <- rep("N",nrow(info_bcra_sdc))


proveedores <- data.frame(codigo_diseno=codigo_diseño,codigo_entidad,fecha_informacion,tipo_identificacion,
                          numero_identificacion,denominacion,situacion,total_deuda,Deudor_encuadrado,
                          refinanciaciones,recateg_oblig,sit_juridica,irrecup_disp_tecnica,dias_atraso,
                          fecha_ult_refi,Rectificativa)

proveedores <- proveedores %>% filter(total_deuda>0.5)


proveedores$total_deuda <- str_pad(proveedores$total_deuda,14, pad = "0")
proveedores$fecha_ult_refi <- str_pad(proveedores$fecha_ult_refi,8, pad = "0")
proveedores$dias_atraso <- str_pad(proveedores$dias_atraso,4, pad = "0")
