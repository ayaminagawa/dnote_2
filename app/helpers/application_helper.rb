module ApplicationHelper

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association, options = {})
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render("fields_" + association.to_s.singularize, :f => builder)
    end
    link_to_function(name, raw("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), options)
  end

  #current_userの存在の確認
  def current_user?(user)
    user == current_user
  end

  def current_nutritionist?(nutritionist)
    nutritionist == current_nutritionist
  end

  # 改行文字を<br>に変換する
  def br(str)
    html_escape(str).gsub(/\r\n|\r|\n/, "<br />").html_safe
  end
end
