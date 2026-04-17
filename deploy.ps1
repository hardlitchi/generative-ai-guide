# 文字コードをUTF-8に設定
 = [System.Text.Encoding]::UTF8

Write-Host '🚀 [1/4] 道具 (Node.js) の準備を確認しています... ' -ForegroundColor Cyan

# Node.jsがあるかチェック
 = Get-Command node -ErrorAction SilentlyContinue
if (-not ) {
    Write-Host '🛠 Node.js が見つかりません。自動でインストールを開始します... ' -ForegroundColor Yellow
    Write-Host '※許可を求める画面が出たら「はい」を押してください。 '
    winget install -e --id OpenJS.NodeJS.LTS --silent --accept-source-agreements --accept-package-agreements
    if ( -ne 0) {
        Write-Host '❌ 自動インストールに失敗しました。https://nodejs.org/ から入れてください。 ' -ForegroundColor Red
        Read-Host 'Enterキーを押すと閉じます '
        exit
    }
    Write-Host '✅ インストール完了！一度この画面を閉じ、もう一度実行してください。 ' -ForegroundColor Green
    Read-Host 'Enterキーを押すと閉じます '
    exit
}

Write-Host '🔑 [2/4] 公開の準備 (ログイン) を確認しています... ' -ForegroundColor Cyan
# npx で vercel が入っていない場合も考慮して --yes を付与
 = npx --yes vercel whoami 2>&1
if ( -ne 0) {
    Write-Host '🔓 Vercelにログインしていません。 ' -ForegroundColor Yellow
    Write-Host '今からブラウザが開くので、ログインを完了させてください。 '
    npx --yes vercel login
}

Write-Host '📦 [3/4] 資料をWebサイトの形に変換しています... ' -ForegroundColor Cyan
npm install --quiet
npm run build

Write-Host '🌐 [4/4] 世界中に公開しています... ' -ForegroundColor Cyan
npx --yes vercel --prod --yes
if ( -eq 0) {
    Write-Host ''
    Write-Host '✨ すべて完了しました！ ' -ForegroundColor Green
    Write-Host '表示された URL を Ctrlキーを押しながらクリック して確認してください。 '
} else {
    Write-Host '❌ デプロイ中にエラーが発生しました。 ' -ForegroundColor Red
}

Read-Host 'Enterキーを押すと閉じます '
