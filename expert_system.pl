% =============================================================================
% PC HARDWARE & NETWORK TROUBLESHOOTING EXPERT SYSTEM
% Language: SWI-Prolog
% =============================================================================

:- dynamic(yes/1).
:- dynamic(no/1).

% -----------------------------------------------------------------------------
% MAIN ENTRY POINT & UI INTERACTION
% -----------------------------------------------------------------------------
start :-
    clear_memory,
    nl,
    write('================================================================='), nl,
    write('    PC HARDWARE & NETWORK TROUBLESHOOTING EXPERT SYSTEM          '), nl,
    write('================================================================='), nl,
    write('Answer the following diagnostic questions with y (yes) or n (no).'), nl,
    nl,
    ( diagnose(Fault) ->
        report_diagnosis(Fault)
    ;
        nl,
        write('Result: Unable to identify the fault based on the given inputs.'), nl,
        write('Recommendation: Perform manual component-level testing.'), nl
    ),
    nl,
    write('Diagnostic session ended.'), nl.

% -----------------------------------------------------------------------------
% 20 DIAGNOSTIC RULES (KNOWLEDGE BASE)
% -----------------------------------------------------------------------------

% Rule 1: Power Supply Unit Failure
diagnose(psu_failure) :-
    verify(power_button_pressed_no_power_or_fans),
    verify(wall_outlet_and_cable_working).

% Rule 2: GPU Seating / Hardware Fault
diagnose(gpu_failure) :-
    verify(system_powers_on),
    verify(one_long_two_short_beeps),
    verify(no_display_output).

% Rule 3: RAM Module Failure
diagnose(ram_failure) :-
    verify(system_powers_on),
    verify(continuous_long_beeps),
    verify(no_display_output).

% Rule 4: CPU Overheating / Thermal Throttling
diagnose(cpu_overheating) :-
    verify(system_powers_on),
    verify(shutdowns_after_few_minutes),
    verify(cpu_fan_runs_at_max_speed).

% Rule 5: Boot Drive Missing / Corrupted
diagnose(boot_drive_failure) :-
    verify(system_powers_on),
    verify(bios_post_completes),
    verify(no_bootable_device_error).

% Rule 6: Memory Corruption / Driver Conflict (IRQL BSOD)
diagnose(driver_or_ram_bsod) :-
    verify(windows_loads_partially),
    verify(bsod_irql_not_less_or_equal).

% Rule 7: GPU Driver Crash
diagnose(gpu_driver_crash) :-
    verify(display_flickers_black),
    verify(display_driver_stopped_responding_alert).

% Rule 8: Mechanical Hard Drive Degradation
diagnose(hdd_physical_failure) :-
    verify(storage_response_extremely_slow),
    verify(clicking_sound_from_drive).

% Rule 9: CMOS Battery Depleted
diagnose(cmos_battery_low) :-
    verify(system_clock_resets_on_reboot),
    verify(bios_settings_reset_to_default).

% Rule 10: Critical System File Damage (BSOD)
diagnose(system_file_corruption) :-
    verify(random_sudden_crash),
    verify(bsod_critical_process_died).

% Rule 11: Motherboard POST Failure
diagnose(motherboard_post_failure) :-
    verify(fans_spin_but_no_display),
    verify(keyboard_caps_lock_not_responding).

% Rule 12: Insufficient Power Supply Wattage
diagnose(insufficient_psu_wattage) :-
    verify(pc_restarts_during_heavy_gaming),
    verify(no_bsod_dump_file_created).

% Rule 13: DHCP Lease Failure (APIPA)
diagnose(dhcp_apipa_issue) :-
    verify(ip_starts_with_169_254),
    verify(no_lan_or_internet_access).

% Rule 14: IP Address Conflict
diagnose(ip_conflict) :-
    verify(intermittent_network_drop),
    verify(ip_address_conflict_warning_shown).

% Rule 15: DNS Resolution Failure
diagnose(dns_resolution_failure) :-
    verify(ping_8_8_8_8_successful),
    verify(browser_cannot_open_domain_names).

