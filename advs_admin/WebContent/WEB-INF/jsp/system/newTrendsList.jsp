<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Program</title>
<link rel="stylesheet" href="<c:url value='/css/layout.css' />" type="text/css">
<%@ include file="/include/header.jsp" %>
<script type="text/javascript" src="/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>

</head>
<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap p-20 h-100">
	<div class="float_left w100p v posi_r">
		<div class="cont_tit2 el-box-tit el-depth-2 el-weight-5">◎ <%=java.net.URLDecoder.decode(menuNm, "UTF-8")%></div>

<!-- 		<div class="contBtn1"> -->
<!-- 			<a href="javascript:fn_initClear()"  class="btn_refresh" title="초기화"></a> -->
<!-- 			<i></i> -->
<!-- 			<a href="javascript:fn_new()" class="btn_new" title="신규"></a> -->
<!-- 			<i></i> -->
<!-- 			<a href="javascript:fn_save()" class="btn_save" title="저장"></a> -->
<!-- 			<i></i> -->
<!-- 			<a href="javascript:fn_delete()" class="btn_del" title="삭제"></a> -->
<!-- 			<i></i> -->
<!-- 			<a href="javascript:fn_search()" class="btn_search" title="조회"></a> -->
<!-- 		</div> -->
	</div>

	<div class="box_search lay-boxItem lay-item--full grids__col-12 mt-10 form-wrap ml-0">
		<form id="searchForm" name="searchForm" method="post">
			<div class="d-flex align-center posi_r">
				<fieldset class="d-flex align-center">
						<span class="tit el-txt fw-500">제목검색</span>
						<div class="el-form custom-input ml-10">
							<input type="text" class="el-form__input el-form-width--200" id="sKeyword" name="sKeyword" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}"/>
						</div>
			    </fieldset>
			    <div class="contBtn2">
					<button type="button" onclick="fn_new()" class="btn" title="신규">신규</button>
					<button type="button" onclick="fn_save()" class="btn" title="저장">저장</button>
					<button type="button" onclick="fn_delete()" class="btn" title="삭제">삭제</button>
					<button type="button" onclick="fn_search()" class="btn btn-b" title="조회">조회</button>
				</div>
			</div>
		</form>
	</div>
	<div class="lay-boxItem lay-item--full grids__col-12 m-0" style="overflow: auto;height:calc(100% - 90px);">
		<div class="boxItem__inner h-100">
			<div class="d-flex flex-7 h-100 flex-wrap">
				<div id="grid" class="float_left ov-auto-y ov-hidden-x" style="width:50%; height: 100%; border: 1px solid #e8eef1;  border-radius: 3px; background: #fff; padding: 10px;">
					<table id="gridList" class="word_b"></table>
				</div>
			
				<div id="form" style="overflow:auto;width: calc(50% - 10px); height: 100%; float: left; border: 1px solid #e8eef1; border-radius: 3px; background: #fff; padding: 10px; margin-left: 10px;">
					<form id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
						<input type="text" style="display: none;" id="userId" name="userId" value="${userVo.userId}"/>
						<input type="text" style="display: none;" id="saveMode" name="saveMode" value="I"/>
						<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>
			
						<div class="el-table-wrap">
							<table class="el-table  el-table--row el-table--autodriving" >
								<caption></caption>
								<colgroup>
									<col width="20%" />
									<col width="*%" />
								</colgroup>
								<tbody>
									<tr>
										<th>게시물번호</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="boardSeq" name="boardSeq" value="" caption="게시물번호" required="required"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>제목</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--full" id="boardTitle" name="boardTitle" value="" caption="제목" required="required"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>템플릿 선택</th>
										<td>
											<label><input type="radio" name="rdTempl" value="template1" /> 템플릿1</label>
											<label><input type="radio" name="rdTempl" value="template2" /> 템플릿2</label>
											<label><input type="radio" name="rdTempl" value="template3" /> 템플릿3</label>
											<label><input type="radio" name="rdTempl" value="template4" /> 템플릿4</label>
											<label><input type="radio" name="rdTempl" value="" /> 초기화</label>
										</td>
									</tr>
									<tr>
										<th>최신동향</th>
										<td class="write_editor">
											<textarea style="width:100%; height:342px;background-color:#fff; display:none; resize: none;" id="boardContents" name="boardContents" value="" caption="내용"></textarea>
										</td>
									</tr>
									<tr>
										<th>첨부파일</th>
										<td>
											<div class="d-flex align-center">
												<input type="file" name="file_info" id="file_info" onchange="javascript:fileMapper();" style="display: none;">
												<div class="el-form custom-input">
													<input type="text" class="el-form__input el-form-width--200" name="attachFileNm" id="attachFileNm" readonly placeholder="선택된 파일 없음">
												</div>
												<label for="file_info" style="height:34px;padding:0 10px;margin-left:5px;margin-right:20px;background-color:#555;color:#fff;line-height:34px;">파일선택</label>
												첨부파일크기
												<input type="text" style="width: 80px; height: 19px;" id="attachFileSize" name="attachFileSize" value="" caption="첨부파일크기" readonly />
												&nbsp;byte
											</div>
										</td>
									</tr>
									<tr>
										<th>공개여부</th>
										<td>
											<div class="el-form custom-sel">
												<select class="el-form__sel"id="gpbcYn" name="gpbcYn" caption="공개여부" required="required"></select>
											</div>
										</td>
									</tr>
									<tr>
										<th>중요도</th>
										<td>
											<div class="el-form custom-sel">
												<select class="el-form__sel"id="rtngCd" name="rtngCd" caption="중요도" required="required"></select>
											</div>
										</td>
									</tr>
									<tr>
										<th>등록자</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="regId" name="regId" value="" disabled="disabled"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>등록일시</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="regDate" name="regDate" value="" disabled="disabled"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>수정자</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="updateId" name="updateId" value="" disabled="disabled"/>
											</div>
										</td>
									</tr>
									<tr>
										<th>수정일시</th>
										<td>
											<div class="el-form custom-input">
												<input type="text" class="el-form__input el-form-width--200" id="updateDate" name="updateDate" value="" disabled="disabled"/>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>





