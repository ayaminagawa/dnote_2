$(function(){
  //トップページのカテゴリー表示トグルボタン
  $('#category-dropdown-switch').click(function(){
    $('#category-dropdown-box').toggle();
    return false;
  });

  $('#close-category').click(function(){
    $('#category-dropdown-box').hide();
  });

  //ログインのモーダル表示
  $('.header-top__menu__item--login').click(function(){
    $('.signup-modal').show();
  });

  $('#close-modal').click(function(){
    $('.signup-modal').hide();
  });


  //サイドバー表示ボタン
  $("body").mobile_menu({
    menu: ['#main-nav #slidemenu_contents' ], //オフキャンバスに含めるobj
    menu_width: 250,  //メニューの横幅
    prepend_button_to: '.sp-header-top__menu__sidebar'  //トリガーになるobjを指定
  });


  //マイページ、カテゴリーページのタブの切り替え
  $('.step-list').click(function(){
    $index = $(this).index();
    $('.step-list').removeClass('active');
    $(this).addClass('active');
    $('.main').removeClass('active');
    $('.main').eq($index).addClass('active');
  });
});