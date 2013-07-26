# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $( ".draggable" ).draggable()    
  $(".group").droppable
    drop: ( event, ui ) ->      
      $( "<tr><td></td></tr>" ).text( ui.draggable.find('td').first().text() ).appendTo( this )




$('#pjax-container').on 'pjax:popstate', (event) ->  
  if (event.direction == "back" or event.direction == "forward")
    $( ".draggable" ).draggable()
    $(".group").droppable
      drop: ( event, ui ) ->
        $( "<tr><td></td></tr>" ).text( ui.draggable.find('td').first().text() ).appendTo( this )

	  
$('#pjax-container').on 'pjax:success', () ->       
  $( ".draggable" ).draggable() 
  $(".group").droppable
    drop: ( event, ui ) ->
      $( "<tr><td></td></tr>" ).text( ui.draggable.find('td').first().text() ).appendTo( this )