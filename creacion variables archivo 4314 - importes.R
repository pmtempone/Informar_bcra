#creacion variables archivo 4314 - importes.txt
library(dplyr)

codigo_diseño <- rep(4314,nrow(info_bcra_sdc))

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

Asistencia_crediticia <- rep(09,nrow(info_bcra_sdc))


'Los importes se expresarán en pesos sin decimales. A los fines del redondeo de las magnitudes
se incrementarán los valores en una unidad cuando el primer dígito de las fracciones sea igual o
mayor que 5, desechando las que resulten inferiores.'
Importe <-  ifelse(round((info_bcra_sdc$`Total de deuda` - info_bcra_sdc$PunitoriosAdeudados)/1000,1)<0.5,
                   round((info_bcra_sdc$SaldoCuotasNoVencidas)/1000,1),
                   round((info_bcra_sdc$`Total de deuda` - info_bcra_sdc$PunitoriosAdeudados)/1000,1))

Rectificativa <- rep("N",nrow(info_bcra_sdc))

importes <- data.frame(codigo_diseno=codigo_diseño,codigo_entidad,fecha_informacion,tipo_identificacion,
                          numero_identificacion,Asistencia_crediticia,Importe,Rectificativa)

importes <- importes %>% filter(Importe>0.5)
