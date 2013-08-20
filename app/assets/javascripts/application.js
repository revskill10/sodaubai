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
//=require bootstrap-all
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require redactor.min
//= require bootstrap-combobox
//= require best_in_place
//= require quanly
//= require bootstrap-datetimepicker

$(document).ready(function(){
	$('.datatable').dataTable({"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>","sPaginationType": "bootstrap","bStateSave":true,"bAutoWidth":true,"sScrollY": "300px"});			
	$('.combobox').combobox();	
	$('.best_in_place').best_in_place();	
	$('.redactor').redactor();

    $('#datetimepicker1').datetimepicker({
  	pickSeconds: false,
  	startDate: new Date(2013, 8, 12),
    endDate: new Date(2014, 8, 12)
  });
});  
