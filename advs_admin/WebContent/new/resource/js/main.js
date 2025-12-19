'use strict';


$(function(){
    // 좌측 LNB(Left Navigation Bar) 메뉴 초기화
    lnbMenu();
    // 패밀리 사이트(하단/상단 드롭다운) 토글 초기화
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


	var tabs = $("#tabs").tabs();

	// 탭 클릭
	$(document).on('click','#tabs button.tab', function() {
		var contentId = $(this).attr("id").replace('TAB_', 'CONTENT_');

		$("#content p").hide();
		$("#tabs li").removeClass("is-open");

		$("#" + contentId).show();
		$(this).parent().addClass("is-open");
	});

	// 탭 REMOVE 클릭
    $(document).on('click','#tabs span.remove', function() {
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
    
    /**
     * 현재 열린 탭(is-open)을 제외하고
     * MENU_MAIN 탭을 제외한 모든 탭 제거
     */
    $(document).on('click', '#tabRemvAll', function () {

        var $openTab = $('#tabs li.is-open');

        $('#tabs li').each(function () {

            var $li = $(this);
            var tabId = $li.find('button.tab').attr('id');

            if (!tabId) return;

            // 🔒 MENU_MAIN 제외
            if (tabId === 'TAB_MENU_MAIN') return;

            // 현재 열린 탭 제외
            if ($li.is($openTab)) return;

            var contentId = tabId.replace('TAB_', 'CONTENT_');

            $('#' + contentId).remove();
            $li.remove();
        });

        // 버튼 상태 재정리
        fn_updateTabRemoveAllBtn();

        fn_absolutXY();
    });

    
    // 화면 크기에 맞게 레이아웃 재계산
	fn_absolutXY();
	 // 메인 화면 진입
	fn_goMain(null, "0", null);
});

/**
 * simplebar 플러그인 초기화 함수
 * - IE 구버전은 기본 overflow 사용
 * - 그 외 브라우저는 SimpleBar 적용
 */
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
/**
 * 좌측 네비게이션(LNB) 메뉴 동작 제어
 * - 햄버거 버튼 열고 닫기
 * - 마우스 hover 시 메뉴 강조
 * - 1depth 클릭 시 2depth 슬라이드
 */
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
/**
 * 좌측 메뉴 전체 열림 / 닫힘 제어
 * @param param true = 열기, false = 닫기
 */
function lnbMenuOpenToggle(param) {
        if (param) {
            $('.content').addClass('lnb-open');
            $('.lnb__cont').addClass('is-show');
        } else {
            $('.content').removeClass('lnb-open');
            $('.lnb__cont').removeClass('is-show')
        }
	
	}
/**
 * 패밀리 사이트 버튼 클릭 시
 * 하위 목록 슬라이드 토글 (미사용 jsp에서 해당요소 주석처리됨)
 */
function famSite() {
    $('.familySite__btn').click(function () {
        $(this).next().slideToggle(200, 'swing');
        $(this).toggleClass('is-clicked');
    })
}
/**
 * 커스텀 셀렉트 박스 동작 정의
 * - 버튼 클릭 시 옵션 목록 표시
 * - 옵션 선택 시 값 반영
 */
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
/**
 * el-tab 형태의 탭 UI 처리
 * - 탭 클릭 시 콘텐츠 전환
 * - 닫기 버튼 클릭 시 탭 + 콘텐츠 제거
 */
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
/**
 * 공통 UI 초기화 함수
 * - 커스텀 셀렉트
 * - 탭 UI
 */
$.fn.fnInit = function () {
    $('.custom-sel').setFormFn();
    $('.el-tab-wrap').tabFn();
};
/**
 * 브라우저 리사이즈 시
 * 레이아웃 재계산
 */
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

/**
 * 화면 크기에 따라
 * - 콘텐츠 영역
 * - 탭 영역
 * - 컨테이너 높이
 * 를 동적으로 재계산
 */
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

/**
 * 메인 페이지 iframe 로딩
 * (/openInit.do)
 */
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
		console.log("10개미만");
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
	} else {//10개 초과 시 
		console.log("10개 초과");
		alert("10개 이상의 창을 열수 없습니다.\n열린창을 닫고 다시 시도해 주세요.");
	}
	
	fn_updateTabRemoveAllBtn();
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

/**
 * 하단 탭 우측 "일괄닫기" 버튼 생성 및 표시 제어
 * - 중복 생성 방지
 * - 탭 개수 1개 이하면 숨김
 */
function fn_updateTabRemoveAllBtn() {

    var $tabs = $('#tabs');
    var $tabsUl = $('#tabs > ul');

    // tabs 또는 ul 없으면 처리 안 함
    if ($tabs.length === 0 || $tabsUl.length === 0) return;

    // 버튼이 없으면 생성
    if ($('#tabRemvAll').length === 0) {
        var btnHtml = `
            <div class="tabs-util">
                <button type="button" id="tabRemvAll" class="btn-tab-util">
                    일괄닫기
                </button>
            </div>
        `;
        $tabs.append(btnHtml);
    }

    // 실제 탭 개수 (MENU_MAIN 포함)
    var tabCount = $tabsUl.find('li').length;

    // 탭이 1개 이하면 버튼 숨김
    if (tabCount <= 1) {
        $('.tabs-util').hide();
    } else {
        $('.tabs-util').show();
    }
}