<!-- 20200221 템플릿 추가 -->
<div id="template1" style="display:none;">
<table  style="margin: 0 auto; font-family:'돋움', dotum, Arial,Trebuchet MS, Helvetica, sans-serif;border:1px solid #bdbdbd;border-collapse:collapse">
	<tbody style="font-family: '나눔 고딕'">
		<!-- header -->
		<tr>
				<td colspan="2" style="padding:0">
							<table style="width:100%;background:url(/images/newsletter/main1.jpg) no-repeat 0 0;background-size:cover;border-collapse:collapse;">
								<tbody>
									<tr>
										<td style="width:685px;padding:0">
												<a href="#" target="_blank" style="display:inline-block;padding:23px 0 33px 28px;box-sizing:border-box;">
													<img src="/images/newsletter/logo.png" alt="한국교통안전공단 자동차안전연구원" />
												</a>
										</td>
										<td style="width:95px;height: 95px;padding:27px 0;background-color: #0d46a0;text-align: center;color: #fff;">
												<span style="display:block;font-size:14px;line-height:100%;">2020.</span>
												<span style="display:block;margin-top:5px;font-size: 22px; font-weight:500;line-height:100%;">01.01.</span>
										</td>
									</tr>
									<tr>
											<td colspan="2" style="width:100%;height:165px;padding:0"></td>
									</tr>
									<tr>
											<td colspan="2" style="width:100%;padding:20px 30px 28px 30px;background-color: rgba(0,0,0,0.3);text-align:right">
														<img src="/images/newsletter/sub_logo2.png" alt=""; style="display:inline-block;vertical-align:middle;width:63px;">
														<span style="display:inline-block;vertical-align:middle;margin-left:5px;margin-top:8px;font-weight:600;font-size:23px;color:#fff;line-height:40px;text-shadow:4px 3px 5px #000">자율주행차 융 · 복합 미래포럼</span>
											</td>
									</tr>
								</tbody>
							</table>
				</td>
		</tr>
		<!-- //header -->
		<!-- content1 -->
		<tr style="background-color:#fafbfc;">
			<td style="padding:0;vertical-align: top;width:50%;padding:30px 20px 30px 40px;box-sizing:border-box;">
							<span style="display:block;font-size:21px;font-weight: 600;margin-bottom: 20px;line-height:100%;letter-spacing:-0.1em;" >국내동향</span>
							<table style="width:100%;">
								<tbody>
									<tr>
										<td style="width:130px">
											<img src="/images/newsletter/internal_trend1.jpg" alt="국내동향 이미지" style="box-shadow:1px 3px 12px 3px #aaaaaaa3">
										</td>
										<td style="width:auto;padding-left:20px;vertical-align:top;">
											<a  href="javascript:void(0)" target="_self" style="display:block;text-decoration: none; color: #000;letter-spacing: -0.1em;font-weight:bold;font-size:18px">자율주행차에서 자율주행기반 교통서비스로</a>
											<a  href="javascript:void(0)" target="_self" style="display:block;margin-top:13px;cursor: pointer; letter-spacing: -0.5px;text-decoration: none; color: #000;font-size:16px;">인공지능, 5G, 사물인터넷 등 4차 산업혁명의 핵심기술이 집약된 자율주행차...</a>
										</td>
									</tr>
								</tbody>
							</table>
			</td>
			<td style="vertical-align: top;width:50%;padding:30px 40px 30px 20px;box-sizing:border-box;">
						<div style="font-size:21px;font-weight: 600;margin-bottom: 20px;line-height:100%;letter-spacing:-0.1em;" >국외동향</div>
						<table style="width:100%;">
							<tbody>
								<tr>
									<td style="width:130px">
										<img src="/images/newsletter/overseas_trend1.jpg" alt="국내동향 이미지" style="box-shadow:1px 3px 12px 3px #aaaaaaa3">
									</td>
									<td style="width:auto;padding-left:20px;vertical-align:top;">
										<a  href="javascript:void(0)" target="_self" style="display:block;text-decoration: none; color: #000;letter-spacing: -0.1em;font-weight:bold;font-size:18px">Waymo, 자율주행차 데이터 공개</a>
										<a  href="javascript:void(0)" target="_self" style="display:block;margin-top:13px;cursor: pointer; letter-spacing: -0.5px;text-decoration: none; color: #000;font-size:16px;">Google의 자율주행차 개발업체인 Waymo가 자율주행자동차 데이터를...</a>
									</td>
								</tr>
							</tbody>
						</table>
			</td>
		</tr>
		<!-- //content1 -->
		<!-- content2 -->
		<tr>
			<td colspan="2">
				<table cellspacing="0" cellpadding="0" style="margin:0 auto">
					<tbody>
						<tr style="text-align: center;">
							<td style="padding:35px 40px 20px;border-top:1px solid #dcdfe6">
										<span style="display:block;font-size: 22px;font-weight: 600;margin-bottom: 20px; letter-spacing: -1px;text-align:left;"> News &amp; 이슈리포트</span>
										<img src="/images/newsletter/news1.jpg" alt="" style="display:block;">
										<div style="font-size: 21px; font-weight: 600; margin-top: 20px; margin-bottom:15px;letter-spacing: -1px; cursor: pointer;text-align:left;" >
											<a  href="javascript:void(0)" target="_self" style="text-decoration: none; color: #000;"> 2019년 하반기 신입직원 임명장수료식 </a>
										</div>
										<a  href="javascript:void(0)" target="_self" style="display:inline-block;text-decoration: none; color: #000;font-size:16px;line-height:1.5em;margin-bottom: 10px; letter-spacing: -1px; text-overflow: ellipsis;word-wrap: break-word; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; cursor: pointer;text-align:left;">한국교통안전공단에서는 2019년 하반기 신입직원들의 임명장 수여식이 있었습니다. 이번에 공단 가족이된 신입직원은 총 28명인데요! 기존 채용인원은 16명이었으나, 공단은 연차수당 절감분을 활용하여... </a>
										<span style="display:block;margin-bottom:20px;color: #888888;font-size:14px; letter-spacing: -0.5px;text-align:left;">2019.10.05</span>
										<table style="width:100%">
											<tbody>
												<tr>
													<td style="border-top: 1px solid #dddddd;">
														<a href="javascript:void(0)" target="_self" style="display:inline-block;padding: 15px 0;text-decoration: none; color: #000; float: left;font-size:17px;text-align:left;vertical-align:top">· 사망 사고 낸 우버 자율주행차...'보행자 못 알아봤다'</a>
														<span style="float: right; color: #848484;font-size:14px;padding: 17px 0;vertical-align:top">2019.10.05</span>
													</td>
												</tr>
												<tr>
													<td style="border-top: 1px solid #dddddd;">
														<a href="javascript:void(0)" target="_self" style="display:block;padding: 15px 0;text-decoration: none; color: #000; float: left;font-size:17px;">· NTSB, 우버 자율주행차 사망 사고 우버 책임</a>
														<span style="float: right; color: #848484;font-size:14px;padding: 17px 0;">2019.10.05</span>
													</td>
												</tr>
												<tr>
													<td style="border-top: 1px solid #dddddd;">
														<a href="javascript:void(0)" target="_self" style="display:block;padding: 15px 0;text-decoration: none; color: #000; float: left;font-size:17px;">· [테슬라]자율주행 실적 30억km돌파...GM,웨이모 등 경쟁업체 압도</a>
														<span style="float: right; color: #848484;font-size:14px;padding: 17px 0;">2019.10.05</span>
													</td>
												</tr>
											</tbody>
										</table>
							</td>
						</tr><!-- / News & 이슈리포트 -->
					</tbody>
				</table>
			</td>
		</tr>
		<!-- //content2 -->
		<!-- content3 -->
		<tr style="height:188px;background-color:#edf4fa;font-size:0;border-bottom:1px solid #dcdfe6">
			<td colspan="2" style="padding:33px 40px 10px;vertical-align:top;">
					<span style="display:inline-block;width:88px;margin-right:25px;vertical-align:top;font-size:21px; font-weight: 600;" >공지사항</span>

					<table style="width:100%">
						<tbody>
							<tr>
								<td style="border-top: 1px solid #dddddd;">
									<a href="javascript:void(0)" target="_self" style="float: left;font-size:17px;text-decoration:none;color:#3d3d3d;">· (폭스바겐)자율주행 자회사 설립</a>
									<span style="float:right;padding-bottom:15px;font-size:14px;color: #848484">2019.10.05</span>
								</td>
							</tr>
							<tr>
								<td style="border-top: 1px solid #dddddd;">
									<a href="javascript:void(0)" target="_self" style="float: left;padding:15px 0;font-size:17px;text-decoration:none;color:#3d3d3d;">· 사망 사고 낸 자율주행차...'보행자 못 알아봤다'</a>
								<span style="float:right;padding:15px 0;font-size:14px;color: #848484">2019.10.05</span>
								</td>
							</tr>
							<tr>
								<td style="border-top: 1px solid #dddddd;">
									<a href="javascript:void(0)" target="_self" style="float: left;padding:15px 0 0 0;font-size:17px;text-decoration:none;color:#3d3d3d;">· NTSB, 우버 자율주행차 사망 사고 우버 책임</a>
								<span style="float:right;padding:15px 0;font-size:14px;color: #848484">2019.10.05</span>
								</td>
							</tr>
						</tbody>
					</table>
			</td>
		</tr>
		<!-- //content3 -->
		<!-- content4 -->
		<tr>
			<td  colspan="2">
				<table  cellspacing="0" cellpadding="0" style="margin:0 auto;background-color: #fafbfc;">
					<tbody>
						<tr style="width: 100%; height: 330px;">
							<td style="width: 50%;padding:40px 10px 20px 40px;vertical-align:top">
									<span style="display:block;margin-bottom:15px;font-size:20px; font-weight: 600; " >회의 일정 공지
										<button style="width: 18px; height: 18px; color: red; background:url(/images/newsletter/plus_icon.png)no-repeat 0 0; border: 1px solid #bdbdbd; cursor:pointer;margin-top:5px;"></button>
									</span>
									<span style="display: block; width: 100%; height: 210px;background-color: #edf4fa; text-align: center; font-size: 16px;  border:1px solid #cfd7e2; box-sizing: border-box;" >
											<span style="display:block;background: url(/images/newsletter/date.png)no-repeat 0 0; text-align: left; margin:20px 0 0 19px; ">
													<b style="display:block;margin-left: 30px;">일시</b>
													<span style="margin:4px 0 0 30px; font-size: 16px;">2019년 10월 10일</span>
											</span>
											<span style="display:block;background: url(/images/newsletter/co.png)no-repeat 0 0;text-align: left; margin:10px 0 0 17px;">
													<b style="display:block;margin-left: 30px;">주최 / 주관</b>
													<span style="margin:4px 0 0 30px; font-size: 16px;">국토교통부, 교통안전공단</span>
											</div>
											<span style="display:block;background: url(/images/newsletter/place.png)no-repeat 0 0; text-align: left; margin:10px 0 0px;">
													<b style="display:block;margin-left: 30px;">장소</b>
													<span style="margin:4px 0 0 30px; font-size: 16px;">세종특별자치시 컨벤션센터</span>
											</span>
									</span>
							</td>
							<td style="width: 50%;padding:40px 40px 20px 10px;vertical-align:top">
									<span style="display:block;margin-bottom:15px;font-size:20px; font-weight: 600;" >회의 결과 안내</span>

									<span style="display: block; width: 100%; height: 210px; background-color: #fff; text-align: center; border:1px solid #cfd7e2;" >
											<span style="display:block;width: 44px; height: 36px; margin: 0 auto; margin-top: 28px; background: url(/images/newsletter/result.png)no-repeat 0 0;"></span>
											<span style="margin-top:20px;font-size:17px; line-height: 150%;">2019 자동차안정기준 국제조화<br/> 최종보고회 개최 결과 안내</span>
											<button style="width: 152px; height: 36px; margin-top: 20px; border:none; background-color:#edf4fa; color: #033f9c; font-weight: bold; cursor:pointer;">결과보고 바로보기&gt;</button>
									</span>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<!-- //content4 -->
		<!-- footer -->
		<tr style="background-color:#e8ebec;">
			<td  colspan="2" style="padding:20px 0;">
				<table style="font-size:13px;">
					<tr>
							<td style="padding-left: 40px;">
								<a href="javascript:void(0)" target="_self"><img src="/images/newsletter/footer_logo_01.png" alt="국토교통부"></a>
							</td>
							<td style="padding-left: 50px; line-height: 200%;padding-bottom: 5px;">
								<span style="display:block;font-weight: 600;font-size:14px">국토교통부</span>
								<span style="display:block;color:#888; font-weight: 500;font-size:14px;letter-spacing:-0.3px">(우)30103 세종특별자치시 도움6로 11 국토교통부</span>
							</td>
					</tr>
					 <tr>
							<td style="padding-left: 40px;" >
								<a href="javascript:void(0)" target="_self"><img src="/images/newsletter/footer_logo_02.png" alt="한국교통안전공단 자동차안전연구원"></a>
							</td>
							<td style="padding-left: 50px; margin-top:30px; line-height: 200%;">
								<span style="display:block;font-weight: 600;font-size:14px">한국교통안전공사 자동차안전연구원</span>
								<span style="display:block;color:#888; font-weight: 500;font-size:14px;letter-spacing:-0.3px">(우)39660 경상북도 김천시 혁신6로 17(율곡동,한국교통안전공사)</span>
							</td>
					</tr>
			</table>
			</td>
		</tr>
		<!-- //footer -->
	</tbody>
