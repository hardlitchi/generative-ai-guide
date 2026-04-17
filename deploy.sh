#!/bin/bash

echo "🚀 [1/4] 道具 (Node.js/nvm) の準備を確認しています..."

# nvm の読み込みを試みる
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if ! command -v nvm &> /dev/null
then
    echo "🛠 nvm が見つかりません。Node.jsを直接確認します..."
    if ! command -v node &> /dev/null; then
        echo "❌ nvmもNode.jsも見つかりませんでした。"
        echo "エンジニアの標準ツールである 'nvm' のインストールをおすすめします。"
        echo "👉 https://github.com/nvm-sh/nvm#installing-and-updating"
        exit 1
    fi
else
    # nvmがある場合は最新LTSを確実に使う
    echo "📦 nvm を使って最新の安定版 Node.js を準備しています..."
    nvm install --lts --quiet
    nvm use --lts --quiet
fi

echo "📦 [2/4] 資料をWebサイトの形に変換しています..."
npm install --quiet
npm run build

echo "🔑 [3/4] 公開の準備 (ログイン) を確認しています..."
if ! npm exec vercel whoami &> /dev/null
then
    echo "🔓 Vercelにログインしていません。"
    echo "今からブラウザが開くので、ログインを完了させてください。"
    npm exec vercel login
fi

echo "🌐 [4/4] 世界中に公開しています..."
npm exec vercel -- --prod --yes

if [ $? -eq 0 ]; then
    echo "✨ すべて完了しました！表示されたURLを確認してください。"
else
    echo "❌ デプロイ中にエラーが発生しました。"
    exit 1
fi
