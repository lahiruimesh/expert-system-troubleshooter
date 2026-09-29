# PC Hardware & Network Troubleshooting Expert System

An interactive, rule-based expert system developed in SWI-Prolog to diagnose common PC hardware failures, kernel crashes (BSOD), and local network connectivity issues.

---

## 📌 Project Overview
This expert system serves as a virtual IT diagnostic technician. It systematically prompts the user with observable symptoms, applies backward-chaining inference over a domain-specific knowledge base, and delivers a concrete diagnosis along with root-cause explanations and corrective actions.

### Key Features
- **20 Verified Rules & Facts:** Formulated from recognized industry standards (CompTIA A+, Microsoft Bug Check Documentation, and Cisco CCNA guidelines).
- **Explanation Facility (Why & How):** Breaks down the reasoning path behind each diagnosis rather than outputting isolated conclusions.
- **Dynamic Memory Management:** Tracks previously answered questions dynamically to eliminate redundant prompts during backward chaining.
- **Graceful Fallback:** Catches unidentified edge cases without infinite loops or unhandled exceptions.

---

## 🛠️ Prerequisites
- **SWI-Prolog** (Version 8.x or 10.x recommended)
  - Download: [https://www.swi-prolog.org/download/stable](https://www.swi-prolog.org/download/stable)

---

## 🚀 How to Run the System

### Option 1: Via SWI-Prolog GUI Console (Recommended)
1. Open the **SWI-Prolog** application from your desktop or start menu.
2. Click on **File** -> **Consult...** from the top menu.
3. Browse and select the `expert_system.pl` file and click **Open**.
4. In the console prompt, run the start predicate:
   ```prolog
   ?- start.
