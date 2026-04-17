# 文字コードをUTF-8に設定
$OutputEncoding = [System.Text.Encoding]::UTF8

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

# バージョンチェック (v20.10以上を推奨)
$nodeVersion = node -v
if ($nodeVersion -match "v20\.[0-9]\.") {
    Write-Host "⚠️ 注意: Node.js のバージョンが少し古いです ($nodeVersion) 。 " -ForegroundColor Yellow
    Write-Host "Vercelのデプロイでエラーが出る場合は、最新のLTS版をインストールしてください。 " -ForegroundColor Yellow
}

Write-Host '🔑 [2/4] 公開の準備 (ログイン) を確認しています... ' -ForegroundColor Cyan
$null = npx --yes vercel whoami 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host '🔓 Vercelにログインしていません。 ' -ForegroundColor Yellow
    Write-Host '今からブラウザが開くので、ログインを完了させてください。 '
    npx --yes vercel login
}

Write-Host '📦 [3/4] 資料をWebサイトの形に変換しています... ' -ForegroundColor Cyan
npm install --quiet
npm run build

Write-Host '🌐 [4/4] 世界中に公開しています... ' -ForegroundColor Cyan
# npxでエラーが出る場合はローカルにインストールして実行を試みる
try {
    npx --yes vercel --prod --yes
} catch {
    Write-Host "🛠 Vercelの実行でエラーが出たため、修復を試みます... " -ForegroundColor Yellow
    npm install --save-dev vercel --quiet
    npx vercel --prod --yes
}

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✨ すべて完了しました！ " -ForegroundColor Green
    Write-Host "表示された URL を Ctrlキーを押しながらクリック して確認してください。 "
} else {
    Write-Host "❌ デプロイ中にエラーが発生しました。 " -ForegroundColor Red
    Write-Host "※Node.jsのバージョンを最新(v20.18以上)にすると解決する場合があります。 " -ForegroundColor Yellow
}

Read-Host 'Enterキーを押すと閉じます '
