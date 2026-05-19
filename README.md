# 🛠️ Bash Scripts Collection

A collection of practical Bash scripts written for real DevOps and system administration use cases.
Built on RHEL Linux as part of hands-on DevOps learning.

---

## 📋 Scripts

| # | Script | Description |
|---|--------|-------------|
| 01 | `01-system-info` | Displays hostname, current user, uptime, RAM, disk, and CPU info |
| 02 | `02-backup-dir` | Interactively backs up a user-specified directory as a timestamped `.tar.gz` archive |
| 03 | `03-log-checker` | Counts today's error entries in `/var/log/messages` and alerts if errors are found |
| 04 | `04-disk-alert` | Checks root partition disk usage and warns if usage exceeds 80% |
| 05 | `05-user-info` | Shows the current logged-in user and last 10 login records with timestamps and IPs |
| 06 | `06-service-checker` | Accepts a list of services from the user and checks if each one is running or stopped |
| 07 | `07-file-organizer` | Organizes files in a directory into subdirectories by extension (images, docs, scripts, others) |
| 08 | `08-port-scanner` | Scans a list of common ports on a given IP and reports which ones are open |
| 09 | `09-health-check` | Full system health report — checks disk, memory, CPU usage and critical service status |
| 10 | `10-log-rotation` | Rotates `/var/log/messages` when it exceeds 50MB, archives it with a timestamp, and keeps the last 5 rotations |
| 11 | `11-deployment` | Clones a git repo, builds a Docker image, tags it, and pushes it to a container registry with error handling |
| 12 | `12-docker-cleaner` | Interactive menu to remove stopped containers, unused images, unused volumes, or do a full system prune |

---

## 🚀 Usage

Clone the repo:
```bash
git clone https://github.com/x091204/scripts.git
cd scripts
```

Make a script executable and run it:
```bash
chmod +x 01-system-info
./01-system-info
```

Or copy to `/usr/local/bin` to run from anywhere:
```bash
sudo cp 01-system-info /usr/local/bin/system-info
system-info
```

---

## 🧰 Tech Used

- Bash scripting
- Linux utilities: `awk`, `grep`, `sed`, `tr`, `cut`, `find`, `tar`, `df`, `free`, `top`, `wc`
- `systemctl` for service management
- Docker CLI
- Git

---

## 📁 Requirements

- RHEL / CentOS / Ubuntu Linux
- Bash 4+
- Docker (for scripts 11 and 12)
- Git (for script 11)
- `sudo` access (for scripts 03, 10)

---

## 👤 Author

**Akif Muhammed**
- GitHub: [@x091204](https://github.com/x091204)
- LinkedIn: [akifmuhammedmc](https://linkedin.com/in/akifmuhammedmc)
