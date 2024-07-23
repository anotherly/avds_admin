<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자율주행 데이터 공유센터</title>

<%@ include file="/include/header.jsp" %>

    <link rel="stylesheet" href="<c:url value='new/resource/css/ux-admin.css' />" type="text/css"/>
    <link rel="stylesheet" href="<c:url value='new/resource/css/main.css' />" type="text/css"/>
    
    <script type="text/javascript" src="new/resource/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="new/resource/js/lib/simplebar.js"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery-ui-1.12.1.custom/jquery-ui.js' />"></script>
    <script type="text/javascript" src="new/resource/js/main.js"></script>
    <script type="text/javascript">
    	function fn_logOut(){
			if (confirm("로그아웃 하시겠습니까?")) {
				location.href = "/actionLogout.do";
			}
    	}
    </script>

</head>
<body>

	<!-- wrap -->
	<div class="wrap">
        <header class="header">
            <div class="header__inner">
                <article class="lnb">
                    <button type="button" class="lnb__btn" title="lnb 메뉴 열림">
                        <span class="lnb__line lnb__line--lineTop"></span>
                        <span class="lnb__line lnb__line--lineMid"></span>
                        <span class="lnb__line lnb__line--lineBot"></span>
                    </button>
                </article>
                <div class="header__logo">
                    <h1 class="logo__h1">
                        <a href="" class="logo__link">자율주행 데이터 공유센터</a>
                    </h1>
                </div>
                <article class="gnb">
                    <ul class="gnb__list">
                        <!-- <li class="gnb__item">
                            <a href="">메인화면</a>
                        </li>
                        <li class="gnb__item">
                            <a href="">주행자료</a>
                        </li>
                        <li class="gnb__item">
                            <a href="">통계정보</a>
                        </li>
                        <li class="gnb__item">
                            <a href="">시스템관리</a>
                        </li> -->
                    </ul>
                </article>
                <article class="header__login">
                    <div class="login login--user">
                        <p class="login__name">
                          	  관리자<span>님</span>
                        </p>
                        <p class="login__name">
                			<a href="javascript:fn_logout();">로그아웃</a>
                		</p>
<!--                         <button type="button" class="btn login__btn" title="로그인"> -->
<!--                             <img src="new/resource/image/common/icon/icon-locker.png" alt="" onclick="fn_logOut();"> -->
<!--                         </button> -->
                    </div>
                </article>

