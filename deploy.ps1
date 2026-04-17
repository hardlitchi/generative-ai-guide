# 文字コードをUTF-8に設定
$OutputEncoding = [System.Text.Encoding]::UTF8

# 1. 実行されているスクリプトの場所へ移動
Set-Location $PSScriptRoot

Write-Host '🚀 [1/4] 道具 (Node.js) の準備を確認しています... ' -ForegroundColor Cyan

# Node.jsがあるかチェック
$nodeExists = Get-Command node -ErrorAction SilentlyContinue
if (-not $nodeExists) {
    Write-Host '🛠 Node.js が見つかりません。インストールを開始します... ' -ForegroundColor Yellow
    winget install -e --id OpenJS.NodeJS.LTS --silent --accept-source-agreements --accept-package-agreements
    Write-Host '✅ インストール完了！一度この画面を閉じ、もう一度実行してください。 ' -ForegroundColor Green
    Read-Host 'Enterキーを押すと閉じます '
    exit
}

Write-Host '📦 [2/4] 資料をWebサイトの形に変換しています... ' -ForegroundColor Cyan
# 依存関係をインストール (ここにvercelも含まれる)
npm install --quiet
npm run build

Write-Host '🔑 [3/4] 公開の準備 (ログイン) を確認しています... ' -ForegroundColor Cyan
# npxのキャッシュバグを避けるため、npm exec を使用
$null = npm exec vercel whoami 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host '🔓 Vercelにログインしていません。 ' -ForegroundColor Yellow
    Write-Host '今からブラウザが開くので、ログインを完了させてください。 '
    npm exec vercel login
}

Write-Host '🌐 [4/4] 世界中に公開しています... ' -ForegroundColor Cyan
# --yes フラグを付けて自動化
npm exec vercel -- --prod --yes

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✨ すべて完了しました！ " -ForegroundColor Green
    Write-Host "表示された URL を Ctrlキーを押しながらクリック して確認してください。 "
} else {
    Write-Host "❌ デプロイ中にエラーが発生しました。 " -ForegroundColor Red
}

Read-Host 'Enterキーを押すと閉じます '
