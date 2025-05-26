require_relative 'challenge_config'
require_relative 'day_tracker'
require_relative 'git_manager'
require_relative 'challenge_logger'

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
        devops help       - Show this help message
      
      Learn more: https://github.com/joshuamichaelhall/devops-180-challenge
    HELP
  end
end