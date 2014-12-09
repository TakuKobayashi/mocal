
/*
 * Swipe 2.0
 *
 * Brad Birdsall
 * Copyright 2013, MIT License
 *
*/
function Swipe(n,t){"use strict";function e(){w=x.children,m=w.length,w.length<2&&(t.continuous=!1),f.transitions&&t.continuous&&w.length<3&&(x.appendChild(w[0].cloneNode(!0)),x.appendChild(x.children[1].cloneNode(!0)),w=x.children),p=new Array(w.length),E=n.getBoundingClientRect().width||n.offsetWidth,x.style.width=w.length*E+"px";for(var e=w.length;e--;){var i=w[e];i.style.width=E+"px",i.setAttribute("data-index",e),f.transitions&&(i.style.left=e*-E+"px",a(e,b>e?-E:e>b?E:0,0))}t.continuous&&f.transitions&&(a(s(b-1),-E,0),a(s(b+1),E,0)),f.transitions||(x.style.left=b*-E+"px"),n.style.visibility="visible"}function i(){t.continuous?r(b-1):b&&r(b-1)}function o(){t.continuous?r(b+1):b<w.length-1&&r(b+1)}function s(n){return(w.length+n%w.length)%w.length}function r(n,e){if(b!=n){if(f.transitions){var i=Math.abs(b-n)/(b-n);if(t.continuous){var o=i;i=-p[s(n)]/E,i!==o&&(n=-i*w.length+n)}for(var r=Math.abs(b-n)-1;r--;)a(s((n>b?n:b)-r-1),E*i,0);n=s(n),a(b,E*i,e||g),a(n,0,e||g),t.continuous&&a(s(n-i),-(E*i),0)}else n=s(n),c(b*-E,n*-E,e||g);b=n,h(t.callback&&t.callback(b,w[b]))}}function a(n,t,e){u(n,t,e),p[n]=t}function u(n,t,e){var i=w[n],o=i&&i.style;o&&(o.webkitTransitionDuration=o.MozTransitionDuration=o.msTransitionDuration=o.OTransitionDuration=o.transitionDuration=e+"ms",o.webkitTransform="translate("+t+"px,0)translateZ(0)",o.msTransform=o.MozTransform=o.OTransform="translateX("+t+"px)")}function c(n,e,i){if(!i)return void(x.style.left=e+"px");var o=+new Date,s=setInterval(function(){var r=+new Date-o;return r>i?(x.style.left=e+"px",L&&d(),t.transitionEnd&&t.transitionEnd.call(event,b,w[b]),void clearInterval(s)):void(x.style.left=(e-n)*(Math.floor(r/i*100)/100)+n+"px")},4)}function d(){T=setTimeout(o,L)}function l(){L=0,clearTimeout(T)}var v=function(){},h=function(n){setTimeout(n||v,0)},f={addEventListener:!!window.addEventListener,touch:"ontouchstart"in window||window.DocumentTouch&&document instanceof DocumentTouch,transitions:function(n){var t=["transitionProperty","WebkitTransition","MozTransition","OTransition","msTransition"];for(var e in t)if(void 0!==n.style[t[e]])return!0;return!1}(document.createElement("swipe"))};if(n){var w,p,E,m,x=n.children[0];t=t||{};var b=parseInt(t.startSlide,10)||0,g=t.speed||300;t.continuous=void 0!==t.continuous?t.continuous:!0;var T,y,L=t.auto||0,k={},D={},M={handleEvent:function(n){switch(n.type){case"touchstart":this.start(n);break;case"touchmove":this.move(n);break;case"touchend":h(this.end(n));break;case"webkitTransitionEnd":case"msTransitionEnd":case"oTransitionEnd":case"otransitionend":case"transitionend":h(this.transitionEnd(n));break;case"resize":h(e)}t.stopPropagation&&n.stopPropagation()},start:function(n){var t=n.touches[0];k={x:t.pageX,y:t.pageY,time:+new Date},y=void 0,D={},x.addEventListener("touchmove",this,!1),x.addEventListener("touchend",this,!1)},move:function(n){if(!(n.touches.length>1||n.scale&&1!==n.scale)){t.disableScroll&&n.preventDefault();var e=n.touches[0];D={x:e.pageX-k.x,y:e.pageY-k.y},"undefined"==typeof y&&(y=!!(y||Math.abs(D.x)<Math.abs(D.y))),y||(n.preventDefault(),l(),t.continuous?(u(s(b-1),D.x+p[s(b-1)],0),u(b,D.x+p[b],0),u(s(b+1),D.x+p[s(b+1)],0)):(D.x=D.x/(!b&&D.x>0||b==w.length-1&&D.x<0?Math.abs(D.x)/E+1:1),u(b-1,D.x+p[b-1],0),u(b,D.x+p[b],0),u(b+1,D.x+p[b+1],0)))}},end:function(){var n=+new Date-k.time,e=Number(n)<250&&Math.abs(D.x)>20||Math.abs(D.x)>E/2,i=!b&&D.x>0||b==w.length-1&&D.x<0;t.continuous&&(i=!1);var o=D.x<0;y||(e&&!i?(o?(t.continuous?(a(s(b-1),-E,0),a(s(b+2),E,0)):a(b-1,-E,0),a(b,p[b]-E,g),a(s(b+1),p[s(b+1)]-E,g),b=s(b+1)):(t.continuous?(a(s(b+1),E,0),a(s(b-2),-E,0)):a(b+1,E,0),a(b,p[b]+E,g),a(s(b-1),p[s(b-1)]+E,g),b=s(b-1)),t.callback&&t.callback(b,w[b])):t.continuous?(a(s(b-1),-E,g),a(b,0,g),a(s(b+1),E,g)):(a(b-1,-E,g),a(b,0,g),a(b+1,E,g))),x.removeEventListener("touchmove",M,!1),x.removeEventListener("touchend",M,!1)},transitionEnd:function(n){parseInt(n.target.getAttribute("data-index"),10)==b&&(L&&d(),t.transitionEnd&&t.transitionEnd.call(n,b,w[b]))}};return e(),L&&d(),f.addEventListener?(f.touch&&x.addEventListener("touchstart",M,!1),f.transitions&&(x.addEventListener("webkitTransitionEnd",M,!1),x.addEventListener("msTransitionEnd",M,!1),x.addEventListener("oTransitionEnd",M,!1),x.addEventListener("otransitionend",M,!1),x.addEventListener("transitionend",M,!1)),window.addEventListener("resize",M,!1)):window.onresize=function(){e()},{setup:function(){e()},slide:function(n,t){l(),r(n,t)},prev:function(){l(),i()},next:function(){l(),o()},stop:function(){l()},getPos:function(){return b},getNumSlides:function(){return m},kill:function(){l(),x.style.width="",x.style.left="";for(var n=w.length;n--;){var t=w[n];t.style.width="",t.style.left="",f.transitions&&u(n,0,0)}f.addEventListener?(x.removeEventListener("touchstart",M,!1),x.removeEventListener("webkitTransitionEnd",M,!1),x.removeEventListener("msTransitionEnd",M,!1),x.removeEventListener("oTransitionEnd",M,!1),x.removeEventListener("otransitionend",M,!1),x.removeEventListener("transitionend",M,!1),window.removeEventListener("resize",M,!1)):window.onresize=null}}}}(window.jQuery||window.Zepto)&&!function(n){n.fn.Swipe=function(t){return this.each(function(){n(this).data("Swipe",new Swipe(n(this)[0],t))})}}(window.jQuery||window.Zepto);


