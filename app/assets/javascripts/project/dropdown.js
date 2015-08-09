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


  //マイページ、カテゴリーページのタブの切り替え
  $('.step-list').click(function(){
    $index = $(this).index();
    $('.step-list').removeClass('active');
    $(this).addClass('active');
    $('.main').removeClass('active');
    $('.main').eq($index).addClass('active');
  });

  //モバイル版タブの切り替え
  $('.mobile-step-list').click(function(){
    $index = $(this).index();
    $('.mobile-step-list').removeClass('active');
    $(this).addClass('active');
    $('.mobile-main').removeClass('active');
    $('.mobile-main').eq($index).addClass('active');
  });
});