% Rule 16: Default Gateway Unreachable
diagnose(default_gateway_unreachable) :-
    verify(ethernet_cable_plugged_in),
    verify(cannot_ping_local_router_gateway).

% Rule 17: ISP Uplink Failure
diagnose(isp_uplink_down) :-
    verify(connected_to_wifi_successfully),
    verify(no_internet_secured_status_shown),
    verify(router_wan_internet_led_red_or_off).

% Rule 18: Wireless Frequency Interference
diagnose(wifi_channel_interference) :-
    verify(wifi_signal_drops_near_router),
    verify(multiple_neighboring_wifi_networks_present).

% Rule 19: Faulty Ethernet Wiring / Cap
diagnose(faulty_ethernet_cable) :-
    verify(gigabit_lan_port_available),
    verify(link_speed_capped_at_100_mbps).

% Rule 20: Network Switch Buffer Saturation
diagnose(network_switch_congestion) :-
    verify(high_packet_loss_above_20_percent),
    verify(local_network_latency_spikes).

% -----------------------------------------------------------------------------
% EXPLANATION FACILITY
% -----------------------------------------------------------------------------
report_diagnosis(Fault) :-
    nl,
    write('----------------- DIAGNOSTIC RESULT -----------------'), nl,
    diagnosis_detail(Fault, Title, Explanation, Action, Source),
    format('Diagnosis: ~w~n', [Title]), nl,
    format('Explanation (Why):~n  ~w~n', [Explanation]), nl,
    format('Recommended Action:~n  ~w~n', [Action]), nl,
    format('Standard Reference:~n  ~w~n', [Source]),
    write('-----------------------------------------------------'), nl.

diagnosis_detail(psu_failure,
    'Power Supply Unit (PSU) Failure or Disconnect',
    'System fails to receive electrical current; power button triggers no fans or LED indicators.',
    'Inspect power cord, wall outlet, test PSU with paperclip method, or replace PSU.',
    'CompTIA A+ Core 1 (220-1101) Section 5.2 - Power Subsystems').

diagnosis_detail(gpu_failure,
    'Graphics Card (GPU) Seating / Hardware Malfunction',
    'AMI BIOS issued 1 long and 2 short beeps indicating video subsystem memory/adapter failure.',
    'Reseat the dedicated GPU into the PCIe slot and verify 6/8-pin PCIe power cables.',
    'American Megatrends (AMI) BIOS Beep Code Diagnostic Standard').

diagnosis_detail(ram_failure,
    'RAM Module Fault or Seating Error',
    'Repetitive long beeps and lack of display output indicate memory initialization failure during POST.',
    'Remove memory sticks, clean golden contacts using isopropyl alcohol, and reseat module in alternate slot.',
    'CompTIA A+ Core 1 Memory Subsystem Diagnostic Guide').

diagnosis_detail(cpu_overheating,
    'CPU Overheating & Thermal Throttling Protection',
    'Sudden shutdown minutes after boot accompanied by high fan RPM indicates critical core temperatures.',
    'Clean dust from CPU cooler heatsink fins, reapply thermal interface material (TIM).',
    'Intel Processor Diagnostic & Thermal Management Standards').

diagnosis_detail(boot_drive_failure,
    'Boot Storage Drive Disconnected or OS Corruption',
    'BIOS POST completed successfully, but the boot loader partition or drive could not be detected.',
    'Check SATA/NVMe drive seating and verify boot sequence priority within BIOS settings.',
    'Microsoft Windows Boot Process Troubleshooting Docs').

diagnosis_detail(driver_or_ram_bsod,
    'Kernel Memory/Driver Conflict (IRQL_NOT_LESS_OR_EQUAL)',
    'A kernel-mode process attempted to access pageable memory at an invalid interrupt request level.',
    'Run Windows Memory Diagnostic (mdsched.exe) and roll back recently updated device drivers.',
    'Microsoft Bug Check 0x0A: IRQL_NOT_LESS_OR_EQUAL Support Reference').