//Search-form
var query = "";


// {Suggest

	$(function() {
		var data = gon.companies;
		$('#search-input').autocomplete({
			source: data,
			autoFocus: true,
			delay: 500,
			minLength: 2
		});	

		$("#judgements").fadeIn();
	});

// suggest}

$(function(){

$("body").addClass(_c.device.type);

$(".card").each(function(){
	var $h2 = $(this).children("h2");
	if($h2){
		$(this).attr("data-defaulttitle",$h2.text())
	}
});

$(window).on({"resize":function(){
	$(".card").css("height","auto");
	var cache = {}
	$(".overview").removeClass("large").removeClass("mid")
	
	if($(this).width() > 600 ){
		$(".overview").addClass("large")
	}else if($(this).width() > 400 ){
		$(".overview").addClass("mid")
	}
	
	$(".card").each(function(){

		if(!cache["h"+$(this).offset().top]){
			cache["h"+$(this).offset().top] = []
		}
		cache["h"+$(this).offset().top].push($(this))
	})

	$.each(cache,function(){
		var tmpHeight = 0;
		$.each(this,function(){
			if(tmpHeight < this.height()){
				tmpHeight = this.height()
			}
		})
		$.each(this,function(){
			this.height(tmpHeight)
		})
	})
	cache = {}
	$(".card").each(function(){

		if(!cache["h"+$(this).offset().top]){
			cache["h"+$(this).offset().top] = []
		}
		cache["h"+$(this).offset().top].push($(this))
	})

	$.each(cache,function(){
		var tmpHeight = 0;
		$.each(this,function(){
			if(tmpHeight < this.height()){
				tmpHeight = this.height()
			}
		})
		$.each(this,function(){
			this.height(tmpHeight)
		})
	})

	console.log(cache)
}})

function resetResult(){
	$(".card").each(function(){
		if(!$(this).hasClass("emotion-graph")){
			$(this).empty()	
		}
		if($(this).attr("data-defaulttitle")){
			$(this).append($("<h2>"+$(this).attr("data-defaulttitle")+"</h2>"))
		}
	});
}


(function(){

	$searchInput = $("#search-input");	
	$searchInput.on({
		"focusin":function(){
			$("#search-area .inputbox").addClass("inputed active");
		},
		"focusout":function(){
			if($(this).val() == ""){
				$("#search-area .inputbox").removeClass("inputed");
			}
			$("#search-area .inputbox").removeClass("active");
		}
	})
	$("#search-form").on({
		"submit":function(){
			resetResult()
			$(".mainvis").slideUp("normal","swing",function(){
				$("#result").find(".card").each(function(i){
					var $target = $(this)
					setTimeout(function(){
						$target.addClass("active");
					},i*100)
					console.log(i);
				});
			});


			query = $("#search-input").val();
			if(query.match(/\ \([0-9]*[\ ,]( )?[0-9]*\)/i)){
				$(this).attr("data-currentquery",query.split(" ")[0])
			}else{
				$(this).attr("data-currentquery",query)
			}


			$.ajax({
			  type: "GET",
			  url: gon.asahi_path + "?q="+encodeURI($("#search-form").attr("data-currentquery")),
			  dataType: 'jsonp',
			  success: function(json){
			  	console.log("asahi:",json)
			  	var $asahi = $("#asahi")
			  	$asahi.find(".positive-article").append(render.asahiArticle(json.positiveArticle))
			  	$asahi.find(".negative-article").append(render.asahiArticle(json.negativeArticle))
			  	$asahi.find(".positive-word").append(render.asahiWords(json.positiveWord))
			  	$asahi.find(".negative-word").append(render.asahiWords(json.negativeWord))
			  	$(window).trigger("resize");
			  }
			});

			$.ajax({
			  type: "GET",
			  url: gon.company_detail_path + "?q="+encodeURI($("#search-form").attr("data-currentquery")),
			  dataType: 'jsonp',
			  success: function(json){

			  	var $result = $("#result")
				var $ul = $("<ul />").addClass()
				console.log($("#result").find(".name"))
				$ul.append('<li class="name">'+ json.name +' <small class="badge">証券番号:'+ json.stock_code +'</small></li>');
				$ul.append('<li class="stockPrice">&yen;'+_c.devideComma(json.price)+' <small class="timestamp">0000/00/00 00:00現在</small></li>');
				$ul.removeClass("positive").removeClass("negative")
				if(json.vector = 0){

					$ul.append('<li class="vector"><div class="">→</div></li>');
				}else if(json.vector = 1){
					$ul.append('<li class="vector"><div class="">▲</div></li>');
					$ul.addClass("positive");
				}else{
					$ul.append('<li class="vector"><div class="">▼</div></li>');
					$ul.addClass("negative");
				}

				console.log("vector:",json.vector)
				$("#overview .card").append($ul);

					var judge = {
					'ぐるなび':{
						'result':'最大の幸運',
						'detail':'穏やかなペースで事業を盛り立てていくことができる。時代の追い風を受けてチャンスに恵まれ、取引先や顧客からの評判も上々。会社としての理想や目標を成就することができる。外部から「商品やサービスが平凡だ」「もっと会社を大きくできるはずだ」と指摘されことも多いが、欲をかいて急な事業拡大や多角経営をしてはいけない。本業を愚直にまっとうしていれば、会社は安泰である。'
					},
					'ソフトバンク':{
						'result':'知恵に恵まれる大吉',
						'detail':'特殊な技術や能力を求められる分野で大成する。最新鋭の機器や最先端の研究などを事業化する際は、この画数の社名を付けると良い。忍耐力が強いスタッフに恵まれるため、あらゆる難事を巧みに切り抜けることができる。不可能と思われていたことを実現することで、大きな功績を生む。その結果、大きな利益が生まれ、さらに新しい研究に投資できるので、末永く会社が繁栄する。'
					},
					'NTTドコモ':{
						'result':'大吉',
						'detail':'ピンチをチャンスに変える強運を持つ。これまでの凶、いま起こりつつある凶、これから先起ころうとする凶、すべてを吉に好転させることができる。大衆の潜在的な需要をつかみ、商品やサービスの形で社会に還元し、事業を大成する。この数を持つ会社は規模の大小や事業分野に関わらず幸運に恵まれるので、最高の吉数といえる。どんな事業を展開していても、業界の上位に立つことができる。'
					},
					'セイコーエプソン':{
						'result':'大吉',
						'detail':'ピンチをチャンスに変える強運を持つ。これまでの凶、いま起こりつつある凶、これから先起ころうとする凶、すべてを吉に好転させることができる。大衆の潜在的な需要をつかみ、商品やサービスの形で社会に還元し、事業を大成する。この数を持つ会社は規模の大小や事業分野に関わらず幸運に恵まれるので、最高の吉数といえる。どんな事業を展開していても、業界の上位に立つことができる。'
					},
					'構造計画研究所':{
						'result':'エネルギーに満ちあふれる',
						'detail':'社内の活気が旺盛。スピーディーでパワフルに事業を展開していくことができる。製造業なら、若者向けの商品を開発するとヒットにつながる。また、宣伝・広告など、大衆へのアピールが必要な業種でも大成する。ただし、自社によって無理やり流行を生み出そうとすると失敗する。自然の摂理に反しないよう、時流に沿った商品やサービスを生み出せば、世の中に支持される。'
					},
					'シャープ':{
						'result':'鉄のように堅固な意志を示す運命',
						'detail':'克己心が強いメンバーが集まりやすい。努力を続けて理念や目標を貫く。新しいアイデアを積極的に実行しようという雰囲気もあるので、時代の波にうまく乗ることもできる。変わるものと変わらないもの、双方を大切にすることで、名実ともに兼ね備えた企業として成長する。ただし、親会社や主要取引先の会社名の画数に凶数がある場合は、災難に見舞われる恐れもある。'
					},
					'デンソー':{
						'result':'大凶の運命',
						'detail':'災難が多い。発表した商品やサービスは短命に終わり、顧客に見放され、資金繰りが悪化し、倒産の憂き目に遭う。悪徳商法や違法行為に手を出すなど、会社ぐるみで法を犯し、社会的に抹殺される可能性もある。また、会社が長く存続しても、有能な人材が他社に流出した結果、他社との競争に敗れるなど、次々と逆境に見舞われる。既にこの画数の社名を持つ会社は吉数に改名するのが無難である。凶数の影響力を回避するためには、法令順守を徹底することが必要である。「この程度なら大丈夫」という甘い意識を断ち、緊張感を持つこと。「当たり前」のことを愚直に行う謙虚さがあれば、最悪の事態は免れる。'
					},
					'HOYA':{
						'result':'大凶の運命',
						'detail':'災難が多い。発表した商品やサービスは短命に終わり、顧客に見放され、資金繰りが悪化し、倒産の憂き目に遭う。悪徳商法や違法行為に手を出すなど、会社ぐるみで法を犯し、社会的に抹殺される可能性もある。また、会社が長く存続しても、有能な人材が他社に流出した結果、他社との競争に敗れるなど、次々と逆境に見舞われる。既にこの画数の社名を持つ会社は吉数に改名するのが無難である。凶数の影響力を回避するためには、法令順守を徹底することが必要である。「この程度なら大丈夫」という甘い意識を断ち、緊張感を持つこと。「当たり前」のことを愚直に行う謙虚さがあれば、最悪の事態は免れる。'
					},
					'楽天':{
						'result':'最も強情な性質を持つ',
						'detail':'強い意志で万難を突破する社風である。それ自体は長所だが、その一方で剛情で猜疑心が強いため、吉数とはいえない。むやみにプライドが高く、「おたくとうちは違う」という姿勢を貫くため、他社と不和になりがちである。業界の足並みを乱した結果、恨みや反感を買い、思わぬ厄難に遭うこともある。協調性を大切にすれば、窮地を脱することができる。凶数の影響力を回避するためには、謙虚な姿勢が必要である。取引先や顧客はもちろんのこと、下請けやライバル会社に対してもおごり高ぶらないこと。学びの精神を大切にし、協調性を大切にすれば、災厄を回避できる。'
					},
					'ブラザー工業':{
						'result':'悪評が立つ凶運',
						'detail':'事業拡大の戦略に長け、スタッフの奮闘によって成功の域に達する。一方で、会社全体の傾向として自尊心が強く、成功すると居丈高になりやすい。顧客や取引先各社から反感を買い、非難の的となる。その結果、途中で失敗挫折することが多く、成功は長く続かない。凶運を回避するには、業績が好調なときこそ社員一同が謙虚になり、世の中に喜ばれる事業を愚直に進めることが必要である。凶数の影響力を回避するために重要な点は、過去の成功体験にしがみつかないこと。一度うまくいくと、すべての事業を同じパターンで進めがちだが、それが落とし穴になる。時流に即したビジネスを展開することが必須。'
					},
					'テレビ朝日ホールディングス':{
						'result':'勢力に乏しく薄弱な運命',
						'detail':'破綻することが多く、困難が絶えない。世の中の動きや周辺の環境から、良くも悪くも大きな影響を受ける。そのため、取引先や関連会社に吉数の名前を持つ会社が多い場合は、良いエネルギーを得て不幸を切り抜け、大成功することもある。ただし、取引先や関連会社に凶数の名前を持つ会社が多ければ、自社が傾き短命に終わる。災厄に遭うこともあって、その不幸は計り知れない。凶数の影響力を回避するためには、社内の意志疎通が必須。経営陣は求心力を養い、社員が疑問だらけで仕事するような状況を脱却すること。会社の目指す方向が決まり、一致団結することができれば、勢いも上向く。'
					},
					'KDDI':{
						'result':'堅固な意志を示す運命',
						'detail':'克己心が強いメンバーが集まりやすい。努力を続けて理念や目標を貫く。新しいアイデアを積極的に実行しようという雰囲気もあるので、時代の波にうまく乗ることもできる。変わるものと変わらないもの、双方を大切にすることで、名実ともに兼ね備えた企業として成長する。ただし、親会社や主要取引先の会社名の画数に凶数がある場合は、災難に見舞われる恐れもある。'
					}
				};
				$(function(){
						$('#seimei').find('.card').html("<h2>社名診断</h2><h3>"+judge[json.name].result+"</h3>"+"<p>"+judge[json.name].detail+"</p>")
				});
				$(window).trigger("resize");
			  }
			});
			$.ajax({
			  type: "GET",
			  url: gon.social_path + "?q="+encodeURI($("#search-form").attr("data-currentquery")),
			  dataType: 'jsonp',
			  success: function(json){
			  	//{positiveComment: null, negativeComment: null, socialTrend: Object}
			  	console.log("social:",json)
			  	$asahi.find(".positive-article").append(render.asahiArticle(json.positiveArticle))
			  	$asahi.find(".negative-article").append(render.asahiArticle(json.negativeArticle))
			  	$asahi.find(".positive-word").append(render.asahiWords(json.positiveWord))
			  	$asahi.find(".negative-word").append(render.asahiWords(json.negativeWord))
			    
			  	$(window).trigger("resize");
			  }
			});
			$("#judgements").find(".graph").each(function(){
			var geom = {
			w:$(this).children("img").width(),
			h:$(this).children("img").height()
			}
			$(this).children("img").css("opacity",0)
			$(this).children("canvas").width(geom.w).width(geom.h).css({"top":0,"left":0,"position":"absolute"})
			})
			var doughnutData = [
			{value: 30,color:"#aaf2fb"},
			{value: 50,color: "#ffb6b9"},
			{value: 120,color: "#ffe361"},
			{value: 170,color: "#fbaa6e"},
			{value: 70,color: "#A8BECB"}];


			$("canvas.chart").each(function(){
			var myDoughnut = new Chart($(this)[0].getContext("2d")).Doughnut(doughnutData);
			})

			return false;
		}
	})

})()//Search-form


var render = {
		asahiArticle:function(input){
			return "<h3>"+input.title + "</h3>" + 
			"<p>" + input.body + "</p>"
		},
		asahiWords:function(input){
			return "<ol><li>"+input[0]+"</li><li>"+input[1]+"</li><li>"+input[2]+"</li><li>"+input[3]+"</li><li>"+input[4]+"</li></ol>"
		}		
	}

if(_c.device.type == "phone"){
Swipe($("#judgements")[0], {
    // startSlide: 4,
    // auto: 3000,
    continuous: false,
    // disableScroll: true,
    stopPropagation: true,
    callback: function(index, element) {
    	//tabHighlight(index)
    },
    transitionEnd: function(index, element) {
    	//tabHighlight(index)
    }
  });
}





})//ready