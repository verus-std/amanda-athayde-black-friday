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
document.querySelectorAll('[data-signup]').forEach(button => button.addEventListener('click', () => dialog.showModal()));
document.querySelectorAll('.close-dialog, .close-preview').forEach(button => button.addEventListener('click', () => dialog.close()));
dialog.addEventListener('click', event => { if (event.target === dialog) { const r = dialog.getBoundingClientRect(); if (event.clientX < r.left || event.clientX > r.right || event.clientY < r.top || event.clientY > r.bottom) dialog.close(); } });
