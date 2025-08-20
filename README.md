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
- Use **Terraform** (for provisioning) and **Ansible** (for configuration).
- Enforce quality with **CI/CD** pipelines.

The result: a lab that spins up cloud VMs, hardens them per-framework, and validates changes automatically.

---

## 🏗️ Architecture Overview

The project uses three main components:

1. **Terraform** → Deploys AWS VMs, each tagged as `nist`, `cis`, `pci`, or `hipaa`.  
2. **Ansible** → Applies a common hardening baseline (encryption, firewalls, logging) and framework-specific deltas.  
3. **GitHub Actions CI/CD** → Lints, validates, and plans Terraform/Ansible code on every commit.

### Diagram  
> To keep this README in one code fence here, the inner backticks are escaped.  
> **After you paste into GitHub**, replace `\`\`\`mermaid` with real ```mermaid so the diagram renders.

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

> Same note: inner block is escaped here. If you want GitHub to format it as a code block, replace `\`\`\`plaintext` with real ```plaintext.

\`\`\`plaintext
compliance-lab/                 # Root project
├── terraform/                  # Terraform IaC for AWS VM provisioning
│   ├── main.tf                 # Main resources (EC2, SSM, SGs)
│   ├── variables.tf            # Input variables
│   └── outputs.tf              # Exported values (e.g., IPs)
│
├── ansible/                    # Ansible for compliance hardening
│   ├── inventories/
│   │   └── aws_ec2.yaml        # Dynamic AWS inventory
│   ├── group_vars/             # Framework-specific vars
│   │   ├── nist.yaml
│   │   ├── cis.yaml
│   │   ├── pci.yaml
│   │   └── hipaa.yaml
│   ├── roles/                  # Roles by framework + common baseline
│   │   ├── common/             # Shared hardening (firewall, logging, updates)
│   │   ├── nist/               # NIST-specific tasks
│   │   ├── cis/                # CIS-specific tasks
│   │   ├── pci/                # PCI-DSS-specific tasks
│   │   └── hipaa/              # HIPAA-specific tasks
│   └── playbooks/              # Entry playbooks
│       ├── nist.yaml
│       ├── cis.yaml
│       ├── pci.yaml
│       └── hipaa.yaml
│
├── .github/workflows/          # CI/CD pipelines
│   ├── terraform-ci.yaml       # fmt/validate/plan
│   ├── ansible-ci.yaml         # lint/syntax check/dry-run
│   └── security.yaml           # tfsec + ansible-lint scans
│
├── docs/                       # Documentation & runbooks
│   ├── compliance-mapping.md   # Control-to-task mappings
│   └── runbook.md              # Operational steps & verification
│
├── Makefile                    # Convenience targets (apply/ansible/destroy)
└── README.md                   # This file
\`\`\`

---

## ⚖️ Compliance Frameworks

Each VM is aligned to a specific framework:

### 🔒 NIST 800-53 VM
- AC-2: Unique user accounts; disable root/guest login  
- AC-11: Session timeout after inactivity  
- SC-28: Full disk encryption  
- AU-2/AU-6: Centralized audit logging  
- SI-2: Automated patching  
- SC-7: Default-deny firewalls

### 🛡️ CIS Benchmarks VM
- Disable guest accounts  
- Minimum password length: 12  
- Enable Gatekeeper-like protections  
- Disable unnecessary services (e.g., Avahi)  
- Enforce strict file permissions (shadow, passwd)

### 💳 PCI-DSS VM
- Req 1: Firewalls restrict inbound/outbound traffic  
- Req 5: Anti-malware (ClamAV)  
- Req 6: Patching within 30 days  
- Req 7/8: Role-based access + MFA for SSH  
- Req 10: Centralized audit logging  
- Req 11: Vulnerability scans (future stretch)

### 🏥 HIPAA VM
- Access Control: Restrict interactive users; RBAC groups  
- Audit Controls: Log retention (≥180 days); central logging hooks  
- Integrity: Strict permissions on PHI directories  
- Authentication: SSH hardened (modern KEX/Ciphers/MACs)  
- Transmission Security: Encrypted channels only

---

## ⚙️ Implementation

### 1) Terraform (Infrastructure as Code)
- Provisions 4 EC2 instances (e.g., `t3.small`) tagged by framework.  
- Enables **SSM** Session Manager (no SSH keys needed).  
- Outputs instance details for inventory.

**Example (escaped here):**  
\`\`\`hcl
module "nist" {
  source        = "./modules/vm"
  name          = "compliance-nist"
  instance_type = "t3.small"
  tags          = { framework = "nist" }
}
\`\`\`

### 2) Ansible (Configuration Management)
- **Common baseline**: disable root login, enforce password policy, idle lock, UFW firewall, unattended upgrades, audit logging.  
- **Framework deltas**:  
  - NIST → fail2ban, SSH ciphers  
  - CIS → disable services, strict file perms  
  - PCI → ClamAV, MFA for SSH  
  - HIPAA → log retention, PHI dir perms, SSH hardening

### 3) GitHub Actions (CI/CD)
- **Terraform CI** → `fmt`, `validate`, `plan`  
- **Ansible CI** → `ansible-lint`, syntax check, dry-run  
- **Security** → `tfsec` for Terraform, `ansible-lint` for playbooks

---

## 🧪 Lab vs. Production

This project is a **lab demo** inspired by enterprise production:

### Lab Environment
- **Scope**: AWS EC2, Terraform + Ansible only  
- **Users**: Simulated accounts & RBAC groups  
- **Logging**: rsyslog + local retention  
- **Auth**: Local users + SSH constraints; MFA simulated  
- **Validation**: CI linting & security scans  
- **Evidence**: Docs mapping controls to playbooks

### Production Environment
- **Enterprise IAM**: Okta / Azure AD (Entra ID) SSO + MFA; conditional access  
- **Endpoint Mgmt**: Jamf / Intune / Kandji enforcing CIS baselines & patches  
- **Network**: Firewalls, VPN/Zero-Trust, Security Groups as code  
- **Audit & Monitoring**: Splunk/ELK/Datadog SIEM with alerts & dashboards  
- **Vuln Mgmt**: Qualys/Tenable/AWS Inspector + remediation SLAs  
- **Change Control**: CI/CD approvals, policy-as-code (OPA/Sentinel), peer review  
- **GRC Reporting**: Evidence tracked against PCI-DSS, HIPAA, SOC 2, etc.  
- **DR/Resilience**: Backups, multi-AZ/region failover, tested runbooks

**Why this matters:** the lab proves the **mechanics**; the mapping shows I understand **enterprise scale**.

---

## 🎤 Interview Storytelling

- **Problem:** Compliance controls are inconsistent and hard to enforce.  
- **Solution:** IaC + configuration management + CI/CD to standardize baselines across VMs mapped to NIST, CIS, PCI-DSS, HIPAA.  
- **Process:** Provision → Harden → Validate → Document mappings.  
- **Result:** Demonstrated ability to go beyond tickets and deliver **automated, auditable** outcomes.

---

## 🎯 Relevance to Employers

- **Adyen (FinTech):** PCI-DSS alignment for payment systems at scale  
- **Bloomberg (Financial Data):** NIST & CIS relevance for secure, reliable infra  
- **NYU Langone (Healthcare):** HIPAA/NIST 800-66 mapping for PHI protection  
- **Unit (Embedded Finance):** PCI + SaaS administration + automation for a fast-growing platform

---

## 🔮 Next Steps

- Centralized logging VM and shipping to **CloudWatch/ELK/Splunk**  
- **OSQuery** for endpoint posture & compliance checks  
- **Okta/Azure AD** integration for SSO/MFA on servers and consoles  
- CI/CD **approval gates** + scheduled **vulnerability scans**

---

## 📚 References

- NIST 800-53 Rev. 5 — https://csrc.nist.gov/publications/detail/sp/800-53/rev-5/final  
- CIS Benchmarks — https://www.cisecurity.org/cis-benchmarks  
- PCI-DSS v4.0 — https://www.pcisecuritystandards.org/  
- HIPAA Security Rule (45 CFR 164) — https://www.hhs.gov/hipaa/for-professionals/security/  
- Terraform — https://developer.hashicorp.com/terraform/docs  
- Ansible — https://docs.ansible.com/  
- GitHub Actions — https://docs.github.com/en/actions  
- tfsec — https://aquasecurity.github.io/tfsec/  
- ansible-lint — https://ansible.readthedocs.io/projects/lint/

---

## 📌 Repo Tagline (≤350 chars)

End-to-end compliance lab using Terraform + Ansible to automate secure AWS VMs aligned with NIST 800-53, CIS Benchmarks, PCI-DSS, and HIPAA. Includes CI/CD with GitHub Actions, automated hardening, logging hooks, and docs. Showcases cloud infra automation, compliance mapping, and DevSecOps practices.
