module ChallengeConfig
  CHALLENGE_NAME = "DevOps 180 Challenge"
  CHALLENGE_DAYS = 180
  
  PHASES = {
    1 => {
      name: "AWS Fundamentals & Linux",
      days: 60,
      certification: "AWS Solutions Architect Associate",
      focus: ["AWS Core Services", "Linux Administration", "Cloud Security Basics"],
      start_day: 1,
      end_day: 60
    },
    2 => {
      name: "Security & Compliance", 
      days: 60,
      certification: "CompTIA Security+ SY0-701",
      focus: ["Security Fundamentals", "AWS Security Services", "Compliance Automation"],
      start_day: 61,
      end_day: 120
    },
    3 => {
      name: "Infrastructure as Code",
      days: 60,
      certification: "HashiCorp Terraform Associate",
      focus: ["Terraform", "GitOps", "CI/CD Integration"],
      start_day: 121,
      end_day: 180
    }
  }
  
  DAILY_TIME_COMMITMENT = "2-3 hours"
  
  SOCIAL_HASHTAG = "#DevOps180"
  
  RESOURCES = {
    aws: [
      "Adrian Cantrill's AWS Courses",
      "AWS Documentation",
      "AWS Well-Architected Framework"
    ],
    linux: [
      "Linux Academy",
      "The Linux Command Line book",
      "Linux Journey"
    ],
    security: [
      "Professor Messer Security+",
      "NIST Cybersecurity Framework",
      "OWASP Top 10"
    ],
    terraform: [
      "HashiCorp Learn",
      "Terraform: Up & Running",
      "Terraform Registry"
    ]
  }
end