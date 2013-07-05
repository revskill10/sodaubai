# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
//= require jquery.sticky

$('#pjax-container').on 'pjax:popstate', (event) ->  
  if (event.direction == "back" or event.direction == "forward")
	  oTable.fnClearTable if oTable	  
	  $('.datatable').hide();

	  

$('#pjax-container').on 'pjax:success', () ->     
  oTable = $('.datatable').dataTable({"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>","sPaginationType": "bootstrap","bRetrieve": true,"iDisplayLength": 25, "bDestroy":true,"bInfo":false,"bProcessing":true,"bStateSave":true,"bAutoWidth":true});
  $('.datatable').show();    
  $('.wysihtml5').each (i, elem) ->
    $(elem).wysiwyg()
  
    
  
  

$(document).ready ->
  $('.wysihtml5').each (i, elem) ->
    $(elem).wysihtml() 
  $(document).on 'submit', 'form', (event) ->
    $.pjax.submit(event, '#pjax-container')    
  


  