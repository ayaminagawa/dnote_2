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
    prepend_button_to: '.sp-header-top__menu__sidebar'  //トリガーになるobjを指定
  });

});