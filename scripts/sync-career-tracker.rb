#!/usr/bin/env ruby
# Sync weekly plans from devops-career-tracker to devops-180-challenge

require 'fileutils'
require 'date'

CAREER_TRACKER_PATH = File.expand_path("~/repos/devops-career-tracker")
CHALLENGE_PATH = File.expand_path("~/repos/devops-180-challenge")

def sync_weekly_plans
  puts "Syncing weekly plans from career-tracker..."
  
  # Map career-tracker weeks to 180-challenge days
  # Week 1-24 = Days 1-168 (Phase 1)
  # Week 25-26 = Days 169-180 (Buffer/Review)
  
  (1..26).each do |week_num|
    career_week_file = "#{CAREER_TRACKER_PATH}/weekly/week-#{week_num.to_s.rjust(2, '0')}-checklist.md"
    
    if File.exist?(career_week_file)
      # Calculate day range for this week
      start_day = (week_num - 1) * 7 + 1
      end_day = week_num * 7
      
      # Create week directory in 180-challenge
      week_dir = "#{CHALLENGE_PATH}/phases/phase1_aws_fundamentals/weeks/week#{week_num}"
      FileUtils.mkdir_p(week_dir)
      
      # Copy and adapt the content
      content = File.read(career_week_file)
      
      # Create week plan for 180-challenge
      week_plan = <<~PLAN
      # Week #{week_num} Plan (Days #{start_day}-#{end_day})
      
      > Synced from devops-career-tracker
      
      #{content}
      
      ## Daily Focus Areas
      
      - **Day #{start_day}**: Setup and overview
      - **Day #{start_day + 1}**: Core concepts
      - **Day #{start_day + 2}**: Hands-on practice
      - **Day #{start_day + 3}**: Deep dive
      - **Day #{start_day + 4}**: Project work
      - **Day #{start_day + 5}**: Review and labs
      - **Day #{start_day + 6}**: Catch-up and planning
      PLAN
      
      File.write("#{week_dir}/plan.md", week_plan)
      puts "✓ Synced Week #{week_num}"
    end
  end
  
  puts "\nSync complete! Weekly plans are now available in the 180-challenge structure."
end

def create_tracking_aliases
  puts "\nCreating convenient aliases..."
  
  aliases = <<~ALIASES
  
  # DevOps Challenge Workflow Aliases
  alias devops-plan='cd #{CAREER_TRACKER_PATH} && cat weekly/week-$(date +%U)-checklist.md'
  alias devops-sync='cd #{CHALLENGE_PATH} && ruby scripts/sync-career-tracker.rb'
  alias devops-today='devops log && devops-plan'
  ALIASES
  
  puts aliases
  puts "\nAdd these to your ~/.zshrc for quick access!"
end

# Main execution
if __FILE__ == $0
  sync_weekly_plans
  create_tracking_aliases
end