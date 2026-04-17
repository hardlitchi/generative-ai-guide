const fs = require('fs');
const path = require('path');

// ---------------------------------------------------------
// 🛠 ビルド成果物を「public」フォルダに集める職人プログラム
// ---------------------------------------------------------

const publicDir = path.join(__dirname, 'public');

// 1. publicフォルダを空っぽにして作り直す
console.log("🧹 準備中: public フォルダを整理しています...");
if (fs.existsSync(publicDir)) {
    fs.rmSync(publicDir, { recursive: true, force: true });
}
fs.mkdirSync(publicDir);

// 2. コピーしたいフォルダやファイルのリスト
const targets = [
    { src: 'index.html', dest: 'index.html' },
    { src: 'slides', dest: 'slides' },
    { src: 'sample-code', dest: 'sample-code' },
    { src: 'docs', dest: 'docs' }
];

// 3. 順番にコピーを実行
targets.forEach(target => {
    const srcPath = path.join(__dirname, target.src);
    const destPath = path.join(publicDir, target.dest);

    if (fs.existsSync(srcPath)) {
        console.log(`📦 コピー中: ${target.src} -> public/${target.dest}`);
        fs.cpSync(srcPath, destPath, { recursive: true });
    } else {
        console.warn(`⚠️ 警告: ${target.src} が見つかりませんでした。`);
    }
});

console.log("✅ 全ての資料を public フォルダに集めました！");
