# weekly_integration.rb
# Integrates weekly plans from career-tracker into daily logging

class WeeklyIntegration
  def initialize(current_day)
    @current_day = current_day
    @current_week = ((current_day - 1) / 7) + 1
    @weekly_plan_path = File.join(
      File.expand_path("~/repos/devops-180-challenge/weekly-plans"),
      "week-#{@current_week}-checklist.md"
    )
  end
  
  def get_daily_focus
    return nil unless File.exist?(@weekly_plan_path)
    
    # Extract key daily tasks from weekly plan
    content = File.read(@weekly_plan_path)
    
    # Find the daily schedule section
    if match = content.match(/## 📅 Daily Schedule(.*?)## /m)
      daily_section = match[1]
      
      # Return relevant daily focus items
      {
        learning_focus: extract_learning_focus(content),
        project_milestone: extract_project_milestone(content),
        networking_targets: extract_networking_targets(content),
        content_tasks: extract_content_tasks(content)
      }
    else
      nil
    end
  end
  
  def get_week_objectives
    return [] unless File.exist?(@weekly_plan_path)
    
    content = File.read(@weekly_plan_path)
    
    # Extract week objectives
    if match = content.match(/## 🎯 Week \d+ Objectives(.*?)## /m)
      objectives = match[1].scan(/^- (.+)$/).flatten
      objectives.map(&:strip)
    else
      []
    end
  end
  
  def generate_daily_template
    focus = get_daily_focus
    objectives = get_week_objectives
    
    template = []
    template << "## 📋 Weekly Plan Reference"
    template << "**Week #{@current_week} - Day #{@current_day}**"
    template << ""
    
    if objectives.any?
      template << "### Week Objectives:"
      objectives.each { |obj| template << "- #{obj}" }
      template << ""
    end
    
    if focus
      template << "### Today's Focus Areas:"
      template << "- **Learning**: #{focus[:learning_focus]}" if focus[:learning_focus]
      template << "- **Project**: #{focus[:project_milestone]}" if focus[:project_milestone]
      template << "- **Networking**: #{focus[:networking_targets]}" if focus[:networking_targets]
      template << "- **Content**: #{focus[:content_tasks]}" if focus[:content_tasks]
      template << ""
    end
    
    template << "### Daily Progress:"
    template << "- [ ] Morning: Review weekly checklist in career-tracker"
    template << "- [ ] Learning: Complete planned study sessions"
    template << "- [ ] Project: Make progress on weekly milestone"
    template << "- [ ] Networking: Complete daily outreach"
    template << "- [ ] Evening: Update career-tracker with progress"
    template << ""
    
    template.join("\n")
  end
  
  private
  
  def extract_learning_focus(content)
    if match = content.match(/### AWS Foundation.*?- \[ \] (.+?) \(\d+ hours?\)/m)
      match[1]
    end
  end
  
  def extract_project_milestone(content)
    if match = content.match(/### Financial Services.*?\*\*Week \d+ Milestone\*\*: (.+?)$/m)
      match[1]
    end
  end
  
  def extract_networking_targets(content)
    day_name = Date.today.strftime("%A")
    if match = content.match(/- \[ \] \*\*#{day_name}\*\*: (.+?)$/m)
      match[1]
    end
  end
  
  def extract_content_tasks(content)
    day_name = Date.today.strftime("%A")
    if match = content.match(/### LinkedIn Posting.*?- \[ \] \*\*#{day_name} Post\*\*: (.+?)$/m)
      match[1]
    end
  end
end