@echo off
setlocal
echo 🚀 [1/4] 道具（Node.js）の準備を確認しています...

:: Node.jsがあるかチェック
node -v >nul 2>&1
if %errorlevel% neq 0 (
    echo 🛠 Node.jsが見つかりません。自動でインストールを開始します...
    echo ※許可を求める画面が出たら「はい」を押してください。
    
    :: wingetを使ってNode.jsをインストール
    winget install -e --id OpenJS.NodeJS.LTS --silent --accept-source-agreements --accept-package-agreements
    
    if %errorlevel% neq 0 (
        echo ❌ 自動インストールに失敗しました。
        echo お手数ですが https://nodejs.org/ から「LTS」版をダウンロードして入れてください。
        pause
        exit /b
    )
    echo ✅ インストールが完了しました！一度この画面を閉じ、もう一度 deploy.bat を実行してください。
    pause
    exit /b
)

echo 🔑 [2/4] 公開の準備（ログイン）を確認しています...
:: Vercelにログインしているかチェック
call npx vercel whoami >nul 2>&1
if %errorlevel% neq 0 (
    echo 🔓 Vercelにログインしていません。
    echo 今からブラウザが開くので、ログインを完了させてください。
    call npx vercel login
)

echo 📦 [3/4] 資料をWebサイトの形に変換しています...
call npm install --quiet
call npm run build

echo 🌐 [4/4] 世界中に公開しています...
call npx vercel --prod --yes

if %errorlevel% eq 0 (
    echo ✨ すべて完了しました！
    echo 表示された「Production」のURLを Ctrlキーを押しながらクリック して確認してください。
) else (
    echo ❌ デプロイ中にエラーが発生しました。
)

pause