diagnosis_detail(gpu_driver_crash,
    'Display Driver Timeout Detection & Recovery (TDR)',
    'Display output froze and flickered, prompting a Windows TDR graphics engine reset.',
    'Execute Display Driver Uninstaller (DDU) in Safe Mode and install the latest stable OEM WHQL driver.',
    'Microsoft Windows Hardware Developer Guide - TDR Architecture').

diagnosis_detail(hdd_physical_failure,
    'Mechanical Hard Drive Head/Platter Degradation',
    'Rhythmic clicking noises accompanied by extreme I/O latency signify physical head-parking failure.',
    'Immediately back up critical data to prevent total data loss and replace the drive with an SSD.',
    'Western Digital Hardware Diagnostic & Maintenance Manual').

diagnosis_detail(cmos_battery_low,
    'CMOS Coin-Cell Battery Depletion',
    'System date/time resets to factory default on AC power disconnect, indicating non-volatile RAM power loss.',
    'Replace the CR2032 3V lithium coin-cell battery located on the motherboard.',
    'CompTIA A+ Core 1 Motherboard Troubleshooting Standards').

diagnosis_detail(system_file_corruption,
    'Operating System File Damage (CRITICAL_PROCESS_DIED)',
    'A core Windows kernel process (such as csrss.exe or wininit.exe) unexpectedly terminated.',
    'Execute "sfc /scannow" and "dism /online /cleanup-image /restorehealth" via administrative command prompt.',
    'Microsoft Support Bug Check 0xEF: CRITICAL_PROCESS_DIED Documentation').

diagnosis_detail(motherboard_post_failure,
    'Motherboard POST Initialization Failure / BIOS Corruption',
    'System fans spin but hardware handshaking halts; keyboard lock indicators remain unpowered.',
    'Perform a clear-CMOS jumper reset, inspect motherboard for swollen capacitors, or reflash BIOS.',
    'Motherboard Hardware Diagnostic & Repair Standards').

diagnosis_detail(insufficient_psu_wattage,
    'PSU Power Spike Capacity Shortage',
    'Under maximum 3D rendering load, transient power spikes cause immediate system reset without BSOD logs.',
    'Upgrade the power supply unit to a higher continuous wattage unit certified 80-Plus Gold.',
    'CompTIA A+ Section 5.3 System Power Budgeting Manual').

diagnosis_detail(dhcp_apipa_issue,
    'DHCP Server Assignment Failure (APIPA 169.254.x.x)',
    'The computer failed to obtain a DHCP lease and assigned itself an Automatic Private IP Address.',
    'Restart local router DHCP service and execute "ipconfig /renew" in command prompt.',
    'Cisco CCNA 200-301 Official Cert Guide: IPv4 Dynamic Configuration').

diagnosis_detail(ip_conflict,
    'Duplicate IP Address Conflict in Local Subnet',
    'Two network adapters on the local subnet are asserting ownership over the same static IP address.',
    'Change adapter configuration to Obtain an IP address automatically (DHCP) or assign an unused address.',
    'Cisco Networking Troubleshooting Guide - Subnet Host Allocation').

diagnosis_detail(dns_resolution_failure,
    'DNS Name Resolution Failure',
    'Outbound layer-3 ICMP ping to public IP (8.8.8.8) succeeds, but domain names cannot be resolved.',
    'Manually reconfigure network adapter DNS servers to public resolvers: 8.8.8.8 and 1.1.1.1.',
    'CompTIA Network+ N10-008 Objective 2.4 - Network Services').

diagnosis_detail(default_gateway_unreachable,
    'Local Router Default Gateway Unreachable',
    'The network interface is active, but ARP/ICMP packets fail to reach the local router gateway address.',
    'Inspect Ethernet wiring, verify local router LAN interface is active, and power-cycle router.',
    'CompTIA Network+ Basic Connectivity Flowcharts').

diagnosis_detail(isp_uplink_down,
    'ISP Uplink Outage / WAN Disconnected',
    'Local Wi-Fi authentication succeeds, but the modem WAN uplink fails to reach external provider nodes.',
    'Check modem WAN status light indicators and contact Internet Service Provider (ISP).',
    'TP-Link / Netgear Broadband Diagnostic Guidelines').

