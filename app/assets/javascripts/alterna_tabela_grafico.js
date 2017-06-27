$(document).on("turbolinks:load", function(){
  var grafico = $("#grafico-disco");
  var tabela = $("#tabela-disco");

  $("#visualizacao").change(function(){
     var current_value = $("#visualizacao").val();

     if(current_value == "grafico"){
       grafico.show();
       tabela.hide();
     }else{
       grafico.hide();
       tabela.show();
     }
  });

});
