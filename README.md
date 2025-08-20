# 🛡️ Compliance Lab with Terraform, Ansible, and CI/CD

In today’s financial, healthcare, and enterprise IT environments, compliance is not optional — it’s critical. Companies like **Adyen**, **Bloomberg LP**, **Unit**, and **NYU Langone** operate in heavily regulated industries where frameworks such as **NIST 800-53**, **CIS Benchmarks**, **PCI-DSS**, and **HIPAA** define how infrastructure and systems should be secured.  

This lab demonstrates how to provision secure cloud environments using **Terraform**, **Ansible**, and **GitHub Actions CI/CD**, applying compliance baselines for multiple frameworks and showing DevSecOps practices in action.

---

## 🌐 Why a Compliance Lab?

Traditional IT support often focuses on user devices, software installs, and resolving incidents. But in regulated industries like **finance** and **healthcare**, support engineers and senior engineers also need to think about **security baselines, compliance, and automation at scale**.  

I wanted a project that:  
- Shows I understand frameworks like **NIST**, **CIS**, **PCI-DSS**, and **HIPAA**.  
- Proves I can apply these controls in real, technical ways.  
- Incorporates **cloud infrastructure automation**.  
- Uses **Terraform** (infrastructure provisioning) and **Ansible** (configuration management).  
- Demonstrates **CI/CD pipelines** to enforce compliance checks automatically.  

The result: a compliance lab that spins up AWS VMs, hardens them according to frameworks, and validates them through automated pipelines.

---

## 🏗️ Architecture

The project uses three main components:  

1. **Terraform** → Provisions 4 AWS VMs (`nist`, `cis`, `pci`, `hipaa`).  
2. **Ansible** → Applies a common hardening baseline plus framework-specific rules.  
3. **GitHub Actions CI/CD** → Lints, validates, and secures all infrastructure-as-code.  

