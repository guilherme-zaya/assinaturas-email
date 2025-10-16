# 📨 Script de Aplicação de Assinaturas de E-mail no Exchange Online

Este script em PowerShell automatiza a aplicação de **assinaturas padronizadas de e-mail** para todos os usuários de uma organização no **Exchange Online** (Microsoft 365).

Ele lê um **modelo HTML** e um **arquivo CSV com dados dos usuários**, substitui variáveis dinâmicas (como a URL da imagem) e aplica automaticamente a assinatura em cada caixa de correio.

---

## 📋 Funcionalidades

- Conecta-se ao **Exchange Online** via PowerShell.
- **Desativa temporariamente** o roaming de assinaturas para evitar conflitos.
- Lê um **modelo HTML de assinatura**.
- Importa dados de usuários de um arquivo CSV.
- Substitui variáveis (como imagem, nome, cargo etc.).
- Aplica a assinatura personalizada para cada usuário.
- Gera um **log detalhado** de sucesso e falhas.

---

## 🧩 Estrutura de Pastas

```
C:\Dependencias-Exchange\
│
├── modelo-assinatura.html     # Template HTML da assinatura
├── assinaturas-zaya.csv            # Dados dos usuários
└── log-assinaturas.txt        # Log gerado após execução
```

---

## 📦 Pré-requisitos

Antes de executar o script:

1. **PowerShell 5.1 ou superior** instalado.
2. **Módulo ExchangeOnlineManagement** instalado.
   ```powershell
   Install-Module ExchangeOnlineManagement
   ```
3. Permissões para alterar assinaturas de usuários no Exchange Online.
4. Arquivos:
   - `modelo-assinatura.html` — modelo de assinatura com placeholders.
   - `assinaturas-zaya.csv` — arquivo com dados dos usuários (exemplo abaixo).

---

## 🧾 Exemplo de modelo HTML (`modelo-assinatura.html`)

```html
<div style="font-family:Segoe UI, Arial, sans-serif; font-size:12pt; color:#222;">
  <img style="width:500px; max-width:100%; height:auto" src="__IMAGE_URL__">
</div>
```

> 🧠 Dica: use `__IMAGE_URL__` como marcador.  
> O script substitui automaticamente pelo valor da coluna `ImageUrl` do CSV.

---

## 🧾 Exemplo de CSV (`assinaturas.csv`)

```csv
UserPrincipalName,ImageUrl
joao.silva@empresa.com,https://empresa.com/imagens/joao.jpg
maria.souza@empresa.com,https://empresa.com/imagens/maria.jpg
```

> O script detecta automaticamente se o delimitador é `,` ou `;`.

---

## 🚀 Execução

1. **Abra o PowerShell como Administrador**.
2. Navegue até a pasta onde está o script:
   ```powershell
   cd C:\Dependencias-Exchange
   ```
3. Execute o script:
   ```powershell
   .\Aplicar-Assinaturas.ps1
   ```
4. Faça login com uma conta com permissões administrativas do Exchange.

O script irá:
- Conectar ao Exchange Online.
- Desativar roaming de assinaturas.
- Aplicar a assinatura para cada usuário listado no CSV.
- Gerar o log `log-assinaturas.txt`.

---

## 🧾 Exemplo de Saída no Log

```
✅ joao.silva@empresa.com - Assinatura aplicada com sucesso.
✅ maria.souza@empresa.com - Assinatura aplicada com sucesso.
❌ pedro.lima@empresa.com - Erro: Usuário não encontrado.
```

---

## ⚙️ Reativando Roaming de Assinaturas (opcional)

Após a execução, você pode reativar o roaming:

```powershell
Set-OrganizationConfig -PostponeRoamingSignaturesUntilLater $false
```

---

## 🧰 Tecnologias Utilizadas

- **PowerShell**
- **ExchangeOnlineManagement**
- **Microsoft 365 / Exchange Online**

---

## 📜 Licença

Este projeto está licenciado sob a licença MIT.  
Você pode usar, modificar e distribuir conforme necessário.

---

## 👨‍💻 Autor

**Guilherme / Zaya.it**  
📧 guilherme.fernando@zaya.it  
🌐 [www.zaya.it]
