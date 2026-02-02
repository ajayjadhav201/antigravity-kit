# Antigravity Kit Architecture

> Comprehensive AI Agent Capability Expansion Toolkit

---

## 📋 Overview

Antigravity Kit is a modular system consisting of:

- **9 Specialist Agents** - Role-based AI personas
- **7 Skills** - Domain-specific knowledge modules
- **11 Workflows** - Slash command procedures
- **Coverage** - ~90% mobile development
---

## 🏗️ Directory Structure

```plaintext
.agent/
├── ARCHITECTURE.md          # This file
├── agents/                  # 9 Specialist Agents
├── skills/                  # 8 Skills
├── workflows/               # 11 Slash Commands
└── rules/                   # Global Rules
```
---

## 🤖 Agents (9)

Specialist AI personas for different domains.

| Agent                 | Focus                      | Skills Used
| --------------------- | ---------------------------| -----------
| `orchestrator`        | Multi-agent coordination   | parallel-agents, behavioral-modes
| `project-planner`     | Discovery, task planning   | brainstorming, plan-writing, architecture
| `frontend-specialist` | Web UI/UX                  | frontend-design, nextjs-react-expert, tailwind-patterns
| `flutter-developer`   | Flutter                    | mobile-design
| `debugger`            | Root cause analysis        | systematic-debugging
| `documentation-writer`| Manuals, docs              | documentation-templates
| `product-manager`     | Requirements, user stories | plan-writing, brainstorming
| `product-owner`       | Strategy, backlog, MVP     | plan-writing, brainstorming
| `explorer-agent`      | Codebase analysis          | -

---

## 🧩 Skills (7)

Modular knowledge domains that agents can load on-demand. based on task context.

| Skill                     | Category                      | Description
| ------------------------- | ----------------------------- | -----------------------------
| `database-design`         | Database                      | Schema design, optimization
| `plan-writing`            | Brainstorming & Planning      | Task planning, breakdown
| `brainstorming`           | Brainstorming & Planning      | Socratic questioning
| `mobile-design`           | Mobile                        | Mobile UI/UX patterns
| `clean-code`              | Other                         | Coding standards (Global)
| `behavioral-modes`        | Other                         | Agent personas
| `documentation-templates` | Other                         | Doc formats

---

## 🔄 Workflows (11)

Slash command procedures. Invoke with `/command`.

| Command          | Description              
| -----------------| ------------------------
| `/brainstorm`    | Socratic discovery
| `/create`        | Create new features
| `/debug`         | Debug issues
| `/deploy`        | Deploy application
| `/enhance`       | Improve existing code
| `/orchestrate`   | Multi-agent coordination
| `/plan`          | Task breakdown
| `/preview`       | Preview changes
| `/status`        | Check project status
| `/test`          | Run tests
| `/ui-ux-pro-max` | Design with 50 styles

---

## 🎯 Skill Loading Protocol

```plaintext
User Request → Skill Description Match → Load SKILL.md → Read templates/ (if present)
```

### Skill Structure

```plaintext
skill-name/
├── SKILL.md    # (Required) Metadata & instructions
├── templates/  # (Optional) Templates, docs
```

## 🔗 Quick Reference

| Need               | Agent               | Skills
| ------------------ | ------------------- | ------
| Flutter Mobile App | `flutter-developer` | flutter-design
| Database           | `database-architect`| database-design
| Debug              | `debugger`          | systematic-debugging
| Plan               | `project-planner`   | brainstorming, plan-writing