diagnosis_detail(wifi_channel_interference,
    '2.4GHz Wireless Frequency Congestion & Interference',
    'Dense overlapping wireless networks on identical channels degrade SNR and cause packet loss.',
    'Log into Wi-Fi router settings and change channel allocation to non-overlapping channels 1, 6, or 11.',
    'IEEE 802.11 Wireless Networking Operational Standards').

diagnosis_detail(faulty_ethernet_cable,
    'Degraded / Damaged 8-Pin Ethernet Cable',
    'Gigabit network interface negotiates down to Fast Ethernet (100 Mbps) due to damaged conductor pins.',
    'Test cable with an RJ-45 continuity tester or replace with a certified Cat6 patch cable.',
    'TIA/EIA-568-C Commercial Building Telecommunications Cabling Standard').

diagnosis_detail(network_switch_congestion,
    'Network Switch Buffer Congestion or Packet Degradation',
    'Excessive packet collisions or switch buffer exhaustion lead to sustained packet drop rates above 20%.',
    'Power cycle network switch and disconnect loopback cables causing broadcast storms.',
    'Cisco LAN Switching and Campus Network Troubleshooting Manual').

% -----------------------------------------------------------------------------
% INFERENCE ENGINE
% -----------------------------------------------------------------------------
verify(Symptom) :-
    yes(Symptom), !.
verify(Symptom) :-
    no(Symptom), !, fail.
verify(Symptom) :-
    ask(Symptom, Answer),
    ( Answer == y ->
        assertz(yes(Symptom))
    ;
        assertz(no(Symptom)),
        fail
    ).

ask(power_button_pressed_no_power_or_fans, A) :-
    prompt_user('When pressing the power button, are there NO lights and NO fan spin at all?', A).
ask(wall_outlet_and_cable_working, A) :-
    prompt_user('Have you verified that the wall outlet and AC power cord are functional?', A).
ask(system_powers_on, A) :-
    prompt_user('Does the system power on (fans spin / LEDs light up)?', A).
ask(one_long_two_short_beeps, A) :-
    prompt_user('Do you hear 1 long beep followed by 2 short beeps from the motherboard?', A).
ask(continuous_long_beeps, A) :-
    prompt_user('Do you hear continuous repeating long beeps?', A).
ask(no_display_output, A) :-
    prompt_user('Is the monitor completely black with "No Signal" message?', A).
ask(shutdowns_after_few_minutes, A) :-
    prompt_user('Does the computer shut down abruptly after 5-10 minutes of operation?', A).
ask(cpu_fan_runs_at_max_speed, A) :-
    prompt_user('Does the CPU cooler fan spin loudly at maximum speed before shutdown?', A).
ask(bios_post_completes, A) :-
    prompt_user('Does the BIOS splash screen appear without hardware beep errors?', A).
ask(no_bootable_device_error, A) :-
    prompt_user('Do you see a "No Bootable Device Found" or "Insert Boot Media" screen?', A).
ask(windows_loads_partially, A) :-
    prompt_user('Does Windows begin loading before crashing with a Blue Screen?', A).
ask(bsod_irql_not_less_or_equal, A) :-
    prompt_user('Does the Blue Screen display the stop code "IRQL_NOT_LESS_OR_EQUAL"?', A).
ask(display_flickers_black, A) :-
    prompt_user('Does the computer screen flicker black intermittently during normal desktop use?', A).
ask(display_driver_stopped_responding_alert, A) :-
    prompt_user('Does Windows display "Display driver stopped responding and has recovered"?', A).
ask(storage_response_extremely_slow, A) :-
    prompt_user('Is storage access freezing and showing 100% disk usage in Task Manager?', A).
ask(clicking_sound_from_drive, A) :-
    prompt_user('Do you hear abnormal mechanical clicking or grinding sounds from the drive?', A).
ask(system_clock_resets_on_reboot, A) :-
    prompt_user('Does the system clock/date reset to a past year after turning off the power?', A).
ask(bios_settings_reset_to_default, A) :-
    prompt_user('Do custom BIOS settings revert back to default after power cut?', A).
