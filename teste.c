
//isso vai rodar no seu server
chave_publica = sha256(boleto  + chave_privada)

envia  o boleto anexada junto com a chave publica
cria um site , em que permita o usuario fazer  o upload do boleto + chave pública

//isso vai rodar no seu server
testagem  = sha256(boleto  + chave_privada)
se  testagem == chave_publica fornececida pelo usuario no headder então
vocẽ emitiu, cas contrario foi adulterado
