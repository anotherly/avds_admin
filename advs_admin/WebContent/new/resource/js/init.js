'use strict';

$(function(){
	
	
    lnbMenu();
    famSite();
    $('html').fnInit();

    $('.boxItem__reset').click(function(){
        $(this).addClass("fn-reset");
        setTimeout(function(){ 
            $(".boxItem__reset").removeClass("fn-reset"); 
        }, 400)
    })


    /*new SimpleBar(document.querySelector('.ui-scroller'), {}); //simplebar
    $('.el-form').parents('.lay-boxItem').addClass('form-wrap');
    $('.el-table .el-form').parents('td').addClass('form-wrap--table');*/


	fn_absolutXY();

	fn_goMain(null, "0", null);
});

$.fn.simplebar = function (customOption) {
    var defaultOption = {
        //
    };

    this.each(function () {
        var option = $.extend({}, defaultOption, customOption);
        var $this = $(this);

        if ($this.data('simplebar') || !$.isFunction(window.SimpleBar)) return;

        if ($.isFunction(window.SimpleBar)) {
            if (userAgentCheck.ieMode <= 10) {
                $this.css('overflow', 'auto');
            } else {
                var simplebar = new SimpleBar($this.get(0), option);
                $this.data('simplebar', simplebar);
            }
        }
    });

    return $(this);
};

function lnbMenu() {
    const $this = $(this),
        list = $('.lnb__list'),
        item = $('.lnb__item'),
        dep1Link = item.find('> a'),
        dep2Ul = item.find('> ul'),
        dep2Li = dep2Ul.find('li'),
        dep2Link = dep2Li.find('a');

	$('.lnb__btn').off("click");
    $('.lnb__btn').click(function () {
        $(this).toggleClass('is-clicked');
        if ($(this).hasClass('is-clicked')) {
            $('.content').addClass('lnb-open');
            $('.lnb__cont').addClass('is-show');
        } else {
            $('.content').removeClass('lnb-open');
            $('.lnb__cont').removeClass('is-show')
        }
    });
    item.hover(function () {
        dep1Link.removeClass('is-hover')
        $(this).find('> a').addClass('is-hover');
        dep2Link.hover(function () {
            dep2Link.removeClass('is-hover');
            $(this).addClass('is-hover');
        })
    });
    dep1Link.click(function () {
        const li = $(this).parent(),
            sibling = li.siblings();
        $('ul', sibling).slideUp("fast");

        sibling.find('a').removeClass('is-clicked');

        const ul = $('>ul', li);
        if (ul.length > 0) {
            ul.slideToggle(200, "swing");
            $(this).toggleClass('is-clicked');
            return false;
        }
    });
    $('.lnb__cont').mouseleave(function () {
        item.find('a').removeClass('is-hover')
    })
}

function lnbMenuOpenToggle(param) {
        if (param) {
            $('.content').addClass('lnb-open');
            $('.lnb__cont').addClass('is-show');
        } else {
            $('.content').removeClass('lnb-open');
            $('.lnb__cont').removeClass('is-show')
        }
	
	}

function famSite() {
    $('.familySite__btn').click(function () {
        $(this).next().slideToggle(200, 'swing');
        $(this).toggleClass('is-clicked');
    })
}

