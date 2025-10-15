#!/bin/bash
# ====================================================
# Script para gerar variável DOCKER_AUTH_CONFIG pro Railway
# ====================================================

echo "🚀 Gerador de DOCKER_AUTH_CONFIG para Railway"
echo

# Pede as credenciais
read -p "👉 Informe seu usuário do Docker Hub: " DOCKER_USERNAME
read -s -p "🔑 Informe seu token de acesso (PAT): " DOCKER_PASSWORD
echo

# Cria o arquivo .dockerconfigjson
cat <<EOF > .dockerconfigjson
{
  "auths": {
    "https://index.docker.io/v1/": {
      "auth": "$(echo -n "$DOCKER_USERNAME:$DOCKER_PASSWORD" | base64)"
    }
  }
}
EOF

# Gera o conteúdo codificado
echo
echo "🧱 Gerando conteúdo codificado..."
ENCODED=$(cat .dockerconfigjson | base64)

# Copia para o clipboard (auto detecta sistema)
if command -v pbcopy &> /dev/null; then
  echo "$ENCODED" | pbcopy
  echo "✅ Conteúdo copiado pro clipboard! (macOS)"
elif command -v clip &> /dev/null; then
  echo "$ENCODED" | clip
  echo "✅ Conteúdo copiado pro clipboard! (Windows)"
elif command -v xclip &> /dev/null; then
  echo "$ENCODED" | xclip -selection clipboard
  echo "✅ Conteúdo copiado pro clipboard! (Linux)"
else
  echo "⚠️ Seu sistema não tem suporte automático pra copiar pro clipboard."
  echo "👇 Copie manualmente o conteúdo abaixo:"
  echo
  echo "$ENCODED"
  echo
fi

echo "✅ Pronto! Agora vá até o painel do Railway e adicione uma variável:"
echo "   Name: DOCKER_AUTH_CONFIG"
echo "   Value: (cole o conteúdo já copiado)"
echo
echo "🎯 Depois é só fazer o deploy novamente!"