</table>
</div>
<div id="template2" style="display:none;">
<table width="780" cellspacing="0" cellpadding="0" class="ns_newsletter" style="margin: 0 auto; font-family:'돋움', dotum, Arial,Trebuchet MS, Helvetica, sans-serif;border:1px solid #bdbdbd;">
	<tbody style="font-family: '나눔 고딕'">
		<!-- header -->
		<tr>
			<td colspan="2" style="padding: 0px;">
				<table style="display:inline-block; background: url(/images/newsletter/main2.jpg) no-repeat 0px 0px;background-size:cover; width: 100%; height:513px; border-collapse: collapse;">
					<tbody>
						<tr>
							<td style="padding: 0px; width: 685px;">
								<a  style="padding: 23px 0px 33px 28px; display: block; box-sizing: border-box;" href="#" target="_blank" rel="noreferrer noopener">
									<img alt="한국교통안전공단 자동차안전연구원" src="/images/newsletter/logo.png">
								</a>
							</td>
							<td style="padding: 0px; width: 95px;">
								<div style="padding: 27px 0px; width: 95px; height: 95px; text-align: center; color: rgb(255, 255, 255); box-sizing: border-box; background-color: rgb(13, 70, 160);">
									<div style="line-height: 100%; font-size: 14px;">2020.</div>
									<div style="line-height: 100%; font-size: 21px; font-weight: 500; margin-top: 5px;">01.01.</div>
								</div>
							</td>
						</tr>
						<tr>
							<td style="padding: 0px; width: 100%; height: 165px;" colspan="2"></td>
						</tr>
						<tr>
							<td style="padding: 0px; width: 100%; background-color: rgba(0,0,0,0.3);" colspan="2">
								<div style="padding: 20px 40px 28px; text-align: left; box-sizing: border-box;">
									<div style="width: 63px; vertical-align: middle; display: inline-block;">
										<img style="vertical-align: middle; display: inline-block;" alt="자동차로고이미지" src="/images/newsletter/sub_logo2.png" />
									</div>
									<div style="color: rgb(255, 255, 255); line-height: 40px; font-size: 23px; font-weight: 600; margin-left: 10px; vertical-align: middle; display: inline-block; text-shadow: 4px 3px 5px #000;">자율주행차 융 · 복합 미래포럼</div>
								</div>
							</td>
						</tr>
						<tr style="width:100%;height:160px;background-color:rgba(0,0,0,0.1);z-index: 50;">
							<td style="width: 100%;" colspan="2">
								<table width="780" height="163"  cellspacing="0" cellpadding="0" style="width: 100%; margin:0 auto; display:table;">
									<tbody>
										<tr style="overflow: hidden; border-bottom-color: rgb(220, 223, 230); border-bottom-width: 1px; border-bottom-style: solid;">
											<td style="width: 20%; vertical-align: top;">
												<div style="color: rgb(255, 255, 255); font-size: 22px; font-weight: 600; margin-top: 20px; margin-left: 40px;" >공지사항</div>
											</td>	
											<td style="margin-left: 20px;">
												<ul style="list-style: none; letter-spacing: -0.5px; padding-right: 40px; padding-left: 0px; margin-top: 7px;">
													<!--공지사항1-->
													<li style="border-bottom: 1px solid #bdbdbd;padding: 12px 0;display:block;overflow:hidden;width:100%">
														<ul style="margin: 0px; padding: 0px; overflow: hidden; float: left;">
															<li style="list-style: none; margin: 10px 0px 0px; padding: 0px; width: 2px; height: 2px; float: left; background-color: rgb(255, 255, 255);"></li>
															<li style="list-style: none; overflow: hidden; margin-left: 10px;">
																		<a href="javascript:void(0)" target="_self" style="color: rgb(255, 255, 255); font-size: 17px; text-decoration: none; float: left;">(폭스바겐)자율주행 자회사 설립</a>
															</li>
														</ul>
														<ul style="list-style: none; margin: 0px; padding: 0px; float: right; display: inline-block;">
																<li style="color: rgb(255, 255, 255); float: right;">2019.10.05</li>
														</ul>
													</li><!--공지사항1-->
													<!--공지사항2-->
													<li style="padding: 12px 0px 35px; width: 100%; border-bottom-color: rgb(189, 189, 189); border-bottom-width: 1px; border-bottom-style: solid;">
														<ul style="margin: 0px; padding: 0px;">
															<li style="list-style: none; margin: 10px 0px 0px; padding: 0px; width: 2px; height: 2px; float: left; background-color: rgb(255, 255, 255);"></li>
															<li style="list-style: none; margin-left: 10px;">
																		<a href="javascript:void(0)" target="_self" style="color: rgb(255, 255, 255); font-size: 17px; text-decoration: none; float: left;">사망 사고 낸 자율주행차...'보행자 못 알아봤다'</a>
															</li>
														</ul>
														<ul style="list-style: none; margin: 0px; padding: 0px;">
																<li style="color: rgb(255, 255, 255); float: right;">2019.10.05</li>
														</ul>
													</li><!--공지사항2-->
													<!--공지사항3-->
													<li style="padding: 12px 0px 35px; width: 100%;">
														<ul style="margin: 0px; padding: 0px;">
															<li style="list-style: none; margin: 10px 0px 0px; padding: 0px; width: 2px; height: 2px; float: left; background-color: rgb(255, 255, 255);"></li>
															<li style="list-style: none;margin-left: 10px; ">
																		<a href="javascript:void(0)" target="_self" style="color: rgb(255, 255, 255); font-size: 17px; text-decoration: none; float: left;">NTSB, 우버 자율주행차 사망 사고 우버 책임</a>
															</li>
														</ul>
														<ul style="list-style: none; margin: 0px; padding: 0px;">
																<li style="color: rgb(255, 255, 255); float: right;">2019.10.05</li>
														</ul>
													</li><!--공지사항3-->
												</ul> 
											</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<!-- //header -->
		<!-- content1 -->
		<tr>
			<td  colspan="2">
				<table width="780" height="330" cellspacing="0" cellpadding="0" style="margin:0 auto;background-color: #fafbfc;">
					<tbody>
						<tr style="width: 100%; height: 330px;">
							<td style="width: 50%;padding:40px 10px 20px 40px;vertical-align:top">
									<div style="margin-bottom:15px;font-size:20px; font-weight: 600; " >회의 일정 공지
										<button style="width: 18px; height: 18px; color: red; background:url(/images/newsletter/plus_icon.png)no-repeat 0 0; border: 1px solid #bdbdbd; cursor:pointer;margin-top:5px;"></button>
									</div>
									<div style="display: block; width: 100%; height: 210px;background-color: #edf4fa; text-align: center; font-size: 16px;  border:1px solid #e2e9f3; box-sizing: border-box;" >
											<div style="background: url(/images/newsletter/date.png)no-repeat 0 0; text-align: left; margin:20px 0 0 19px; ">
													<div style="margin-left: 30px;">일시</div>
													<div style="margin:4px 0 0 30px; font-size: 16px;">2019년 10월 10일</div>
											</div>
											<div style="background: url(/images/newsletter/co.png)no-repeat 0 0;text-align: left; margin:10px 0 0 17px;">
													<div style="margin-left: 30px;">주최 / 주관</div>
													<div style="margin:4px 0 0 30px; font-size: 16px;">국토교통부, 교통안전공단</div>
											</div>
											<div style="background: url(/images/newsletter/place.png)no-repeat 0 0; text-align: left; margin:10px 0 0px 17px;">
													<div style="margin-left: 30px;">장소</div>
													<div style="margin:4px 0 0 30px; font-size: 16px;">세종특별자치시 컨벤션센터</div>
											</div>
									</div>
							</td>
							<td style="width: 50%;padding:40px 40px 20px 10px;vertical-align:top">
									<div style="margin-bottom:15px;font-size:20px; font-weight: 600;" >회의 결과 안내</div>

									<div style="display: block; width: 100%; height: 210px; background-color: #fff; text-align: center; border:1px solid #e2e9f3;" >
											<div style="width: 44px; height: 36px; margin: 0 auto; margin-top: 28px; background: url(/images/newsletter/result.png)no-repeat 0 0;"></div>
											<div style="margin-top:20px;font-size:17px; line-height: 150%;">2019 자동차안정기준 국제조화<br/> 최종보고회 개최 결과 안내</div>
											<button style="width: 152px; height: 36px; margin-top: 20px; border:none; background-color:#edf4fa; color: #033f9c; font-weight: bold; cursor:pointer;font-size: 15px;">결과보고 바로보기&gt;</button>
									</div>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<!-- //content1 -->
		<!-- content2 -->
		<td>
			<table width="780" cellspacing="0" cellpadding="0" style="margin:0 auto; border-top: 1px solid #dcdfe6; border-bottom: 1px solid #dcdfe6; ">
				<tbody>
					<tr style=" display: block; text-align: center;">
						<td>
							<table width="780" height="440" cellspacing="0" cellpadding="0" style="margin:0 auto;"><!-- News & 이슈리포트 -->
								<tbody>
									<tr>
										<td>
											<div style="display:block; width: 90%; font-size: 22px; font-weight: 600; margin-top: 25px; margin-bottom: 20px; margin-left: 40px; letter-spacing: -1px;text-align:left;"> News &amp; 이슈리포트</div>
										</td>
									</tr>

									<tr  style="overflow:hidden;width:100%;">
										<td style="float:left; width: 50%;">
											<div sytle="display:inline;text-align:left;">
												<div style="display: block;	width: 333px;	height: 150px;	margin: 0 40px;	padding: 15px;	background-color: #edf4fa; text-align: center;	font-size: 16px;
												border-top: 1px solid #e2e9f3;border-left: 1px solid #e2e9f3;border-right: 1px solid #e2e9f3; box-sizing: border-box;">
													<div style="font-size: 19px;text-align:left;font-weight:600;letter-spacing:-0.5px;overflow:hidden;text-overflow:ellipsis;	word-wrap:break-word;white-space: nowrap;">(폭스바겐) 자율주행 자회사 설립</div>
													<div style="text-align:left;margin-top:15px;line-height:1.5em;overflow:hidden;text-overflow:ellipsis;line-height:1.5;height:3em; word-wrap:break-word;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical; cursor: pointer; letter-spacing: -0.5px;">폭스바겐그룹은 지난달 28일 독일 뮌헨과 볼프스부르크에 자율주행 </div>
													<div style="text-align:left;margin-top:10px;color:#888888;">2019.10.05</div>
												</div>
												<div style="display: block;	width: 333px;	height: 150px;	margin: 0 40px;	padding: 15px;	background-color: #edf4fa; text-align: center;	font-size: 16px;
												border: 1px solid #e2e9f3; box-sizing: border-box;">
													<div style="font-size: 19px;text-align:left;font-weight:600;letter-spacing:-1.5px;overflow:hidden;text-overflow:ellipsis;	word-wrap:break-word;white-space: nowrap;">사망 사고 낸 우버 자율주행차 '보행...  </div>
													<div style="text-align:left;margin-top:15px;line-height:1.5em;overflow:hidden;text-overflow:ellipsis;line-height:1.5;height:3em; word-wrap:break-word;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical; cursor: pointer; letter-spacing: -0.5px;">미국 연방교통안전위원회(NTSB)의 조사결과에 따르면, 우버(Uber)의... </div>
													<div style="text-align:left;margin-top:10px;color:#888888;">2019.10.05</div>
												</div>
											</div>	
										</td>
										<td style="float:left; overflow:hidden; width: 45%; height: 315px; margin-left:20px; box-sizing:border-box">
											<div style="display:inline;">
												<div style="display:blcok; width:333px; ">
													<img src="/images/newsletter/news2.jpg" alt="국내동향 이미지" style="box-shadow: 3px 7px 10px #e1e2e3;">
												</div>
												<div style="display:block; width:333px; margin-top: 7px;">
													<div style="font-size: 19px;text-align:left;font-weight:600;letter-spacing:-1.5px;overflow:hidden;text-overflow:ellipsis;	word-wrap:break-word;white-space: nowrap;">美 뉴욕에서 자율주행셔틀 운행 </div>
													<div style="text-align:left;margin-top:10px;line-height:1.5em;overflow:hidden;text-overflow:ellipsis;line-height:1.5;height:3em;
													word-wrap:break-word;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;letter-spacing: -1px;font-size:17px;">인민국 자율주행 스타트업 옵티머스인 미국 자육주행 스타트업 옵티머스...</div>
													<div style="text-align:left;margin-top:10px;color:#888888;font-size:15px;">2019.10.05</div>
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr><!-- / News & 이슈리포트 -->
				</tbody>
			</table>
		</td>
		<!-- //content2 -->
		<!-- content3 -->
		<tr style="display:block;height:250px;background-color:#fafbfc;">
			<td>
				<table width="780" height="250" align="center" border="0" cellspacing="0" cellpadding="0">
					<tbody>
						<tr style="width: 100%; height: 250px; background-color: #fafbfc;">
							<td style="width: 50%; ">
									<div style="margin-left: 40px; font-size:21px; font-weight: 600; margin-bottom: 20px; " >국내동향</div>
									<div style="overflow:hidden;display: block; width: 350px;	height: 150px; margin: 0 10px 0 30px;text-align: center;	font-size: 16px;	box-sizing: border-box;">
										<div style="float:left; width:37%">
											<img src="/images/newsletter/internal_trend1.jpg" alt="국내동향 이미지" style="box-shadow: 3px 7px 10px #e1e2e3;">
										</div>
										<div style="width:57%; margin-left: 42%; text-align: left; letter-spacing: -1.5px;">
											<div style="font-size: 20px; font-weight: 600; margin: 12px 0;">
												<a  href="javascript:void(0)" target="_self" style="text-decoration: none; color: #000; overflow:hidden;text-overflow:ellipsis;line-height:1.5;height:3em;
												word-wrap:break-word;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical">자율주행차에서 자율주행기반 교통서비스로 </a>
											</div>
											<div style="overflow:hidden;text-overflow:ellipsis;line-height:1.3;height:3.8em; word-wrap:break-word;display:-webkit-box;-webkit-line-clamp:3;-webkit-box-orient:vertical; cursor: pointer; letter-spacing: -0.5px;">
												<a  href="javascript:void(0)" target="_self" style="text-decoration: none; color: #000;">인공지능, 5G, 사물인터넷 등 4차 산업혁명의 핵심기술이 집약된 자율주행차는 이동.../a>
											</div>
										</div>
									</div>
							</td>
							<td style="width: 50%;">
									<div style="margin-left: 15px; font-size:21px; font-weight: 600; margin-bottom: 20px;" >국외동향</div>
									<div style="overflow:hidden;display: block; width: 350px;	height: 150px; margin: 0 10px 0 15px;text-align: center;	font-size: 16px;	box-sizing: border-box;">
										<div style="float:left; width:37%">
											<img src="/images/newsletter/overseas_trend1.jpg" alt="국외동향 이미지" style="box-shadow: 3px 7px 10px #e1e2e3;">
										</div>
										<div style="width:57%; margin-left: 42%; text-align: left; letter-spacing: -1.5px;">
											<div style="font-size: 20px; font-weight: 600; margin: 12px 0;">
												<a  href="javascript:void(0)" target="_self" style="text-decoration: none; color: #000; overflow:hidden;text-overflow:ellipsis;line-height:1.5;height:3em;
												word-wrap:break-word;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical">Waymo, 자율주행차 데이터 공개</a>
											</div>
											<div style="overflow:hidden;text-overflow:ellipsis;line-height:1.3;height:3.8em; word-wrap:break-word;display:-webkit-box;-webkit-line-clamp:3;-webkit-box-orient:vertical">
												<a  href="javascript:void(0)" target="_self" style="text-decoration: none; color: #000;">Google의 자율주행차 개발업체인 Waymo가 자율주행자동차 데이터를 공개함 Waymo...</a>
											</div>
										</div>
									</div>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<!-- //content3 -->
		
			<!-- footer -->
			<tr style="display:block;background-color:#e8ebec;">
				<td style="padding:20px 0;">
					<table style="font-size:13px;">
						<tr>
								<td style="padding-left: 40px;">
									<a href="javascript:void(0)" target="_self"><img src="/images/newsletter/footer_logo_01.png" alt="국토교통부"></a>
								</td>
								<td style="padding-left: 50px; line-height: 200%;padding-bottom: 5px;"> 
									<div style="font-weight: 600;">국토교통부</div>
									<div style="color:#838383; font-weight: 600;">(우)30103 세종특별자치시 도움6로 11 국토교통부</div>
								</td>
						</tr>
						 <tr>
								<td style="padding-left: 40px;" >
									<a href="javascript:void(0)" target="_self"><img src="/images/newsletter/footer_logo_02.png" alt="한국교통안전공단 자동차안전연구원"></a>
								</td>
								<td style="padding-left: 50px; margin-top:30px; line-height: 200%;"> 
									<div style="font-weight: 600;">한국교통안전공사 자동차안전연구원</div>
									<div style="color:#838383; font-weight: 600;">(우)39660 경상북도 김천시 혁신6로 17(율곡동,한국교통안전공사)</div>
								</td>
						</tr>
				</table>
				</td>
			</tr>
			<!-- //footer -->
	</tbody>
