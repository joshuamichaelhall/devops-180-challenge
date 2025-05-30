# Weekly Plans Integration

This directory contains weekly plans synced from the devops-career-tracker repository.

## Overview

The DevOps 180 Challenge uses comprehensive weekly plans developed in the career-tracker system:

- **Career Tracker**: Private repository for detailed planning and tracking
- **180 Challenge**: Public repository for daily execution and community sharing

## Workflow

### 1. Planning Phase (Career Tracker)
- Detailed weekly checklists are created using phase prompts
- Plans include learning objectives, project milestones, networking goals
- Business skills and career development activities are integrated

### 2. Execution Phase (180 Challenge)
- Daily logs reference the weekly plan objectives
- Progress is tracked publicly through daily commits
- Community engagement through the challenge format

### 3. Synchronization
- Run `devops sync` to pull latest weekly plans from career-tracker
- Plans are copied to this directory for reference
- Daily activities align with weekly objectives

## Using Weekly Plans

### View Current Week Plan
```bash
devops week
```

### Access Full Weekly Checklist
```bash
# Calculate current week number
WEEK=$(( ($(devops day) - 1) / 7 + 1 ))
cat weekly-plans/week-$WEEK-checklist.md
```

### Daily Integration
When you run `devops start`, the daily log will include:
- Current week objectives
- Today's focus areas from the weekly plan
- Links to the full weekly checklist

## Phase Alignment

| 180 Challenge Days | Career Tracker Weeks | Phase |
|-------------------|---------------------|-------|
| Days 1-168 | Weeks 1-24 | Phase 1: Foundation Building |
| Days 169-180 | Weeks 25-26 | Phase 2: Professional Growth (partial) |

## Key Components in Weekly Plans

Each weekly plan includes:

### Learning & Certification (25-30 hours/week in Phase 1)
- Specific course modules and sections
- Hands-on labs and practice exercises
- Certification preparation milestones

### Project Development (8-12 hours/week)
- Weekly project milestones
- Architecture and implementation tasks
- Business value documentation

### Networking (4-6 hours/week)
- Daily connection targets
- SuiteCRM management
- Strategic relationship building

### Content Creation (3-5 hours/week)
- LinkedIn posting schedule
- Technical articles
- Community engagement

### Business Skills (4-5 hours/week)
- ROI calculation practice
- Executive communication
- Strategic thinking exercises

## Maintaining Separation

### Public (180 Challenge)
- Daily progress logs
- General learning topics
- Community-friendly updates
- Portfolio projects

### Private (Career Tracker)
- Detailed networking strategies
- Salary targets and negotiations
- Company-specific research
- Personal career goals

## Sync Command

To update weekly plans from career-tracker:
```bash
devops sync
```

This will:
1. Copy relevant weekly checklists
2. Update phase mapping
3. Maintain integration timestamps

## Best Practices

1. **Morning Routine**: Check weekly plan before starting daily work
2. **Evening Review**: Update career-tracker with detailed progress
3. **Weekly Sync**: Run sync command weekly to get latest plans
4. **Public Sharing**: Share general progress, not specific career details

## Support

- Career Tracker Issues: Track in private devops-career-tracker repo
- 180 Challenge Issues: Track in public devops-180-challenge repo
- Integration Problems: Check sync script logs