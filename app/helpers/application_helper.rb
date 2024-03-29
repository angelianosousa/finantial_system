module ApplicationHelper
  def badge_pill(content = nil, html_options = {})
    tag.span(class: "badge badge-pill #{html_options[:class]}", style: "font-size: 11px; #{html_options[:style]}") do
      content
    end
  end

  def fontawesome_icon(text, icon_class)
    tag.i("#{text}", class: "#{icon_class}")
  end

  def modal_to_new_resource(text, target: '', width: '270px')
    link_to '#', class: "btn btn-outline-light btn-sm my-sm-3", "data-toggle":"modal", "data-target":"#{target}", style:"width:#{width}" do
      "#{fontawesome_icon(text, 'fa fa-plus-square')}".html_safe
    end
  end

  def modal_to_pay_resource(text, target: '', width: '270px')
    link_to '#', class: "btn-sm", "data-toggle":"modal", "data-target":"#{target}", style:"width:#{width}" do
      "#{fontawesome_icon(text, 'fa fa-money')}".html_safe
    end
  end

  def link_to_show_resource(text, link)
    link_to link, class: 'btn-sm' do
      "#{fontawesome_icon(text, 'fa fa-eye')}".html_safe
    end
  end

  def link_to_edit_resource(text, link)
    link_to link, class: 'btn-sm', style:'border-radius:10px;' do
      "#{fontawesome_icon(text, 'fa fa-pencil')}".html_safe
    end
  end

  def link_to_delete_resource(text, link)
    link_to link, class: 'btn-sm', style:'border-radius: 10px;', method: :delete, data: { confirm: 'Tem certeza disso ?'} do
      "#{fontawesome_icon(text, 'fa fa-trash')}".html_safe
    end
  end
end
