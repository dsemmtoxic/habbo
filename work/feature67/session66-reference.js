(function (config) {
  'use strict';
  if (location.protocol !== 'https:' || location.hostname !== config.host) return;
  if (window.__habboSession65) return;
  window.__habboSession65 = true;
  var finished = false, injector, session, root, unwatch, requesting = false, waiting = false, attempted = false;
  var retryTimer = 0, attempts = 0, lastStatus = '', lastProfile = '';
  function emit(value) {
    if (finished || location.protocol !== 'https:' || location.hostname !== config.host) return;
    var encoded = encodeURIComponent(JSON.stringify(value));
    if (encoded.length <= 16000) location.href = config.bridge + '#' + encoded;
  }
  function stop() { finished = true; if (retryTimer) clearTimeout(retryTimer); if (unwatch) unwatch(); }
  function status(kind, reason) {
    var key = kind + ':' + (reason || '');
    if (key !== lastStatus) { lastStatus = key; emit({kind: kind, reason: reason || ''}); }
  }
  function profile(user) {
    if (!user || typeof user.name !== 'string' || !user.name || user.name.length > 64 ||
        typeof user.figureString !== 'string' || !/^[A-Za-z0-9.\-]{1,1024}$/.test(user.figureString)) return null;
    var value = {name: user.name, figure: user.figureString, id: String(user.uniqueId || '')};
    try {
      var imager = injector.get('imager');
      var pose = imager.generatePose({size: 'bighead', direction: 'sw', headDirection: 'sw', action: 'stand', gesture: 'smile'});
      var url = new URL(imager.getImagerUrl(user.figureString, pose), location.href);
      if (url.origin === location.origin && /^\/habbo-imaging\/avatar\//.test(url.pathname)) value.image = url.href;
    } catch (_) {}
    return value;
  }
  function ticket(result, current) {
    var code = result && result.ticket;
    if (typeof code !== 'string' || code.length > 8192 ||
        !/^hh(?:br|us|fi|fr|de|nl|es|it|tr)\.[A-Za-z0-9_-]+\.[A-Za-z0-9_.-]+$/.test(code) || code.slice(0, 4).toLowerCase() !== config.prefix) {
      requesting = false; status('error', 'ticket'); return;
    }
    var latest = profile(session.user);
    if (!latest || latest.id !== current.id) { requesting = false; status('error', 'account-changed'); return; }
    emit({kind: 'ticket', code: code, profile: latest}); stop();
  }
  function requestTicket(current) {
    if (finished || requesting || waiting || attempted) return;
    requesting = true; attempted = true;
    try {
      var service = injector.get('nativeHotelService');
      service.stop();
      service.start().then(function (result) { ticket(result, current); }, function (error) {
        requesting = false; if (error === 'force') attempted = false;
        status(error === 'force' ? 'needs-login' : 'error', String(error || 'network'));
      });
    } catch (_) { requesting = false; status('error', 'client-service'); }
  }
  function enter(current) {
    if (requesting || waiting || finished) return;
    if (session.user.force && session.user.force.length) { status('needs-login', 'verification'); return; }
    if (session.user.ageVerificationRequired === true) { status('needs-login', 'age-verification'); return; }
    if (!session.isTrusted()) {
      status('needs-login', 'safety-lock'); waiting = true;
      try { injector.get('safetyLockModal').open().then(function () { waiting = false; ready(); }, function () { waiting = false; status('error', 'verification-cancelled'); }); }
      catch (_) { waiting = false; status('error', 'safety-lock'); }
      return;
    }
    requestTicket(current);
  }
  function ready() {
    if (finished || !session) return;
    if (!session.hasSession()) { status('needs-login', 'signed-out'); return; }
    if (session.user.force && session.user.force.length) { status('needs-login', 'verification'); return; }
    var current = profile(session.user);
    if (!current) return;
    var signature = JSON.stringify(current);
    if (config.mode === 'link') { emit({kind: 'linked', profile: current}); stop(); return; }
    if (config.mode === 'switch') {
      if (current.id && config.initialId && current.id !== config.initialId) { emit({kind: 'selected', profile: current}); stop(); }
      return;
    }
    if (signature !== lastProfile) { lastProfile = signature; emit({kind: 'profile', profile: current}); }
    if (config.mode === 'enter') enter(current);
  }
  function selected(body) {
    if (config.mode !== 'switch' || finished) return;
    var user;
    try { user = typeof body === 'string' ? JSON.parse(body) : body; } catch (_) { return; }
    var current = profile(user);
    if (!current) { setTimeout(ready, 0); return; }
    emit({kind: 'selected', profile: current}); stop();
  }
  function observeSelection() {
    var originalOpen = XMLHttpRequest.prototype.open;
    XMLHttpRequest.prototype.open = function (method, url) {
      var parsed;
      try { parsed = new URL(String(url), location.href); } catch (_) {}
      if (parsed && parsed.origin === location.origin && parsed.pathname === '/api/user/avatars/select' && String(method).toUpperCase() === 'POST') {
        var request = this;
        request.addEventListener('load', function () {
          if (request.status >= 200 && request.status < 300) {
            try { selected(request.responseType === 'json' ? request.response : request.responseText); } catch (_) { setTimeout(ready, 0); }
          }
        });
      }
      return originalOpen.apply(this, arguments);
    };
  }
  function initialize() {
    if (finished) return;
    try {
      var angular = window.angular;
      if (angular) injector = angular.element(document).injector() || angular.element(document.documentElement).injector();
      if (injector && injector.has('Session')) {
        session = injector.get('Session'); root = injector.get('$rootScope'); if (config.mode === 'switch') observeSelection();
        unwatch = root.$watch(function () {
          var user = session.user;
          return !user ? '' : [user.uniqueId, user.name, user.figureString, user.trusted, user.ageVerificationRequired, (user.force || []).length].join('|');
        }, ready);
        ready(); return;
      }
    } catch (_) {}
    if (++attempts <= 100) retryTimer = setTimeout(initialize, 200);
    else status('error', 'website-not-ready');
  }
  initialize();
})(__H64_CONFIG__);