$.fn.setFormFn = function () {
    const $this = $(this),
        selBtn = $('> button', this),
        selCont = $('> ul', this),
        selValue = selCont.find('> li');

    selCont.hide();
    selBtn.click(function () {
        $(this).parent().toggleClass('is-open').find('ul').slideToggle('fast', 'swing');
    });
    selValue.click(function () {
        $(this).parent().prev('button').find('span').text($(this).text());
        selCont.slideUp('fast', 'swing');
        $this.removeClass('is-open');
    });
    selValue.hover(function () {
        $(this).toggleClass('is-hover');
    })
};
$.fn.tabFn = function () {
    const linkWrap = $('.el-tab__link'),
    linkItem = linkWrap.find('li'),
    linkBtn = linkItem.find('button'),
    linkClose = linkItem.find('> span');

    $('.el-tab-wrap').parent().addClass('tabs-on');

    linkBtn.click(function(){
        const thisId = $(this).parent().data('id'),
        thisConId = $('#' + thisId);

        linkItem.removeClass('is-open');
        $(this).parent().addClass('is-open');
        $('.el-tab__cont').removeClass('is-open');
        thisConId.addClass('is-open');
    })
    linkClose.click(function(){
        const thisId = $(this).parent().data('id'),
        thisConId = $('#' + thisId);

        thisConId.remove();
        $(this).parent('li').remove();
    })
}

$.fn.fnInit = function () {
    $('.custom-sel').setFormFn();
    $('.el-tab-wrap').tabFn();
};

$(window).resize(function(event) {
	if (this == event.target) {
		fn_absolutXY();
	}
});

/*$(document).ready(function() {
	var tabs = $("#tabs").tabs();

	// 탭 클릭
	$(document).on('click','#tabs a.tab', function() {
		var contentId = $(this).attr("id").replace('TAB_', 'CONTENT_');

		$("#content p").hide();
		$("#tabs li").removeClass("current");

		$("#" + contentId).show();
		$(this).parent().addClass("current");
	});

	// 탭 REMOVE 클릭
    $(document).on('click','#tabs a.remove', function() {
        var tabid = $(this).parent().find(".tab").attr("id");

        var contentId = tabid.replace('TAB_', 'CONTENT_');

        $("#" + contentId).remove();
        $(this).parent().remove();		//탭삭제


        if ($("#tabs li.current").length == 0 && $("#tabs li").length > 0) {
            var firsttab = $("#tabs li:first-child");
            firsttab.addClass("current");
            var firsttabid = $(firsttab).find("a.tab").attr("id").replace('TAB_', 'CONTENT_');

            $("#" + firsttabid).show();
        } else if ($("#tabs li.current").length == 0 && $("#tabs li").length == 0) {	//모든탭이 닫히면 첫화면 show
        	$("#content p").show();
        }
    });

	fn_absolutXY();

	fn_goMain(null, "0");
});*/

function fn_absolutXY() {
	var body_w = document.body.clientWidth;
	var cont_area_w = body_w - 17;
	var tabs_w = body_w;

	if ($("#leftMenu").css("display") != "none") {	//왼쪽 사이드 메뉴 Size 추가 (152px)
		cont_area_w = body_w - 192 - 17;
		tabs_w = body_w - 192;
	}
	$("#cont_area").css("width", cont_area_w);
	$("#tabs").css("width", tabs_w);

	var body_h = document.body.clientHeight;
	var documentElement_h = document.documentElement.clientHeight;
	var content_h = documentElement_h - 60;
	
	var container_h = content_h + 33;
	$('body').css("height", documentElement_h - 33);
	//$(".content").css("height", content_h);
	//$(".wrap").css("height", body_h);
	
	$(".container").css("height", documentElement_h - 60);
	$("#content").css("height", documentElement_h - 99);

	/*if ($("#tabs").css("display") != "none") {	//하단 탭메뉴 Size 추가 (40px)
		content_h = body_h - 175;
	}
	$("#content").css("height", content_h);*/
	
}

