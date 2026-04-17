@echo off
chcp 65001 >nul
setlocal

echo 🚀 [1/4] Node.js の準備を確認しています...

rem Node.jsがあるかチェック
node -v >nul 2>&1
if %errorlevel% neq 0 goto :INSTALL_NODE

:CHECK_LOGIN
echo 🔑 [2/4] ログイン状態を確認しています...
rem Vercelにログインしているかチェック
call npx vercel whoami >nul 2>&1
if %errorlevel% neq 0 goto :LOGIN_VERCEL

:BUILD
echo 📦 [3/4] 資料をWebサイトの形に変換しています...
call npm install --quiet
call npm run build

:DEPLOY
echo 🌐 [4/4] 世界中に公開しています...
call npx vercel --prod --yes
if %errorlevel% neq 0 goto :DEPLOY_ERROR

echo ✨ すべて完了しました！
echo 表示されたURLを Ctrlキーを押しながらクリック して確認してください。
pause
exit /b

:INSTALL_NODE
echo 🛠 Node.js が見つかりません。自動でインストールを開始します...
echo ※許可を求める画面が出たら「はい」を押してください。
winget install -e --id OpenJS.NodeJS.LTS --silent --accept-source-agreements --accept-package-agreements
if %errorlevel% neq 0 (
    echo ❌ 自動インストールに失敗しました。https://nodejs.org/ から入れてください。
    pause
    exit /b
)
echo ✅ インストール完了！この画面を閉じ、もう一度実行してください。
pause
exit /b

:LOGIN_VERCEL
echo 🔓 Vercelにログインしていません。
echo 今からブラウザが開くので、ログインを完了させてください。
call npx vercel login
goto :BUILD

:DEPLOY_ERROR
echo ❌ デプロイ中にエラーが発生しました。
pause
exit /b
