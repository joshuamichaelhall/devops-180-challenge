require 'open3'

class GitManager
  def initialize
    @repo_root = find_repo_root
  end
  
  def commit_and_push(day)
    return false unless @repo_root
    
    Dir.chdir(@repo_root) do
      # Stage all changes
      run_command("git add -A")
      
      # Create commit message
      phase = DayTracker.current_phase
      phase_name = ChallengeConfig::PHASES[phase][:name]
      commit_message = "Day #{day}: #{phase_name} #{ChallengeConfig::SOCIAL_HASHTAG}"
      
      # Commit
      success = run_command("git commit -m \"#{commit_message}\"")
      return false unless success
      
      # Push to remote
      run_command("git push origin main") || run_command("git push origin master")
    end
  end
  
  def status
    return unless @repo_root
    
    Dir.chdir(@repo_root) do
      system("git status")
    end
  end
  
  def current_streak
    return 0 unless @repo_root
    
    Dir.chdir(@repo_root) do
      # Get commit dates for the last 180 days
      output, _ = Open3.capture2("git log --format='%ad' --date=short --since='180 days ago'")
      dates = output.split("\n").map { |d| Date.parse(d) rescue nil }.compact
      
      # Calculate streak
      streak = 0
      current_date = Date.today
      
      while dates.include?(current_date) || dates.include?(current_date - 1)
        streak += 1
        current_date -= 1
      end
      
      streak
    end
  end
  
  private
  
  def find_repo_root
    current = Dir.pwd
    
    while current != "/"
      return current if Dir.exist?(File.join(current, ".git"))
      current = File.dirname(current)
    end
    
    nil
  end
  
  def run_command(cmd)
    output, status = Open3.capture2e(cmd)
    
    if status.success?
      true
    else
      puts "Git command failed: #{cmd}"
      puts output
      false
    end
  end
end