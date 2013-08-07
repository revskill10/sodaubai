# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('#pjax-container').on 'pjax:popstate', (event) ->  
  if (event.direction == "back" or event.direction == "forward")
    oTable.fnClearTable if oTable	  
    $('.redactor').redactor({wym: true});
  

  

$('#pjax-container').on 'pjax:success', () ->     
  oTable = $('.datatable').dataTable({"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>","sPaginationType": "bootstrap","bRetrieve": true,"iDisplayLength": 25, "bDestroy":true,"bInfo":false,"bProcessing":true,"bStateSave":true,"bAutoWidth":true,"sScrollY": "300px"});  
  $('.redactor').redactor({wym: true});
	
  
    


  