ask(random_sudden_crash, A) :-
    prompt_user('Does Windows crash suddenly with a Blue Screen at unpredictable intervals?', A).
ask(bsod_critical_process_died, A) :-
    prompt_user('Does the crash screen show stop code "CRITICAL_PROCESS_DIED"?', A).
ask(fans_spin_but_no_display, A) :-
    prompt_user('Do system fans spin continuously with black screen and no beep codes at all?', A).
ask(keyboard_caps_lock_not_responding, A) :-
    prompt_user('Does pressing Caps Lock on the keyboard fail to toggle the keyboard LED?', A).
ask(pc_restarts_during_heavy_gaming, A) :-
    prompt_user('Does the PC abruptly restart or shut off during demanding gaming/rendering?', A).
ask(no_bsod_dump_file_created, A) :-
    prompt_user('Does the shutdown happen instantly without generating any BSOD crash dump?', A).
ask(ip_starts_with_169_254, A) :-
    prompt_user('Does "ipconfig" show an IPv4 address starting with 169.254.x.x?', A).
ask(no_lan_or_internet_access, A) :-
    prompt_user('Is both local network access and internet connection unavailable?', A).
ask(intermittent_network_drop, A) :-
    prompt_user('Does network connectivity disconnect and reconnect unpredictably?', A).
ask(ip_address_conflict_warning_shown, A) :-
    prompt_user('Does Windows display an "IP address conflict detected" notification?', A).
ask(ping_8_8_8_8_successful, A) :-
    prompt_user('Can you successfully ping public IP 8.8.8.8 in command prompt?', A).
ask(browser_cannot_open_domain_names, A) :-
    prompt_user('Are web browsers unable to open websites (e.g. google.com)?', A).
ask(ethernet_cable_plugged_in, A) :-
    prompt_user('Is the Ethernet LAN cable firmly plugged in with port lights blinking?', A).
ask(cannot_ping_local_router_gateway, A) :-
    prompt_user('Does pinging your local router gateway IP (e.g., 192.168.1.1) time out?', A).
ask(connected_to_wifi_successfully, A) :-
    prompt_user('Is the device connected to the Wi-Fi Access Point successfully?', A).
ask(no_internet_secured_status_shown, A) :-
    prompt_user('Does Wi-Fi show "Connected, no internet" or "No Internet, secured"?', A).
ask(router_wan_internet_led_red_or_off, A) :-
    prompt_user('Is the WAN/Internet LED indicator on the router red, orange, or OFF?', A).
ask(wifi_signal_drops_near_router, A) :-
    prompt_user('Does Wi-Fi signal/speed drop severely despite being close to the router?', A).
ask(multiple_neighboring_wifi_networks_present, A) :-
    prompt_user('Are there many other strong Wi-Fi networks visible in your surroundings?', A).
ask(gigabit_lan_port_available, A) :-
    prompt_user('Do both your router port and PC NIC support 1 Gbps Gigabit speed?', A).
ask(link_speed_capped_at_100_mbps, A) :-
    prompt_user('Is the network adapter link speed strictly negotiating at only 100 Mbps?', A).
ask(high_packet_loss_above_20_percent, A) :-
    prompt_user('Does pinging network hosts show packet loss exceeding 20%?', A).
ask(local_network_latency_spikes, A) :-
    prompt_user('Are ping latency responses fluctuating with extreme spikes (100ms+)?', A).

prompt_user(Question, Answer) :-
    format('~w (y/n): ', [Question]),
    read_line_to_string(user_input, RawString),
    normalize_space(atom(CleanAtom), RawString),
    downcase_atom(CleanAtom, LowerAtom),
    ( sub_atom(LowerAtom, 0, 1, _, y) ->
        Answer = y
    ; sub_atom(LowerAtom, 0, 1, _, n) ->
        Answer = n
    ;
        write('Please type "y" for yes or "n" for no.'), nl,
        prompt_user(Question, Answer)
    ).

clear_memory :-
    retractall(yes(_)),
    retractall(no(_)).