<!--                 <article class="familySite"> -->
<!--                     <button type="button" class="familySite__btn" title="관련 사이트"> -->
<!--                         관련 사이트 -->
<!--                         <img src="new/resource/image/common/icon/icon-clamp--down.png" alt=""> -->
<!--                     </button> -->
<!--                     <div class="familySite__list"> -->
<!--                         <a href="" class="familySite__item">1</a> -->
<!--                         <a href="" class="familySite__item">2</a> -->
<!--                         <a href="" class="familySite__item">3</a> -->
<!--                     </div> -->
<!--                 </article> -->
            </div>
        </header>
			<section class="container">
	            <div class="container__inner">
	                <div class="content">
	                    <div class="lnb-wrap">
	                        <div class="lnb__cont">
	                            <h3 class="lnb__cont__tit el-tit-3 el-weight-5">시스템관리</h3>
	                            <ul class="lnb__list">
	                                <li class="lnb__item">
	                                    <a href="javascript:void(0)">기본정보</a>
	                                    <ul class="ui-listUl ui-listUl--bar">
	                                        <li>
	                                            <a href="">test</a>
	                                        </li>
	                                        <li>
	                                            <a href="">test</a>
	                                        </li>
	                                    </ul>
	                                </li>
	                                <li class="lnb__item">
	                                    <a href="javascript:void(0)">웹사이트 관리</a>
	                                    <ul class="ui-listUl ui-listUl--bar">
	                                        <li>
	                                            <a href="">시스템로그 관리</a>
	                                        </li>
	                                        <li>
	                                            <a href="">작업로그 관리</a>
	                                        </li>
	                                        <li>
	                                            <a href="">접속로그 관리</a>
	                                        </li>
	                                        <li>
	                                            <a href="">공지사항</a>
	                                        </li>
	                                        <li>
	                                            <a href="">자율주행 공지사항</a>
	                                        </li>
	                                        <li>
	                                            <a href="">요청승인</a>
	                                        </li>
	                                        <li>
	                                            <a href="">협의체 등급관리</a>
	                                        </li>
	                                        <li>
	                                            <a href="">권한관리</a>
	                                        </li>
	                                        <li>
	                                            <a href="">메뉴관리</a>
	                                        </li>
	                                        <li>
	                                            <a href="">역할관리</a>
	                                        </li>
	                                        <li>
	                                            <a href="">OpenApi관리</a>
	                                        </li>
	                                    </ul>
	                                </li>
	                            </ul>
	                        </div>
	                        <a href="" class="lnb__logo">
	                            <img src="new/resource/image/common/img/img-logo--foot.png" alt="TS 한국교통안전공단">
	                        </a>
	                    </div>
	                    <div class="content__inner" style="">
	                        <div class="lay-box-wrap grids" id="content">
	                            <!-- <div class="lay-boxItem lay-boxItem--index lay-item--300 grids__col-2 bgc--lightNavy">
	                                <div class="boxItem__inner boxItem-index">
	                                    <span class="boxItem__img">
	                                        <img src="new/resource/image/main/img-boxItem--index01.png" alt="">
	                                        <em class="boxItem__caption">임시운행</em>
	                                    </span>
	                                    <p class="boxItem__txt">
	                                        <span>허가대수</span>
	                                        <strong>
	                                            1,032
	                                            <em>대</em>
	                                        </strong>
	
	                                    </p>
	                                </div>
	                            </div> -->
	                            <!-- <div class="lay-boxItem lay-boxItem--index lay-item--784 grids__col-6 bgc--greenBlue">
	                                <div class="boxItem__inner boxItem-index">
	                                    <span class="boxItem__img">
	                                        <img src="new/resource/image/main/img-boxItem--index02.png" alt="">
	                                        <em class="boxItem__caption">거리</em>
	                                    </span>
	                                    <p class="boxItem__txt">
	                                        <span>총 주행</span>
	                                        <strong>
	                                            1,548,711
	                                            <em>KM</em>
	                                        </strong>
	
	                                    </p>
	                                    <p class="boxItem__txt">
	                                        <span>자율모드 주행</span>
	                                        <strong>
	                                            1,561,742
	                                            <em>KM</em>
	                                        </strong>
	
	                                    </p>
	                                    <p class="boxItem__txt">
	                                        <span>일반모드 주행</span>
	                                        <strong>
	                                            1,001,702
	                                            <em>KM</em>
	                                        </strong>
	
	                                    </p>
	                                </div>
	                            </div> -->
	                            <!-- <div class="lay-boxItem lay-boxItem--index lay-item--456 grids__col-4 bgc--steelBlue">
	                                <div class="boxItem__inner boxItem-index">
	                                    <span class="boxItem__img">
	                                        <img src="new/resource/image/main/img-boxItem--index03.png" alt="">
	                                        <em class="boxItem__caption">데이터</em>
	                                    </span>
	                                    <p class="boxItem__txt">
	                                        <span>건수</span>
	                                        <strong>
	                                            1777
	                                            <em>건</em>
	                                        </strong>
	
	                                    </p>
	                                    <p class="boxItem__txt">
	                                        <span>용량</span>
	                                        <strong>
	                                            1,247.2
	                                            <em>GB</em>
	                                        </strong>
	
	                                    </p>
	                                </div>
	                            </div> -->
	                            <%-- <div class="lay-boxItem lay-item--775 grids__col-6">
	                                <div class="boxItem__inner">
	                                    <h5 class="boxItem__tit">
	                                        데이터 사용 현황
	                                        <button type="button" class="boxItem__reset">
	                                            <img src="new/resource/image/common/icon/icon-reset.png" alt="">
	                                        </button>
	                                    </h5>
	                                    <div class="lay-table-wrap">
	                                        <div class="lay-table__inner">
	                                            <div class="el-table-wrap">
	                                                <table
	                                                    class="el-table el-table--col el-table--dataUse el-table--dataList mt-10">
	                                                    <caption>데이터 사용 현황 테이블 지난주,이번주</caption>
	                                                <colgroup>
	                                                    <col style="width:25%" />
	                                                    <col style="width:25%" />
	                                                    <col style="width:25%" />
	                                                    <col style="width:25%" />
	                                                </colgroup>
	                                                <thead>
	                                                    <tr>
	                                                        <th scope="col" colspan="2">지난 주</th>
	                                                        <th scope="col" colspan="2">이번 주</th>
	                                                    </tr>
	                                                    <tr>
	                                                        <th scope="col">다운로드</th>
	                                                        <th scope="col">업로드</th>
	                                                        <th scope="col">다운로드</th>
	                                                        <th scope="col">업로드</th>
	                                                    </tr>
	                                                </thead>
	                                                <tbody>
	                                                    <tr>
	                                                        <td>1</td>
	                                                        <td>0</td>
	                                                        <td>0</td>
	                                                        <td>0</td>
	                                                    </tr>
	                                                </tbody>
	                                            </table>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="lay-table-wrap mt-10">
	                                    <div class="lay-table__inner">
	                                        <div class="el-table-wrap lay-tableH--300 ui-scroller ui-table-fixHead"
	                                            data-simplebar-auto-hide="false">
	                                            <table
	                                                class="el-table el-table--col el-table--dataUse el-table--dataDetail">
	                                                <caption>데이터 사용 현황 테이블 순번, 사용자ID, 업로드 건수</caption>
	                                                <colgroup>
	                                                    <col style="width:25%" />
	                                                    <col style="width:auto" />
	                                                    <col style="width:25%" />
	                                                </colgroup>
	                                                <thead>
	                                                    <tr>
	                                                        <th scope="col">순번</th>
	                                                        <th scope="col">사용자 ID</th>
	                                                        <th scope="col">업로드 건수</th>
	                                                    </tr>
	                                                </thead>
	                                                <tbody>
	                                                    <tr>
	                                                        <td>1</td>
	                                                        <td>spring0506</td>
	                                                        <td>1</td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td>1</td>
	                                                        <td>spring0506</td>
	                                                        <td>1</td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td>1</td>
	                                                        <td>spring0506</td>
	                                                        <td>1</td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td>1</td>
	                                                        <td>spring0506</td>
	                                                        <td>1</td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td>1</td>
	                                                        <td>spring0506</td>
	                                                        <td>1</td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td>1</td>
	                                                        <td>spring0506</td>
	                                                        <td>1</td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td>1</td>
	                                                        <td>spring0506</td>
	                                                        <td>1</td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td>1</td>
	                                                        <td>spring0506</td>
	                                                        <td>1</td>
	                                                    </tr>
	
	                                                </tbody>
	                                            </table>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div> --%>
	                        <%-- <div class="lay-boxItem lay-item--775 grids__col-6">
	                            <div class="boxItem__inner">
	                                <h5 class="boxItem__tit">
	                                    사고발생
	                                    <button type="button" class="boxItem__reset">
	                                        <img src="new/resource/image/common/icon/icon-reset.png" alt="">
	                                    </button>
	                                </h5>
	                                <div class="lay-table-wrap">
	                                    <div class="lay-table__inner">
	                                        <div class="el-table-wrap">
	                                            <table
	                                                class="el-table el-table--col el-table--accident el-table--acciList mt-10">
	                                                <caption>데이터 사용 현황 테이블</caption>
	                                                <colgroup>
	                                                    <col style="width:25%" />
	                                                    <col style="width:25%" />
	                                                    <col style="width:25%" />
	                                                    <col style="width:25%" />
	                                                </colgroup>
	                                                <thead>
	                                                    <tr>
	                                                        <th scope="col" colspan="2">지난 주</th>
	                                                        <th scope="col" colspan="2">이번 주</th>
	                                                    </tr>
	                                                    <tr>
	                                                        <th scope="col">자율모드</th>
	                                                        <th scope="col">일반모드</th>
	                                                        <th scope="col">자율모드</th>
	                                                        <th scope="col">일반모드</th>
	                                                    </tr>
	                                                </thead>
	                                                <tbody>
	                                                    <tr>
	                                                        <td>0</td>
	                                                        <td>0</td>
	                                                        <td>0</td>
	                                                        <td>0</td>
	                                                    </tr>
	                                                </tbody>
	                                            </table>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="lay-table-wrap mt-10">
	                                    <div class="lay-table__inner">
	                                        <div class="el-table-wrap  lay-tableH--300 ui-scroller ui-table-fixHead">
	                                            <table
	                                                class="el-table el-table--col el-table--accident el-table--acciDetail el-table-noData">
	                                                <caption>데이터 사용 현황 테이블 순번, 사용자ID, 업로드 건수</caption>
	                                                <colgroup>
	                                                    <col style="width:25%" />
	                                                    <col style="width:auto" />
	                                                    <col style="width:25%" />
	                                                </colgroup>
	                                                <thead>
	                                                    <tr>
	                                                        <th scope="col">순번</th>
	                                                        <th scope="col">기관</th>
	                                                        <th scope="col">사용발생 건수</th>
	                                                    </tr>
	                                                </thead>
	                                                <tbody>
	                                                    <tr>
	                                                        <td colspan="3" rowspan="3">검색결과가 없습니다.</td>
	                                                    </tr>
	                                                </tbody>
	                                            </table>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div> --%>
	                        <!-- <div class="lay-boxItem lay-item--775 grids__col-6">
	                            <div class="boxItem__inner">
	                                <h5 class="boxItem__tit">
	                                    통계 현황
	                                    <button type="button" class="boxItem__reset">
	                                        <img src="new/resource/image/common/icon/icon-reset.png" alt="">
	                                    </button>
	                                </h5>
	                                <div class="lay-box-wrap">
	                                    <div class="lay-box__inner">
	                                        <div id="chart"></div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div> -->
	                        <!-- <div class="lay-boxItem lay-item--775 grids__col-6">
	                            <div class="boxItem__inner">
	                                <h5 class="boxItem__tit">
	                                    데이터베이스 사용 현황
	                                    <button type="button" class="boxItem__reset">
	                                        <img src="new/resource/image/common/icon/icon-reset.png" alt="">
	                                    </button>
	                                </h5>
	                            </div>
	                        </div> -->
	                    </div>
	                    <div class="el-tab-wrap">
                            <div class="el-tab__inner">
                                <div class="el-tab__link" id="tabs">
                                    <ul>
                                        <li class="is-open" data-id="tab-link--1">
                                            <button type="button">
                                                권한관리
                                            </button>
                                            <span>
                                                <img src="../../resource/image/common/icon/icon-close-s.png" alt="">
                                            </span>
                                        </li>
                                        <li data-id="tab-link--2">
                                            <button type="button" class="">
                                                요청승인
                                            </button>
                                            <span>
                                                <img src="../../resource/image/common/icon/icon-close-s.png" alt="">
                                            </span>
                                        </li>
                                        <li data-id="tab-link--3">
                                            <button type="button" class="">
                                                메뉴관리
                                            </button>
                                            <span>
                                                <img src="../../resource/image/common/icon/icon-close-s.png" alt="">
                                            </span>
                                        </li>
                                    </ul>
                                    
                                </div>
                            </div>
                        </div>
	                </div>
	            </div>
	        </div>
	    </section>
		<!-- //cont_area -->
		<footer></footer>
	</div>
	<!-- //wrap -->
</body>
</html>