</table>
</div>
<div id="template3" style="display:none;">
<table width="780" cellspacing="0" cellpadding="0" class="ns_newsletter" style="margin: 0 auto; font-family:'돋움', dotum, Arial,Trebuchet MS, Helvetica, sans-serif;border:1px solid #bdbdbd;">
	<tbody style="font-family: '나눔 고딕'">
		<!-- header -->
		<tr>
			<td colspan="2" style="padding: 0px;">
				<table style="background: url(/images/newsletter/main3.jpg) no-repeat 0px 0px;background-size:cover; width: 100%; border-collapse: collapse;">
					<tbody>
						<tr>
							<td style="padding: 0px; width: 685px;">
								<a  style="padding: 23px 0px 33px 28px; display: block; box-sizing: border-box;" href="#" target="_blank" rel="noreferrer noopener">
									<img alt="한국교통안전공단 자동차안전연구원" src="/images/newsletter/logo.png">
								</a>
							</td>
							<td style="padding: 0px; width: 95px;">
								<div style="padding: 27px 0px; width: 95px; height: 95px; text-align: center; color: rgb(255, 255, 255); box-sizing: border-box; background-color: rgb(13, 70, 160);">
									<div style="line-height: 100%; font-size: 14px;">2020.</div>
									<div style="line-height: 100%; font-size: 21px; font-weight: 500; margin-top: 5px;">01.01.</div>
								</div>
							</td>
						</tr>
						<tr>
							<td style="padding: 0px; width: 100%; height: 165px;" colspan="2"></td>
						</tr>
						<tr>
							<td style="padding: 0px; width: 100%; background-color: rgba(0,0,0,0.3);" colspan="2">
								<div style="padding: 20px 40px 28px; text-align: left; box-sizing: border-box;">
									<div style="width: 63px; vertical-align: middle; display: inline-block;">
										<img style="vertical-align: middle; display: inline-block;" alt="자동차로고이미지" src="/images/newsletter/sub_logo2.png" />
									</div>
									<div style="color: rgb(255, 255, 255); line-height: 40px; font-size: 23px; font-weight: 600; margin-left: 10px; vertical-align: middle; display: inline-block; text-shadow: 4px 3px 5px #000;">자율주행차 융 · 복합 미래포럼</div>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<!-- //header -->
		<!-- content1 -->
		<tr style="">
			<td style="width:100%;padding:0;border-bottom:1px solid #dcdfe6;background:#fafbfc url(/images/newsletter/bg01.png) no-repeat 44px 127px;font-size:0;">
				<div style="display:inline-block;width:67px;height:67px;margin-right:30px;padding:10px 0;box-sizing:border-box;vertical-align:top;background:url(/images/newsletter/blue.png) no-repeat 0 0;text-align:center;">
					<div style="display:inline-block;color:#fff;font-size:15px;font-weight:600;">국내<br/>동향</div>
				</div>
				<div style="display:inline-block;width:208px;padding:40px 0;margin-right:30px;vertical-align:top;">
					<a href="#" style="cursor:pointer"><img style="box-shadow: 3px 7px 10px #dbdbdb;" src="/images/newsletter/internal_trend2.jpg" alt="국내동향 이미지"></a>
				</div>
				<div style="display:inline-block;width:calc(100% - 335px);padding:40px 40px 40px 0;box-sizing:border-box;vertical-align:top">
					<div style="overflow:hidden;font-size: 19px;text-align:left;font-weight:600;letter-spacing:-1.5px;text-overflow:ellipsis;	word-wrap:break-word;white-space: nowrap;">
						<a href="#" style="cursor:pointer;text-decoration:none;color:#000;">자율주행차에서 자율주행 기반 교통서비스로</a>
					</div>
					<div style="overflow:hidden;margin-top:10px;line-height:1.5em;text-overflow:ellipsis;line-height:1.5;height:6em;
					word-wrap:break-word;display:-webkit-box;-webkit-line-clamp:4;-webkit-box-orient:vertical;letter-spacing: -1.5px;font-size:17px;text-align:left;">
						<a href="#" style="cursor:pointer;text-decoration:none;color:#000;">인공지능, 5G, 사물인터넷 등 4차 산업혁명의 핵심기술이 집약된 자율주행차는 이동의 혁신을 넘어 우리가 살아왔고 일해왔던 삶의 방식들이 인공지능, 5G, 사물인터넷 등 4차 산업혁명의 핵심기술이 집약된 자율주행차는 이동의 혁신을 넘어 ...<a/>
					</div>
					<div style="text-align:left;margin-top:3px;color:#888888;font-size:15px;">2019.10.05</div>
				</div>
			</td>
		</tr>
		<!-- //content1 -->
		<!-- content2 -->
		<tr>
			<td style="width:100%;padding:0;border-bottom:1px solid #dcdfe6;background:#fafbfc url(/images/newsletter/bg02.png) no-repeat 44px 102px;font-size:0;">
				<div style="display:inline-block;width:67px;height:67px;margin-right:30px;padding:10px 0;box-sizing:border-box;vertical-align:top;background:url(/images/newsletter/blue.png) no-repeat 0 0;text-align:center;">
					<div style="display:inline-block;color:#fff;font-size:15px;font-weight:600;">국외<br/>동향</div>
				</div>
				<div style="display:inline-block;width:208px;padding:40px 0;margin-right:30px;vertical-align:top;">
					<a href="#" style="cursor:pointer"><img style="box-shadow: 3px 7px 10px #dbdbdb;" src="/images/newsletter/overseas_trend2.jpg" alt="국외동향 이미지"></a>
				</div>
				<div style="display:inline-block;width:calc(100% - 335px);padding:40px 40px 40px 0;box-sizing:border-box;vertical-align:top">
					<div style="overflow:hidden;font-size: 19px;text-align:left;font-weight:600;letter-spacing:-1.5px;text-overflow:ellipsis;	word-wrap:break-word;white-space: nowrap;">
						<a href="#" style="cursor:pointer;text-decoration:none;color:#000;">美 뉴욕에서 자율주행셔틀 운행</a>
					</div>
					<div style="overflow:hidden;margin-top:10px;line-height:1.5em;text-overflow:ellipsis;line-height:1.5;height:6em;
					word-wrap:break-word;display:-webkit-box;-webkit-line-clamp:4;-webkit-box-orient:vertical;letter-spacing: -1.5px;font-size:17px;text-align:left;">
						<a href="#" style="cursor:pointer;text-decoration:none;color:#000;">인미국 자율주행 스타트업 옵티머스 라이드가 뉴욕의 브룩클린에서 자율주행 셔틀버스 운행을
						시작 해당 지역은 약 10,000명이 근무하는 공업단지로, 단지 내 도로가 모두  ...<a/>
					</div>
					<div style="text-align:left;margin-top:3px;color:#888888;font-size:15px;">2019.10.05</div>
				</div>
			</td>
		</tr>
			<!-- //content2 -->
		<!-- content3 -->
		<tr style="">
			<td style="padding:0;font-size:0;">
				<div style="display:inline-block;width:67px;height:67px;margin-right:30px;padding:10px 0;box-sizing:border-box;vertical-align:top;background:url(/images/newsletter/yellow.png) no-repeat 0 0;text-align:center;">
					<div style="display:inline-block;color:#fff;font-size:15px;font-weight:600;">이슈<br/>리포트</div>
				</div>

				<ul style="display:inline-block;width:calc(100% - 97px);list-style: none;padding:40px 40px 40px 0;box-sizing:border-box; letter-spacing: -0.5px;">
					<!--첫번째 기사-->
					<li style="overflow:hidden;padding-bottom:15px;border-bottom: 1px solid #bdbdbd;">
						<a href="#" target="_self" style="float:left;text-decoration: none; color: #000; font-size:17px;">· (폭스바겐) 자율주행 자회사 설립</a>
						<span style="display:block;float:right;color: #848484;font-size:15px;">2019.10.05</span>
					</li><!--첫번째 기사 끝-->
					<!--두번째 기사-->
					<li style="overflow:hidden;padding:15px 0;border-bottom: 1px solid #bdbdbd;">
						<a href="#" target="_self" style="float:left;text-decoration: none; color: #000; font-size:17px;">· 사망 사고 낸 우버 자율주행차...'보행자 못 알아봤다'</a>
						<span style="display:block;float:right;color: #848484;font-size:15px;">2019.10.05</span>
					</li><!--두번째 기사 끝-->
					<!--세번째 기사-->
					<li style="overflow:hidden;padding:15px 0;border-bottom: 1px solid #bdbdbd;">
						<a href="#" target="_self" style="float:left;text-decoration: none; color: #000; font-size:17px;">· NTSB, 우버 자율주행차 사망 사고 우버 책임</a>
						<span style="display:block;float:right;color: #848484;font-size:15px;">2019.10.05</span>
					</li><!--세번째 기사 끝-->
					<!--네번째 기사-->
					<li style="overflow:hidden;padding-top:15px;border-bottom:none">
						<a href="#" target="_self" style="float:left;text-decoration: none; color: #000; font-size:17px;">· [테슬라]자율주행 실적 30억km돌파...GM,웨이모 등 경쟁업체 압도</a>
						<span style="display:block;float:right;color: #848484;font-size:15px;">2019.10.05</span>
					</li><!--네번째 기사 끝-->
				</ul>
			</td>
		</tr>
		<!-- //content3 -->
		<!-- content4 -->
		<tr style="background-color: #edf4fa;">
			<td style="padding:0;font-size:0;">
				<div style="display:inline-block;width:67px;height:67px;margin-right:30px;padding:10px 0;box-sizing:border-box;vertical-align:top;background:url(/images/newsletter/yellow.png) no-repeat 0 0;text-align:center;">
					<div style="display:inline-block;color:#fff;font-size:15px;font-weight:600;">공지<br/>사항</div>
				</div>

				<ul style="display:inline-block;width:calc(100% - 97px);list-style: none;padding:40px 40px 40px 0;box-sizing:border-box; letter-spacing: -0.5px;">
					<!--첫번째 기사-->
					<li style="overflow:hidden;padding-bottom:15px;border-bottom: 1px solid #bdbdbd;">
						<a href="#" target="_self" style="float:left;text-decoration: none; color: #000; font-size:17px;">· (폭스바겐) 자율주행 자회사 설립</a>
						<span style="display:block;float:right;color: #848484;font-size:15px;">2019.10.05</span>
					</li><!--첫번째 기사 끝-->
					<!--두번째 기사-->
					<li style="overflow:hidden;padding:15px 0;border-bottom: 1px solid #bdbdbd;">
						<a href="#" target="_self" style="float:left;text-decoration: none; color: #000; font-size:17px;">· 사망 사고 낸 우버 자율주행차...'보행자 못 알아봤다'</a>
						<span style="display:block;float:right;color: #848484;font-size:15px;">2019.10.05</span>
					</li><!--두번째 기사 끝-->
					<!--세번째 기사-->
					<li style="overflow:hidden;padding:15px 0;border-bottom: none">
						<a href="#" target="_self" style="float:left;text-decoration: none; color: #000; font-size:17px;">· NTSB, 우버 자율주행차 사망 사고 우버 책임</a>
						<span style="display:block;float:right;color: #848484;font-size:15px;">2019.10.05</span>
					</li><!--세번째 기사 끝-->
					<!--네번째 기사-->
				</ul>
			</td>
		</tr>

		<!-- //content4 -->
		<!-- content5 -->
		<tr>
			<td  colspan="2">
				<table width="780" height="330" cellspacing="0" cellpadding="0" style="margin:0 auto;background-color: #fafbfc;">
					<tbody>
						<tr style="width: 100%; height: 330px;">
							<td style="width: 50%;padding:40px 10px 20px 40px;vertical-align:top">
									<div style="margin-bottom:15px;font-size:20px; font-weight: 600; " >회의 일정 공지
										<button style="width: 18px; height: 18px; color: red; background:url(/images/newsletter/plus_icon.png)no-repeat 0 0; border: 1px solid #bdbdbd; cursor:pointer;"></button>
									</div>
									<div style="display: block; width: 100%; height: 210px;background-color: #edf4fa; text-align: center; font-size: 16px;  border:1px solid #bdbdbd; box-sizing: border-box;" >
											<div style="background: url(/images/newsletter/date.png)no-repeat 0 0; text-align: left; margin:20px 0 0 19px; ">
													<div style="margin-left: 30px;">일시</div>
													<div style="margin:4px 0 0 30px; font-size: 16px;">2019년 10월 10일</div>
											</div>
											<div style="background: url(/images/newsletter/co.png)no-repeat 0 0;text-align: left; margin:10px 0 0 17px;">
													<div style="margin-left: 30px;">주최 / 주관</div>
													<div style="margin:4px 0 0 30px; font-size: 16px;">국토교통부, 교통안전공단</div>
											</div>
											<div style="background: url(/images/newsletter/place.png)no-repeat 0 0; text-align: left; margin:10px 0 0px 17px;">
													<div style="margin-left: 30px;">장소</div>
													<div style="margin:4px 0 0 30px; font-size: 16px;">세종특별자치시 컨벤션센터</div>
											</div>
									</div>
							</td>
							<td style="width: 50%;padding:40px 40px 20px 10px;vertical-align:top">
									<div style="margin-bottom:15px;font-size:20px; font-weight: 600;" >회의 결과 안내</div>

									<div style="display: block; width: 100%; height: 210px; background-color: #fff; text-align: center; border:1px solid #bdbdbd;" >
											<div style="width: 44px; height: 36px; margin: 0 auto; margin-top: 28px; background: url(/images/newsletter/result.png)no-repeat 0 0;"></div>
											<div style="margin-top:20px;font-size:17px; line-height: 150%;">2019 자동차안정기준 국제조화<br/> 최종보고회 개최 결과 안내</div>
											<button style="width: 152px; height: 36px; margin-top: 20px; border:none; background-color:#edf4fa; color: #033f9c; font-weight: bold; cursor:pointer;font-size: 15px;">결과보고 바로보기&gt;</button>
									</div>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<!-- //content5 -->
		<!-- footer -->
		<tr style="display:block;background-color:#e8ebec;">
			<td style="padding:20px 0;">
				<table style="font-size:13px;">
					<tr>
							<td style="padding-left: 40px;">
								<a href="#" target="_self"><img src="/images/newsletter/footer_logo_01.png" alt="국토교통부"></a>
							</td>
							<td style="padding-left: 50px; line-height: 200%;padding-bottom: 5px;">
								<div style="font-weight: 600;">국토교통부</div>
								<div style="color:#838383; font-weight: 600;">(우)30103 세종특별자치시 도움6로 11 국토교통부</div>
							</td>
					</tr>
					 <tr>
							<td style="padding-left: 40px;" >
								<a href="#" target="_self"><img src="/images/newsletter/footer_logo_02.png" alt="한국교통안전공단 자동차안전연구원"></a>
							</td>
							<td style="padding-left: 50px; margin-top:30px; line-height: 200%;">
								<div style="font-weight: 600;">한국교통안전공사 자동차안전연구원</div>
								<div style="color:#838383; font-weight: 600;">(우)39660 경상북도 김천시 혁신6로 17(율곡동,한국교통안전공사)</div>
							</td>
					</tr>
			</table>
			</td>
		</tr>
		<!-- //footer -->
	</tbody>
