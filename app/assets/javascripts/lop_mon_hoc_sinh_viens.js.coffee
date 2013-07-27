# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $( ".draggable" ).draggable
    stop: ->
      $(this).html($(this).find('td').first())
      alert($(this).html())  
    

  $(".group").droppable
    drop: ( event, ui ) ->                
      $( "<tr class='draggable ui-draggable'></tr>" ).html( ui.draggable.html() ).appendTo( this );
      $( ".draggable" ).draggable()
      ui.draggable.remove()




$('#pjax-container').on 'pjax:popstate', (event) ->  
  if (event.direction == "back" or event.direction == "forward")
    $( ".draggable" ).draggable()
    $(".group").droppable
      drop: ( event, ui ) ->
        $( "<tr class='draggable'><td>" ).text( ui.draggable.find('td').first().text() ).append("</td></tr>").appendTo( this )
      $( ".draggable" ).draggable()

	  
$('#pjax-container').on 'pjax:success', () ->       
  $( ".draggable" ).draggable() 
  $(".group").droppable
    drop: ( event, ui ) ->
      $( "<tr class='draggable'><td>" ).text( ui.draggable.find('td').first().text() ).append("</td></tr>").appendTo( this )
      $( ".draggable" ).draggable()