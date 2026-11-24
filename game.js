const levels = [
  {
    title: '沉睡的<br>零用錢走廊', description: '門後藏著你今晚的第一把鑰匙。',
    lessonTitle: '先存下，再慢慢花', lessonText: '收到零用錢時，先留一部分給未來的自己。剩下的再安排想要和需要。', tag: '儲蓄習慣',
    question: '今晚收到 100 元零用錢，<br>你會怎麼安排？', intro: '把一點點留給未來，讓願望慢慢長大。',
    choices: [
      { text: '全部拿去買糖果，今天開心最重要。', correct: false, feedback: '糖果很開心，但全部花光就沒有存款了。試著為未來留一點。' },
      { text: '先存下 30 元，再用剩下的安排想要的東西。', correct: true, feedback: '答對了！先存一部分，還能練習安排花費。' },
      { text: '把錢藏起來，不告訴任何人。', correct: false, feedback: '把錢收好很重要，也要知道自己存了多少、為什麼存。' }
    ],
    success: '走廊的門亮起來了！你拿到了第一把夢境鑰匙。'
  },
  {
    title: '沉入深海的<br>投資星海', description: '星光忽明忽暗，找到安全航道吧。',
    lessonTitle: '投資會成長，也有風險', lessonText: '投資可能讓錢慢慢增加，也可能減少。先學習、分散風險，並且不把所有錢放在同一處。', tag: '風險與分散',
    question: '你有一袋星星，要讓它們長大，<br>哪個方法比較穩當？', intro: '記住：投資有機會，也會有風險。',
    choices: [
      { text: '把全部星星押在一顆最亮的星上。', correct: false, feedback: '只選一顆，萬一它變暗，損失就很大。' },
      { text: '先了解規則，再分散放在幾個星球。', correct: true, feedback: '答對了！先學習、再分散，可以降低單一風險。' },
      { text: '相信陌生人的保證，星星一定會翻倍。', correct: false, feedback: '沒有人能保證投資一定賺錢。遇到保證高報酬要小心。' }
    ],
    success: '星海為你點亮！兩把鑰匙都收集完成。'
  }
];
let current = 0, score = 0, unlocked = [false, false], chosen = null;
const $ = id => document.getElementById(id);
const modal = $('modal');
function paint() {
  const level = levels[current];
  $('levelEyebrow').textContent = `夢境 0${current + 1} / 02`;
  $('sceneTitle').innerHTML = level.title; $('sceneDescription').textContent = level.description;
  $('lessonTitle').textContent = level.lessonTitle; $('lessonText').textContent = level.lessonText; $('lessonTag').textContent = level.tag;
  $('score').textContent = score; $('scoreProgress').style.width = `${score / 2}%`;
  $('scoreHint').textContent = score ? '星光收集中，繼續前進！' : '答對問題，收集夢境星光';
  $('missionCount').textContent = `${unlocked.filter(Boolean).length} / 2`;
  $('missionText').textContent = unlocked[current] ? '挑戰完成，鑰匙已收入口袋。' : '完成互動挑戰，取得夢境鑰匙。';
  $('keyIndicator').classList.toggle('acquired', unlocked[current]);
  $('challengeButton').textContent = unlocked[current] ? (current === 0 ? '前往下一個夢境' : '查看進步成果') : '開始互動挑戰';
  $('railFill').style.width = `${current === 0 ? (unlocked[0] ? '50%' : '0%') : '100%'}`;
  $('step1').classList.toggle('active', current === 0 || unlocked[0]); $('step2').classList.toggle('active', current === 1 && unlocked[0]);
  $('scene').style.background = current ? 'linear-gradient(180deg,#142b37,#264451 55%,#594c3a)' : '';
  $('scene').classList.toggle('ocean-scene', current === 1);
  $('hero').style.left = current ? '53%' : '39%';
}
function openChallenge() {
  if (unlocked[0] && current === 0) { current = 1; paint(); return; }
  if (unlocked[1] && current === 1) { showSummary(); return; }
  const level = levels[current]; chosen = null;
  $('modalKicker').textContent = `互動挑戰 · 0${current + 1}`;
  $('modalTitle').innerHTML = level.question; $('modalIntro').textContent = level.intro;
  $('feedback').textContent = ''; $('feedback').className = 'feedback'; $('modalNext').disabled = true; $('modalNext').textContent = '確認選擇';
  $('choices').innerHTML = level.choices.map((c, i) => `<button class="choice" data-index="${i}"><span class="choice-mark">${String.fromCharCode(65 + i)}</span><span>${c.text}</span></button>`).join('');
  $('choices').querySelectorAll('.choice').forEach(btn => btn.addEventListener('click', () => {
    chosen = Number(btn.dataset.index); $('choices').querySelectorAll('.choice').forEach(x => x.classList.toggle('selected', x === btn));
    $('modalNext').disabled = false; $('feedback').textContent = ''; $('feedback').className = 'feedback';
  }));
  modal.classList.add('open'); modal.setAttribute('aria-hidden', 'false');
}
function closeModal() { modal.classList.remove('open'); modal.setAttribute('aria-hidden', 'true'); }
function submitAnswer() {
  if (chosen === null) return;
  const item = levels[current].choices[chosen];
  if (!item.correct) { $('feedback').textContent = item.feedback; $('feedback').className = 'feedback wrong'; return; }
  score += 50; unlocked[current] = true; $('feedback').textContent = item.feedback; $('feedback').className = 'feedback';
  $('modalNext').textContent = current === 1 ? '完成旅程' : '領取鑰匙';
  $('modalNext').onclick = finishLevel;
}
function finishLevel() {
  $('modalNext').onclick = submitAnswer; closeModal(); paint(); toast(levels[current].success);
  if (current === 1) setTimeout(showSummary, 1100);
}
function showSummary() {
  $('modalKicker').textContent = '旅程完成 · 進步成果'; $('modalTitle').innerHTML = '你讓夢境<br>多了好多光。';
  $('modalIntro').textContent = `兩關得分 ${score} 分 · 收集夢境鑰匙 ${unlocked.filter(Boolean).length} 把`;
  $('choices').innerHTML = `<div class="result-card"><b>✦ 儲蓄習慣</b><span>知道先存下一部分，再安排花費。</span></div><div class="result-card"><b>✦ 投資觀念</b><span>明白投資有風險，先學習並分散配置。</span></div><div class="result-card"><b>↗ 你的進步</b><span>從安排零用錢，到辨認投資風險，你完成了兩次理財選擇。</span></div>`;
  $('feedback').textContent = '真正的理財高手，會持續學習和練習。'; $('feedback').className = 'feedback'; $('modalNext').disabled = false; $('modalNext').textContent = '再玩一次'; $('modalNext').onclick = () => { score = 0; current = 0; unlocked = [false,false]; $('modalNext').onclick = submitAnswer; closeModal(); paint(); };
  modal.classList.add('open'); modal.setAttribute('aria-hidden', 'false');
}
function toast(message) { const node = $('toast'); node.textContent = message; node.classList.add('show'); setTimeout(() => node.classList.remove('show'), 2400); }
$('challengeButton').addEventListener('click', openChallenge); $('closeModal').addEventListener('click', closeModal);
$('modalNext').addEventListener('click', submitAnswer);
modal.addEventListener('click', e => { if (e.target === modal) closeModal(); });
$('soundToggle').addEventListener('click', e => { const button=e.currentTarget; button.classList.toggle('is-off'); button.querySelector('span').textContent = button.classList.contains('is-off') ? '音效關' : '音效'; });
document.addEventListener('keydown', e => { if (['ArrowLeft','a','A'].includes(e.key)) move(-3); if (['ArrowRight','d','D'].includes(e.key)) move(3); if (e.key === 'Escape') closeModal(); });
function move(amount) { if (modal.classList.contains('open')) return; const hero = $('hero'); const percent = parseFloat(hero.style.left || '39'); hero.style.left = `${Math.max(12,Math.min(66,percent + amount))}%`; }
paint();
