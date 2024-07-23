'use strict';

//**************** common function ****************
$(function () {
    famSite();
    //$('html').fnInit();

    new SimpleBar(document.querySelector('.ui-scroller'), {}); //simplebar
    $('.el-form').parents('.lay-boxItem').addClass('form-wrap');
    $('.el-table .el-form').parents('td').addClass('form-wrap--table');
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

function commonAjax(oData, sUrl, successCallback, errorCallback, bAsync) {
	$.ajax({
		async: bAsync == undefined ? true : bAsync,
		data: oData,
		dataType: "json",
		url: sUrl,
		type: "post",
		beforeSend: function() {
	    	$("#lodingBar").show();
	    },
	    complete: function() {
	    	$("#lodingBar").hide();
	    },
	    success: function(returnData, textStatus, jqXHR) {
	    	if (returnData.interceptorMsg != undefined) {
					// alert(returnData.interceptorMsg);

					top.location.replace("/");
					return;
				}
	    	successCallback(returnData, textStatus, jqXHR);
		},
		error: function(jqXHR, textStatus, errorThrown) {
			if (jqXHR.responseJSON == undefined) {
				alert("에러가 발생했습니다. 관리자에게 문의하세요");
			} else {
				alert(jqXHR.responseJSON.message);
			}
			if (errorCallback != undefined) {
				errorCallback(jqXHR, textStatus, errorThrown)
			}
		}
	});
}

function commonFormAjax(oData, sUrl, successCallback, errorCallback, bAsync) {
	$.ajax({
		async: bAsync == undefined ? true : bAsync,
		data: oData,
		url: sUrl,
		type: "post",
		processData : false,
		contentType : false,
		beforeSend: function() {
	    	$("#lodingBar").show();
	    },
	    complete: function() {
	    	$("#lodingBar").hide();
	    },
	    success: function(returnData, textStatus, jqXHR) {
	    	if (returnData.interceptorMsg != undefined) {
					// alert(returnData.interceptorMsg);

					top.location.replace("/");
					return;
				}

	    	successCallback(returnData, textStatus, jqXHR);
		},
		error: function(jqXHR, textStatus, errorThrown) {
			if (jqXHR.responseJSON == undefined) {
				alert("에러가 발생했습니다. 관리자에게 문의하세요");
			} else {
				alert(jqXHR.responseJSON.message);
			}
			if (errorCallback != undefined) {
				errorCallback(jqXHR, textStatus, errorThrown)
			}
		}
	});
}

function commonMakeGridParam(sGridId, sUrl, oColNames, oColModel, oData, bShrinkToFit, loadCompleteCallback, onSelectRowCallback, loadErrorCallback) {
	$("#"+sGridId).jqGrid({
		url: sUrl,
		mtype: "POST",
		datatype: "local",
		viewrecords: false,
		rowNum: -1,
		loadonce:false,
		shrinkToFit: bShrinkToFit,
		colNames: oColNames,
		colModel: oColModel,
		postData: oData,
	  loadComplete: function(data) {
	   	if (data.interceptorMsg != undefined) {
				// alert(data.interceptorMsg);
				top.location.replace("/");
				return;
			}

			if (data != undefined && data.total == undefined) {
		   	if (data.rows == 0) {
					var h = $(".ui-jqgrid-bdiv").height()-3;
		      $("#"+sGridId).append('<tr><td colspan="'+oColModel.length+'" style="text-align:center; height: '+h+'px; border: none;" title="no data">검색된 결과가 없습니다.</td></tr>');
		    } else {
		      loadCompleteCallback(data);
		    }
		  }
	  },
	  loadError: function(xhr, status, error) {
	   	alert(status+" : "+error);
	   	if (loadErrorCallback != undefined) {
	   		loadErrorCallback(xhr, status, error);
	   	}
		},
		onSelectRow: function(rowid, status, e) {
			if (onSelectRowCallback != undefined) {
				onSelectRowCallback(rowid, status, e);
	  	}
		}
	});
}

function commonMakeGrid(sGridId, sUrl, oColModel, bShrinkToFit, loadCompleteCallback, onSelectRowCallback, loadErrorCallback) {
	$("#"+sGridId).jqGrid({
	   	url: sUrl,
	   	mtype: "POST",
		datatype: "local",
	   	viewrecords: false,
			rowNum: -1,
	   	shrinkToFit: bShrinkToFit,
	  	colModel: oColModel,
	    loadComplete: function(data) {
	    	if (data.interceptorMsg != undefined) {
				// alert(data.interceptorMsg);

				top.location.replace("/");
				return;
			}

	        if (data != undefined && data.total == undefined) {
	        	if (data.rows == 0) {
	        		var h = $(".ui-jqgrid-bdiv").height()-3;
	        		$("#"+sGridId).append('<tr><td colspan="'+oColModel.length+'" style="text-align:center; height: '+h+'px; border: none;" title="no data">검색된 결과가 없습니다.</td></tr>');
	        	} else {
	        		loadCompleteCallback(data);
	        	}
	        }
	    },
	    loadError: function(xhr, status, error) {
	    	alert(status+" : "+error);
	    	if (loadErrorCallback != undefined) {
	    		loadErrorCallback(xhr, status, error);
	    	}
		},
		onSelectRow: function(rowid, status, e) {
			if (onSelectRowCallback != undefined) {
				onSelectRowCallback(rowid, status, e);
	    	}
		}
	});
}

function commonMakeCodeComboBox(sComBoId, sCodeCd, bSelectYn, bDisabled, changeCallback, selectedVal, sRefVal1) {
	var data = {
		sCodeCd: sCodeCd,
		sRefVal1: sRefVal1 == undefined ? null : sRefVal1,
		sUseYn: "Y"
	};

	$("#"+sComBoId).empty();
	commonAjax(data , "/system/code/selectCodeComboBox.do", function(returnData, textStatus, jqXHR) {
		if (bSelectYn == undefined ? false : bSelectYn) {
			if (typeof(bSelectYn) == "boolean") {
				$("#"+sComBoId).append('<option value="">[선택 ]</option>');
			} else {
				$("#"+sComBoId).append('<option value="">['+bSelectYn+']</option>');
			}
		}

		for(var i=0; i<returnData.rows.length; i++) {
			var rowData = returnData.rows[i];
			if (selectedVal != undefined && selectedVal == rowData.codeDetlCd) {
				$("#"+sComBoId).append('<option value="'+ rowData.codeDetlCd +'" selected>' + rowData.codeDetlNm + '</option>');
			} else {
				$("#"+sComBoId).append('<option value="'+ rowData.codeDetlCd +'">' + rowData.codeDetlNm + '</option>');
			}
		}

		$("#"+sComBoId).attr("disabled", bDisabled == undefined ? false : bDisabled);

		if (changeCallback != undefined) {
			$("#"+sComBoId).on("change", function(event) {
				changeCallback(event);
			});
		}
	}, false);
}

function commonMakeAuthComboBox(sComBoId, bSelectYn, bDisabled, changeCallback, selectedVal) {
	var data = {
		sUseYn: "Y"
	};

	$("#"+sComBoId).empty();
	commonAjax(data , "/system/auth/selectAuthComboBox.do", function(returnData, textStatus, jqXHR) {
		if (bSelectYn == undefined ? false : bSelectYn) {
			if (typeof(bSelectYn) == "boolean") {
				$("#"+sComBoId).append('<option value="">[선택 ]</option>');
			} else {
				$("#"+sComBoId).append('<option value="">['+bSelectYn+']</option>');
			}
		}

		for(var i=0; i<returnData.rows.length; i++) {
			var rowData = returnData.rows[i];
			if (selectedVal != undefined && selectedVal == rowData.authId) {
				$("#"+sComBoId).append('<option value="'+ rowData.authId +'" selected>' + rowData.authNm + '</option>');
			} else {
				$("#"+sComBoId).append('<option value="'+ rowData.authId +'">' + rowData.authNm + '</option>');
			}
		}

		$("#"+sComBoId).attr("disabled", bDisabled == undefined ? false : bDisabled);

		if (changeCallback != undefined) {
			$("#"+sComBoId).on("change", function(event) {
				changeCallback(event);
			});
		}
	}, false);
}

function commonMakeMenuComboBox(sComBoId, bSelectYn, bDisabled, changeCallback, selectedVal) {
	var data = {
		sUseYn: "Y"
	};

	$("#"+sComBoId).empty();
	commonAjax(data , "/system/menu/selectMenuComboBox.do", function(returnData, textStatus, jqXHR) {
		if (bSelectYn == undefined ? false : bSelectYn) {
			if (typeof(bSelectYn) == "boolean") {
				$("#"+sComBoId).append('<option value="">[선택 ]</option>');
			} else {
				$("#"+sComBoId).append('<option value="">['+bSelectYn+']</option>');
			}
		}

		for(var i=0; i<returnData.rows.length; i++) {
			var rowData = returnData.rows[i];
			if (selectedVal != undefined && selectedVal == rowData.menuId) {
				$("#"+sComBoId).append('<option value="'+ rowData.menuId +'" selected>' + rowData.menuNm + '</option>');
			} else {
				$("#"+sComBoId).append('<option value="'+ rowData.menuId +'">' + rowData.menuNm + '</option>');
			}
		}

		$("#"+sComBoId).attr("disabled", bDisabled == undefined ? false : bDisabled);

		if (changeCallback != undefined) {
			$("#"+sComBoId).on("change", function(event) {
				changeCallback(event);
			});
		}
	}, false);
}

function commonMakeWebMenuComboBox(sComBoId, bSelectYn, bDisabled, changeCallback, selectedVal) {
	var data = {
		sUseYn: "Y"
	};

	$("#"+sComBoId).empty();
	commonAjax(data , "/system/webMenu/selectMenuComboBox.do", function(returnData, textStatus, jqXHR) {
		if (bSelectYn == undefined ? false : bSelectYn) {
			if (typeof(bSelectYn) == "boolean") {
				$("#"+sComBoId).append('<option value="">[선택 ]</option>');
			} else {
				$("#"+sComBoId).append('<option value="">['+bSelectYn+']</option>');
			}
		}

		for(var i=0; i<returnData.rows.length; i++) {
			var rowData = returnData.rows[i];
			if (selectedVal != undefined && selectedVal == rowData.menuId) {
				$("#"+sComBoId).append('<option value="'+ rowData.menuId +'" selected>' + rowData.menuNm + '</option>');
			} else {
				$("#"+sComBoId).append('<option value="'+ rowData.menuId +'">' + rowData.menuNm + '</option>');
			}
		}

		$("#"+sComBoId).attr("disabled", bDisabled == undefined ? false : bDisabled);

		if (changeCallback != undefined) {
			$("#"+sComBoId).on("change", function(event) {
				changeCallback(event);
			});
		}
	}, false);
}