</table>
</div>
<div id="template4" style="display:none;">
<table width="780" cellspacing="0" cellpadding="0" class="ns_newsletter" style="margin: 0 auto; font-family:'돋움', dotum, Arial,Trebuchet MS, Helvetica, sans-serif;border:1px solid #bdbdbd;">
	<tbody style="font-family: '나눔 고딕'">
		<!-- header -->
		<tr>
			<td colspan="2" style="padding: 0px;">
				<table style="background: url(/images/newsletter/main4.jpg) no-repeat 0px 0px;background-size:cover; width: 100%; border-collapse: collapse;">
					<tbody>
						<tr>
							<td style="padding: 0px; width: 685px;">
								<a  style="padding: 23px 0px 33px 28px; display: block; box-sizing: border-box;" href="#" target="_blank" rel="noreferrer noopener">
									<img alt="한국교통안전공단 자동차안전연구원" src="/images/newsletter/logo.png">
								</a>
							</td>
							<td style="padding: 0px; width: 95px;">
								<div style="padding: 27px 0px; width: 95px; height: 95px; text-align: center; color: rgb(255, 255, 255); box-sizing: border-box; background-color: rgb(13, 70, 160);">
									<div style="line-height: 100%; font-size: 14px;">2020.</div>
									<div style="line-height: 100%; font-size: 21px; font-weight: 500; margin-top: 5px;">01.01.</div>
								</div>
							</td>
						</tr>
						<tr>
							<td style="padding: 0px; width: 100%; height: 165px;" colspan="2"></td>
						</tr>
						<tr>
							<td style="padding: 0px; width: 100%; background-color: rgba(0,0,0,0.3);" colspan="2">
								<div style="padding: 20px 40px 28px; text-align: left; box-sizing: border-box;">
									<div style="width: 63px; vertical-align: middle; display: inline-block;">
										<img style="vertical-align: middle; display: inline-block;" alt="자동차로고이미지" src="/images/newsletter/sub_logo2.png" />
									</div>
									<div style="color: rgb(255, 255, 255); line-height: 40px; font-size: 23px; font-weight: 600; margin-left: 10px; vertical-align: middle; display: inline-block; text-shadow: 4px 3px 5px #000;">자율주행차 융 · 복합 미래포럼</div>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<!-- //header -->
		<!-- content1 -->
		<tr style="display:block;">
			<td>
				<table width="780" cellspacing="0" cellpadding="0" style="margin:0 auto">
					<tbody>
						<tr style=" display: block; text-align: center;">
							<td>
								<table width="780" height="585" cellspacing="0" cellpadding="0" style="margin:0 auto"><!-- News & 이슈리포트 -->
									<tbody>
										<tr>
											<td style="border-top: 1px solid #dcdfe6">
												<div style="display:block; width: 90%; font-size: 22px; font-weight: 600; margin-top: 25px; margin-bottom: 20px; margin-left: 40px; letter-spacing: -1px;text-align:left;"> News &amp; 이슈리포트</div>
											</td>
										</tr>
										<tr  style="overflow:hidden;width:100%;height:335px;">
											<td style="float:left; overflow:hidden; width: 45%; height: 315px; margin-left:40px; box-sizing:border-box">
												<div style="display:inline;">
													<div style="display:block; width:333px;">
														<img src="/images/newsletter/news3.jpg" alt="news1 이미지" style="box-shadow: 3px 7px 10px #e1e2e3;">
													</div>
													<div style=" display:block; width:333px;">
														<div style="font-size: 19px;text-align:left;font-weight:600;letter-spacing:-1.5px;overflow:hidden;text-overflow:ellipsis;	word-wrap:break-word;white-space: nowrap;margin-top:7px; color:#000;">2019년 하반기 신입직원 임명장수료식 </div>
														<div style="text-align:left;margin-top:10px;line-height:1.5em;overflow:hidden;text-overflow:ellipsis;line-height:1.5;height:3em;
														word-wrap:break-word;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;letter-spacing: -1px; font-size:17px; color:#000;">한국교통안전공단에서는 2019년 하반기 신입직원들의 임명장 수여식이 있었습니다. 이번에 공단...</div>
														<div style="text-align:left;margin-top:10px;color:#888888;">2019.10.05</div>
													</div>
												</div>
											</td>
											<td style="float:left; overflow:hidden; width: 45%; height: 315px; margin-left:20px; box-sizing:border-box">
												<div style="display:inline;">
													<div style="display:block; width:333px;">
														<img src="/images/newsletter/news4.jpg" alt="news2 이미지" style="box-shadow: 3px 7px 10px #e1e2e3;">
													</div>
													<div style=" display:block; width:333px;">
														<div style="font-size: 19px;text-align:left;font-weight:600;letter-spacing:-1.5px;overflow:hidden;text-overflow:ellipsis;	word-wrap:break-word;white-space: nowrap;margin-top:7px; color:#000;">자율주행차 사이버보안 세미나 개최</div>
														<div style="text-align:left;margin-top:10px;line-height:1.5em;overflow:hidden;text-overflow:ellipsis;line-height:1.5;height:3em;
														word-wrap:break-word;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;letter-spacing: -1px; font-size:17px; color:#000;">[국토일보 김준현 기자] 한국교통안전공단(이사장 권병윤)이 15일 서울 코엑스에서 자동차 사이버...</div>
														<div style="text-align:left;margin-top:10px;color:#888888;">2019.10.05</div>
													</div>
												</div>
											</td>
										</tr>
										<tr ><!-- 기사 3개 -->
											<td style="border-bottom: 1px solid #dcdfe6">
												<ul style="list-style: none; margin-left:40px; margin-top:-20px; padding: 0; letter-spacing: -0.5px; margin-top: -5px;">
														<!--첫번째 기사-->
														<li style="border-top: 1px solid #bdbdbd; width:95%; padding: 15px 0 35px 0">
															<ul style="margin: 0; padding: 0;">
																<li style="list-style: none; margin: 0; padding: 0; float: left;background-color: black; width: 2px; height: 2px; margin-top: 10px;"></li>
																<li style="list-style: none;margin-left: 10px; ">
																			<a href="#" target="_self" style="text-decoration: none; color: #000; float: left;font-size:17px">사망 사고 낸 우버 자율주행차...'보행자 못 알아봤다'</a>
																</li>
															</ul>
															<ul style="list-style: none; margin: 0; padding: 0;">
																	<li style="float: right; color: #848484; font-size:14px">2019.10.05</li>
															</ul>
														</li><!--첫번째 기사 끝-->
														<!--두번째 기사-->
														<li style="border-top: 1px solid #bdbdbd; width:95%; padding: 15px 0 35px 0">
															<ul style="margin: 0; padding: 0;">
																<li style="list-style: none; margin: 0; padding: 0; float: left;background-color: black; width: 2px; height: 2px; margin-top: 10px;"></li>
																<li style="list-style: none;margin-left: 10px; ">
																			<a href="#" target="_self" style="text-decoration: none; color: #000; float: left;font-size:17px">NTSB, 우버 자율주행차 사망 사고 우버 책임</a>
																</li>
															</ul>
															<ul style="list-style: none; margin: 0; padding: 0;">
																	<li style="float: right; color: #848484; font-size:14px">2019.10.05</li>
															</ul>
														</li><!--두번째 기사 끝-->
														<!--세번째 기사-->
														<li style="border-top: 1px solid #bdbdbd; width:95%; padding: 15px 0 35px 0">
															<ul style="margin: 0; padding: 0;">
																<li style="list-style: none; margin: 0; padding: 0; float: left;background-color: black; width: 2px; height: 2px; margin-top: 10px;"></li>
																<li style="list-style: none;margin-left: 10px; ">
																			<a href="#" target="_self" style="text-decoration: none; color: #000; float: left;font-size:17px">[테슬라]자율주행 실적 30억km돌파...GM,웨이모 등 경쟁업체 압도</a>
																</li>
															</ul>
															<ul style="list-style: none; margin: 0; padding: 0;">
																	<li style="float: right; color: #848484; font-size:14px">2019.10.05</li>
															</ul>
														</li><!--세번째 기사 끝-->
												</ul>
											</td>
										</tr>

									</tbody>
								</table>
							</td>
						</tr><!-- / News & 이슈리포트 -->
					</tbody>
				</table>
			</td>
		</tr>
		<!-- //content1 -->
		<!-- content2 -->
		<tr>
			<td  colspan="2">
				<table width="780" height="330" cellspacing="0" cellpadding="0" style="margin:0 auto;background-color: #fafbfc;">
					<tbody>
						<tr style="width: 100%; height: 330px;">
							<td style="width: 50%;padding:40px 10px 20px 40px;vertical-align:top">
									<div style="margin-bottom:15px;font-size:20px; font-weight: 600; " >회의 일정 공지
										<button style="width: 18px; height: 18px; margin-top: 5px; color: red; background:url(/images/newsletter/plus_icon.png)no-repeat 0 0; border: 1px solid #bdbdbd; cursor:pointer;"></button>
									</div>
									<div style="display: block; width: 100%; height: 210px;background-color: #edf4fa; text-align: center; font-size: 16px;  border:1px solid #cfd7e2; box-sizing: border-box;" >
											<div style="background: url(/images/newsletter/date.png)no-repeat 0 0; text-align: left; margin:20px 0 0 19px; ">
													<div style="margin-left: 30px;">일시</div>
													<div style="margin:4px 0 0 30px; font-size: 16px;">2019년 10월 10일</div>
											</div>
											<div style="background: url(/images/newsletter/co.png)no-repeat 0 0;text-align: left; margin:10px 0 0 17px;">
													<div style="margin-left: 30px;">주최 / 주관</div>
													<div style="margin:4px 0 0 30px; font-size: 16px;">국토교통부, 교통안전공단</div>
											</div>
											<div style="background: url(/images/newsletter/place.png)no-repeat 0 0; text-align: left; margin:10px 0 0px 17px;">
													<div style="margin-left: 30px;">장소</div>
													<div style="margin:4px 0 0 30px; font-size: 16px;">세종특별자치시 컨벤션센터</div>
											</div>
									</div>
							</td>
							<td style="width: 50%;padding:40px 40px 20px 10px;vertical-align:top">
									<div style="margin-bottom:15px;font-size:20px; font-weight: 600;" >회의 결과 안내</div>

									<div style="display: block; width: 100%; height: 210px; background-color: #fff; text-align: center; border:1px solid #cfd7e2;" >
											<div style="width: 44px; height: 36px; margin: 0 auto; margin-top: 28px; background: url(/images/newsletter/result.png)no-repeat 0 0;"></div>
											<div style="margin-top:20px;font-size:17px; line-height: 150%;">2019 자동차안정기준 국제조화<br/> 최종보고회 개최 결과 안내</div>
											<button style="width: 152px; height: 36px; margin-top: 20px; border:none; background-color:#edf4fa; color: #033f9c; font-weight: bold; cursor:pointer;font-size: 15px;">결과보고 바로보기&gt;</button>
									</div>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<!-- //content2 -->
		<!-- footer -->
		<tr style="display:block;background-color:#e8ebec;">
			<td style="padding:20px 0;">
				<table style="font-size:13px;">
					<tr>
							<td style="padding-left: 40px;">
								<a href="#" target="_self"><img src="/images/newsletter/footer_logo_01.png" alt="국토교통부"></a>
							</td>
							<td style="padding-left: 50px; line-height: 200%;padding-bottom: 5px;">
								<div style="font-weight: 600;">국토교통부</div>
								<div style="color:#838383; font-weight: 600;">(우)30103 세종특별자치시 도움6로 11 국토교통부</div>
							</td>
					</tr>
					 <tr>
							<td style="padding-left: 40px;" >
								<a href="#" target="_self"><img src="/images/newsletter/footer_logo_02.png" alt="한국교통안전공단 자동차안전연구원"></a>
							</td>
							<td style="padding-left: 50px; margin-top:30px; line-height: 200%;">
								<div style="font-weight: 600;">한국교통안전공사 자동차안전연구원</div>
								<div style="color:#838383; font-weight: 600;">(우)39660 경상북도 김천시 혁신6로 17(율곡동,한국교통안전공사)</div>
							</td>
					</tr>
			</table>
			</td>
		</tr>
		<!-- //footer -->
	</tbody>