function fn_goMain(objId, menuId, menuNm) {
	for (var i=1; i<=9; i++) {
		$("#tmenu_"+i).removeClass("tmenu_on");
	}

	if (menuId == "0") {
		$("#content").empty();
		$("#tabs").empty();
		$("#tabs").append("<ul></ul>");
		$("#tabs").hide();
		var body_h = document.body.clientHeight;
		var content_h = body_h - 60;
		content_h = content_h + "px";
		//$("#content").css("height", content_h);

		fn_goMainPage(); //메인화면 표출
		fn_makeMenu("00000", menuNm); //메뉴생성
		//fn_hideMenu(false); //메뉴숨김
		lnbMenuOpenToggle(false);
	}
	else if (menuId == "A0000") {
		$("#content").empty();
		$("#tabs").empty();
		$("#tabs").append("<ul></ul>");
		$("#tabs").hide();
		var body_h = document.body.clientHeight;
		var content_h = body_h - 60;
		content_h = content_h + "px";
		//$("#content").css("height", content_h);

		fn_goMainPage(); //메인화면 표출
		//fn_hideMenu(false); //메뉴숨김
		lnbMenuOpenToggle(false);
	} else {
		if (objId != null) {
			$("#"+objId).addClass("tmenu_on");
		}

		$("#tabs").show();
		var body_h = document.body.clientHeight;
		var content_h = body_h - 100;
		content_h = content_h + "px";
		//$("#content").css("height", content_h);

		fn_makeMenu(menuId, menuNm); //메뉴생성
    	//fn_hideMenu(true); //메뉴펼침
		lnbMenuOpenToggle(true);
	}
}

function fn_goMainPage() {
	if ($("#TAB_MENU_MAIN_content").length > 0) return;

	var realMenuId = "MENU_MAIN";
	var targetWorkSpaceUrl = "/openInit.do";
	var tabHeight = "100%";
	var iframe = "<iframe id='Workspace_"+realMenuId+"' name='Workspace_"+realMenuId+"' class='wsp' src='"+targetWorkSpaceUrl+"' frameborder='0' width='100%' height='"+tabHeight+"' style='overflow:auto; margin:5px; padding:0px;'></iframe>";
	//$("#content").append("<p class='tab_content' id='TAB_MENU_MAIN_content' name='TAB_MENU_MAIN_content'>" + iframe + "</p>");
	$("#content").append(iframe);
}

