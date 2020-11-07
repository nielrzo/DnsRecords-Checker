# Ferramenta de Consulta de Tabelas DNS #
# Autor: Daniel Freitas #
# Data: 07/11/2020 #
# Dependências: Módulo DNSClient-PS (Install-Module)

## Variáveis globais ##

$dominios = Import-csv 'C:\tmp\dominios.csv' # Lista de domínios a serem consultados
$arquivoSaida = 'C:\tmp\Registros.csv' # Arquivo para onde serão exportados os resultados
$chave  = '*spf1.*' # Palavras-chave que serão pesquisadas na tabela de domínios


foreach ($item in $dominios){

$dns = $item.domain

$resolver = Resolve-DnsName $dns -type TXT

$entradasTxt = $resolver.Strings

if ($entradasTxt -like $chave) {
    $resultado = "Atualizado"}
else {
    $resultado = "Desatualizado"}


$detalhes = @{

    Nome = $dns
    Status = $resultado
    Chave_Pesquisada = $chave}

$exportar = New-Object PSObject -Property $detalhes | Export-csv -Append -Path $arquivoSaida -NoTypeInformation}
