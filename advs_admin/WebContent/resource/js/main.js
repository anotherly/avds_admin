'use strict';

$(function(){
    $('.boxItem__reset').click(function(){
        $(this).addClass("fn-reset");
        setTimeout(function(){ 
            $(".boxItem__reset").removeClass("fn-reset"); 
        }, 400)
    })
})