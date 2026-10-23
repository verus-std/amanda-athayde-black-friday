// Data informada na copy: 17 de novembro, 20h (horário de Brasília).
const launch = new Date('2026-11-17T20:00:00-03:00').getTime();
function updateCountdown() {
  const remaining = Math.max(0, Math.floor((launch - Date.now()) / 1000));
  const values = { days: Math.floor(remaining / 86400), hours: Math.floor(remaining / 3600) % 24, minutes: Math.floor(remaining / 60) % 60, seconds: remaining % 60 };
  for (const [key, value] of Object.entries(values)) document.querySelector(`[data-time="${key}"]`).textContent = String(value).padStart(2, '0');
}
updateCountdown();
setInterval(updateCountdown, 1000);
const dialog = document.querySelector('#signup-dialog');
const signupForm = document.querySelector('#signup-form');
const signupEntry = document.querySelector('#signup-entry');
const signupSuccess = document.querySelector('#signup-success');
function resetSignup() {
  signupForm.reset();
  signupEntry.hidden = false;
  signupSuccess.hidden = true;
  dialog.setAttribute('aria-labelledby', 'dialog-title');
}
document.querySelectorAll('[data-signup]').forEach(button => button.addEventListener('click', () => {
  resetSignup();
  dialog.showModal();
}));
signupForm.addEventListener('submit', event => {
  event.preventDefault();
  signupForm.reset();
  signupEntry.hidden = true;
  signupSuccess.hidden = false;
  dialog.setAttribute('aria-labelledby', 'success-title');
  document.querySelector('#success-title').focus();
  dialog.scrollTop = 0;
});
dialog.addEventListener('close', resetSignup);
document.querySelectorAll('.close-dialog, .close-preview').forEach(button => button.addEventListener('click', () => dialog.close()));
dialog.addEventListener('click', event => { if (event.target === dialog) { const r = dialog.getBoundingClientRect(); if (event.clientX < r.left || event.clientX > r.right || event.clientY < r.top || event.clientY > r.bottom) dialog.close(); } });

// Preenche as duas faixas inclusive em monitores largos.
const ribbonLanes = [...document.querySelectorAll('.ribbon > div')];
const ribbonSeeds = ribbonLanes.map(lane => lane.innerHTML);
function fillRibbons() {
  const targetWidth = window.innerWidth * 2 + 160;
  ribbonLanes.forEach((lane, index) => {
    lane.innerHTML = ribbonSeeds[index];
    for (let repeat = 0; lane.scrollWidth < targetWidth && repeat < 16; repeat++) {
      lane.insertAdjacentHTML('beforeend', ' ' + ribbonSeeds[index]);
    }
  });
}
fillRibbons();
document.fonts.ready.then(fillRibbons);
let ribbonFrame;
window.addEventListener('resize', () => {
  cancelAnimationFrame(ribbonFrame);
  ribbonFrame = requestAnimationFrame(fillRibbons);
});
document.querySelectorAll('.modules > .module').forEach((card, index) => card.style.setProperty('--stack-order', index));
