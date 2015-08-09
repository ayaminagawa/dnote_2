var standardCalorieData = {
  '1' : {
    '25' : {
      'A' : '2300',
      'B' : '2300',
      'C' : '2100',
      'D' : '1850'
    },
    '30' : {
      'A' : '2650',
      'B' : '2650',
      'C' : '2450',
      'D' : '2200' 
    },
    '35' : {
      'A' : '3050',
      'B' : '3050',
      'C' : '2800',
      'D' : '2500'   
    }
  },
  '2' : {
    '25' : {
      'A' : '1650',
      'B' : '1750',
      'C' : '1650',
      'D' : '1500'
    },
    '30' : {
      'A' : '1900',
      'B' : '2000',
      'C' : '1900',
      'D' : '1750'
    },
    '35' : {
      'A' : '2200',
      'B' : '2300',
      'C' : '2200',
      'D' : '2000' 
    }    
  }
}

function userAgeSelect(user_age){
  if (18 <= user_age && user_age <= 29) {
    userAgeSelect = 'A';
  }else
    if (30 <= user_age && user_age <= 49) {
      userAgeSelect = 'B';
    }else
      if(50 <= user_age && user_age <= 69){
        userAgeSelect = 'C';
      }else
        if(70 <= user_age){
          userAgeSelect = 'D';
        }
  return userAgeSelect;
}

$(function() {

  //現在の体重の表示
  $('#user_weight').on('blur',function(){
    var currentWeight = $(this).val();
    $('.user-current-weight').html(currentWeight + 'kg)');
  })


  //標準体重の算出
  $('#user_height').on('blur',function(){
    var textWrite = $(this).val();
    var standardWeight = textWrite * textWrite * 0.0022
    standardWeight = Math.round(standardWeight)
    $('.user-standard-weight').html(standardWeight + 'kg)');
  })


  //現在の体重を維持するためのカロリーの算出
  $('.active_level').click(function(){
    var currentWeight = $('#user_weight').val();
    var user_active = $('input[name="user[active_level]"]').filter(':checked').val();
    var currentCalorieDay = currentWeight * user_active;
    var currentCalorie = currentCalorieDay / 3;
    currentCalorie = Math.round(currentCalorie);
    currentCalorieDay = Math.round(currentCalorieDay);
    $('.user-question-2_1').html(currentCalorie);
    $('.user-question-2_2').html(currentCalorieDay);
  })


  //標準体重を目標としたカロリーの算出
  $('.active_level').click(function(){
    var user_sex = $('input[name="user[gender]"]').filter(':checked').val();
    var now = new Date();
    var now_year = now.getFullYear();
    var user_birth_year = $('select[name="user[birth_year]"] option:selected').val();
    var user_age = now_year - user_birth_year;
    var user_active = $('input[name="user[active_level]"]').filter(':checked').val();
    user_age_select = userAgeSelect(user_age);
    standardCalorieDay = standardCalorieData[user_sex][user_active][user_age_select]
    $('.user-question-2_4').html(standardCalorieDay)
    var standardCalorie = standardCalorieDay / 3
    standardCalorie = Math.round(standardCalorie)
    $('.user-question-2_3').html(standardCalorie)
  })

});