function fn_makeMenu(menuPrntId, menuNm) {
	$(".lnb__cont").empty();

	commonAjax({ "menuPrntId": menuPrntId }, "/selectMainMenuList.do", function(returnData, textStatus, jqXHR) {
		var records = returnData.rows;
		var menuHtml = "";
		if (menuPrntId == "00000") {
			for (var i=0; i<records.length; i++) {
				menuHtml += '<li class="gnb__item"><a id="'+records[i].iconNm+'" href="javascript:fn_goMain(\''+records[i].iconNm+'\', \''+records[i].id+'\', \''+records[i].menuNm+'\');" class="'+records[i].iconNm+'"><span></span>'+records[i].menuNm+'</a></li>';
			}

			$(".gnb__list").append(menuHtml);
		} else {
			var menuLevel = "3";
	    	for (var i=0; i<records.length; i++) {
	    		
	    			if (i == 0) {
	        			//menuHtml += "<span class='logo'></span><ul class='lmenu'>";
	    				menuHtml += '<h3 class="lnb__cont__tit el-tit-3 el-weight-5">'+menuNm+'</h3>';
	    				menuHtml += "<ul class='lnb__list'>";
	        		} else {
	        			/* if (menuLevel > records[i].menuLevel) {
	        				//menuHtml += "</ul></ul><ul class='lmenu'>";
	        				menuHtml += '</ul></li><h3 class="lnb__cont__tit el-tit-3 el-weight-5">'+records[i].menuNm+'</h3>';
	        			} */
	        		}
	    			

	        		if (records[i].menuLevel == "2") { //중메뉴
	    				if (i == 0) {
	    					//menuHtml += "<li class='lmenu1' id='"+records[i].id+"'><a href='javascript:fn_acdnMenu(\""+records[i].id+"\");'>"+records[i].menuNm+"</a></li><ul class='lmenu2' style='height: 0px; overflow: auto;' id='"+records[i].id+"_menu'>";
	    					//menuHtml += '<ul class="ui-listUl ui-listUl--bar">';
	    					menuHtml += '<li class="lnb__item">';
	    					//menuHtml += '<a href="javascript:fn_acdnMenu(\''+records[i].id+'\');">'+records[i].menuNm+'</a>';
	    					menuHtml += '<a href="javascript:void(0)">'+records[i].menuNm+'</a>';
	    					//menuHtml += '</li>';
	    					menuHtml += '<ul class="ui-listUl ui-listUl--bar">';
	    					
	    				} else {
	    					if (menuLevel > records[i].menuLevel) {
	    						menuHtml += "</li>";
	    					}
	    					//menuHtml += "<li class='lmenu1' id='"+records[i].id+"'><a href='javascript:fn_acdnMenu(\""+records[i].id+"\");'>"+records[i].menuNm+"</a></li><ul class='lmenu2 display_none' style='height: 0px; overflow: auto;' id='"+records[i].id+"_menu'>";
	    					menuHtml += '</ul>';
	    					menuHtml += '<li class="lnb__item">';
	    					menuHtml += '<a href="javascript:void(0)">'+records[i].menuNm+'</a>';
	    					//menuHtml += '</li>';
	    					menuHtml += '<ul class="ui-listUl ui-listUl--bar">';
	    				}
	        		} else { //프로그램
	        			//menuHtml += "<li class='menu3' id='"+records[i].id+"'><a href='javascript:fn_goMenu(\""+records[i].id+"\", \""+records[i].menuNm+"\");'>"+records[i].menuNm+"</a></li>";
	        			menuHtml += '<li>';
        				menuHtml += '<a href="javascript:fn_openMenu(\''+records[i].id+'\', \''+records[i].menuNm+'\');">'+records[i].menuNm+'</a>';
        				menuHtml += '</li>';
        				
	        		}

	        		if (i == records.length-1) {
	        			menuHtml += "</ul></li>";
	        		}

	        		menuLevel = records[i].menuLevel;
	    	}
	    	menuHtml += "</ul>";

	    	$(".lnb__cont").append(menuHtml);

	    	var menu3Cnt = 0;
	    	var menu3Height = 0;
	    	for (var i=0; i<records.length; i++) {
	    		if (records[i].menuLevel == "2") { //중메뉴
	    			menu3Cnt = 0;
	    		} else { //프로그램
	    			menu3Cnt++;
	    			menu3Cnt = menu3Cnt > 20 ? 20 : menu3Cnt;
	    			menu3Height = menu3Cnt * 24;
	    			$("#" + records[i].menuPrntId + "_menu").css("height", menu3Height+"px");
	    		}
	    	}
		}
		lnbMenu();
	});
}

function fn_acdnMenu(id) {
	$("ul.lmenu2").removeClass().addClass("lmenu2 display_none");
	$("#"+id+"_menu").removeClass().addClass("lmenu2");
}

function fn_goMenu(id, nm) {
	$("li.lmenu3").removeClass().addClass("lmenu3");
	$("#"+id).removeClass().addClass("lmenu3 on");
	fn_openMenu(id, nm);
}

function fn_openMenu(menuId, menuNm) {
	var targetUrl = "", targetPath = "";

	commonAjax({ "menuId": menuId }, "/selectMenu.do", function(returnData, textStatus, jqXHR) {
		for (var i=0; i<returnData.rows.length; i++) {
			targetUrl = returnData.rows[i].menuObject;
			targetPath = returnData.rows[i].menuPath;

			if (targetUrl == null || targetUrl == "") {
				if (targetPath == null || targetPath == "") {
					return false;
				} else {
					fn_openPage(menuId, menuNm, targetPath);
				}
			} else {
				fn_goPage(menuId, menuNm, targetUrl);
			}
		 }
	});
}

function fn_openPage(menuId, menuNm, targetPath) {
	window.open(targetPath, menuNm);
}

