module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def selectable_roles
    Role.find(:all, :conditions => ["name != ?", :admin])
  end

  def set_title(title)
    provide(:title, title)
  end

  def enrollment_status_label(user, campaign)
    authorized = user.authorized_for?(campaign)
    klass, message = authorized ? ['success', 'approved'] : ['warning', 'waiting for approval']
    content_tag :span, class: "label label-#{klass}" do
      message
    end
  end

end
