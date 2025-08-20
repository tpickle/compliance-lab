# 🛡️ Compliance Lab with Terraform, Ansible, and CI/CD

In today’s financial and enterprise IT environments, compliance is not optional — it’s critical. Companies like **Adyen**, **Bloomberg**, **NYU Langone**, and **Unit** operate in heavily regulated industries where frameworks such as **NIST 800-53**, **CIS Benchmarks**, **PCI-DSS**, and **HIPAA** define how infrastructure and systems must be secured.  

This project is a hands-on **compliance lab** that demonstrates not just IT troubleshooting skills, but also **infrastructure automation, compliance enforcement, and DevSecOps thinking**.  

---

## 🚀 Why a Compliance Lab?

Traditional IT support often focuses on user devices, software installs, and resolving incidents.  
But in regulated industries like **finance and healthcare**, **IT Support Engineers and Senior Engineers** also need to think about:  

- **Security baselines**  
- **Compliance frameworks**  
- **Automation at scale**  

This project shows I can:  
- Understand frameworks like NIST, CIS, PCI-DSS, and HIPAA.  
- Apply these controls in real, technical ways.  
- Incorporate **cloud infrastructure** — not just endpoints.  
- Use **Terraform** (for cloud provisioning) and **Ansible** (for configuration management).  
- Demonstrate **CI/CD pipelines** to enforce security checks.  

The result: a compliance lab that spins up cloud VMs, hardens them according to different standards, and proves compliance with automated pipelines.  

---

## 🏗️ Architecture Overview

The project uses three main components:  

1. **Terraform** → Deploys AWS VMs, each tagged as `nist`, `cis`, `pci`, or `hipaa`.  
2. **Ansible** → Applies a common hardening baseline (encryption, firewalls, logging) and framework-specific deltas.  
3. **GitHub Actions CI/CD** → Lints, validates, and plans Terraform/Ansible code on every commit.  

### Diagram  
(escape applied so it doesn’t break the big fence — replace `\`\`\`` with real backticks if you want GitHub to render Mermaid.)  

\`\`\`mermaid  
flowchart LR  
    A[Terraform] --> B[AWS VMs (NIST / CIS / PCI / HIPAA)]  
    C[Ansible] --> B  
    D[GitHub Actions (CI/CD)] --> A  
    D --> C  
    B --> E[Documentation (Control Mapping & Runbook)]  
\`\`\`  

---

## 📂 Project File Structure  

(escape applied here too so it doesn’t break the big fence — replace `\`\`\`` with real backticks for formatting.)  

\`\`\`plaintext
compliance-lab/
├── terraform/                 # IaC for AWS VM provisioning
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── ansible/                   # Configuration management
│   ├── roles/
│   │   ├── common/            # Shared hardening (firewall, logging, updates)
│   │   ├── nist/              # NIST-specific tasks
│   │   ├── cis/               # CIS-specific tasks
│   │   ├── pci/               # PCI-DSS-specific tasks
│   │   └── hipaa/             # HIPAA-specific tasks
│   └── playbook.yml
│
├── .github/workflows/         # CI/CD pipelines
│   ├── terraform.yml
│   ├── ansible.yml
│   └── security.yml
│
├── docs/                      # Documentation & runbooks
│   ├── control-mapping.md     # Control-to-task mappings
│   └── runbook.md             # Operational runbook
│
└── README.md                  # This file
\`\`\`  

---

## ⚖️ Compliance Frameworks

Each VM is aligned to a specific compliance framework:  

### 🔒 NIST 800-53 VM
- AC-2: Unique user accounts, disable root/guest login  
- AC-11: Session timeout after inactivity  
- SC-28: Full disk encryption  
- AU-2/AU-6: Centralized audit logging  
- SI-2: Automated patching  
- SC-7: Firewalls default-deny  

### 🛡️ CIS Benchmarks VM
- Disable guest accounts  
- Set minimum password length to 12  
- Enable Gatekeeper (macOS analogy)  
- Disable unnecessary services (e.g., Avahi)  
- Enforce file permissions (shadow, passwd)  

### 💳 PCI-DSS VM
- Req 1: Firewall restricts inbound/outbound traffic  
- Req 5: Anti-malware protection (ClamAV)  
- Req 6: Patching within 30 days  
- Req 7/8: Role-based access + MFA for SSH  
- Req 10: Centralized audit logging  
- Req 11: Vulnerability scans (future stretch goal)  

### 🏥 HIPAA VM
- Access Control: Restrict interactive users; enforce RBAC  
- Audit Controls: Extended log retention (180 days); centralized logging hooks  
- Integrity: Strict permissions on PHI directories  
- Person/Entity Authentication: SSH hardening (strong KEX/Ciphers/MACs)  
- Transmission Security: Encrypted data in transit (strong SSH ciphers)  

---
