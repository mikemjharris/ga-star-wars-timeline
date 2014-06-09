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
//= require jquery.ui.all
//= require underscore
//= require_tree .

function prepare() {
  $('#randomize').on('click', function(ev) {
    ev.preventDefault();
    randomizeboxes();
  })
  gameGo();
  createSlider();
}


function gameGo() {
  $('#game_container').empty();
  var gamesize = $('#game_container').data("size")
  var $container = $('#game_container');
  var x = 0;
  var y = 0;
  var size = 640 / gamesize

  for (var i = 0; i < gamesize * gamesize ; i ++) {

    var template = _.template($('#tmpl_square').html(), {id: i, right: size * (i % gamesize), bottom: size * Math.floor(i / gamesize) });
    $container.append(template);
  }

  
  $(".box").each(function(i,el){ 
    el.setAttribute("style","width:" + size + "px; height: " + size + "px")
  });

  
  
}

function randomizeboxes () {
  var gamesize = $('#game_container').data("size")
  var collection = _.sample($(".box"), gamesize * gamesize)

  $('#game_container').empty();
  
  $.each(collection, function(i,el) {
      $('#game_container').append($(el))
  })

  $("#game_container").sortable({
      update: function (event, ui){ 
         checkSolution()
          }
        })
  }

  function createSlider() {
     $( "#slider" ).slider({
      range: "max",
      min: 2,
      max: 10,
      value: 2,
      slide: function( event, ui ) {
        $( "#amount" ).val( ui.value );
        $("#game_container").data("size", ui.value);
         
        gameGo();
      }
    });
      
    $( "#amount" ).val( $( "#slider" ).slider( "value" ) )
    $( "#game_container" ).data("size", $( "#slider" ).slider( "value" ) );
  }

function checkSolution() {
  var solution = 1
  var previousdata = 0
  $('.box').each(function(i,el) {
    console.log($(el).data('position'));
      if ($(el).data("position") < previousdata) {
        solution = 0;
      }
      previousdata = $(el).data("position") 
    }
    )

  if(solution == 1){
    alert("You won!");
    prepare();
  }

  }

 


$( window ).load(function() {
    prepare();
});
