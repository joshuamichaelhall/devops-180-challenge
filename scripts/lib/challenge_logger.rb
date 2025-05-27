require 'date'
require 'fileutils'
require_relative 'weekly_integration'

class ChallengeLogger
  def initialize
    @repo_root = find_repo_root
    @progress_dir = File.join(@repo_root, 'progress')
  end
  
  def create_daily_log(day, phase)
    # Ensure directories exist
    daily_logs_dir = File.join(@progress_dir, 'daily-logs')
    FileUtils.mkdir_p(daily_logs_dir)
    
    # Create daily log from template
    template = read_template('daily_log.md')
    phase_info = ChallengeConfig::PHASES[phase]
    
    content = template
      .gsub('{{DAY}}', day.to_s)
      .gsub('{{DATE}}', Date.today.strftime('%Y-%m-%d'))
      .gsub('{{PHASE_NAME}}', phase_info[:name])
      .gsub('{{PHASE_NUMBER}}', phase.to_s)
      .gsub('{{FOCUS_AREA}}', phase_info[:focus].first)
    
    # Integrate weekly plan if available
    integration = WeeklyIntegration.new(day)
    weekly_content = integration.generate_daily_template
    
    # Insert weekly content after the focus area
    if weekly_content && !weekly_content.empty?
      insertion_point = content.index("## 📋 Today's Plan")
      if insertion_point
        content = content[0...insertion_point] + weekly_content + "\n" + content[insertion_point..-1]
      end
    end
    
    log_path = daily_log_path(day)
    File.write(log_path, content)
    
    # Open in default editor if available
    editor = ENV['EDITOR'] || 'nano'
    system("#{editor} #{log_path}")
  end
  
  def daily_log_path(day)
    File.join(@progress_dir, 'daily-logs', "day-#{day.to_s.rjust(3, '0')}.md")
  end
  
  def update_weekly_summary(day)
    log_path = daily_log_path(day)
    return false unless File.exist?(log_path)
    
    week = ((day - 1) / 7) + 1
    phase = DayTracker.current_phase
    
    weekly_dir = File.join(@progress_dir, 'weekly-summaries')
    FileUtils.mkdir_p(weekly_dir)
    
    summary_path = File.join(weekly_dir, "week-#{week.to_s.rjust(2, '0')}.md")
    
    # Create or update weekly summary
    if File.exist?(summary_path)
      update_existing_summary(summary_path, day)
    else
      create_new_summary(summary_path, week, phase)
    end
    
    true
  end
  
  def get_daily_log_summary(day)
    log_path = daily_log_path(day)
    return nil unless File.exist?(log_path)
    
    content = File.read(log_path)
    
    # Extract key sections
    accomplished = extract_section(content, "What I Accomplished", "Resources Used")
    challenges = extract_section(content, "Challenges Faced", "Key Insights")
    
    "### Day #{day}\n#{accomplished}\n#{challenges}\n"
  end
  
  private
  
  def find_repo_root
    current = Dir.pwd
    
    while current != "/"
      return current if Dir.exist?(File.join(current, ".git"))
      current = File.dirname(current)
    end
    
    Dir.pwd
  end
  
  def read_template(template_name)
    template_path = File.join(@repo_root, 'scripts', 'templates', template_name)
    
    if File.exist?(template_path)
      File.read(template_path)
    else
      default_daily_template
    end
  end
  
  def default_daily_template
    <<~TEMPLATE
      # Day {{DAY}} - {{PHASE_NAME}}
      
      **Date**: {{DATE}}  
      **Phase**: {{PHASE_NUMBER}} of 3  
      **Focus Area**: {{FOCUS_AREA}}
      
      ## 📋 Today's Plan
      - [ ] Morning Learning (1 hour): 
      - [ ] Hands-on Practice (1.5 hours): 
      - [ ] Documentation (30 min): 
      
      ## 🎯 What I Accomplished
      ### Technical Skills
      - 
      
      ### Hands-on Work
      - 
      
      ### Knowledge Gained
      - 
      
      ## 🔗 Resources Used
      - 
      
      ## 🚧 Challenges Faced
      - 
      
      ## 💡 Key Insights
      - 
      
      ## 📊 Skill Progress
      - **AWS**: ⬜⬜⬜⬜⬜ (0/5)
      - **Linux**: ⬜⬜⬜⬜⬜ (0/5)
      - **Security**: ⬜⬜⬜⬜⬜ (0/5)
      - **IaC**: ⬜⬜⬜⬜⬜ (0/5)
      - **CI/CD**: ⬜⬜⬜⬜⬜ (0/5)
      
      ## 🔜 Tomorrow's Focus
      - 
      
      ## 💭 Reflections
      
    TEMPLATE
  end
  
  def create_new_summary(path, week, phase)
    phase_info = ChallengeConfig::PHASES[phase]
    
    content = <<~SUMMARY
      # Week #{week} Summary
      
      **Phase**: #{phase} - #{phase_info[:name]}  
      **Dates**: #{Date.today.strftime('%Y-%m-%d')} - TBD
      
      ## 📊 Week Overview
      
      ### Goals for This Week
      - 
      - 
      - 
      
      ## 📝 Daily Progress
      
      #{get_week_daily_logs(week)}
      
      ## 🎯 Week Accomplishments
      - 
      
      ## 🚧 Challenges Overcome
      - 
      
      ## 📚 Resources Discovered
      - 
      
      ## 🔜 Next Week's Focus
      - 
    SUMMARY
    
    File.write(path, content)
  end
  
  def update_existing_summary(path, day)
    # This would be more complex in a real implementation
    # For now, just append a note
    content = File.read(path)
    content += "\nUpdated with Day #{day} progress.\n"
    File.write(path, content)
  end
  
  def get_week_daily_logs(week)
    start_day = (week - 1) * 7 + 1
    end_day = [week * 7, DayTracker.current_day].min
    
    logs = []
    (start_day..end_day).each do |day|
      summary = get_daily_log_summary(day)
      logs << summary if summary
    end
    
    logs.join("\n")
  end
  
  def extract_section(content, start_marker, end_marker)
    start_index = content.index(start_marker)
    end_index = content.index(end_marker)
    
    return "" unless start_index && end_index
    
    content[start_index..end_index-1].strip
  end
end