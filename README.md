# Compliance Lab with Terraform, Ansible, and CI/CD

In financial services, healthcare, and fintech, compliance isn’t optional — it’s mission-critical. This lab demonstrates how to apply **security baselines, compliance frameworks, and automation** at scale using **Terraform, Ansible, and GitHub Actions**.

The lab provisions four AWS VMs, each hardened against a specific framework:

- **NIST 800-53** (government/financial data)  
- **CIS Benchmarks** (industry best practices)  
- **PCI-DSS** (payment/fintech compliance)  
- **HIPAA** (healthcare / PHI protection)  

This project showcases not only IT troubleshooting but also **infrastructure automation, compliance enforcement, and DevSecOps practices**.

---

## 📐 Architecture

```mermaid
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

---

## ⚖️ Compliance Frameworks

### NIST 800-53 VM
- AC-2: Unique user accounts, disable root/guest login  
- AC-11: Session timeout after inactivity  
- SC-28: Full disk encryption  
- AU-2/AU-6: Centralized audit logging  
- SI-2: Automated patching  
- SC-7: Default-deny firewalls  

### CIS Benchmarks VM
- Disable guest accounts  
- Set minimum password length to 12  
- Enable Gatekeeper  
- Disable unnecessary services (e.g., Avahi)  
- Enforce file permissions (shadow, passwd)  

### PCI-DSS VM
- Req 1: Firewalls restrict inbound/outbound traffic  
- Req 5: Anti-malware protection (ClamAV)  
- Req 6: Patching within 30 days  
- Req 7/8: Role-based access + MFA for SSH  
- Req 10: Centralized audit logging  
- Req 11: Vulnerability scans  

### HIPAA VM (Mapped to NIST 800-66 / 45 CFR 164)
- Access Control: Restrict interactive shells  
- Audit Controls: Extended log retention (≥180 days)  
- Integrity: Strict permissions on PHI data directories  
- Authentication: Harden SSH (strong KEX/ciphers/MACs)  
- Transmission Security: Encrypted channels for PHI  

---

## 📊 Framework Comparison Table

| Framework     | Key Controls / Requirements |
|---------------|-----------------------------|
| **NIST 800-53** | AC-2: Unique user accounts<br>AC-11: Session timeouts<br>SC-28: Disk encryption<br>AU-2/AU-6: Centralized audit logging<br>SI-2: Automated patching<br>SC-7: Default-deny firewalls |
| **CIS Benchmarks** | Disable guest accounts<br>Min password length 12<br>Enable Gatekeeper<br>Disable unnecessary services<br>Enforce file permissions |
| **PCI-DSS** | Req 1: Firewalls<br>Req 5: Anti-malware<br>Req 6: Patch ≤30 days<br>Req 7/8: RBAC + MFA<br>Req 10: Audit logging<br>Req 11: Vulnerability scans |
| **HIPAA** | Access control: restricted shells<br>Audit: extended log retention<br>Integrity: PHI directory perms<br>Auth: SSH hardening<br>Transmission: strong encryption |

---

## ⚙️ Implementation

### Terraform
- Provisions AWS EC2 instances (`t3.small`)  
- Uses SSM (no SSH keys needed)  
- Tags instances by compliance framework  

### Ansible
- **Common baseline**: disable root login, enforce password length, idle session lock, UFW firewall, unattended upgrades, audit logging  
- **NIST**: fail2ban, SSH ciphers  
- **CIS**: service disabled, strict file permissions  
- **PCI**: anti-malware, MFA for SSH  
- **HIPAA**: log retention, PHI directory protections, SSH hardening  

### CI/CD (GitHub Actions)
- Terraform lint/validate/plan  
- Ansible lint/syntax check/dry-run  
- Security checks (tfsec + ansible-lint)  

---

## 🔮 Next Steps

If extended, this lab could integrate:  
- Centralized logging (CloudWatch/ELK)  
- OSQuery for compliance checks  
- Okta/Azure AD for enterprise SSO  
- CI/CD approvals + vulnerability scans  

---

## 📚 References

- [Terraform Docs](https://developer.hashicorp.com/terraform/docs)  
- [Ansible Docs](https://docs.ansible.com/)  
- [GitHub Actions Docs](https://docs.github.com/en/actions)  
- [NIST 800-53](https://csrc.nist.gov/publications/detail/sp/800-53/rev-5/final)  
- [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks)  
- [PCI-DSS v4.0](https://www.pcisecuritystandards.org/document_library)  
- [HIPAA Security Rule (45 CFR 164)](https://www.hhs.gov/hipaa/for-professionals/security/index.html)  

---

**Repo tagline (350 chars):** End-to-end compliance lab using Terraform and Ansible to automate secure AWS VMs aligned with NIST 800-53, CIS Benchmarks, PCI-DSS, and HIPAA. Includes CI/CD with GitHub Actions, automated security hardening, logging hooks, and documentation. Showcases cloud infra automation, compliance mapping, and DevSecOps practices.
