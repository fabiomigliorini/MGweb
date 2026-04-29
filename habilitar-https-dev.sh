#!/bin/bash
set -e

### CONFIG
CERT_DIR="$HOME/.certs-mg-dev"
DOMAINS=(
  "api-mgspa-dev.mgpapelaria.com.br"
  "auth-dev.mgpapelaria.com.br"
  "sistema-dev.mgpapelaria.com.br"
  "negocios-dev.mgpapelaria.com.br"
  "notas-dev.mgpapelaria.com.br"
  "pessoas-dev.mgpapelaria.com.br"
)

echo "==> Detectando IP da máquina..."
IP=$(ip route get 1 | awk '{print $7; exit}')

if [[ -z "$IP" ]]; then
  echo "❌ Não foi possível detectar o IP da máquina"
  exit 1
fi

echo "✔ IP detectado: $IP"

### INSTALAR MKCERT SE NÃO EXISTIR
if ! command -v mkcert >/dev/null 2>&1; then
  echo "==> mkcert não encontrado, instalando..."
  sudo apt update
  sudo apt install -y mkcert
fi

### CRIAR DIRETÓRIO DE CERTIFICADOS
echo "==> Criando diretório de certificados em $CERT_DIR"
mkdir -p "$CERT_DIR"
cd "$CERT_DIR"

### INSTALAR CA LOCAL
echo "==> Instalando CA local do mkcert"
mkcert -install

### GERAR CERTIFICADO
echo "==> Gerando certificado único para:"
echo " - $IP"
for d in "${DOMAINS[@]}"; do
  echo " - $d"
done

mkcert "$IP" "${DOMAINS[@]}"

### IMPORTAR CA NO SISTEMA (Chrome / Edge / Chromium)
echo "==> Importando CA no trust store do sistema (Chrome / Edge)"
CAROOT=$(mkcert -CAROOT)
sudo cp "$CAROOT/rootCA.pem" /usr/local/share/ca-certificates/mkcert-rootCA.crt
sudo update-ca-certificates

echo
echo "✅ HTTPS DEV habilitado com sucesso!"
echo
echo "📁 Certificados gerados em:"
echo "   $CERT_DIR"
ls -lh *.pem
echo
echo "👉 Use no Nginx / Docker:"
echo "ssl_certificate     $CERT_DIR/<arquivo>.pem;"
echo "ssl_certificate_key $CERT_DIR/<arquivo>-key.pem;"

