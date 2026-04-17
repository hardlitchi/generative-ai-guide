# 文字コードをUTF-8に設定
$OutputEncoding = [System.Text.Encoding]::UTF8

# 1. 実行されているスクリプトの場所へ移動
Set-Location $PSScriptRoot

Write-Host '🚀 [1/4] 道具 (Node.js/nvm) の準備を確認しています... ' -ForegroundColor Cyan

# nvm があるかチェック
$nvmExists = Get-Command nvm -ErrorAction SilentlyContinue

if (-not $nvmExists) {
    # nvmがないのにnodeがある場合 = 直接インストールされている
    $nodeExists = Get-Command node -ErrorAction SilentlyContinue
    if ($nodeExists) {
        Write-Host "⚠️ Node.jsが直接インストールされているのを見つけました。" -ForegroundColor Yellow
        Write-Host "プロの環境にするために、今あるNode.jsを一度消して、nvm（管理ツール）に切り替えることをおすすめします。" -ForegroundColor Gray
        $cleanChoice = Read-Host "今のNode.jsを削除して、nvmに切り替えますか？ (Y/N)"
        if ($cleanChoice -eq 'Y' -or $cleanChoice -eq 'y') {
            Write-Host "🛠 Node.jsを削除しています... 設定画面が開いたら手動でアンインストールしてください。" -ForegroundColor Yellow
            Start-Process ms-settings:appsfeatures
            Write-Host "完了したらEnterキーを押してください。" -ForegroundColor White
            Read-Host
        } else {
            Write-Host "🆗 そのまま続行します。不具合が出た場合はnvmへの移行を検討してください。" -ForegroundColor Gray
            goto :START_BUILD
        }
    }

    Write-Host '🛠 nvm (Node Version Manager) をインストールします... ' -ForegroundColor Yellow
    winget install -e --id CoreyButler.nvm-for-windows --silent --accept-source-agreements --accept-package-agreements
    Write-Host '✅ nvmのインストールが完了しました！ ' -ForegroundColor Green
    Write-Host '⚠️ 重要: 設定を反映させるため、PCを一度「再起動」してからもう一度実行してください。 ' -ForegroundColor Yellow
    Read-Host 'Enterキーを押すと閉じます '
    exit
}

# Node.jsが入っていない、またはnvmがある場合のセットアップ
:START_BUILD
$nodeExists = Get-Command node -ErrorAction SilentlyContinue
if (-not $nodeExists) {
    Write-Host '📦 nvmを使って Node.js (LTS版) を準備しています... ' -ForegroundColor Yellow
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
