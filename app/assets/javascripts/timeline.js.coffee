# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@Timeline = 
	load: (game) -> 
		ajax = $.getJSON(game+"/timeline/feed.json", (data) ->  
			console.log("Updating")
			$('#timeline').html("<h2>Recently Solved Challenges</h2>")
			for i in data
				$('#timeline').append('<li>'+i.email+' solved ' + i.name + '</li>')
			)
	