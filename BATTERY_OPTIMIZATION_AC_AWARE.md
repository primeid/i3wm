# Battery Optimization - AC/Battery Aware

**Goal:** Full performance on AC, maximum battery on battery
**System:** Pop!_OS with system76-power (already installed!)

---

## ✅ GOOD NEWS

**system76-power is already running!**
- Automatically switches CPU governor based on AC/Battery
- **On AC:** `performance` mode (full power) ✅
- **On Battery:** `balanced` or `battery` mode (power saving) ✅
- No need to install TLP (would conflict)

---

## 🚀 OPTIMIZATIONS TO APPLY

These work WITH system76-power and don't interfere with AC performance:

### **1. Install PowerTOP for Additional Tuning** ⭐⭐⭐⭐
**Impact:** 5-10% battery savings (on battery only)

```bash
sudo apt install -y powertop
sudo powertop --auto-tune
```

PowerTOP applies optimizations that don't affect AC performance:
- USB autosuspend
- Audio power saving
- SATA link power management
- NMI watchdog disable
- VM writeback timeout

---

### **2. Stop COSMIC Services When Using i3** ⭐⭐⭐⭐⭐
**Impact:** 50-100MB RAM, 5-10% battery (AC and Battery)

Create startup script to stop unnecessary COSMIC services:

```bash
cat > ~/.config/i3/startup.sh << 'EOF'
#!/bin/bash
# Stop COSMIC services when using i3 (saves RAM and battery)

# Stop COSMIC services
systemctl --user stop cosmic-comp.service 2>/dev/null
systemctl --user stop cosmic-greeter.service 2>/dev/null
systemctl --user stop cosmic-app-library.service 2>/dev/null
systemctl --user stop cosmic-launcher.service 2>/dev/null
systemctl --user stop cosmic-osd.service 2>/dev/null
systemctl --user stop cosmic-workspaces.service 2>/dev/null
systemctl --user stop cosmic-files-applet.service 2>/dev/null
systemctl --user stop cosmic-bg.service 2>/dev/null
systemctl --user stop cosmic-idle.service 2>/dev/null

# Kill remaining COSMIC processes
pkill -f "cosmic-comp" 2>/dev/null
pkill -f "cosmic-greeter" 2>/dev/null
pkill -f "cosmic-app-library" 2>/dev/null
pkill -f "xdg-desktop-portal-cosmic" 2>/dev/null

echo "COSMIC services stopped for i3 session"
EOF

chmod +x ~/.config/i3/startup.sh
```

---

### **3. Disable Unused Services** ⭐⭐⭐
**Impact:** 20-50MB RAM, 2-5% battery

```bash
# Geoclue (location services) - usually not needed
systemctl --user disable geoclue-demo-agent
systemctl --user stop geoclue-demo-agent

# Tracker (file indexing) - if not needed
systemctl --user mask tracker-store.service
systemctl --user mask tracker-miner-fs.service
systemctl --user mask tracker-extract.service
```

---

### **4. Disable Bluetooth if Not Used** ⭐⭐⭐
**Impact:** 5-10% battery savings

**If you don't use Bluetooth:**
```bash
sudo systemctl disable bluetooth
sudo systemctl stop bluetooth
```

**Also comment out in i3/config (line 28):**
```bash
# exec_always blueman-applet
```

---

### **5. Use system76-power Profiles** ⭐⭐⭐⭐⭐
**Impact:** Intelligent switching

```bash
# Check current profile
system76-power profile

# Profiles available:
# - performance (AC default) - Full power
# - balanced (Battery default) - Balance
# - battery (Manual) - Maximum savings

# Manually switch (if needed)
system76-power profile battery  # Max savings
system76-power profile performance  # Max performance
system76-power profile balanced  # Balanced
```

**Note:** system76-power automatically switches when you plug/unplug AC!

---

