module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = { fenced_code_blocks: true }
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    redcarpet.render(text).html_safe
  end

  def new_plan
    current_user.role == "free" ? "Premium" : "free"
  end

  def new_plan_description
    if current_user.role == "free"
      "Premium plan. Gives you the ability to create and collaborate on private wikis."
    else
      "Free plan. Can only create, view and edit publicly available wikis."
    end
  end

  def new_plan_button
    if current_user.role == "free"
      "Upgrade to Premium"
    else
      "Downgrade to Free"
    end
  end

  def disable_class(user, role)
    role == user.role ? "disabled" : ""
  end
end
