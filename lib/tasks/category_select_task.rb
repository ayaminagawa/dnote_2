# 使用するモデルファイル(test)を読み込む
require "#{Rails.root}/app/models/category_select"

class Tasks::CategorySelectTask
  def self.execute
    category_selects = CategorySelect.all
    category_selects.each do |category_select|

      if category_select.category_number2 == 1
        new_category_select = CategorySelect.new
        recipe = category_select.recipe_id
        menu = category_select.menu_id
        new_category_select.update(category: "2", recipe_id: recipe, menu_id: menu)
        new_category_select.save
      end

      if category_select.category_number3 == 1
        new_category_select = CategorySelect.new
        recipe = category_select.recipe_id
        menu = category_select.menu_id
        new_category_select.update(category: "3", recipe_id: recipe, menu_id: menu)
        new_category_select.save
      end

      if category_select.category_number4 == 1
        new_category_select = CategorySelect.new
        recipe = category_select.recipe_id
        menu = category_select.menu_id
        new_category_select.update(category: "4", recipe_id: recipe, menu_id: menu)
        new_category_select.save
      end

      if category_select.category_number5 == 1
        new_category_select = CategorySelect.new
        recipe = category_select.recipe_id
        menu = category_select.menu_id
        new_category_select.update(category: "5", recipe_id: recipe, menu_id: menu)
        new_category_select.save
      end

      if category_select.category_number6 == 1
        new_category_select = CategorySelect.new
        recipe = category_select.recipe_id
        menu = category_select.menu_id
        new_category_select.update(category: "6", recipe_id: recipe, menu_id: menu)
        new_category_select.save
      end

        category_select.delete
    
    end
  end
end