#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

CONFIG_FILE="$BASE_DIR/config.cfg"
CHECK_DIR="$BASE_DIR/checks"
LOG_FILE="$BASE_DIR/logs/health.log"
REPORT_FILE="$BASE_DIR/reports/report.html"

source "$CONFIG_FILE"

mkdir -p "$BASE_DIR/logs"
mkdir -p "$BASE_DIR/reports"


run_checks() {

echo "=============================="
echo " Server Health Monitor Report "
echo "=============================="
echo "Timestamp: $(date)"
echo ""

bash "$CHECK_DIR/cpu.sh"
bash "$CHECK_DIR/memory.sh"
bash "$CHECK_DIR/disk.sh"
bash "$CHECK_DIR/services.sh"

echo ""
echo "Health check completed."

}


generate_report() {

CPU_STATUS=$(grep CPU "$LOG_FILE" | tail -1 | awk '{print $4}')
CPU_VALUE=$(grep CPU "$LOG_FILE" | tail -1 | awk '{print $5}')

MEM_STATUS=$(grep MEMORY "$LOG_FILE" | tail -1 | awk '{print $4}')
MEM_VALUE=$(grep MEMORY "$LOG_FILE" | tail -1 | awk '{print $5}')

DISK_STATUS=$(grep DISK "$LOG_FILE" | tail -1 | awk '{print $4}')
DISK_VALUE=$(grep DISK "$LOG_FILE" | tail -1 | awk '{print $5}')


cat <<EOF > "$REPORT_FILE"

<html>

<head>

<title>Server Health Monitoring Report</title>

<style>

body {
font-family: Arial, sans-serif;
background-color: #0f172a;
color: #e5e7eb;
padding: 30px;
}

h2 {
color: #38bdf8;
}

table {
border-collapse: collapse;
width: 70%;
margin-top: 20px;
}

th {
background-color: #1e293b;
padding: 12px;
}

td {
padding: 12px;
text-align: center;
}

.pass {
background-color: #14532d;
color: #bbf7d0;
}

.alert {
background-color: #7f1d1d;
color: #fecaca;
}

.logbox {
background: #020617;
padding: 15px;
margin-top: 20px;
border-radius: 8px;
}

</style>

</head>


<body>

<h2>Server Health Monitoring Report</h2>

<p><strong>Generated:</strong> $(date)</p>


<table>

<tr>
<th>Metric</th>
<th>Usage</th>
<th>Threshold</th>
<th>Status</th>
</tr>

EOF


write_row() {

METRIC=$1
VALUE=$2
THRESHOLD=$3
STATUS=$4

if [ "$STATUS" = "PASS" ]
then
CLASS="pass"
else
CLASS="alert"
fi

echo "<tr class='$CLASS'>
<td>$METRIC</td>
<td>$VALUE</td>
<td>$THRESHOLD%</td>
<td>$STATUS</td>
</tr>" >> "$REPORT_FILE"

}


write_row "CPU" "$CPU_VALUE" "$CPU_THRESHOLD" "$CPU_STATUS"
write_row "Memory" "$MEM_VALUE" "$MEMORY_THRESHOLD" "$MEM_STATUS"
write_row "Disk" "$DISK_VALUE" "$DISK_THRESHOLD" "$DISK_STATUS"


echo "</table>" >> "$REPORT_FILE"


echo "<div class='logbox'>" >> "$REPORT_FILE"
echo "<h3>Last 10 Log Entries</h3>" >> "$REPORT_FILE"
echo "<pre>" >> "$REPORT_FILE"

tail -10 "$LOG_FILE" >> "$REPORT_FILE"

echo "</pre>" >> "$REPORT_FILE"
echo "</div>" >> "$REPORT_FILE"


cat <<EOF >> "$REPORT_FILE"

</body>
</html>

EOF


echo "HTML report generated at: $REPORT_FILE"

}


run_checks
generate_report
