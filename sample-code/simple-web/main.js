// ---------------------------------------------------------
// AIと作ったWebサイトに動きをつけるプログラム (JavaScript)
// ---------------------------------------------------------

console.log("🛠️ JavaScriptの読み込みが成功しました！");
console.log("この画面（開発者ツール）の「コンソール」は、プログラムからの手紙を読む場所です。");

// 1. HTMLの中にある「ボタン」と「メッセージを表示する場所」を探して、変数に保存します
const magicButton = document.getElementById("magicButton");
const messageArea = document.getElementById("message");

// 保存がうまくいったか確認します
console.log("📍 HTMLの要素を見つけました:", { magicButton, messageArea });

// 2. ボタンが「クリックされたとき」の動作を設定します
magicButton.addEventListener("click", () => {
    
    // クリックされたことをコンソールに記録します
    console.log("👆 ボタンがクリックされました！魔法が始まります。");

    // メッセージの内容を設定します
    const messages = [
        "🌸 おめでとう！最初のWebページを動かせましたね！",
        "🚀 プログラミングは、AIがいれば怖くありません。",
        "✨ あなたのアイデアを、形にする第一歩です！",
        "💡 失敗しても大丈夫。AIに聞いて何度でも挑戦しましょう。"
    ];

    // ランダムに1つメッセージを選びます
    const randomIndex = Math.floor(Math.random() * messages.length);
    const selectedMessage = messages[randomIndex];

    // 選ばれたメッセージを画面に表示します
    messageArea.innerText = selectedMessage;
    messageArea.style.color = "#007bff";

    // 演出として、コンソールにも表示します
    console.log("📝 表示されたメッセージ:", selectedMessage);
    console.log("🎉 これでWebページとの会話が成立しました！");
});

console.log("✅ 全ての設定が完了しました。ボタンを押して遊んでみてください！");