### **6. Create PowerTOP Systemd Service (Optional)** ⭐⭐⭐
**Impact:** Automatic power tuning on boot

```bash
sudo bash -c 'cat > /etc/systemd/system/powertop.service << "EOF"
[Unit]
Description=PowerTOP auto tune
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/sbin/powertop --auto-tune

[Install]
WantedBy=multi-user.target
EOF'

sudo systemctl enable powertop.service
```

---

## 📊 EXPECTED RESULTS

| Optimization | AC Impact | Battery Impact | Always On |
|--------------|-----------|----------------|-----------|
| system76-power | ✅ Full performance | 🔋 Powersave | ✅ Yes |
| PowerTOP auto-tune | ✅ No impact | 🔋 5-10% savings | ✅ Yes |
| Stop COSMIC services | ✅ Less RAM | 🔋 5-10% savings | ✅ Yes |
| Disable services | ✅ Less RAM | 🔋 2-5% savings | ✅ Yes |
| Disable Bluetooth | ✅ Less RAM | 🔋 5-10% savings | ⚠️ Optional |
| **TOTAL** | ✅ **Full speed** | 🔋 **17-35% savings** | - |

---

## 🎯 IMPLEMENTATION PLAN

### **Step 1: Install PowerTOP**
```bash
sudo apt install -y powertop
```

### **Step 2: Apply PowerTOP Tuning**
```bash
sudo powertop --auto-tune
```

### **Step 3: Create i3 Startup Script**
```bash
# Already shown above - creates ~/.config/i3/startup.sh
```

### **Step 4: Add to i3 Config**
Add to i3/config after line 10:
```bash
exec_always --no-startup-id ~/.config/i3/startup.sh
```

### **Step 5: Disable Unused Services**
```bash
systemctl --user disable geoclue-demo-agent
systemctl --user stop geoclue-demo-agent
systemctl --user mask tracker-store tracker-miner-fs tracker-extract
```

### **Step 6: (Optional) Disable Bluetooth**
```bash
# Only if you don't use Bluetooth
sudo systemctl disable bluetooth
sudo systemctl stop bluetooth
```

### **Step 7: (Optional) Make PowerTOP Permanent**
```bash
# Create systemd service (shown above)
```

---

## ✅ VERIFICATION

### Check system76-power is working:
```bash
# Check current profile
system76-power profile

# On AC should show: performance
# On battery should show: balanced or battery
```

### Check CPU governor:
```bash
# On AC
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
# Should show: performance

# On battery (unplug and check again)
# Should show: powersave or schedutil
```

### Check PowerTOP applied:
```bash
sudo powertop
# Go to "Tunables" tab, all should be "Good"
```

### Check COSMIC services stopped:
```bash
systemctl --user list-units | grep cosmic
# Should show fewer or no running services
```

---

## 🎉 SUMMARY

**System76-power advantages:**
- ✅ Optimized for System76/Pop!_OS hardware
- ✅ Automatic AC/Battery detection
- ✅ Graphics switching (if you have hybrid graphics)
- ✅ Already configured properly
- ✅ No manual configuration needed

**Our additions:**
- ✅ PowerTOP for additional USB/device tuning
- ✅ Stop COSMIC services to save RAM
- ✅ Disable unused services
- ✅ Optional Bluetooth disable

**Result:**
- 🔌 **On AC:** Full performance (no compromise)
- 🔋 **On Battery:** 17-35% better battery life
- 💾 **Always:** 70-150MB RAM saved

---

## ⚠️ IMPORTANT

**DO NOT install TLP!**
- TLP conflicts with system76-power
- system76-power is better for Pop!_OS
- Keep system76-power enabled

**Keep these enabled:**
- system76-power daemon ✅
- thermald (thermal management) ✅

---

**Strategy:** Use system76-power for CPU/GPU, add PowerTOP for peripherals, stop COSMIC bloat.

**Result:** Best of both worlds - performance when needed, battery when unplugged!
