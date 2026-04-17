# 文字コードをUTF-8に設定
$OutputEncoding = [System.Text.Encoding]::UTF8

# 1. 実行されているスクリプトの場所へ移動
Set-Location $PSScriptRoot

Write-Host '🚀 [1/4] 道具 (Node.js/nvm) の準備を確認しています... ' -ForegroundColor Cyan

# nvm があるかチェック
$nvmExists = Get-Command nvm -ErrorAction SilentlyContinue
if (-not $nvmExists) {
    Write-Host '🛠 nvm (Node Version Manager) が見つかりません。セットアップを開始します... ' -ForegroundColor Yellow
    Write-Host 'これを入れると、Node.jsのバージョン管理がとても楽になります。 ' -ForegroundColor Gray
    winget install -e --id CoreyButler.nvm-for-windows --silent --accept-source-agreements --accept-package-agreements
    Write-Host '✅ nvmのインストールが完了しました！ ' -ForegroundColor Green
    Write-Host '⚠️ 重要: 設定を反映させるため、PCを再起動するか、一度ログアウトしてからもう一度実行してください。 ' -ForegroundColor Yellow
    Read-Host 'Enterキーを押すと閉じます '
    exit
}

# Node.js が入っているかチェック
$nodeExists = Get-Command node -ErrorAction SilentlyContinue
if (-not $nodeExists) {
    Write-Host '📦 nvmを使って Node.js (LTS版) をインストールしています... ' -ForegroundColor Yellow
    nvm install lts
    nvm use lts
}

# バージョンが古い場合も nvm で更新
$nodeVersion = node -v
$vNumber = [version]($nodeVersion -replace 'v', '')
if ($vNumber -lt [version]"20.10.0") {
    Write-Host "⚠️ 現在の Node.js ($nodeVersion) は少し古いです。nvmで最新版に切り替えます。 " -ForegroundColor Yellow
    nvm install lts
    nvm use lts
}

Write-Host '📦 [2/4] 資料をWebサイトの形に変換しています... ' -ForegroundColor Cyan
npm install --quiet
npm run build

Write-Host '🔑 [3/4] 公開の準備 (ログイン) を確認しています... ' -ForegroundColor Cyan
$null = npm exec vercel whoami 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host '🔓 Vercelにログインしていません。 ' -ForegroundColor Yellow
    Write-Host '今からブラウザが開くので、ログインを完了させてください。 '
    npm exec vercel login
}

Write-Host '🌐 [4/4] 世界中に公開しています... ' -ForegroundColor Cyan
npm exec vercel -- --prod --yes

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✨ すべて完了しました！ " -ForegroundColor Green
    Write-Host "表示された URL を Ctrlキーを押しながらクリック して確認してください。 "
} else {
    Write-Host "❌ デプロイ中にエラーが発生しました。 " -ForegroundColor Red
}

Read-Host 'Enterキーを押すと閉じます '
