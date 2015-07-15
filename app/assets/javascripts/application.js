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


