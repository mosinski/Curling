!function(){function t(t){return"<meta name='sharer'><link rel='stylesheet' href='http://weloveiconfonts.com/api/?family=entypo'><link rel='stylesheet' href='http://fonts.googleapis.com/css?family=Lato:900'><style>"+t.selector+"{width:90px;height:20px}"+t.selector+" [class*=entypo-]:before{font-family:entypo,sans-serif}"+t.selector+" label{font-size:16px;cursor:pointer;margin:0;padding:5px 10px;border-radius:5px;background:"+t.button_background+";color:"+t.button_color+";-webkit-transition:all .3s ease;transition:all .3s ease}"+t.selector+" label:hover{opacity:.8}"+t.selector+" label span{text-transform:uppercase;font-size:.85em;font-family:Lato,sans-serif;font-weight:900;-webkit-font-smoothing:antialiased;padding-left:6px}"+t.selector+" .social{-webkit-transform-origin:50% 0;-ms-transform-origin:50% 0;transform-origin:50% 0;-webkit-transform:scale(0) translateY(-190px);-ms-transform:scale(0) translateY(-190px);transform:scale(0) translateY(-190px);opacity:0;-webkit-transition:all .4s ease;transition:all .4s ease;margin-left:-15px}"+t.selector+" .social.active{opacity:1;-webkit-transform:scale(1) translateY(-90px);-ms-transform:scale(1) translateY(-90px);transform:scale(1) translateY(-90px);-webkit-transition:all .4s ease;transition:all .4s ease;margin-left:-45px}"+t.selector+" ul{position:relative;left:0;right:0;width:180px;height:46px;color:#fff;background:#3b5998;margin:auto;padding:0;list-style:none}"+t.selector+" ul li{font-size:20px;cursor:pointer;width:60px;margin:0;padding:12px 0;text-align:center;float:left;display:block;height:22px;position:relative;z-index:2;-webkit-box-sizing:content-box;-moz-box-sizing:content-box;box-sizing:content-box;-webkit-transition:all .3s ease;transition:all .3s ease}"+t.selector+" ul li:hover{color:rgba(0,0,0,.5)}"+t.selector+" ul:after{content:'';display:block;width:0;height:0;position:absolute;left:0;right:0;margin:35px auto;border-left:20px solid transparent;border-right:20px solid transparent;border-top:20px solid #3b5998}"+t.selector+" li[class*=twitter]{background:#6cdfea;padding:12px 0}"+t.selector+" li[class*=gplus]{background:#e34429;padding:12px 0}</style>"}$.fn.share=function(e){var n,i,o,r,a,s,l,c,u=this;return $(this).hide(),null==e&&(e={}),r={},r.url=e.url||window.location.href,r.text=e.text||$("meta[name=description]").attr("content")||"",r.app_id=e.app_id,r.title=e.title,r.image=e.image,r.button_color=e.color||"#333",r.button_background=e.background||"#e1e1e1",r.button_icon=e.icon||"export",r.button_text=e.button_text||"Share",l=function(t,n){return e[t]?e[t][n]||r[n]:r[n]},r.twitter_url=l("twitter","url"),r.twitter_text=l("twitter","text"),r.fb_url=l("facebook","url"),r.fb_title=l("facebook","title"),r.fb_caption=l("facebook","caption"),r.fb_text=l("facebook","text"),r.fb_image=l("facebook","image"),r.gplus_url=l("gplus","url"),r.selector="."+$(this).attr("class"),r.twitter_text=encodeURIComponent(r.twitter_text),"integer"==typeof r.app_id&&(r.app_id=r.app_id.toString()),$("meta[name=sharer]").length||$("head").append(t(r)),$(this).html("<label class='entypo-"+r.button_icon+"'><span>"+r.button_text+"</span></label><div class='social'><ul><li class='entypo-twitter' data-network='twitter'></li><li class='entypo-facebook' data-network='facebook'></li><li class='entypo-gplus' data-network='gplus'></li></ul></div>"),!window.FB&&r.app_id&&$("body").append("<div id='fb-root'></div><script>(function(a,b,c){var d,e=a.getElementsByTagName(b)[0];a.getElementById(c)||(d=a.createElement(b),d.id=c,d.src='//connect.facebook.net/en_US/all.js#xfbml=1&appId="+r.app_id+"',e.parentNode.insertBefore(d,e))})(document,'script','facebook-jssdk');</script>"),s={twitter:"http://twitter.com/intent/tweet?text="+r.twitter_text+"&url="+r.twitter_url,facebook:"https://www.facebook.com/sharer/sharer.php?u="+r.fb_url,gplus:"https://plus.google.com/share?url="+r.gplus_url},n=$(this).parent().find(".social"),c=function(t){return t.stopPropagation(),n.toggleClass("active")},a=function(){return n.addClass("active")},o=function(){return n.removeClass("active")},i=function(){var t;return t=s[$(this).data("network")],"facebook"===$(this).data("network")&&r.app_id?window.FB.ui({method:"feed",name:r.fb_title,link:r.fb_url,picture:r.fb_image,caption:r.fb_caption,description:r.fb_text}):window.open(t,"targetWindow","toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,height=350"),!1},$(this).find("label").on("click",c),$(this).find("li").on("click",i),$("body").on("click",function(){return n.hasClass("active")?n.removeClass("active"):void 0}),setTimeout(function(){return $(u).show()},250),{toggle:c.bind(this),open:a.bind(this),close:o.bind(this),options:r,self:this}}}.call(this);