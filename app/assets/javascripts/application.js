// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.pjax
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require redactor.min
//= require bootstrap-combobox
//= require best_in_place

$(document).ready(function(){
	$('.datatable').dataTable({"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>","sPaginationType": "bootstrap","bRetrieve": true,"iDisplayLength": 100, "bDestroy":true,"bInfo":false,"bProcessing":true,"bStateSave":true,"bAutoWidth":true,"sScrollY": "300px"});		
	$('.combobox').combobox();	
	$(document).pjax('a[data-pjax]', '#pjax-container');
	$('.best_in_place').best_in_place();	
	$('.redactor').redactor({wym: true});
});  


$('#pjax-container').on('pjax:popstate', function(event){	
	$('.datatable').dataTable({"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>","sPaginationType": "bootstrap","bRetrieve": true,"iDisplayLength": 100, "bDestroy":true,"bInfo":false,"bProcessing":true,"bStateSave":true,"bAutoWidth":true,"sScrollY": "300px"});		
	$('.combobox').combobox();	
	$(document).pjax('a[data-pjax]', '#pjax-container');
	$('.best_in_place').best_in_place();	
	$('.redactor').redactor({wym: true});
});
  

	  
$('#pjax-container').on('pjax:success', function(){	
	$('.datatable').dataTable({"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>","sPaginationType": "bootstrap","bRetrieve": true,"iDisplayLength": 100, "bDestroy":true,"bInfo":false,"bProcessing":true,"bStateSave":true,"bAutoWidth":true,"sScrollY": "300px"});		
	$('.combobox').combobox();	
	$(document).pjax('a[data-pjax]', '#pjax-container');
	$('.best_in_place').best_in_place();	
	$('.redactor').redactor({wym: true});
});