</table>
</div>
<!-- 20200221 템플릿 추가 -->





</body>
</html>
<script type="text/javascript">
var oEditors = []; //스마트에디터 오브젝트
var colModel = [
	{ label: '번호',	name: 'bdwrSeq',		width: 60,	align: "center" },
  	{ label: '제목',	name: 'bdwrTtlNm',		width: 200 },
  	{ label: '첨부파일',	name: 'attachFilename',	width: 100 },
  	{ label: '파일크기',	name: 'fileSize',	width: 60,	align: "center" },
  	{ label: '등록자ID',	name: 'regId',		width: 60,	align: "center" },
  	{ label: '등록일시',	name: 'regDate',		width: 100,	align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {

	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "boardContents",
		sSkinURI: "/se2/SmartEditor2Skin.html",
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//에디터 로딩 후 그리드 로딩 -> 그리드에서 상세정보 -> 에디터 데이터 표출 가능
			fn_mkeGrid();
		},
		fCreator: "createSEditor2"
	});

	$("input:radio[name='rdTempl']").on("click", function(){
		
		var templateId = $(this).val();
		// 초기화
		oEditors.getById["boardContents"].exec("SET_IR", [""]);
		if(templateId){
			var html = $("#"+templateId).html();
			oEditors.getById["boardContents"].exec("PASTE_HTML", [html]);
		}

	});

});

