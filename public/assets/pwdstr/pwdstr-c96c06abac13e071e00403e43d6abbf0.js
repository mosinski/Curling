!function(t){t.fn.extend({pwdstr:function(e){return this.each(function(){function n(t){var e=0,n=28e8;/[a-z]/.test(t)&&(e+=26),/[A-Z]/.test(t)&&(e+=26),/[0-9]/.test(t)&&(e+=10),/[^a-zA-Z0-9]/.test(t)&&(e+=32);var i=Math.pow(e,t.length),o=i/n,r=o/31536e3,a=Math.floor(r),s=12*(r-a),l=Math.floor(s),c=30*(s-l),u=Math.floor(c),p=24*(c-u),d=Math.floor(p),f=60*(p-d),h=Math.floor(f),m=60*(f-h),g=Math.floor(m),y=[];return a>0&&(1==a?y.push("1 rok, "):a>1&&5>a?y.push(a+" lata, "):y.push(a+" lat, ")),l>0&&(1==l?y.push("1 miesiąc, "):l>1&&5>l?y.push(l+" miesiące, "):y.push(l+" miesięcy, ")),u>0&&(1==u?y.push("1 dzień, "):y.push(u+" dni, ")),d>0&&(1==d?y.push("1 godzinę, "):d>1&&5>d?y.push(d+" godziny, "):y.push(d+" godzin, ")),h>0&&(1==h?y.push("1 minute, "):h>1&&5>h?y.push(h+" minuty, "):y.push(h+" minut, ")),g>0&&(1==g?y.push("1 sekunde, "):g>1&&5>g?y.push(g+" sekundy, "):y.push(g+" sekund, ")),y=y.length<=0?"mniej niż sekunde, ":1==y.length?y[0]:y[0]+y[1],y.substring(0,y.length-2)}t(this).keyup(function(){t(e).html("Hasło zostanie złamane w "+n(t(this).val()))})})}})}(jQuery);