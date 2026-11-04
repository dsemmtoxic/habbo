const vm = require('node:vm');
const fs = require('node:fs');
const assert = require('node:assert/strict');
const source = fs.readFileSync('work/session64.js', 'utf8');
function scenario(text = '', actualHost = 'www.habbo.com.br') {
  const callbacks = [], messages = [], requests = [], clicks = [];
  const location = {protocol: 'https:', hostname: actualHost, origin: 'https://' + actualHost};
  Object.defineProperty(location, 'href', {get() { return location.origin + '/home'; }, set(value) { messages.push(JSON.parse(decodeURIComponent(value.split('#')[1]))); }});
  function XHR() {}
  XHR.prototype.open = function () {};
  const play = {textContent: 'JOGAR', getClientRects() { return [{}]; }, click() { clicks.push('play'); }};
  const document = {body: {innerText: text}, querySelectorAll(selector) { return selector === 'a, button, [role="button"]' ? [play] : []; }};
  const fetch = async path => {
    requests.push(path);
    const body = path.endsWith('/users/me') ? {name: 'TestAvatar', figureString: 'hd-180-1.ch-210-66'} : {url: 'habbo://hhbr.fixture.fresh'};
    const response = {ok: true, status: 200, url: location.origin + path, text: async () => JSON.stringify(body)};
    response.clone = () => response;
    return response;
  };
  const window = {fetch};
  const context = {window, document, location, XMLHttpRequest: XHR, URL, setInterval(callback) { callbacks.push(callback); return callbacks.length; }, clearInterval() {}};
  const config = {host: 'www.habbo.com.br', prefix: 'hhbr', bridge: 'habbosession64://fixture/result', launch: true};
  vm.runInNewContext(source.replace('__H64_CONFIG__', JSON.stringify(config)), context);
  return {callbacks, messages, requests, clicks};
}
async function flush() { for (let i = 0; i < 10; i++) await Promise.resolve(); }
(async () => {
  const direct = scenario('Código hhbr.fixture.session');
  assert.equal(direct.messages[0].kind, 'ticket');
  assert.equal(direct.messages[0].code, 'hhbr.fixture.session');
  const other = scenario('Código hhus.wrong.hotel');
  assert.equal(other.messages.filter(x => x.kind === 'ticket').length, 0);
  const hostile = scenario('hhbr.fixture.session', 'www.habbo.com.br.evil.example');
  assert.equal(hostile.messages.length, 0);
  assert.equal(hostile.requests.length, 0);
  const fresh = scenario();
  await flush(); fresh.callbacks[0](); await flush(); fresh.callbacks[0](); await flush();
  const result = fresh.messages.find(x => x.kind === 'ticket');
  assert.equal(result.code, 'hhbr.fixture.fresh');
  assert.equal(result.profile.name, 'TestAvatar');
  for (let i = 0; i < 10; i++) fresh.callbacks[0]();
  assert.equal(fresh.requests.filter(x => x === '/api/client/clienturl').length, 1);
  assert.equal(fresh.requests.filter(x => x === '/api/public/users/me').length, 1);
  assert.equal(fresh.messages.filter(x => x.kind === 'ticket').length, 1);
  assert.ok(!source.includes('document.cookie') && !source.includes('localStorage.setItem') && !source.includes('console.log'));
  console.log('PASS: actual browser script extracts Launcher code, accepts only the chosen hotel and exact HTTPS origin, reads selected-avatar profile, obtains a fresh code and delivers once. Requests are bounded; credentials/cookies are not exported. DOM/network/OS behavior remains a real-device boundary.');
})().catch(error => { console.error(error); process.exit(1); });
