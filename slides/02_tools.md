---
marp: true
theme: default
paginate: true
header: "文系新卒のためのWebサービス自作ガイド"
footer: "Chapter 2: 道具を揃えよう"
---

# 道具を揃えよう！
# 3つの必須ツールをセットアップ

### 〜 挫折しないための最短ステップ 〜

---

# ツールたちの関係図

![mermaid](https://kroki.io/mermaid/svg/eNpLL0osyFAIceFSAILQ4tQiDY3HjU2PG1c9bpyvqamgq2unEBbsnJ-SGq0UFqwAYtgkFenbaTxu2vy4ec_j5s7HTZOezd7xuLH_cXMfWKRDUykWbBpEH9gIPyDDKzhaCUTrZRVDjHjaPfVxY_fjxpmPm1Y8bt78uGkHkMSi2T2zxKM0KVoJQkP0Ptk_9-naGWC93S_bJz7dtRqmEWIVWKNjQUG0Unhq0uOmrWCXTX7ctPPpup5nHRPe72mEKocYCvFnalFyag7Qn2Aa6s3m3sfNzUBPPW5c_bR1zctp3UB7AAqUgzY)

---

# 1. VS Code（ブイエスコート）の準備

プロも愛用する「高機能なノート」をインストールします。

1. **公式サイトにアクセス**
   - [code.visualstudio.com](https://code.visualstudio.com/) を開く
2. **ダウンロード**
   - 「Download for Windows」または「for macOS」をクリック
3. **インストール**
   - ダウンロードしたファイルを開き、すべて「次へ」で進めてOK！
4. **日本語化（おすすめ）**
   - 左側の四角いアイコンをクリックし、「Japanese」と検索してインストールすれば日本語になります。

---

# 2. GitHub（ギットハブ）のアカウント作成

作ったプログラムを保存する「無料の金庫」の鍵を作りましょう。

1. **公式サイトにアクセス**
   - [github.com](https://github.com/) を開く
2. **サインアップ**
   - 「Sign up」をクリックし、メールアドレスを入力
3. **パスワード設定**
   - 忘れないようにメモしておきましょう！
4. **完了！**
   - 登録したメールに届く認証コードを入力すれば完了です。

---

# 3. Node.js（ノード・ジェーエス）の確認

プログラムを動かすための「エンジン」がPCに入っているか確認します。

1. **ターミナル（黒い画面）を開く**
   - VS Codeの上部メニュー「ターミナル」→「新しいターミナル」を選択
3. **魔法の言葉を入力**
   - 下に出てきた画面に `node -v` と入力してEnterキー！

   ```text
   ┌──────────────────────┐
   │ > node -v            │
   │ v20.10.0             │
   └──────────────────────┘
   ```

---

# 3. Node.jsの確認（続き）

3. **数字が出ればOK**
   - `v20.10.0` のような数字が出れば、エンジンは搭載済みです。
4. **出ない場合は？**
   - [nodejs.org](https://nodejs.org/ja) から「LTS（推奨版）」をインストールしましょう。
   - **※インストール直後はVS Codeを一度閉じて、開き直すと確実です。**

---

# まずは準備されたファイルを動かしてみよう！

初心者が絶対に失敗しない、プログラム実行の手順です。

1. **ファイルを見つける**
   - 左側のファイル一覧にある `hello-ai.js` を探します。
2. **右クリックして開く**
   - `hello-ai.js` を右クリックして **「統合ターミナルで開く」** を選択。
3. **魔法の言葉を入力**
   - 下に開いたターミナルに `node hello-ai.js` と入力してEnter！
4. **メッセージが出れば大成功！**
   - 画面に挨拶が表示されたら、あなたのPCでプログラムが動いた証拠です。

---

# これで準備完了です！

### 次のステップでは、いよいよAIにプログラムを書いてもらいます。

**「自分でも意外とすぐできた！」**と思えたら100点満点です！
もし詰まったら、その画面をAIに見せて「どうすればいい？」と聞いてみましょう。

---

# 🧭 次はどこへ行く？

### [ ➔ 詳細 02: 💬 AIへの頼み方（プロンプトのコツ）](03_ai_prompts.html)

[ ← 前のチャプターに戻る（体験） ](00_quick_start.html)
[ 🏠 目次（ロードマップ）に戻る ](../index.html)


