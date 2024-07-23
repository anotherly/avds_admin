'use strict';

//**************** common function ****************
$(function () {
    lnbMenu();
    famSite();
    $('html').fnInit();

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

function lnbMenu() {
    const $this = $(this),
        list = $('.lnb__list'),
        item = $('.lnb__item'),
        dep1Link = item.find('> a'),
        dep2Ul = item.find('> ul'),
        dep2Li = dep2Ul.find('li'),
        dep2Link = dep2Li.find('a');

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