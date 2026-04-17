#!/bin/bash

echo "🚀 [1/4] 道具（Node.js）の準備を確認しています..."

if ! command -v node &> /dev/null
then
    echo "🛠 Node.jsが見つかりません。インストールを試みます..."
    
    if command -v brew &> /dev/null; then
        brew install node
    elif command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y nodejs npm
    else
        echo "❌ 自動インストールができませんでした。"
        echo "https://nodejs.org/ からダウンロードしてインストールしてください。"
        exit 1
    fi
fi

echo "🔑 [2/4] 公開の準備（ログイン）を確認しています..."
if ! npx vercel whoami &> /dev/null
then
    echo "🔓 Vercelにログインしていません。"
    echo "今からブラウザが開くので、ログインを完了させてください。"
    npx vercel login
fi

echo "📦 [3/4] 資料をWebサイトの形に変換しています..."
npm install --quiet
npm run build

echo "🌐 [4/4] 世界中に公開しています..."
npx vercel --prod --yes

if [ $? -eq 0 ]; then
    echo "✨ すべて完了しました！表示されたURLを確認してください。"
else
    echo "❌ デプロイ中にエラーが発生しました。"
    exit 1
fi
