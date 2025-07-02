#!/bin/bash

echo "🚀 Smart deploy..."

# Build com release
flutter build web --release

# Verifica se build/web existe
if [ ! -d "build/web" ]; then
    echo "❌ Build não encontrado!"
    exit 1
fi

# Copia vercel.json para build/web se existir
if [ -f "vercel.json" ]; then
    echo "📄 Copiando vercel.json..."
    cp vercel.json build/web/
fi

# Remove qualquer .git dentro de build/web
if [ -d "build/web/.git" ]; then
    echo "🧹 Removendo .git de build/web..."
    rm -rf build/web/.git
fi

# Remove do cache se já existe como submodule
git rm -r --cached build/web/ 2>/dev/null || true

# Adiciona apenas build/web
echo "📝 Adicionando build/web..."
git add build/web/

# Verifica se algo foi adicionado
if git diff --staged --quiet; then
    echo "⚠️ Nenhuma mudança para commitar"
else
    git commit -m "Deploy: $(date +'%Y-%m-%d %H:%M:%S')"
    git push origin main
    echo "✅ Deploy enviado!"
fi

echo "🏁 Processo concluído!"