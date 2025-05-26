require 'fileutils'

class DayTracker
  CONFIG_FILE = File.expand_path("~/.devops-180-current")
  BACKUP_FILE = File.expand_path("~/.devops-180-backup")
  
  def self.current_day
    return 1 unless File.exist?(CONFIG_FILE)
    day = File.read(CONFIG_FILE).to_i
    day > 0 ? day : 1
  end
  
  def self.increment!
    current = current_day
    if current >= ChallengeConfig::CHALLENGE_DAYS
      puts "🎉 Congratulations! You've completed the DevOps 180 Challenge!"
      return current
    end
    
    # Backup current state
    File.write(BACKUP_FILE, current)
    
    # Increment day
    new_day = current + 1
    File.write(CONFIG_FILE, new_day)
    new_day
  end
  
  def self.current_phase
    day = current_day
    ChallengeConfig::PHASES.each do |num, phase|
      return num if day >= phase[:start_day] && day <= phase[:end_day]
    end
    1 # Default to phase 1
  end
  
  def self.phase_day
    day = current_day
    phase = current_phase
    phase_info = ChallengeConfig::PHASES[phase]
    day - phase_info[:start_day] + 1
  end
  
  def self.days_remaining
    ChallengeConfig::CHALLENGE_DAYS - current_day
  end
  
  def self.phase_days_remaining
    phase = current_phase
    phase_info = ChallengeConfig::PHASES[phase]
    phase_info[:end_day] - current_day
  end
  
  def self.reset!
    File.delete(CONFIG_FILE) if File.exist?(CONFIG_FILE)
    File.delete(BACKUP_FILE) if File.exist?(BACKUP_FILE)
  end
  
  def self.restore_from_backup
    if File.exist?(BACKUP_FILE)
      backup_day = File.read(BACKUP_FILE).to_i
      File.write(CONFIG_FILE, backup_day)
      true
    else
      false
    end
  end
end