function fn_goPage(menuId, menuNm, targetUrl) {
	var menuId = 'MENU_'+menuId;
	var tabId = "TAB_" + menuId;
	var iframeId = "IFRAME_" + menuId;
	var contentId = "CONTENT_" + menuId;

	var iframe = "";
	var tabUrl;
	if (targetUrl.indexOf("?") > -1) {
		tabUrl = targetUrl+"&menuId="+menuId+"&menuNm="+encodeURI(encodeURIComponent(menuNm));
	} else {
		tabUrl = targetUrl+"?menuId="+menuId+"&menuNm="+encodeURI(encodeURIComponent(menuNm));
	}

	var tabHeight = "100%";

	if ($('#'+menuId).length > 0) {
		$("#tabs li").removeClass("current");
	    $("#content p").hide();

	    $("#"+menuId).show();
	}

	$("#" + contentId).remove();
	$("#Workspace_MENU_MAIN").remove();

	if ($('#tabs li').length < 10) {
		$("#tabs li").removeClass("is-open"); //탭 모두 선택해제
		$("#content p").hide();				  //열려있는 iframe 모두숨김

		iframe = "<iframe id='"+iframeId+"' name='"+iframeId+"' class='wsp' src='"+tabUrl+"' frameborder='0' width='100%' height='"+tabHeight+"' style='overflow:auto; margin:0px; padding:0px;'></iframe>";
		//$("#content").html("");
		$("#content").append("<p class='tab_content' id='"+contentId+"' name='"+contentId+"' style='width:100%;'>" + iframe + "</p>");

		$("#" + contentId).show();

		if ($("#" + tabId).length == 0) {
			$("#tabs>ul").append("<li class='current is-open' data-id='"+tabId+"'><button class='tab' id='"+tabId+"' name='"+tabId+"' href='#'>" + menuNm + "</button><span href='#' class='remove'><img src='../../new/resource/image/common/icon/icon-close-s.png'></span></li>");
		    $("#tabs").tabs( "refresh" );
		} else {
			$("#" + contentId).show();
			$("#" + tabId).parent().addClass("is-open");
		}
	} else {
		alert("10개 이상의 창을 열수 없습니다.\n열린창을 닫고 다시 시도해 주세요.");
	}
	fn_absolutXY();
}

/*function fn_hideMenu(bOpen) {
	
	var obj = $(".lnb__cont");
	var body_w = document.body.clientWidth;
	var cont_area_w = 0;
	var tabs_w = body_w - 192;

	if (bOpen == undefined) {
		if (obj.css("display") != "none") { //메뉴숨김
			bOpen = false;
		} else { //메뉴펼침
			bOpen = true;
		}
	}

	if ($("#tabs").css("display") == "none" && bOpen) {
		return;
	}

	if (bOpen) { //메뉴펼침
		obj.show();

		cont_area_w = body_w - 192 - 17;
		$("#cont_area").css("width", cont_area_w);
		tabs_w = body_w - 192;
		$("#tabs").css("width", tabs_w);
		$("#leftMenuImg").attr("src", "/images/left/ico_mhide.png");
	} else { //메뉴숨김
		obj.hide();

		cont_area_w = body_w - 17;
		$("#cont_area").css("width", cont_area_w);
		tabs_w = body_w;
		$("#tabs").css("width", tabs_w);
		$("#leftMenuImg").attr("src", "/images/left/ico_mshow.png");
	}
}*/

function fn_openUserInfo() {
    alert("사용자가 직접 개인정보 수정하는 팝업 페이지 호출");
}

function fn_logout() {
	if (confirm("로그아웃 하시겠습니까?")) {
		location.href = "/actionLogout.do";
	}
}

function fn_Site() {
	var cls = $("#ul_site").attr("class");
	if(cls == "display_none") {
		$("#ul_site").removeClass("display_none");
	} else {
		$("#ul_site").addClass("display_none");
	}
}