// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require moment
//= require bootstrap-datetimepicker

//= require_tree .


$(function(){
    if(localStorage.getItem('i18n') == undefined || localStorage.getItem('i18n') == 'vi'){
        i18nJs = i18nJs.vi;
    }else{
        i18nJs = i18nJs.en;
    }
    //set layout
    if(localStorage.getItem('global_layout') == undefined){
        localStorage.setItem('global_layout', "fixed");
    }
    $('#layout-' + localStorage.getItem('global_layout')).prop('checked', true)
    change_layout(localStorage.getItem('global_layout'));

})

function setLaguage(val){
    localStorage.setItem('i18n', val);
}

function goBack() {
    window.history.back();
}
