<p align="center">
  <a href="README.id.md">🇮🇩 Bahasa Indonesia</a>
</p>

# BankSatu
> *One banking platform. Built for everyone.*

---

## Philosophy

### Why BankSatu?

Indonesia has many banks. But a platform that truly unifies the customer experience end-to-end — from onboarding, to transactions, to services — still feels fragmented.

BankSatu was born from a simple question:

> *"Why does banking have to be so complicated?"*

**Satu** means "One." It's a promise:
- One platform for all banking needs
- One consistent experience from mobile to web
- One point of trust between the bank and its customers

### Core Values

| Value | Meaning |
|---|---|
| **Simplicity** | Complex features, simple interface |
| **Trust** | Secure data, transparent transactions |
| **Inclusivity** | Designed for all customer segments |
| **Speed** | No customer likes to wait |

### Product Position

BankSatu is not a core banking replacement. BankSatu is an **experience layer** on top of existing banking infrastructure — making bank services feel modern, fast, and human.

---

## Product Requirements Document (PRD)

| | |
|---|---|
| **Version** | v1.0 — Initial Release |
| **Status** | Draft |
| **Date** | May 2026 |
| **Platform** | Mobile (iOS + Android) + Web |
| **Model** | White-label per banking institution |
| **Target** | Indonesian bank customers — all segments |

---

## 1. Executive Summary

BankSatu is a customer-facing banking platform designed to deliver a modern banking experience — from digital onboarding, daily transactions, to financial product services.

The platform comes as a white-label solution that can be customized per banking institution while maintaining high UX and security standards.

---

## 2. Problem Statement

### 2.1 Current State

- Most Indonesian bank mobile apps feel heavy, slow, and unintuitive
- New customer onboarding still requires physical branch visits
- Transaction notifications are not real-time or not informative enough
- Customers lack full visibility into their financial products

### 2.2 Key Pain Points

| Pain Point | Impact | Frequency |
|---|---|---|
| Onboarding requires branch visit | High barrier for new customers | Per acquisition |
| Slow and error-prone apps | Trust erosion, high churn | Daily |
| No real-time notifications | Customers unaware of transactions | Daily |
| Unclear product information | Low cross-sell | Monthly |
| Complex PIN/password reset | Frustration, call center overload | Weekly |

---

## 3. Target Users & Personas

| Persona | Characteristics | Key Needs |
|---|---|---|
| Young customer (18–30) | Digital native, mobile-first | Fast onboarding, modern UX |
| Productive customer (31–50) | Needs efficiency, business & personal | Fast transfers, financial reports |
| Senior customer (50+) | Less tech-savvy | Simple UI, large fonts, accessible |
| MSME customer | Mixed personal & business accounts | Transaction categorization, invoicing |

---

## 4. Core Modules

### 4.1 Digital Onboarding & KYC
- Account registration without branch visit
- ID photo + selfie with liveness detection
- Automatic data verification via Dukcapil API
- e-Sign for account opening

### 4.2 Dashboard & Transactions
- Real-time balance across all accounts
- Transaction history with filter & search
- Real-time push notification for every transaction
- Automatic expense categorization

### 4.3 Transfers & Payments
- Interbank transfer via BI-FAST
- Bill payments (electricity, water, internet, BPJS)
- QRIS scan & pay
- Scheduled recurring transfers

### 4.4 Financial Products
- Savings, deposits, and loan information
- Product simulation (mortgage, personal loan, deposits)
- Apply for new products directly from the app
- Real-time application status

### 4.5 Services & Self-Service
- Change PIN without visiting a branch
- Block/unblock card
- Digital bank statements
- In-app chat with customer service

---

## 5. Non-Functional Requirements

| Category | Target |
|---|---|
| Performance | App load < 2 seconds |
| Availability | 99.9% uptime |
| Security | OJK-compliant, AES-256 encryption |
| Compliance | PBI No. 23/6/PBI/2021, POJK 38 |
| Accessibility | WCAG 2.1 AA |

---

## 6. Tech Stack Recommendation

| Layer | Technology |
|---|---|
| Mobile | Flutter (iOS + Android) |
| Web | Next.js + PWA |
| Backend | Go (Golang) |
| Database | MySQL + Redis |
| Auth | JWT + OTP + Biometric |
| KYC | Dukcapil API + Liveness SDK |
| Payment | BI-FAST, QRIS (GPN) |

---

## 7. Roadmap

### Phase 1 — MVP (Months 1–3)
- Digital onboarding & KYC
- Balance dashboard & transactions
- Interbank transfers
- Real-time notifications

### Phase 2 — Core Expansion (Months 4–6)
- Bill payments & QRIS
- Financial products & simulation
- Self-service (PIN, card block)
- In-app CS chat

### Phase 3 — Growth (Months 7–12)
- AI transaction categorization
- Digital financial product applications
- Loyalty & reward program
- Open banking API

---

## 8. Success Metrics

| Metric | Target |
|---|---|
| Onboarding completion rate | > 70% |
| DAU / MAU ratio | > 40% |
| Transactions per user per month | > 8x |
| App store rating | > 4.5 |
| CS tickets via app | > 60% of total |

---

## 9. Open Questions

1. Which core banking system will be integrated? (Temenos, Silverlake, in-house)
2. Does KYC require face liveness detection or are static photos sufficient?
3. Does white-label include custom domains and separate app store listings?
4. Which OJK regulations are most critical for the MVP phase?

---

*BankSatu — One banking platform. Built for everyone.*
*PRD v1.0 — Confidential*