function fn_mkeGrid() {
	commonMakeGrid("gridList", "/system/newTrends/selectNewTrendsList.do", colModel, true
		, function(data) {
			if ($("#rowId").val() == "") $("#rowId").val("1");
			$("#gridList").jqGrid("setSelection", $("#rowId").val());
			}
		, function(rowid, status, e) {
			fn_searchForm(rowid);
		}
	);
	commonMakeCodeComboBox("gpbcYn", "YN_CODE1");
	commonMakeCodeComboBox("rtngCd", "bdwr_rtng_cd");

	fn_init();
	fn_search();
	$("#sKeyword").focus();
}

function fn_init() {
	// $("#grid").css("height", "calc(100% - "+($("#form").height()+119)+"px)");
	$("#gridList").jqGrid("setGridWidth", $("#grid").width()-2);
	$("#gridList").jqGrid("setGridHeight", $("#grid").height()-30);
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList").jqGrid("clearGridData");
	$("#boardContents").val("");
	oEditors.getById["boardContents"].exec("SET_IR", [""]);
	document.detailForm.reset();

	$("#sKeyword").focus();
}

function fn_search(selectNode) {
	$("#gridList").jqGrid("clearGridData");
	document.detailForm.reset();

	var searchData = {
		sKeyword: $("#sKeyword").val()
	};
	$("#gridList").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchForm(rowId) {
	var rowData = $("#gridList").jqGrid("getRowData", rowId);

	commonAjax({ "boardSeq": rowData.bdwrSeq }, "/system/newTrends/selectNewTrendsInfo.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];
		$("#saveMode").val("U");

		$("#boardSeq").val(formData.bSeq);
		$("#boardTitle").val(formData.bTitle);
		if(formData.bContent != null) {
			$("#boardContents").val(formData.bContent);
			oEditors.getById["boardContents"].exec("LOAD_CONTENTS_FIELD");
		}
		$("#attachFileNm").val(formData.attachFileNm);
		$("#attachFileSize").val(formData.attachFileSize);
		$("#gpbcYn").val(formData.gpbcYn);
		$("#rtngCd").val(formData.bRtng);
		$("#regId").val(formData.regId);
		$("#regDate").val(formData.regDate);
		$("#updateId").val(formData.updateId);
		$("#updateDate").val(formData.updateDate);

		$("#boardSeq").attr("readonly", true);
		$("#attachFileSize").attr("readonly", true);
		$("#regId").attr("readonly", true);
		$("#regDate").attr("readonly", true);
		$("#updateId").attr("readonly", true);
		$("#updateDate").attr("readonly", true);

		$("#boardSeq").css("background-color", "rgb(235, 235, 228)");
		$("#attachFileSize").css("background-color", "rgb(235, 235, 228)");
		$("#regId").css("background-color", "rgb(235, 235, 228)");
		$("#regDate").css("background-color", "rgb(235, 235, 228)");
		$("#updateId").css("background-color", "rgb(235, 235, 228)");
		$("#updateDate").css("background-color", "rgb(235, 235, 228)");
	});
}

