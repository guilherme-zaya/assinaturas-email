# Conectar ao Exchange Online
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline

# Postergar roaming signatures
Set-OrganizationConfig -PostponeRoamingSignaturesUntilLater $true

# Caminhos
$Base = 'C:\Assinaturas Zaya.it\Dependencias-Exchange"'
$TemplatePath = Join-Path $Base 'modelo-assinatura.html'
$CsvPath = Join-Path $Base 'assinaturas-zaya.csv'
$LogPath = Join-Path $Base 'log-assinaturas.txt'

# Validar arquivos
if (!(Test-Path $TemplatePath)) { Write-Error "Arquivo HTML não encontrado."; exit }
if (!(Test-Path $CsvPath)) { Write-Error "Arquivo CSV não encontrado."; exit }

# Carregar template
$Template = Get-Content -LiteralPath $TemplatePath -Raw

# Detectar delimitador
$Delimiter = ','; if ((Get-Content -LiteralPath $CsvPath -First 1) -match ';') { $Delimiter = ';' }

# Importar CSV
$rows = Import-Csv -Path $CsvPath -Delimiter $Delimiter | Where-Object { $_.UserPrincipalName -and $_.ImageUrl }

# Limpar log anterior
if (Test-Path $LogPath) { Remove-Item $LogPath }

# Aplicar para cada usuário
foreach ($u in $rows) {
    try {
        $sigHtml = $Template -replace '__IMAGE_URL__', $u.ImageUrl

        # Forçar HTML
        Set-MailboxMessageConfiguration -Identity $u.UserPrincipalName -DefaultFormat Html

        # Aplicar assinatura
        Set-MailboxMessageConfiguration -Identity $u.UserPrincipalName `
            -SignatureHtml $sigHtml `
            -AutoAddSignature $true `
            -AutoAddSignatureOnReply $true

        Add-Content -Path $LogPath -Value "✅ $($u.UserPrincipalName) - Assinatura aplicada com sucesso."
    }
    catch {
        Add-Content -Path $LogPath -Value "❌ $($u.UserPrincipalName) - Erro: $($_.Exception.Message)"
    }
}

# Opcional: Reativar roaming depois
# Set-OrganizationConfig -PostponeRoamingSignaturesUntilLater $false

Write-Host "Processo concluído. Verifique o log em $LogPath"