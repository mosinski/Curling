/*!
 * fancyBox - jQuery Plugin
 * version: 2.1.4 (Thu, 10 Jan 2013)
 * @requires jQuery v1.6 or later
 *
 * Examples at http://fancyapps.com/fancybox/
 * License: www.fancyapps.com/fancybox/#license
 *
 * Copyright 2012 Janis Skarnelis - janis@fancyapps.com
 *
 */
!function(t,e,n,i){"use strict";var o=n(t),r=n(e),a=n.fancybox=function(){a.open.apply(this,arguments)},s=navigator.userAgent.match(/msie/),l=null,c=e.createTouch!==i,u=function(t){return t&&t.hasOwnProperty&&t instanceof n},d=function(t){return t&&"string"===n.type(t)},p=function(t){return d(t)&&t.indexOf("%")>0},f=function(t){return t&&!(t.style.overflow&&"hidden"===t.style.overflow)&&(t.clientWidth&&t.scrollWidth>t.clientWidth||t.clientHeight&&t.scrollHeight>t.clientHeight)},h=function(t,e){var n=parseInt(t,10)||0;return e&&p(t)&&(n=a.getViewport()[e]/100*n),Math.ceil(n)},m=function(t,e){return h(t,e)+"px"};n.extend(a,{version:"2.1.4",defaults:{padding:15,margin:20,width:800,height:600,minWidth:100,minHeight:100,maxWidth:9999,maxHeight:9999,autoSize:!0,autoHeight:!1,autoWidth:!1,autoResize:!0,autoCenter:!c,fitToView:!0,aspectRatio:!1,topRatio:.5,leftRatio:.5,scrolling:"auto",wrapCSS:"",arrows:!0,closeBtn:!0,closeClick:!1,nextClick:!1,mouseWheel:!0,autoPlay:!1,playSpeed:3e3,preload:3,modal:!1,loop:!0,ajax:{dataType:"html",headers:{"X-fancyBox":!0}},iframe:{scrolling:"auto",preload:!0},swf:{wmode:"transparent",allowfullscreen:"true",allowscriptaccess:"always"},keys:{next:{13:"left",34:"up",39:"left",40:"up"},prev:{8:"right",33:"down",37:"right",38:"down"},close:[27],play:[32],toggle:[70]},direction:{next:"left",prev:"right"},scrollOutside:!0,index:0,type:null,href:null,content:null,title:null,tpl:{wrap:'<div class="fancybox-wrap" tabIndex="-1"><div class="fancybox-skin"><div class="fancybox-outer"><div class="fancybox-inner"></div></div></div></div>',image:'<img class="fancybox-image" src="{href}" alt="" />',iframe:'<iframe id="fancybox-frame{rnd}" name="fancybox-frame{rnd}" class="fancybox-iframe" frameborder="0" vspace="0" hspace="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen'+(s?' allowtransparency="true"':"")+"></iframe>",error:'<p class="fancybox-error">Obrazek nie może być wyświetlony, ponieważ zawiera błędy.<br/>Spróbuj ponownie za chwilę.</p>',closeBtn:'<a title="Close" class="fancybox-item fancybox-close" href="javascript:;"></a>',next:'<a title="Następne" class="fancybox-nav fancybox-next" href="javascript:;"><span></span></a>',prev:'<a title="Poprzednie" class="fancybox-nav fancybox-prev" href="javascript:;"><span></span></a>'},openEffect:"fade",openSpeed:250,openEasing:"swing",openOpacity:!0,openMethod:"zoomIn",closeEffect:"fade",closeSpeed:250,closeEasing:"swing",closeOpacity:!0,closeMethod:"zoomOut",nextEffect:"elastic",nextSpeed:250,nextEasing:"swing",nextMethod:"changeIn",prevEffect:"elastic",prevSpeed:250,prevEasing:"swing",prevMethod:"changeOut",helpers:{overlay:!0,title:!0},onCancel:n.noop,beforeLoad:n.noop,afterLoad:n.noop,beforeShow:n.noop,afterShow:n.noop,beforeChange:n.noop,beforeClose:n.noop,afterClose:n.noop},group:{},opts:{},previous:null,coming:null,current:null,isActive:!1,isOpen:!1,isOpened:!1,wrap:null,skin:null,outer:null,inner:null,player:{timer:null,isActive:!1},ajaxLoad:null,imgPreload:null,transitions:{},helpers:{},open:function(t,e){return t&&(n.isPlainObject(e)||(e={}),!1!==a.close(!0))?(n.isArray(t)||(t=u(t)?n(t).get():[t]),n.each(t,function(o,r){var s,l,c,p,f,h,m,g={};"object"===n.type(r)&&(r.nodeType&&(r=n(r)),u(r)?(g={href:r.data("fancybox-href")||r.attr("href"),title:r.data("fancybox-title")||r.attr("title"),isDom:!0,element:r},n.metadata&&n.extend(!0,g,r.metadata())):g=r),s=e.href||g.href||(d(r)?r:null),l=e.title!==i?e.title:g.title||"",c=e.content||g.content,p=c?"html":e.type||g.type,!p&&g.isDom&&(p=r.data("fancybox-type"),p||(f=r.prop("class").match(/fancybox\.(\w+)/),p=f?f[1]:null)),d(s)&&(p||(a.isImage(s)?p="image":a.isSWF(s)?p="swf":"#"===s.charAt(0)?p="inline":d(r)&&(p="html",c=r)),"ajax"===p&&(h=s.split(/\s+/,2),s=h.shift(),m=h.shift())),c||("inline"===p?s?c=n(d(s)?s.replace(/.*(?=#[^\s]+$)/,""):s):g.isDom&&(c=r):"html"===p?c=s:p||s||!g.isDom||(p="inline",c=r)),n.extend(g,{href:s,type:p,content:c,title:l,selector:m}),t[o]=g}),a.opts=n.extend(!0,{},a.defaults,e),e.keys!==i&&(a.opts.keys=e.keys?n.extend({},a.defaults.keys,e.keys):!1),a.group=t,a._start(a.opts.index)):void 0},cancel:function(){var t=a.coming;t&&!1!==a.trigger("onCancel")&&(a.hideLoading(),a.ajaxLoad&&a.ajaxLoad.abort(),a.ajaxLoad=null,a.imgPreload&&(a.imgPreload.onload=a.imgPreload.onerror=null),t.wrap&&t.wrap.stop(!0,!0).trigger("onReset").remove(),a.coming=null,a.current||a._afterZoomOut(t))},close:function(t){a.cancel(),!1!==a.trigger("beforeClose")&&(a.unbindEvents(),a.isActive&&(a.isOpen&&t!==!0?(a.isOpen=a.isOpened=!1,a.isClosing=!0,n(".fancybox-item, .fancybox-nav").remove(),a.wrap.stop(!0,!0).removeClass("fancybox-opened"),a.transitions[a.current.closeMethod]()):(n(".fancybox-wrap").stop(!0).trigger("onReset").remove(),a._afterZoomOut())))},play:function(t){var e=function(){clearTimeout(a.player.timer)},i=function(){e(),a.current&&a.player.isActive&&(a.player.timer=setTimeout(a.next,a.current.playSpeed))},o=function(){e(),n("body").unbind(".player"),a.player.isActive=!1,a.trigger("onPlayEnd")},r=function(){a.current&&(a.current.loop||a.current.index<a.group.length-1)&&(a.player.isActive=!0,n("body").bind({"afterShow.player onUpdate.player":i,"onCancel.player beforeClose.player":o,"beforeLoad.player":e}),i(),a.trigger("onPlayStart"))};t===!0||!a.player.isActive&&t!==!1?r():o()},next:function(t){var e=a.current;e&&(d(t)||(t=e.direction.next),a.jumpto(e.index+1,t,"next"))},prev:function(t){var e=a.current;e&&(d(t)||(t=e.direction.prev),a.jumpto(e.index-1,t,"prev"))},jumpto:function(t,e,n){var o=a.current;o&&(t=h(t),a.direction=e||o.direction[t>=o.index?"next":"prev"],a.router=n||"jumpto",o.loop&&(0>t&&(t=o.group.length+t%o.group.length),t%=o.group.length),o.group[t]!==i&&(a.cancel(),a._start(t)))},reposition:function(t,e){var i,o=a.current,r=o?o.wrap:null;r&&(i=a._getPosition(e),t&&"scroll"===t.type?(delete i.position,r.stop(!0,!0).animate(i,200)):(r.css(i),o.pos=n.extend({},o.dim,i)))},update:function(t){var e=t&&t.type,n=!e||"orientationchange"===e;n&&(clearTimeout(l),l=null),a.isOpen&&!l&&(l=setTimeout(function(){var i=a.current;i&&!a.isClosing&&(a.wrap.removeClass("fancybox-tmp"),(n||"load"===e||"resize"===e&&i.autoResize)&&a._setDimension(),"scroll"===e&&i.canShrink||a.reposition(t),a.trigger("onUpdate"),l=null)},n&&!c?0:300))},toggle:function(t){a.isOpen&&(a.current.fitToView="boolean"===n.type(t)?t:!a.current.fitToView,c&&(a.wrap.removeAttr("style").addClass("fancybox-tmp"),a.trigger("onUpdate")),a.update())},hideLoading:function(){r.unbind(".loading"),n("#fancybox-loading").remove()},showLoading:function(){var t,e;a.hideLoading(),t=n('<div id="fancybox-loading"><div></div></div>').click(a.cancel).appendTo("body"),r.bind("keydown.loading",function(t){27===(t.which||t.keyCode)&&(t.preventDefault(),a.cancel())}),a.defaults.fixed||(e=a.getViewport(),t.css({position:"absolute",top:.5*e.h+e.y,left:.5*e.w+e.x}))},getViewport:function(){var e=a.current&&a.current.locked||!1,n={x:o.scrollLeft(),y:o.scrollTop()};return e?(n.w=e[0].clientWidth,n.h=e[0].clientHeight):(n.w=c&&t.innerWidth?t.innerWidth:o.width(),n.h=c&&t.innerHeight?t.innerHeight:o.height()),n},unbindEvents:function(){a.wrap&&u(a.wrap)&&a.wrap.unbind(".fb"),r.unbind(".fb"),o.unbind(".fb")},bindEvents:function(){var t,e=a.current;e&&(o.bind("orientationchange.fb"+(c?"":" resize.fb")+(e.autoCenter&&!e.locked?" scroll.fb":""),a.update),t=e.keys,t&&r.bind("keydown.fb",function(o){var r=o.which||o.keyCode,s=o.target||o.srcElement;return 27===r&&a.coming?!1:(o.ctrlKey||o.altKey||o.shiftKey||o.metaKey||s&&(s.type||n(s).is("[contenteditable]"))||n.each(t,function(t,s){return e.group.length>1&&s[r]!==i?(a[t](s[r]),o.preventDefault(),!1):n.inArray(r,s)>-1?(a[t](),o.preventDefault(),!1):void 0}),void 0)}),n.fn.mousewheel&&e.mouseWheel&&a.wrap.bind("mousewheel.fb",function(t,i,o,r){for(var s=t.target||null,l=n(s),c=!1;l.length&&!(c||l.is(".fancybox-skin")||l.is(".fancybox-wrap"));)c=f(l[0]),l=n(l).parent();0===i||c||a.group.length>1&&!e.canShrink&&(r>0||o>0?a.prev(r>0?"down":"left"):(0>r||0>o)&&a.next(0>r?"up":"right"),t.preventDefault())}))},trigger:function(t,e){var i,o=e||a.coming||a.current;if(o){if(n.isFunction(o[t])&&(i=o[t].apply(o,Array.prototype.slice.call(arguments,1))),i===!1)return!1;o.helpers&&n.each(o.helpers,function(e,i){i&&a.helpers[e]&&n.isFunction(a.helpers[e][t])&&(i=n.extend(!0,{},a.helpers[e].defaults,i),a.helpers[e][t](i,o))}),n.event.trigger(t+".fb")}},isImage:function(t){return d(t)&&t.match(/(^data:image\/.*,)|(\.(jp(e|g|eg)|gif|png|bmp|webp)((\?|#).*)?$)/i)},isSWF:function(t){return d(t)&&t.match(/\.(swf)((\?|#).*)?$/i)},_start:function(t){var e,i,o,r,s,l={};if(t=h(t),e=a.group[t]||null,!e)return!1;if(l=n.extend(!0,{},a.opts,e),r=l.margin,s=l.padding,"number"===n.type(r)&&(l.margin=[r,r,r,r]),"number"===n.type(s)&&(l.padding=[s,s,s,s]),l.modal&&n.extend(!0,l,{closeBtn:!1,closeClick:!1,nextClick:!1,arrows:!1,mouseWheel:!1,keys:null,helpers:{overlay:{closeClick:!1}}}),l.autoSize&&(l.autoWidth=l.autoHeight=!0),"auto"===l.width&&(l.autoWidth=!0),"auto"===l.height&&(l.autoHeight=!0),l.group=a.group,l.index=t,a.coming=l,!1===a.trigger("beforeLoad"))return a.coming=null,void 0;if(o=l.type,i=l.href,!o)return a.coming=null,a.current&&a.router&&"jumpto"!==a.router?(a.current.index=t,a[a.router](a.direction)):!1;if(a.isActive=!0,("image"===o||"swf"===o)&&(l.autoHeight=l.autoWidth=!1,l.scrolling="visible"),"image"===o&&(l.aspectRatio=!0),"iframe"===o&&c&&(l.scrolling="scroll"),l.wrap=n(l.tpl.wrap).addClass("fancybox-"+(c?"mobile":"desktop")+" fancybox-type-"+o+" fancybox-tmp "+l.wrapCSS).appendTo(l.parent||"body"),n.extend(l,{skin:n(".fancybox-skin",l.wrap),outer:n(".fancybox-outer",l.wrap),inner:n(".fancybox-inner",l.wrap)}),n.each(["Top","Right","Bottom","Left"],function(t,e){l.skin.css("padding"+e,m(l.padding[t]))}),a.trigger("onReady"),"inline"===o||"html"===o){if(!l.content||!l.content.length)return a._error("content")}else if(!i)return a._error("href");"image"===o?a._loadImage():"ajax"===o?a._loadAjax():"iframe"===o?a._loadIframe():a._afterLoad()},_error:function(t){n.extend(a.coming,{type:"html",autoWidth:!0,autoHeight:!0,minWidth:0,minHeight:0,scrolling:"no",hasError:t,content:a.coming.tpl.error}),a._afterLoad()},_loadImage:function(){var t=a.imgPreload=new Image;t.onload=function(){this.onload=this.onerror=null,a.coming.width=this.width,a.coming.height=this.height,a._afterLoad()},t.onerror=function(){this.onload=this.onerror=null,a._error("image")},t.src=a.coming.href,t.complete!==!0&&a.showLoading()},_loadAjax:function(){var t=a.coming;a.showLoading(),a.ajaxLoad=n.ajax(n.extend({},t.ajax,{url:t.href,error:function(t,e){a.coming&&"abort"!==e?a._error("ajax",t):a.hideLoading()},success:function(e,n){"success"===n&&(t.content=e,a._afterLoad())}}))},_loadIframe:function(){var t=a.coming,e=n(t.tpl.iframe.replace(/\{rnd\}/g,(new Date).getTime())).attr("scrolling",c?"auto":t.iframe.scrolling).attr("src",t.href);n(t.wrap).bind("onReset",function(){try{n(this).find("iframe").hide().attr("src","//about:blank").end().empty()}catch(t){}}),t.iframe.preload&&(a.showLoading(),e.one("load",function(){n(this).data("ready",1),c||n(this).bind("load.fb",a.update),n(this).parents(".fancybox-wrap").width("100%").removeClass("fancybox-tmp").show(),a._afterLoad()})),t.content=e.appendTo(t.inner),t.iframe.preload||a._afterLoad()},_preloadImages:function(){var t,e,n=a.group,i=a.current,o=n.length,r=i.preload?Math.min(i.preload,o-1):0;for(e=1;r>=e;e+=1)t=n[(i.index+e)%o],"image"===t.type&&t.href&&((new Image).src=t.href)},_afterLoad:function(){var t,e,i,o,r,s,l=a.coming,c=a.current,d="fancybox-placeholder";if(a.hideLoading(),l&&a.isActive!==!1){if(!1===a.trigger("afterLoad",l,c))return l.wrap.stop(!0).trigger("onReset").remove(),a.coming=null,void 0;switch(c&&(a.trigger("beforeChange",c),c.wrap.stop(!0).removeClass("fancybox-opened").find(".fancybox-item, .fancybox-nav").remove()),a.unbindEvents(),t=l,e=l.content,i=l.type,o=l.scrolling,n.extend(a,{wrap:t.wrap,skin:t.skin,outer:t.outer,inner:t.inner,current:t,previous:c}),r=t.href,i){case"inline":case"ajax":case"html":t.selector?e=n("<div>").html(e).find(t.selector):u(e)&&(e.data(d)||e.data(d,n('<div class="'+d+'"></div>').insertAfter(e).hide()),e=e.show().detach(),t.wrap.bind("onReset",function(){n(this).find(e).length&&e.hide().replaceAll(e.data(d)).data(d,!1)}));break;case"image":e=t.tpl.image.replace("{href}",r);break;case"swf":e='<object id="fancybox-swf" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="100%"><param name="movie" value="'+r+'"></param>',s="",n.each(t.swf,function(t,n){e+='<param name="'+t+'" value="'+n+'"></param>',s+=" "+t+'="'+n+'"'}),e+='<embed src="'+r+'" type="application/x-shockwave-flash" width="100%" height="100%"'+s+"></embed></object>"}u(e)&&e.parent().is(t.inner)||t.inner.append(e),a.trigger("beforeShow"),t.inner.css("overflow","yes"===o?"scroll":"no"===o?"hidden":o),a._setDimension(),a.reposition(),a.isOpen=!1,a.coming=null,a.bindEvents(),a.isOpened?c.prevMethod&&a.transitions[c.prevMethod]():n(".fancybox-wrap").not(t.wrap).stop(!0).trigger("onReset").remove(),a.transitions[a.isOpened?t.nextMethod:t.openMethod](),a._preloadImages()}},_setDimension:function(){var t,e,i,o,r,s,l,c,u,d,f,g,y,v,b,x=a.getViewport(),w=0,k=!1,C=!1,T=a.wrap,S=a.skin,$=a.inner,E=a.current,j=E.width,N=E.height,A=E.minWidth,_=E.minHeight,D=E.maxWidth,L=E.maxHeight,H=E.scrolling,O=E.scrollOutside?E.scrollbarWidth:0,M=E.margin,P=h(M[1]+M[3]),W=h(M[0]+M[2]);if(T.add(S).add($).width("auto").height("auto").removeClass("fancybox-tmp"),t=h(S.outerWidth(!0)-S.width()),e=h(S.outerHeight(!0)-S.height()),i=P+t,o=W+e,r=p(j)?(x.w-i)*h(j)/100:j,s=p(N)?(x.h-o)*h(N)/100:N,"iframe"===E.type){if(v=E.content,E.autoHeight&&1===v.data("ready"))try{v[0].contentWindow.document.location&&($.width(r).height(9999),b=v.contents().find("body"),O&&b.css("overflow-x","hidden"),s=b.height())}catch(R){}}else(E.autoWidth||E.autoHeight)&&($.addClass("fancybox-tmp"),E.autoWidth||$.width(r),E.autoHeight||$.height(s),E.autoWidth&&(r=$.width()),E.autoHeight&&(s=$.height()),$.removeClass("fancybox-tmp"));if(j=h(r),N=h(s),u=r/s,A=h(p(A)?h(A,"w")-i:A),D=h(p(D)?h(D,"w")-i:D),_=h(p(_)?h(_,"h")-o:_),L=h(p(L)?h(L,"h")-o:L),l=D,c=L,E.fitToView&&(D=Math.min(x.w-i,D),L=Math.min(x.h-o,L)),g=x.w-P,y=x.h-W,E.aspectRatio?(j>D&&(j=D,N=h(j/u)),N>L&&(N=L,j=h(N*u)),A>j&&(j=A,N=h(j/u)),_>N&&(N=_,j=h(N*u))):(j=Math.max(A,Math.min(j,D)),E.autoHeight&&"iframe"!==E.type&&($.width(j),N=$.height()),N=Math.max(_,Math.min(N,L))),E.fitToView)if($.width(j).height(N),T.width(j+t),d=T.width(),f=T.height(),E.aspectRatio)for(;(d>g||f>y)&&j>A&&N>_&&!(w++>19);)N=Math.max(_,Math.min(L,N-10)),j=h(N*u),A>j&&(j=A,N=h(j/u)),j>D&&(j=D,N=h(j/u)),$.width(j).height(N),T.width(j+t),d=T.width(),f=T.height();else j=Math.max(A,Math.min(j,j-(d-g))),N=Math.max(_,Math.min(N,N-(f-y)));O&&"auto"===H&&s>N&&g>j+t+O&&(j+=O),$.width(j).height(N),T.width(j+t),d=T.width(),f=T.height(),k=(d>g||f>y)&&j>A&&N>_,C=E.aspectRatio?l>j&&c>N&&r>j&&s>N:(l>j||c>N)&&(r>j||s>N),n.extend(E,{dim:{width:m(d),height:m(f)},origWidth:r,origHeight:s,canShrink:k,canExpand:C,wPadding:t,hPadding:e,wrapSpace:f-S.outerHeight(!0),skinSpace:S.height()-N}),!v&&E.autoHeight&&N>_&&L>N&&!C&&$.height("auto")},_getPosition:function(t){var e=a.current,n=a.getViewport(),i=e.margin,o=a.wrap.width()+i[1]+i[3],r=a.wrap.height()+i[0]+i[2],s={position:"absolute",top:i[0],left:i[3]};return e.autoCenter&&e.fixed&&!t&&r<=n.h&&o<=n.w?s.position="fixed":e.locked||(s.top+=n.y,s.left+=n.x),s.top=m(Math.max(s.top,s.top+(n.h-r)*e.topRatio)),s.left=m(Math.max(s.left,s.left+(n.w-o)*e.leftRatio)),s},_afterZoomIn:function(){var t=a.current;t&&(a.isOpen=a.isOpened=!0,a.wrap.css("overflow","visible").addClass("fancybox-opened"),a.update(),(t.closeClick||t.nextClick&&a.group.length>1)&&a.inner.css("cursor","pointer").bind("click.fb",function(e){n(e.target).is("a")||n(e.target).parent().is("a")||(e.preventDefault(),a[t.closeClick?"close":"next"]())}),t.closeBtn&&n(t.tpl.closeBtn).appendTo(a.skin).bind("click.fb",function(t){t.preventDefault(),a.close()}),t.arrows&&a.group.length>1&&((t.loop||t.index>0)&&n(t.tpl.prev).appendTo(a.outer).bind("click.fb",a.prev),(t.loop||t.index<a.group.length-1)&&n(t.tpl.next).appendTo(a.outer).bind("click.fb",a.next)),a.trigger("afterShow"),t.loop||t.index!==t.group.length-1?a.opts.autoPlay&&!a.player.isActive&&(a.opts.autoPlay=!1,a.play()):a.play(!1))},_afterZoomOut:function(t){t=t||a.current,n(".fancybox-wrap").trigger("onReset").remove(),n.extend(a,{group:{},opts:{},router:!1,current:null,isActive:!1,isOpened:!1,isOpen:!1,isClosing:!1,wrap:null,skin:null,outer:null,inner:null}),a.trigger("afterClose",t)}}),a.transitions={getOrigPosition:function(){var t=a.current,e=t.element,n=t.orig,i={},o=50,r=50,s=t.hPadding,l=t.wPadding,c=a.getViewport();return!n&&t.isDom&&e.is(":visible")&&(n=e.find("img:first"),n.length||(n=e)),u(n)?(i=n.offset(),n.is("img")&&(o=n.outerWidth(),r=n.outerHeight())):(i.top=c.y+(c.h-r)*t.topRatio,i.left=c.x+(c.w-o)*t.leftRatio),("fixed"===a.wrap.css("position")||t.locked)&&(i.top-=c.y,i.left-=c.x),i={top:m(i.top-s*t.topRatio),left:m(i.left-l*t.leftRatio),width:m(o+l),height:m(r+s)}},step:function(t,e){var n,i,o,r=e.prop,s=a.current,l=s.wrapSpace,c=s.skinSpace;("width"===r||"height"===r)&&(n=e.end===e.start?1:(t-e.start)/(e.end-e.start),a.isClosing&&(n=1-n),i="width"===r?s.wPadding:s.hPadding,o=t-i,a.skin[r](h("width"===r?o:o-l*n)),a.inner[r](h("width"===r?o:o-l*n-c*n)))},zoomIn:function(){var t=a.current,e=t.pos,i=t.openEffect,o="elastic"===i,r=n.extend({opacity:1},e);delete r.position,o?(e=this.getOrigPosition(),t.openOpacity&&(e.opacity=.1)):"fade"===i&&(e.opacity=.1),a.wrap.css(e).animate(r,{duration:"none"===i?0:t.openSpeed,easing:t.openEasing,step:o?this.step:null,complete:a._afterZoomIn})},zoomOut:function(){var t=a.current,e=t.closeEffect,n="elastic"===e,i={opacity:.1};n&&(i=this.getOrigPosition(),t.closeOpacity&&(i.opacity=.1)),a.wrap.animate(i,{duration:"none"===e?0:t.closeSpeed,easing:t.closeEasing,step:n?this.step:null,complete:a._afterZoomOut})},changeIn:function(){var t,e=a.current,n=e.nextEffect,i=e.pos,o={opacity:1},r=a.direction,s=200;i.opacity=.1,"elastic"===n&&(t="down"===r||"up"===r?"top":"left","down"===r||"right"===r?(i[t]=m(h(i[t])-s),o[t]="+="+s+"px"):(i[t]=m(h(i[t])+s),o[t]="-="+s+"px")),"none"===n?a._afterZoomIn():a.wrap.css(i).animate(o,{duration:e.nextSpeed,easing:e.nextEasing,complete:a._afterZoomIn})},changeOut:function(){var t=a.previous,e=t.prevEffect,i={opacity:.1},o=a.direction,r=200;"elastic"===e&&(i["down"===o||"up"===o?"top":"left"]=("up"===o||"left"===o?"-":"+")+"="+r+"px"),t.wrap.animate(i,{duration:"none"===e?0:t.prevSpeed,easing:t.prevEasing,complete:function(){n(this).trigger("onReset").remove()}})}},a.helpers.overlay={defaults:{closeClick:!0,speedOut:200,showEarly:!0,css:{},locked:!c,fixed:!0},overlay:null,fixed:!1,create:function(t){t=n.extend({},this.defaults,t),this.overlay&&this.close(),this.overlay=n('<div class="fancybox-overlay"></div>').appendTo("body"),this.fixed=!1,t.fixed&&a.defaults.fixed&&(this.overlay.addClass("fancybox-overlay-fixed"),this.fixed=!0)},open:function(t){var e=this;t=n.extend({},this.defaults,t),this.overlay?this.overlay.unbind(".overlay").width("auto").height("auto"):this.create(t),this.fixed||(o.bind("resize.overlay",n.proxy(this.update,this)),this.update()),t.closeClick&&this.overlay.bind("click.overlay",function(t){n(t.target).hasClass("fancybox-overlay")&&(a.isActive?a.close():e.close())}),this.overlay.css(t.css).show()},close:function(){n(".fancybox-overlay").remove(),o.unbind("resize.overlay"),this.overlay=null,this.margin!==!1&&(n("body").css("margin-right",this.margin),this.margin=!1),this.el&&this.el.removeClass("fancybox-lock")},update:function(){var t,n="100%";this.overlay.width(n).height("100%"),s?(t=Math.max(e.documentElement.offsetWidth,e.body.offsetWidth),r.width()>t&&(n=r.width())):r.width()>o.width()&&(n=r.width()),this.overlay.width(n).height(r.height())},onReady:function(t,i){n(".fancybox-overlay").stop(!0,!0),this.overlay||(this.margin=r.height()>o.height()||"scroll"===n("body").css("overflow-y")?n("body").css("margin-right"):!1,this.el=e.all&&!e.querySelector?n("html"):n("body"),this.create(t)),t.locked&&this.fixed&&(i.locked=this.overlay.append(i.wrap),i.fixed=!1),t.showEarly===!0&&this.beforeShow.apply(this,arguments)},beforeShow:function(t,e){e.locked&&(this.el.addClass("fancybox-lock"),this.margin!==!1&&n("body").css("margin-right",h(this.margin)+e.scrollbarWidth)),this.open(t)},onUpdate:function(){this.fixed||this.update()},afterClose:function(t){this.overlay&&!a.isActive&&this.overlay.fadeOut(t.speedOut,n.proxy(this.close,this))}},a.helpers.title={defaults:{type:"float",position:"bottom"},beforeShow:function(t){var e,i,o=a.current,r=o.title,l=t.type;if(n.isFunction(r)&&(r=r.call(o.element,o)),d(r)&&""!==n.trim(r)){switch(e=n('<div class="fancybox-title fancybox-title-'+l+'-wrap">'+r+"</div>"),l){case"inside":i=a.skin;break;case"outside":i=a.wrap;break;case"over":i=a.inner;break;default:i=a.skin,e.appendTo("body"),s&&e.width(e.width()),e.wrapInner('<span class="child"></span>'),a.current.margin[2]+=Math.abs(h(e.css("margin-bottom")))}e["top"===t.position?"prependTo":"appendTo"](i)}}},n.fn.fancybox=function(t){var e,i=n(this),o=this.selector||"",s=function(r){var s,l,c=n(this).blur(),u=e;r.ctrlKey||r.altKey||r.shiftKey||r.metaKey||c.is(".fancybox-wrap")||(s=t.groupAttr||"data-fancybox-group",l=c.attr(s),l||(s="rel",l=c.get(0)[s]),l&&""!==l&&"nofollow"!==l&&(c=o.length?n(o):i,c=c.filter("["+s+'="'+l+'"]'),u=c.index(this)),t.index=u,a.open(c,t)!==!1&&r.preventDefault())};return t=t||{},e=t.index||0,o&&t.live!==!1?r.undelegate(o,"click.fb-start").delegate(o+":not('.fancybox-item, .fancybox-nav')","click.fb-start",s):i.unbind("click.fb-start").bind("click.fb-start",s),this.filter("[data-fancybox-start=1]").trigger("click"),this},r.ready(function(){n.scrollbarWidth===i&&(n.scrollbarWidth=function(){var t=n('<div style="width:50px;height:50px;overflow:auto"><div/></div>').appendTo("body"),e=t.children(),i=e.innerWidth()-e.height(99).innerWidth();return t.remove(),i}),n.support.fixedPosition===i&&(n.support.fixedPosition=function(){var t=n('<div style="position:fixed;top:20px;"></div>').appendTo("body"),e=20===t[0].offsetTop||15===t[0].offsetTop;return t.remove(),e}()),n.extend(a.defaults,{scrollbarWidth:n.scrollbarWidth(),fixed:n.support.fixedPosition,parent:n("body")})})}(window,document,jQuery);