function fn_new() {
	$("#boardContents").val("");
	oEditors.getById["boardContents"].exec("SET_IR", [""]);
	document.detailForm.reset();
	$("#saveMode").val("I");
	$("#boardSeq").val("신규");

	$("#boardTitle").focus();
}

function fn_save() {
	oEditors.getById["boardContents"].exec("UPDATE_CONTENTS_FIELD", []);

	if (!$("#detailForm").valid()) return;

	var data = new FormData($("#detailForm")[0]);
	var requestUrl = "";

	if($("#saveMode").val() == "I") requestUrl = "/system/newTrends/insertNewTrendsInfo.do";
	else if($("#saveMode").val() == "U") requestUrl = "/system/newTrends/updateNewTrendsInfo.do";

	if(requestUrl != "") {
		commonFormAjax(data, requestUrl, function(returnData, textStatus, jqXHR) {
			alert(returnData.message);
			fn_search();
		});
	}
}

function fn_delete() {
	if ($("#boardSeq").val() == "신규" || $("#boardSeq").val() == "") return;

	if (!confirm("<spring:message code='common.delete.msg'/>")) return;

	$("#saveMode").val("D");

	var data = $("#detailForm").serializeArray();

	commonAjax(data ,"/system/newTrends/deleteNewTrendsInfo.do" , function(returnData, textStatus, jqXHR) {
		alert(returnData.message);
		fn_search();
	});
}

function fileMapper() {
	$('#attachFileNm').val($('#file_info').val());
}

</script>
