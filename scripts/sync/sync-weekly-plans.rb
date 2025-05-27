#!/usr/bin/env ruby
# sync-weekly-plans.rb
# Syncs weekly plans from devops-career-tracker to devops-180-challenge

require 'fileutils'
require 'yaml'

class WeeklyPlanSync
  TRACKER_PATH = File.expand_path("~/repos/devops-career-tracker")
  CHALLENGE_PATH = File.expand_path("~/repos/devops-180-challenge")
  
  def initialize
    @phase_mapping = {
      1 => { weeks: 1..24, days: 1..168 },     # 24 weeks = 168 days
      2 => { weeks: 25..48, days: 169..336 },  # 24 weeks = 168 days  
      3 => { weeks: 49..72, days: 337..504 },  # 24 weeks = 168 days
      # Note: 180 days only covers part of Phase 2
    }
  end
  
  def sync_weekly_plans
    puts "🔄 Syncing weekly plans from career-tracker to 180-challenge..."
    
    # Create weekly-plans directory if it doesn't exist
    weekly_plans_dir = File.join(CHALLENGE_PATH, "weekly-plans")
    FileUtils.mkdir_p(weekly_plans_dir)
    
    # Sync existing weekly checklists
    sync_existing_checklists(weekly_plans_dir)
    
    # Create phase mapping file
    create_phase_mapping(weekly_plans_dir)
    
    # Update README with integration info
    update_readme_integration
    
    puts "✅ Weekly plan sync complete!"
  end
  
  private
  
  def sync_existing_checklists(target_dir)
    # Copy Phase 1 weekly checklists (weeks 1-24)
    source_weekly_dir = File.join(TRACKER_PATH, "weekly")
    
    Dir.glob(File.join(source_weekly_dir, "week-*-checklist.md")).each do |file|
      week_num = file.match(/week-(\d+)-checklist/)[1].to_i
      
      # Only sync weeks that fall within 180 days (up to week 26)
      if week_num <= 26
        FileUtils.cp(file, target_dir)
        puts "  📄 Copied week-#{week_num}-checklist.md"
      end
    end
  end
  
  def create_phase_mapping(target_dir)
    mapping = {
      "phase_1" => {
        "weeks" => "1-24",
        "days" => "1-168",
        "focus" => "AWS Fundamentals & Linux",
        "certifications" => ["AWS SAA", "Terraform Associate"],
        "source" => "devops-career-tracker/weekly/week-XX-checklist.md"
      },
      "phase_2_partial" => {
        "weeks" => "25-26", 
        "days" => "169-180",
        "focus" => "Beginning Professional Growth",
        "certifications" => ["AWS DevOps Professional (prep)"],
        "source" => "devops-career-tracker/weekly/phase-prompts/phase-2-prompt.md"
      },
      "integration" => {
        "career_tracker_path" => TRACKER_PATH,
        "sync_script" => "scripts/sync/sync-weekly-plans.rb",
        "last_sync" => Time.now.strftime("%Y-%m-%d %H:%M:%S")
      }
    }
    
    File.write(File.join(target_dir, "phase-mapping.yml"), mapping.to_yaml)
    puts "  📊 Created phase-mapping.yml"
  end
  
  def update_readme_integration
    readme_path = File.join(CHALLENGE_PATH, "README.md")
    readme_content = File.read(readme_path)
    
    integration_section = <<~INTEGRATION
    
    ## 📋 Weekly Plan Integration
    
    This challenge integrates with the comprehensive weekly plans from devops-career-tracker:
    
    - **Weekly Plans**: Detailed checklists for each week covering learning, projects, networking, and career development
    - **Source**: Weekly plans are maintained in `devops-career-tracker` and synced here
    - **Sync Command**: `ruby scripts/sync/sync-weekly-plans.rb`
    
    ### Using Weekly Plans
    
    1. **View your current week's plan**:
       ```bash
       cat weekly-plans/week-$(( ($(devops day) - 1) / 7 + 1 ))-checklist.md
       ```
    
    2. **Track daily progress against weekly goals**:
       - Use `devops log` to track daily activities
       - Reference weekly checklist for comprehensive tasks
       - Update GitHub issues in career-tracker for detailed tracking
    
    3. **Phase Alignment**:
       - Days 1-168 (Weeks 1-24): Phase 1 - Foundation Building
       - Days 169-180 (Weeks 25-26): Phase 2 - Professional Growth (partial)
    
    INTEGRATION
    
    # Insert before the Projects section
    insertion_point = readme_content.index("## 🏗️ Projects")
    
    if insertion_point && !readme_content.include?("Weekly Plan Integration")
      updated_content = readme_content.insert(insertion_point, integration_section)
      File.write(readme_path, updated_content)
      puts "  📝 Updated README.md with integration info"
    end
  end
end

# Run the sync
if __FILE__ == $0
  syncer = WeeklyPlanSync.new
  syncer.sync_weekly_plans
end