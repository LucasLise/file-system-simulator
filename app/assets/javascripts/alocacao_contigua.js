$(document).on("turbolinks:load", function(){
  var grafico = $("#grafico-disco");
  var tabela = $("#tabela-disco");

  tabela.hide();

  $("#vizualizacao").change(function(){
    var valor =   $("#vizualizacao").val();

     if(grafico.is(':visible')){
       grafico.hide();
       tabela.show();
     }else{
       tabela.hide();
       grafico.show();
     }
  });

});
