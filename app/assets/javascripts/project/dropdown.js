$(function(){
  //トップページのカテゴリー表示トグルボタン
  $('#category-dropdown-switch').click(function(){
    $('#category-dropdown-box').toggle();
    return false;
  });

  //サイドバー表示ボタン
  $("body").mobile_menu({
    menu: ['#main-nav #slidemenu_contents' ], //オフキャンバスに含めるobj
    menu_width: 250,  //メニューの横幅
    prepend_button_to: '#menu-btn',  //トリガーになるobjを指定
    button_content:'<i class="icon-bars"></i><br>メニュー' 
  });
});