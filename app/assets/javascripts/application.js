// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require_directory ./project
//= require jquery_ujs
//= require_tree .

//プレビュー画像を表示
$(function(){
  var setFileInput = $('.imgInput'),
  setFileImg = $('.imgView');
  
  setFileInput.each(function(){
    var selfFile = $(this),
    selfInput = $(this).find('input[type=file]'),
    prevElm = selfFile.find(setFileImg),
    orgPass = prevElm.attr('src');
    
    selfInput.change(function(){
      var file = $(this).prop('files')[0],
      fileRdr = new FileReader();
      
      if (!this.files.length){
        prevElm.attr('src', orgPass);
        return;
      } else {
        if (!file.type.match('image.*')){
          prevElm.attr('src', orgPass);
          return;
        } else {
          fileRdr.onload = function() {
            prevElm.attr('src', fileRdr.result);
          }
          fileRdr.readAsDataURL(file);
        }
      }
    });
  });
});


//材料、作り方のフォームの追加、削除
function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").remove();
}

function add_fields(link, association, content) {
  $fields = $("." + association).find(".fields")
  // console.log($fields.filter(":last").find(".step-count").text());
  var new_id = $fields[0] ? $fields.filter(":last").find(".step-count").text() : new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
  // $(link).parents("." + association).find(".step-count").text(new_id + 1);
}


//エンターキーでsubmitされないように
$(function() {
  $(document).on("keypress", "input:not(.allow_submit)", function(event) {
    return event.which !== 13;
  });
});


//エンターキーで改行できるように
$(function() {
  $(document).on("keypress", "input:text", function (e) {
  // $("input:text").keypress(function(e) {
    if (e.which == 13) { // Enterキーの場合
      // input type="text"の配列を作成
      var textArry = $("input:text");
      for (var i = 0 ; i < textArry.length ; ++i) {


        // Enterキーが押されたテキストボックスだった場合
        if (this == textArry[i]) {

          var tab_index = 0; //テキストボックス配列のインデックス
          // イベントが起きたテキストボックスが配列の最後以外の場合
          if (i + 1 != textArry.length) {
            tab_index = i + 1; // インデックスをプラス1する
          }

          // フォーカスを移動
          textArry[tab_index].focus();
          return;
        }
      }
    }
  });


//カウントダウンしてくれる
$(function(){
        var countMax = 60;
        $('textarea').bind('keydown keyup keypress change',function(){
            var thisValueLength = $(this).val().length;
            var countDown = (countMax)-(thisValueLength);
            $('.count').html(countDown);
     
            if(countDown < 0){
                $('.count').css({color:'#ff0000',fontWeight:'bold'});
            } else {
                $('.count').css({color:'#000000',fontWeight:'normal'});
            }
        });
        $(window).load(function(){
            $('.count').html(countMax);
        });
    });
});


