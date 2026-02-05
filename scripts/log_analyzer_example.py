#!/usr/bin/env python3
"""
Security Log Analyzer - Demonstration Script
Shows log analysis capabilities using simulated data
No real production data or sensitive information included
"""

import re
from datetime import datetime
from collections import defaultdict


class SecurityLogAnalyzer:
    """Demonstrates log analysis techniques for security monitoring"""
    
    def __init__(self):
        # Threat patterns for demonstration (simulated data only)
        self.threat_patterns = {
            'malware': r'(?i)malware|virus|trojan|ransomware',
            'brute_force': r'(?i)brute.*force|multiple.*failed.*login',
            'sqli': r'(?i)sql.*injection|injection.*attempt',
            'phishing': r'(?i)phishing|suspicious.*email',
            'ddos': r'(?i)ddos|flood|traffic.*anomaly',
            'unauthorized_access': r'(?i)unauthorized|access.*denied|permission.*denied'
        }
        
    def analyze_logs(self, simulated_logs):
        """
        Analyze simulated security logs
        
        Args:
            simulated_logs (str): Mock log data for demonstration
            
        Returns:
            dict: Analysis results with simulated findings
        """
        results = {
            'analysis_timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
            'total_log_entries': 0,
            'threats_detected': [],
            'ip_activity': defaultdict(int),
            'severity_counts': {'LOW': 0, 'MEDIUM': 0, 'HIGH': 0, 'CRITICAL': 0},
            'summary': {}
        }
        
        # Split logs into lines
        lines = simulated_logs.strip().split('\n')
        results['total_log_entries'] = len(lines)
        
        # Analyze each line (simulated data only)
        for line_num, line in enumerate(lines, 1):
            # Simulated IP extraction (using mock IPs)
            ip_match = re.search(r'\b(?:192\.168|10\.|172\.(?:1[6-9]|2[0-9]|3[0-1]))\.\d{1,3}\.\d{1,3}\b', line)
            if ip_match:
                results['ip_activity'][ip_match.group()] += 1
            
            # Check for simulated threat patterns
            for threat_name, pattern in self.threat_patterns.items():
                if re.search(pattern, line, re.IGNORECASE):
                    # Simulated severity assignment
                    severity = self._assign_simulated_severity(threat_name)
                    results['severity_counts'][severity] += 1
                    
                    results['threats_detected'].append({
                        'line': line_num,
                        'threat_type': threat_name.upper(),
                        'severity': severity,
                        'timestamp': datetime.now().strftime('%H:%M:%S'),
                        'sample_data': line[:80] + '...' if len(line) > 80 else line
                    })
        
        # Generate summary statistics
        results['summary'] = {
            'total_threats': len(results['threats_detected']),
            'unique_threat_types': len(set(t['threat_type'] for t in results['threats_detected'])),
            'most_active_ip': max(results['ip_activity'].items(), key=lambda x: x[1]) if results['ip_activity'] else None,
            'highest_severity': max(results['severity_counts'].items(), key=lambda x: x[1])[0] if any(results['severity_counts'].values()) else 'NONE'
        }
        
        return results
    
    def _assign_simulated_severity(self, threat_type):
        """Assign simulated severity levels for demonstration"""
        severity_map = {
            'malware': 'CRITICAL',
            'ddos': 'HIGH',
            'sqli': 'HIGH',
            'brute_force': 'MEDIUM',
            'unauthorized_access': 'MEDIUM',
            'phishing': 'LOW'
        }
        return severity_map.get(threat_type, 'LOW')
    
    def generate_report(self, results):
        """Generate formatted security report"""
        report = []
        report.append("=" * 70)
        report.append("SECURITY LOG ANALYSIS REPORT - DEMONSTRATION ONLY")
        report.append("=" * 70)
        report.append(f"Analysis Time: {results['analysis_timestamp']}")
        report.append(f"Log Entries Analyzed: {results['total_log_entries']}")
        report.append(f"Total Threats Detected: {results['summary']['total_threats']}")
        report.append(f"Unique Threat Types: {results['summary']['unique_threat_types']}")
        
        if results['threats_detected']:
            report.append("\n" + "-" * 70)
            report.append("DETECTED THREATS (Simulated Data):")
            report.append("-" * 70)
            
            for i, threat in enumerate(results['threats_detected'][:5], 1):  # Show first 5 only
                report.append(f"\n{i}. [{threat['severity']}] {threat['threat_type']}")
                report.append(f"   Line {threat['line']}: {threat['sample_data']}")
                report.append(f"   Time: {threat['timestamp']}")
        
        if results['ip_activity']:
            report.append("\n" + "-" * 70)
            report.append("IP ACTIVITY SUMMARY (Simulated IPs):")
            report.append("-" * 70)
            
            for ip, count in list(results['ip_activity'].items())[:3]:  # Show top 3
                report.append(f"  {ip}: {count} occurrences")
        
        report.append("\n" + "-" * 70)
        report.append("SEVERITY DISTRIBUTION:")
        report.append("-" * 70)
        
        for severity, count in results['severity_counts'].items():
            if count > 0:
                report.append(f"  {severity}: {count} events")
        
        report.append("\n" + "=" * 70)
        report.append("NOTE: This analysis uses SIMULATED DATA only.")
        report.append("No real production data or sensitive information is included.")
        report.append("=" * 70)
        
        return "\n".join(report)


def get_simulated_logs():
    """Generate simulated log data for demonstration"""
    return """
2024-02-06 08:15:23 [INFO] Firewall started successfully
2024-02-06 08:30:45 [WARNING] Multiple failed login attempts from 192.168.1.105
2024-02-06 09:12:10 [ALERT] Possible malware signature detected in file download
2024-02-06 09:45:33 [INFO] User authentication successful for admin@example.com
2024-02-06 10:20:15 [CRITICAL] SQL injection attempt blocked from 10.0.0.22
2024-02-06 11:05:47 [WARNING] Unauthorized access attempt to sensitive directory
2024-02-06 11:30:12 [INFO] System backup completed
2024-02-06 12:15:30 [ALERT] DDoS attack detected from multiple IPs
2024-02-06 13:40:55 [WARNING] Phishing email detected in user mailbox
2024-02-06 14:25:18 [INFO] Security policy updated
2024-02-06 15:10:42 [ALERT] Brute force attack in progress from 172.16.254.1
2024-02-06 16:00:05 [INFO] Antivirus definitions updated
2024-02-06 16:45:29 [WARNING] Suspicious outbound connection to unknown host
2024-02-06 17:30:52 [INFO] Network scan completed - no vulnerabilities found
"""


def main():
    """Main function - demonstrates log analysis capabilities"""
    print("\n" + "=" * 70)
    print("SECURITY LOG ANALYZER - PORTFOLIO DEMONSTRATION")
    print("=" * 70)
    print("This script demonstrates log analysis techniques using")
    print("simulated data. No real production information is used.")
    print("=" * 70 + "\n")
    
    # Create analyzer instance
    analyzer = SecurityLogAnalyzer()
    
    # Get simulated logs
    simulated_logs = get_simulated_logs()
    
    print("Analyzing simulated security logs...\n")
    
    # Perform analysis
    results = analyzer.analyze_logs(simulated_logs)
    
    # Generate and display report
    report = analyzer.generate_report(results)
    print(report)
    
    print("\n" + "=" * 70)
    print("DEMONSTRATION COMPLETE")
    print("=" * 70)
    print("This script shows:")
    print("• Log parsing and analysis capabilities")
    print("• Threat detection logic")
    print("• Report generation skills")
    print("• Python programming proficiency")
    print("=" * 70)


if __name__ == "__main__":
    main()