### Diagram
\`\`\`mermaid
flowchart LR
    A[Terraform] --> B[AWS VMs]
    B --> B1[NIST 800-53]
    B --> B2[CIS Benchmarks]
    B --> B3[PCI-DSS]
    B --> B4[HIPAA]
    C[Ansible] --> B
    D[GitHub Actions (CI/CD)] --> A
    D --> C
    B --> E[Documentation (Control Mapping & Runbook)]
\`\`\`

---
### 📂 Project File Structure
compliance-lab/
├── terraform/                  # Infrastructure as Code (Terraform)
│   ├── main.tf                 # Provisions AWS VMs
│   ├── variables.tf            # Input variables
│   ├── outputs.tf              # Exported values (e.g., IPs)
│   └── modules/
│       └── vm/                 # Reusable VM module
│
├── ansible/                    # Configuration Management
│   ├── inventories/
│   │   └── aws_ec2.yaml        # Dynamic AWS inventory
│   ├── group_vars/             # Framework-specific vars
│   │   ├── nist.yaml
│   │   ├── cis.yaml
│   │   ├── pci.yaml
│   │   └── hipaa.yaml
│   ├── roles/                  # Ansible roles (hardening per framework)
│   │   ├── common/             # Shared baseline
│   │   ├── nist/
│   │   ├── cis/
│   │   ├── pci/
│   │   └── hipaa/
│   └── playbooks/              # Entry playbooks
│       ├── nist.yaml
│       ├── cis.yaml
│       ├── pci.yaml
│       └── hipaa.yaml
│
├── .github/                    # GitHub Actions CI/CD
│   └── workflows/
│       ├── terraform-ci.yaml   # Terraform lint/validate/plan
│       ├── ansible-ci.yaml     # Ansible lint/syntax check
│       └── security.yaml       # tfsec + ansible-lint scans
│
├── docs/                       # Documentation & Compliance Mapping
│   ├── compliance-mapping.md   # Maps controls to frameworks
│   ├── architecture.png        # Architecture diagram
│   └── screenshots/            # Lab verification screenshots
│
├── Makefile                    # Shortcut commands (terraform, ansible, hipaa)
├── README.md                   # Project overview & usage
└── LICENSE                     # License file
---
## ⚖️ Compliance Frameworks

### NIST 800-53 VM
- AC-2: Unique user accounts, disable root/guest login.  
- AC-11: Session timeout after inactivity.  
- SC-28: Full disk encryption.  
- AU-2/AU-6: Centralized audit logging.  
- SI-2: Automated patching.  
- SC-7: Firewalls default-deny.  

### CIS Benchmarks VM
- Disable guest accounts.  
- Set minimum password length to 12.  
- Enable Gatekeeper-like protections.  
- Disable unnecessary services (e.g., Avahi).  
- Enforce strict file permissions (shadow, passwd).  

### PCI-DSS VM
- Req 1: Firewall restricts inbound/outbound traffic.  
- Req 5: Anti-malware protection (ClamAV).  
- Req 6: Patching within 30 days.  
- Req 7/8: Role-based access + MFA for SSH.  
- Req 10: Centralized audit logging.  
- Req 11: Vulnerability scans (future stretch goal).  

### HIPAA VM
- Access Control: Restrict interactive users; RBAC groups.  
- Audit Controls: Extended log retention (180 days).  
- Integrity: Strict permissions on PHI directories.  
- Authentication: SSH hardened with modern ciphers.  
- Transmission Security: Strong encryption for SSH traffic.  

---

## ⚙️ Implementation

### 1. Terraform Infrastructure
Terraform provisions 4 AWS EC2 instances (`t3.small`), each tagged with its compliance framework.  
Dynamic inventory groups hosts for Ansible automatically.  

Example snippet:  
\`\`\`hcl
module "nist" {
  source        = "./modules/vm"
  name          = "compliance-nist"
  instance_type = "t3.small"
  tags          = { framework = "nist" }
}
\`\`\`

### 2. Ansible Hardening
**Common baseline role**:  
- Disable root login.  
- Enforce password policy.  
- Idle session lock.  
- Enable UFW firewall.  
- Configure unattended upgrades.  
- Centralized audit logging.  

**Framework-specific roles**:  
- NIST → fail2ban, SSH ciphers.  
- CIS → disable services, enforce file perms.  
- PCI → anti-malware, MFA for SSH.  
- HIPAA → log retention, PHI directories, SSH hardening.  

### 3. CI/CD Pipelines
GitHub Actions runs:  
- Terraform CI → validate & plan.  
- Ansible CI → lint & dry-run.  
- Security Checks → tfsec, ansible-lint.  

---

## 🔄 Lab vs. Production

This project is designed as a **lab environment**, but it is inspired by how compliance is implemented in **production environments** at scale.  

### Lab Environment
- **Cloud Scope**: Runs in AWS free-tier (t3.small) VMs, provisioned via Terraform.  
- **Users**: Simulated system users, test service accounts, and mock RBAC groups.  
- **Security Controls**: Enforced via Ansible playbooks (e.g., SSH ciphers, password policies, firewalls, log retention).  
- **Audit Logging**: Centralized with rsyslog and local file retention.  
- **Authentication**: Basic local users + SSH key enforcement (MFA is mocked).  
- **Monitoring**: Limited to OS-level logging and CI/CD linting/security scans.  
- **Compliance Evidence**: Markdown docs showing which control maps to which playbook.  

### Production Environment
- **Enterprise IAM**: Centralized identity via Okta, Azure AD, or Google Workspace, enforcing MFA, SSO, and conditional access.  
- **Endpoint Security**: Macs/PCs managed with Jamf or Intune, enforcing CIS baselines, encryption, and automated patching.  
- **Network Security**: Enforced via firewalls, VPNs, zero-trust access, and cloud security groups.  
- **Audit Logging**: Forwarded to a SIEM (Splunk, ELK, Datadog) with real-time alerting, retention policies, and compliance dashboards.  
- **Vulnerability Management**: Automated scans (Qualys, Tenable, or AWS Inspector) with remediation pipelines.  
- **Change Management**: All infra-as-code changes gated by CI/CD approval workflows, peer reviews, and automated policy-as-code checks (OPA, Sentinel).  
- **Compliance Reporting**: Evidence collected via GRC tools, mapped against frameworks like PCI-DSS, HIPAA, and SOC 2.  
- **Disaster Recovery**: Backups, redundant regions, and failover strategies tested and documented.  

---

✅ **Why this matters:**  
The **lab proves I understand the mechanics of compliance controls** and how to automate them with Terraform + Ansible.  
The **production mapping shows I understand how large enterprises (finance, healthcare, embedded banking) actually enforce and audit compliance at scale**.  
This is the bridge between *IT support engineering* and *senior-level systems/infra engineering in regulated industries*.  
---

## 🚀 What’s Next?

- Add centralized logging VM (rsyslog/ELK).  
- Stream logs to CloudWatch/Elastic.  
- OSQuery for endpoint compliance.  
- Okta/Azure AD integration for identity.  
- CI/CD with approval gates + vuln scans.  

---

## 📚 References

- NIST 800-53 Rev. 5: https://csrc.nist.gov/publications/detail/sp/800-53/rev-5/final  
- CIS Benchmarks: https://www.cisecurity.org/cis-benchmarks  
- PCI-DSS v4.0: https://www.pcisecuritystandards.org/standards/  
- HIPAA (45 CFR 164 / NIST 800-66): https://www.hhs.gov/hipaa/for-professionals/security/index.html  
- Terraform: https://developer.hashicorp.com/terraform/docs  
- Ansible: https://docs.ansible.com/  
- GitHub Actions: https://docs.github.com/en/actions  
- tfsec: https://aquasecurity.github.io/tfsec/  
- ansible-lint: https://ansible.readthedocs.io/projects/lint/  

---
