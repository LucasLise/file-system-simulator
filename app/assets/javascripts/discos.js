$(document).on("turbolinks:load", function(){
  var button_informacoes = $("#button-informacoes")
  var informacoes = $("#informacoes")

  button_informacoes.click(function(){
     if(informacoes.is(':visible')){
       button_informacoes.find("i").removeClass('glyphicon glyphicon-chevron-up').addClass('glyphicon glyphicon-chevron-down');
     }else{
       button_informacoes.find("i").removeClass('glyphicon glyphicon-chevron-down').addClass('glyphicon glyphicon-chevron-up');
     }
     informacoes.slideToggle('slow');
  });

  $(".alert").fadeTo(2000, 500).slideUp(1000, function(){
      $(".alert").slideUp(1000);
  });

  if ($('.section').length) {
    $('.alternador').click(function(){
      $.scrollify.next();
    });
    $.scrollify({});
  } else {
    $.scrollify.destroy();
  }

  $("#btn-voltar-table").click(function(){
    $.scrollify.move("#3");
  });
});
