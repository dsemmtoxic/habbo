'use strict';
// Executes the exact injected source with official Angular service boundaries.
const fs = require('fs'), vm = require('vm'), assert = require('assert'), crypto = require('crypto');
const source = fs.readFileSync('work/session64.js', 'utf8');
const figure = 'hr-828-42.hd-209-11.ch-255-110.lg-270-64.sh-908-92';
const user = (id = 'old', name = 'Avatar') => ({uniqueId:id, name, figureString:figure, trusted:true, force:[], ageVerificationRequired:false});
function fixture(mode, options={}) {
  const events=[], timers=[], watchers=[], requests=[], selections=[];
  let userValue=options.user === undefined ? user() : options.user, starts=0, stops=0, safety=0, watchRemovals=0;
  const location={protocol:'https:', hostname:options.host || 'www.habbo.com.br', origin:'https://' + (options.host || 'www.habbo.com.br')};
  Object.defineProperty(location, 'href', {get:()=> location.origin+'/', set:value=> {
    assert(value.startsWith('habbosession65://nonce/result#'));
    events.push(JSON.parse(decodeURIComponent(value.split('#')[1])));
  }});
  const session={get user(){return userValue;}, hasSession:()=>!!userValue, isTrusted:()=>userValue && userValue.trusted};
  class XHR {
    constructor(){this.listeners={};this.status=0;this.responseType='';}
    open(method,url){this.method=method;this.url=url;requests.push([method,url]);}
    addEventListener(event,callback){this.listeners[event]=callback;}
    complete(status,body){this.status=status;this.responseText=JSON.stringify(body);this.listeners.load?.();}
  }
  const services={Session:session, $rootScope:{$watch:(read,callback)=>{
    const watcher={read,callback,last:Symbol()}; watchers.push(watcher);
    return ()=>{watcher.removed=true;watchRemovals++;};
  }}, imager:{
    generatePose:pose=>{assert.deepStrictEqual(JSON.parse(JSON.stringify(pose)), {size:'bighead',direction:'sw',headDirection:'sw',action:'stand',gesture:'smile'});return 's-2.g-1.d-2.h-2.a-0';},
    getImagerUrl:(f,p)=>'/habbo-imaging/avatar/'+f+','+p+','+crypto.createHash('md5').update(f+p+'ef2356a4926bf225eb86c75c52309c32').digest('hex')+'.png'
  }, nativeHotelService:{stop:()=>{stops++;},start:()=>{
    starts++;return options.ticketPromise || (options.error ? Promise.reject(options.error) : Promise.resolve({ticket:options.ticket || 'hhbr.fresh.launcher-ticket'}));
  }}, safetyLockModal:{open:()=>{safety++;return options.safetyPromise || Promise.resolve().then(()=>{userValue.trusted=true;});}}};
  const injector={has:name=>name in services,get:name=>{assert(name in services, 'Unknown site service '+name);return services[name];}};
  const document={documentElement:{}};
  Object.defineProperty(document,'body',{get(){throw new Error('Full-page DOM scans are forbidden');}});
  const context={window:{angular:{element:()=>({injector:()=>injector})}},document,location,URL,XMLHttpRequest:XHR,
    setTimeout:(callback,ms)=>{timers.push({callback,ms});return timers.length;},clearTimeout:id=>{if(timers[id-1])timers[id-1].cancelled=true;},
    __H64_CONFIG__:{host:'www.habbo.com.br',prefix:'hhbr',mode,initialId:'old',bridge:'habbosession65://nonce/result'}};
  vm.runInNewContext(source,context,{timeout:2000});
  return {events,timers,requests,XHR,context,services,session, get starts(){return starts;},get stops(){return stops;},get safety(){return safety;},get watchRemovals(){return watchRemovals;},
    setUser:value=>{userValue=value;},digest:()=>{for(const w of watchers){if(w.removed)continue;const value=w.read();if(value!==w.last){w.last=value;w.callback();}}},
    status:kind=>events.filter(e=>e.kind===kind), injectAgain:()=>vm.runInNewContext(source,context,{timeout:2000})};
}
async function flush(){for(let i=0;i<5;i++)await Promise.resolve();}
(async()=>{
  const link=fixture('link',{user:null});assert.equal(link.status('linked').length,0);assert.equal(link.status('needs-login')[0].reason,'signed-out');
  link.setUser({...user(),force:['two-factor']});link.digest();assert.equal(link.status('linked').length,0);
  link.setUser(user());link.digest();assert.equal(link.status('linked').length,1);assert.equal(link.starts,0);assert.equal(link.watchRemovals,1);
  const profile=link.status('linked')[0].profile;assert.deepStrictEqual(Object.keys(profile).sort(),['figure','id','image','name']);
  assert(profile.image.endsWith('s-2.g-1.d-2.h-2.a-0,bc813df3aed7ff6f4a016acc24883a9b.png'));
  link.injectAgain();assert.equal(link.status('linked').length,1);
  const enter=fixture('enter');enter.digest();await flush();assert.equal(enter.starts,1);assert.equal(enter.stops,1);assert.equal(enter.status('ticket')[0].code,'hhbr.fresh.launcher-ticket');
  enter.digest();enter.injectAgain();await flush();assert.equal(enter.starts,1);assert.equal(enter.status('ticket').length,1);assert.equal(enter.requests.length,0);
  const wrong=fixture('enter',{ticket:'hhus.other.hotel'});await flush();assert.equal(wrong.status('ticket').length,0);assert.equal(wrong.status('error')[0].reason,'ticket');
  wrong.digest();await flush();assert.equal(wrong.starts,1);
  const force=fixture('enter',{user:{...user(),force:['2fa']}});assert.equal(force.starts,0);force.setUser(user());force.digest();await flush();assert.equal(force.starts,1);
  const age=fixture('enter',{user:{...user(),ageVerificationRequired:true}});assert.equal(age.starts,0);assert.equal(age.status('needs-login')[0].reason,'age-verification');
  age.setUser(user());age.digest();await flush();assert.equal(age.status('ticket').length,1);
  const locked=fixture('enter',{user:{...user(),trusted:false}});await flush();assert.equal(locked.safety,1);assert.equal(locked.starts,1);
  const network=fixture('enter',{error:'error'});await flush();network.digest();await flush();assert.equal(network.starts,1);assert.equal(network.status('ticket').length,0);
  let resolve;const changed=fixture('enter',{ticketPromise:new Promise(r=>resolve=r)});changed.setUser(user('new'));resolve({ticket:'hhbr.stale.ticket'});await flush();assert.equal(changed.status('ticket').length,0);assert.equal(changed.status('error')[0].reason,'account-changed');
  const swap=fixture('switch');swap.digest();assert.equal(swap.events.length,0);assert.equal(swap.starts,0);
  const failed=new swap.XHR();failed.open('POST','/api/user/avatars/select');failed.complete(400,user('bad'));assert.equal(swap.status('selected').length,0);
  const external=new swap.XHR();external.open('POST','https://evil.example/api/user/avatars/select');external.complete(200,user('bad'));assert.equal(swap.status('selected').length,0);
  const good=new swap.XHR();good.open('POST','/api/user/avatars/select');good.complete(200,user('new','Novo avatar'));
  assert.equal(swap.status('selected').length,1);assert.equal(swap.status('selected')[0].profile.name,'Novo avatar');assert.equal(swap.watchRemovals,1);assert.equal(swap.starts,0);
  const reload=fixture('switch');reload.setUser(user('new'));reload.digest();assert.equal(reload.status('selected').length,1);
  const manage=fixture('manage');manage.digest();assert.equal(manage.starts,0);assert.equal(manage.status('profile').length,1);assert.equal(manage.watchRemovals,0);
  const evil=fixture('link',{host:'www.habbo.com.br.evil.example'});assert.equal(evil.events.length,0);assert.equal(evil.starts,0);
  assert(!source.includes('setInterval'));assert(!source.includes('innerText'));assert(!source.includes('querySelectorAll'));assert(!source.includes('document.cookie'));
  console.log('PASS: official-site service fixtures: link after 2FA without JOGAR; one fresh background launcher ticket; account switch closes only after a successful selection; exact official right-facing head/hash; stale/foreign tickets rejected; safety/age gates retained; no repeated DOM scans or credential export. Live hotel/Android remain device boundaries.');
})().catch(error=>{console.error(error);process.exitCode=1;});
