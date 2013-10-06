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

  def enrollment_actions_for(user, campaign)
    enrollment = user.enrollments.find_by_campaign_id(campaign.id)
    user_needs_approval = !user.authorized_for?(campaign) && can?(:update, Enrollment)
    destroy_label = user_needs_approval ? "Decline" : "Unsubscribe"

    html = ''
    html += enrollment_approval_form(enrollment) if user_needs_approval
    html += enrollment_removal_form(enrollment, destroy_label) if can? :destroy, Enrollment
    content_tag(:span, raw(html))
  end

  def enrollment_approval_form(enrollment)
    url = enrollment_authorization_path(enrollment)
    options = { url: url, html: { class: "form-inline", method: :put } }
    simple_form_for enrollment, options do |f|
      f.input :id, :as => :hidden, :input_html => { :value => enrollment.id }
      f.submit "Accept", class: "btn"
    end
  end

  def enrollment_removal_form(enrollment, button_label)
    simple_form_for enrollment, :html => { :class => "form-inline", :method => :delete } do |f|
      f.input :id, :as => :hidden, :input_html => { :value => enrollment.id }
      f.submit button_label, class: "btn"
    end
  end

end
