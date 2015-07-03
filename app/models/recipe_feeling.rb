class RecipeFeeling < ActiveRecord::Base
  belongs_to :recipe

  def self.feelings
    {
      1 => '小腹を満たしたいとき',
      2 => 'さっぱりしたものを食べたい',
      3 => '少しこってりしたものを食べたい',
      4 => '野菜多めなものが食べたい',
      5 => '女性ホルモンに良さそうなもの',
      6 => '胃腸にやさしいものが食べたい',
      7 => '体調が弱っている時に',
    }
  end
end
