require_relative 'challenge_config'
require_relative 'day_tracker'
require_relative 'git_manager'
require_relative 'challenge_logger'
require_relative 'weekly_integration'

class ChallengeManager
  def run(args)
    command = args[0] || 'help'
    
    case command
    when 'start'
      start_day
    when 'log'
      log_progress
    when 'push'
      push_progress
    when 'status'
      show_status
    when 'cert'
      track_certification
    when 'project'
      manage_project(args[1])
    when 'resource'
      show_resources(args[1])
    when 'help'
      show_help
    when 'week'
      show_weekly_plan
    when 'sync'
      sync_weekly_plans
    else
      puts "Unknown command: #{command}"
      show_help
    end
  end
  
  private
  
  def start_day
    day = DayTracker.current_day
    phase = DayTracker.current_phase
    phase_info = ChallengeConfig::PHASES[phase]
    
    puts "🚀 Starting Day #{day} of the DevOps 180 Challenge!"
    puts "📚 Phase #{phase}: #{phase_info[:name]}"
    puts "🎯 Focus: #{phase_info[:focus].join(', ')}"
    puts ""
    
    logger = ChallengeLogger.new
    logger.create_daily_log(day, phase)
    
    puts "✅ Daily log created at: #{logger.daily_log_path(day)}"
    puts "📝 Open your editor and start documenting your learning!"
    puts ""
    puts "When done, run: devops log"
  end
  
  def log_progress
    day = DayTracker.current_day
    logger = ChallengeLogger.new
    
    if logger.update_weekly_summary(day)
      puts "✅ Progress logged for Day #{day}"
      puts "📊 Weekly summary updated"
      puts ""
      puts "Ready to commit? Run: devops push"
    else
      puts "❌ No daily log found for Day #{day}"
      puts "Run 'devops start' first!"
    end
  end
  
  def push_progress
    day = DayTracker.current_day
    git = GitManager.new
    
    puts "📤 Pushing Day #{day} progress..."
    
    if git.commit_and_push(day)
      DayTracker.increment!
      new_day = DayTracker.current_day
      
      puts "✅ Day #{day} completed and pushed!"
      puts "🎉 Ready for Day #{new_day} tomorrow!"
      puts ""
      puts "Share your progress: #DevOps180 Day #{day} ✅"
    else
      puts "❌ Failed to push progress. Check git status."
    end
  end
  
  def show_status
    day = DayTracker.current_day
    phase = DayTracker.current_phase
    phase_day = DayTracker.phase_day
    phase_info = ChallengeConfig::PHASES[phase]
    
    progress_percentage = (day.to_f / ChallengeConfig::CHALLENGE_DAYS * 100).round(1)
    
    puts "📊 DevOps 180 Challenge Status"
    puts "=" * 40
    puts "📅 Overall Progress: Day #{day} of #{ChallengeConfig::CHALLENGE_DAYS} (#{progress_percentage}%)"
    puts "📚 Current Phase: #{phase} - #{phase_info[:name]}"
    puts "📆 Phase Progress: Day #{phase_day} of #{phase_info[:days]}"
    puts "🎯 Target Certification: #{phase_info[:certification]}"
    puts "=" * 40
    
    # Show progress bar
    completed = "█" * (progress_percentage / 5).to_i
    remaining = "░" * (20 - (progress_percentage / 5).to_i)
    puts "Progress: [#{completed}#{remaining}] #{progress_percentage}%"
  end
  
  def track_certification
    puts "🎓 Certification Tracking"
    puts "=" * 40
    
    ChallengeConfig::PHASES.each do |num, phase|
      cert_file = "progress/certifications/#{phase[:certification].downcase.gsub(/\s+/, '_')}.md"
      status = File.exist?(cert_file) ? "✅ Completed" : "⏳ In Progress"
      puts "Phase #{num}: #{phase[:certification]} - #{status}"
    end
  end
  
  def manage_project(action)
    puts "🏗️  Project Management"
    puts "Available projects:"
    puts "- aws-multi-account"
    puts "- security-automation"
    puts "- terraform-modules"
  end
  
  def show_resources(topic)
    puts "📚 Learning Resources"
    if topic
      puts "Resources for: #{topic}"
    else
      puts "Topics: aws, linux, security, terraform, docker, kubernetes"
    end
  end
  
  def show_help
    puts <<~HELP
      DevOps 180 Challenge CLI
      
      Commands:
        devops start      - Start a new day
        devops log        - Log your progress
        devops push       - Commit and push your progress
        devops status     - Show challenge status
        devops cert       - Track certification progress
        devops project    - Manage projects
        devops resource   - Access learning resources
        devops week       - Show current week's plan from career-tracker
        devops sync       - Sync weekly plans from career-tracker
        devops help       - Show this help message
      
      Learn more: https://github.com/joshuamichaelhall/devops-180-challenge
    HELP
  end
  
  def show_weekly_plan
    day = DayTracker.current_day
    integration = WeeklyIntegration.new(day)
    week = ((day - 1) / 7) + 1
    
    puts "📋 Week #{week} Plan (Day #{day}/180)"
    puts "=" * 50
    
    objectives = integration.get_week_objectives
    if objectives.any?
      puts "🎯 Week Objectives:"
      objectives.each { |obj| puts "  • #{obj}" }
      puts ""
    end
    
    focus = integration.get_daily_focus
    if focus
      puts "📍 Today's Focus:"
      puts "  Learning: #{focus[:learning_focus]}" if focus[:learning_focus]
      puts "  Project: #{focus[:project_milestone]}" if focus[:project_milestone]
      puts "  Network: #{focus[:networking_targets]}" if focus[:networking_targets]
      puts "  Content: #{focus[:content_tasks]}" if focus[:content_tasks]
    else
      puts "No weekly plan found for week #{week}."
      puts "Run 'devops sync' to sync plans from career-tracker."
    end
    
    puts ""
    puts "📂 Full plan: ~/repos/devops-career-tracker/weekly/week-#{week}-checklist.md"
  end
  
  def sync_weekly_plans
    puts "🔄 Syncing weekly plans from career-tracker..."
    
    sync_script = File.join(File.dirname(__FILE__), '..', 'sync', 'sync-weekly-plans.rb')
    if File.exist?(sync_script)
      system("ruby #{sync_script}")
    else
      puts "❌ Sync script not found. Creating it now..."
      # Would create the sync script here
    end
  end
end