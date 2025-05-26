# Phase 3: Infrastructure as Code (Days 121-180)

## 🎯 Phase Overview

Master Infrastructure as Code principles and practices using Terraform. This phase prepares you for the HashiCorp Terraform Associate certification while building production-ready infrastructure automation skills.

## 📚 Learning Objectives

By the end of this phase, you will:
- Master Terraform configuration language (HCL)
- Build reusable infrastructure modules
- Implement GitOps workflows
- Integrate IaC with CI/CD pipelines
- Prepare for Terraform Associate certification

## 📅 Weekly Breakdown

### Weeks 19-20: Terraform Fundamentals
- HCL syntax and structure
- Terraform workflow (init, plan, apply)
- State management concepts
- Provider configuration

### Weeks 21-22: Advanced Terraform Features
- Module development
- Workspaces and environments
- Remote state and locking
- Dynamic blocks and loops

### Weeks 23-24: Production Patterns
- Module composition patterns
- Testing and validation
- Security scanning for IaC
- Cost estimation and optimization

### Weeks 25-26: GitOps & CI/CD Integration
- Git workflows for IaC
- Automated testing pipelines
- Policy as Code with Sentinel/OPA
- Terraform Cloud/Enterprise features

### Week 27: Exam Preparation & Project Completion
- Practice exams and scenarios
- Complete IaC platform project
- Documentation and best practices
- Final exam preparation

## 🏗️ Capstone Project: Production Terraform Platform

Build enterprise-ready Terraform modules with:

### Requirements
- [ ] Reusable modules for common patterns
- [ ] Multi-environment management
- [ ] Automated testing framework
- [ ] CI/CD pipeline integration
- [ ] Security and compliance validation
- [ ] Cost tracking and optimization
- [ ] Documentation and examples
- [ ] Disaster recovery procedures

### Deliverables
- Terraform module library
- CI/CD pipeline configuration
- Testing framework
- Module documentation
- Best practices guide

## 📖 Required Resources

### Primary Learning
- **Platform**: [HashiCorp Learn](https://learn.hashicorp.com/terraform)
- **Book**: "Terraform: Up & Running" by Yevgeniy Brikman
- **Labs**: Terraform Cloud free tier

### Supplementary Resources
- Terraform Registry
- HashiCorp Documentation
- Terraform Weekly Newsletter
- r/terraform subreddit

### Practice Exams
- HashiCorp official practice exam
- Bryan Krausen's practice tests
- WhizLabs Terraform Associate

## 🎓 Certification Details

**Exam**: HashiCorp Certified: Terraform Associate
- **Format**: 57 questions, 60 minutes
- **Passing Score**: 70%
- **Cost**: $70.50 USD
- **Validity**: 2 years

### Key Topics
1. Understand infrastructure as code concepts
2. Understand Terraform's purpose
3. Understand Terraform basics
4. Use the Terraform CLI
5. Interact with Terraform modules
6. Navigate Terraform workflow
7. Implement and maintain state
8. Read, generate, and modify configuration
9. Understand Terraform Cloud capabilities

## 📊 Progress Tracking

### Skill Checkpoints
- [ ] Week 20: Deploy first Terraform infrastructure
- [ ] Week 22: Create reusable module
- [ ] Week 24: Implement automated testing
- [ ] Week 26: Complete GitOps pipeline
- [ ] Week 27: Pass practice exam with 85%+

### Knowledge Areas
Track your progress in each area (1-5 scale):
- HCL Syntax: ⬜⬜⬜⬜⬜
- State Management: ⬜⬜⬜⬜⬜
- Module Development: ⬜⬜⬜⬜⬜
- Provider Usage: ⬜⬜⬜⬜⬜
- Testing & Validation: ⬜⬜⬜⬜⬜
- GitOps Workflows: ⬜⬜⬜⬜⬜

## 💡 Daily Focus Areas

### Hands-On Practice (60%)
- Writing Terraform configurations
- Refactoring code to modules
- Debugging state issues
- Building test scenarios

### Conceptual Learning (25%)
- IaC best practices
- State management strategies
- Module design patterns
- GitOps principles

### Exam Preparation (15%)
- Command memorization
- Scenario practice
- Configuration examples
- Troubleshooting exercises

## 🚀 Tips for Success

1. **Start Simple**: Begin with basic resources before complex modules
2. **Version Everything**: Use version constraints for providers and modules
3. **Test Locally First**: Use terraform plan extensively
4. **Modularize Early**: Don't wait to create reusable components
5. **Understand State**: Master state management—it's crucial

## 📋 Week 19 Kickstart Checklist

- [ ] Install Terraform CLI
- [ ] Set up code editor with HCL support
- [ ] Configure AWS credentials for Terraform
- [ ] Create Terraform Cloud account
- [ ] Initialize first Terraform project
- [ ] Join Terraform community
- [ ] Schedule certification exam
- [ ] Continue daily logging

## 🛠️ Essential Terraform Tools

### Core Tools
- Terraform CLI
- Terraform Cloud/Enterprise
- tfenv (version manager)
- pre-commit hooks

### Testing Tools
- Terratest
- Kitchen-Terraform
- tfsec
- checkov
- terraform-compliance

### Supporting Tools
- Terragrunt
- Atlantis
- tfcost
- infracost
- terraform-docs

## 📝 Module Template Structure

```text
terraform-aws-example/
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── examples/
│   ├── basic/
│   └── advanced/
├── test/
│   └── example_test.go
└── docs/
    └── architecture.md
```

## 🔗 Quick Links

- [Terraform Registry](https://registry.terraform.io/)
- [Terraform Documentation](https://www.terraform.io/docs/)
- [Certification Details](https://www.hashicorp.com/certification/terraform-associate)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

---

Infrastructure as Code is the foundation of modern DevOps. Master it and automate everything! 🏗️