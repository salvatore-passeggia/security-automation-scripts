<#
.SYNOPSIS
Security Automation Demonstration Script
Demonstrates PowerShell automation capabilities for security operations

.DESCRIPTION
This script shows security automation techniques using simulated data.
No real production data, credentials, or sensitive information is included.

.NOTES
Author: Salvatore Passeggia
Date: February 2026
Purpose: Portfolio demonstration only
#>

# ============================================================================
# CONFIGURATION - SIMULATED DATA ONLY
# ============================================================================
$Script:Config = @{
    CompanyName = "DemoCorp Security"
    LogFilePath = ".\simulated_security_logs.txt"
    ReportPath  = ".\security_report_$(Get-Date -Format 'yyyyMMdd_HHmmss').html"
    MaxEvents   = 50
}

# ============================================================================
# SECURITY EVENT SIMULATION
# ============================================================================
function Get-SimulatedSecurityEvents {
    <#
    .SYNOPSIS
    Generates simulated security events for demonstration
    
    .DESCRIPTION
    Creates mock security events to demonstrate analysis capabilities.
    All data is fictional and generated for portfolio purposes only.
    #>
    
    $simulatedEvents = @()
    $eventTemplates = @(
        @{Type="Firewall"; Severity="INFO"; Message="Firewall rule applied successfully"},
        @{Type="Authentication"; Severity="WARNING"; Message="Multiple failed login attempts from 192.168.1.105"},
        @{Type="Malware"; Severity="HIGH"; Message="Potential malware signature detected in downloaded file"},
        @{Type="Network"; Severity="INFO"; Message="Network scan completed - no vulnerabilities found"},
        @{Type="Access"; Severity="MEDIUM"; Message="Unauthorized access attempt to restricted directory"},
        @{Type="Compliance"; Severity="INFO"; Message="Security policy compliance check passed"},
        @{Type="Threat"; Severity="CRITICAL"; Message="SQL injection attempt blocked from external IP"},
        @{Type="System"; Severity="INFO"; Message="Antivirus definitions updated successfully"},
        @{Type="Email"; Severity="MEDIUM"; Message="Phishing email detected and quarantined"},
        @{Type="DDoS"; Severity="HIGH"; Message="DDoS mitigation activated - attack blocked"}
    )
    
    # Generate simulated events
    for ($i = 1; $i -le $Script:Config.MaxEvents; $i++) {
        $template = $eventTemplates | Get-Random
        $timestamp = (Get-Date).AddMinutes(-$i).ToString("yyyy-MM-dd HH:mm:ss")
        
        $event = [PSCustomObject]@{
            Id        = $i
            Timestamp = $timestamp
            Type      = $template.Type
            Severity  = $template.Severity
            Message   = $template.Message
            SourceIP  = "192.168.$((Get-Random -Minimum 1 -Maximum 254)).$((Get-Random -Minimum 1 -Maximum 254))"
            User      = "user$(Get-Random -Minimum 1000 -Maximum 9999)@democorp.com"
        }
        
        $simulatedEvents += $event
    }
    
    return $simulatedEvents
}

# ============================================================================
# SECURITY ANALYSIS FUNCTIONS
# ============================================================================
function Get-SecuritySummary {
    <#
    .SYNOPSIS
    Analyzes simulated security events and generates summary
    
    .DESCRIPTION
    Processes security events to identify patterns, threats, and generate reports.
    Uses only simulated data for demonstration.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [array]$SecurityEvents
    )
    
    Write-Host "`n[ANALYSIS] Analyzing $($SecurityEvents.Count) security events..." -ForegroundColor Cyan
    
    # Count events by type
    $typeSummary = $SecurityEvents | Group-Object Type | ForEach-Object {
        [PSCustomObject]@{
            EventType = $_.Name
            Count = $_.Count
            Percentage = [math]::Round(($_.Count / $SecurityEvents.Count) * 100, 2)
        }
    }
    
    # Count events by severity
    $severitySummary = $SecurityEvents | Group-Object Severity | ForEach-Object {
        [PSCustomObject]@{
            Severity = $_.Name
            Count = $_.Count
        }
    }
    
    # Identify potential threats
    $threatEvents = $SecurityEvents | Where-Object {
        $_.Severity -in @("HIGH", "CRITICAL", "MEDIUM") -and 
        $_.Type -in @("Malware", "Threat", "DDoS", "Access")
    }
    
    # Top source IPs (simulated)
    $topIPs = $SecurityEvents | Group-Object SourceIP | 
              Sort-Object Count -Descending | 
              Select-Object -First 5
    
    return [PSCustomObject]@{
        TotalEvents     = $SecurityEvents.Count
        TypeSummary     = $typeSummary
        SeveritySummary = $severitySummary
        ThreatCount     = $threatEvents.Count
        TopIPs          = $topIPs
        AnalysisTime    = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    }
}

# ============================================================================
# REPORT GENERATION
# ============================================================================
function New-SecurityReport {
    <#
    .SYNOPSIS
    Generates HTML security report from analysis results
    
    .DESCRIPTION
    Creates professional HTML report showing security analysis findings.
    All data is simulated for portfolio demonstration.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [PSCustomObject]$AnalysisResults
    )
    
    $htmlReport = @"
<!DOCTYPE html>
<html>
<head>
    <title>Security Analysis Report - Demonstration</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; margin: 40px; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #2c3e50; border-bottom: 3px solid #3498db; padding-bottom: 10px; }
        h2 { color: #34495e; margin-top: 30px; }
        .summary-box { background: #ecf0f1; padding: 20px; border-radius: 5px; margin: 20px 0; }
        .alert { padding: 15px; border-radius: 5px; margin: 10px 0; }
        .alert-high { background: #ffebee; border-left: 5px solid #f44336; }
        .alert-medium { background: #fff3e0; border-left: 5px solid #ff9800; }
        .alert-low { background: #e8f5e8; border-left: 5px solid #4caf50; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #3498db; color: white; }
        .note { background: #fffde7; padding: 15px; border-radius: 5px; margin-top: 30px; border-left: 5px solid #ffeb3b; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔒 Security Analysis Report</h1>
        <p><strong>Generated:</strong> $($AnalysisResults.AnalysisTime)</p>
        <p><strong>Company:</strong> $($Script:Config.CompanyName)</p>
        
        <div class="summary-box">
            <h2>📊 Executive Summary</h2>
            <p><strong>Total Events Analyzed:</strong> $($AnalysisResults.TotalEvents)</p>
            <p><strong>Potential Threats Identified:</strong> $($AnalysisResults.ThreatCount)</p>
            <p><strong>Analysis Scope:</strong> Portfolio Demonstration Only</p>
        </div>
        
        <h2>⚠️ Security Events by Severity</h2>
        <table>
            <tr><th>Severity Level</th><th>Count</th><th>Percentage</th></tr>
"@

    foreach ($severity in $AnalysisResults.SeveritySummary) {
        $percentage = [math]::Round(($severity.Count / $AnalysisResults.TotalEvents) * 100, 2)
        $htmlReport += "<tr><td>$($severity.Severity)</td><td>$($severity.Count)</td><td>$percentage%</td></tr>`n"
    }

    $htmlReport += @"
        </table>
        
        <h2>📈 Event Type Distribution</h2>
        <table>
            <tr><th>Event Type</th><th>Count</th><th>Percentage</th></tr>
"@

    foreach ($type in $AnalysisResults.TypeSummary) {
        $htmlReport += "<tr><td>$($type.EventType)</td><td>$($type.Count)</td><td>$($type.Percentage)%</td></tr>`n"
    }

    $htmlReport += @"
        </table>
        
        <div class="alert alert-high">
            <h3>🚨 Key Findings</h3>
            <ul>
                <li>All data in this report is simulated for demonstration purposes</li>
                <li>Script demonstrates PowerShell automation and reporting capabilities</li>
                <li>No real production data or sensitive information is included</li>
            </ul>
        </div>
        
        <div class="note">
            <h3>📝 Important Note</h3>
            <p>This report is generated from simulated data as part of a technical portfolio demonstration. 
            It showcases PowerShell scripting, data analysis, and reporting skills for security operations. 
            All IP addresses, usernames, and event details are fictional.</p>
        </div>
        
        <p style="margin-top: 40px; text-align: center; color: #7f8c8d;">
            Report generated by Security Automation Demo Script • $(Get-Date -Format 'yyyy-MM-dd')
        </p>
    </div>
</body>
</html>
"@

    # Save report to file
    $htmlReport | Out-File -FilePath $Script:Config.ReportPath -Encoding UTF8
    
    return $Script:Config.ReportPath
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================
function Start-SecurityAutomationDemo {
    <#
    .SYNOPSIS
    Main function that runs the security automation demonstration
    
    .DESCRIPTION
    Orchestrates the entire demonstration workflow:
    1. Generate simulated security events
    2. Analyze events for patterns and threats
    3. Generate professional HTML report
    4. Display results in console
    #>
    
    Clear-Host
    
    Write-Host "`n" -NoNewline
    Write-Host "=" * 70 -ForegroundColor Cyan
    Write-Host "🔒 SECURITY AUTOMATION DEMONSTRATION" -ForegroundColor Yellow
    Write-Host "=" * 70 -ForegroundColor Cyan
    Write-Host "This script demonstrates PowerShell automation capabilities" -ForegroundColor White
    Write-Host "for security operations using simulated data only." -ForegroundColor White
    Write-Host "=" * 70 -ForegroundColor Cyan
    Write-Host "`n"
    
    # Step 1: Generate simulated events
    Write-Host "[1/3] Generating simulated security events..." -ForegroundColor Green
    $securityEvents = Get-SimulatedSecurityEvents
    Write-Host "   Generated $($securityEvents.Count) simulated events" -ForegroundColor Gray
    
    # Step 2: Analyze events
    Write-Host "[2/3] Analyzing security events..." -ForegroundColor Green
    $analysisResults = Get-SecuritySummary -SecurityEvents $securityEvents
    
    # Display analysis in console
    Write-Host "`n" + ("-" * 50) -ForegroundColor DarkGray
    Write-Host "ANALYSIS RESULTS" -ForegroundColor Cyan
    Write-Host ("-" * 50) -ForegroundColor DarkGray
    
    Write-Host "Total Events: $($analysisResults.TotalEvents)" -ForegroundColor White
    Write-Host "Potential Threats: $($analysisResults.ThreatCount)" -ForegroundColor White
    
    Write-Host "`nSeverity Breakdown:" -ForegroundColor Cyan
    foreach ($severity in $analysisResults.SeveritySummary) {
        $color = switch ($severity.Severity) {
            "CRITICAL" { "Red" }
            "HIGH"     { "Magenta" }
            "MEDIUM"   { "Yellow" }
            "LOW"      { "Green" }
            default    { "Gray" }
        }
        Write-Host "  $($severity.Severity): $($severity.Count) events" -ForegroundColor $color
    }
    
    # Step 3: Generate HTML report
    Write-Host "`n[3/3] Generating HTML report..." -ForegroundColor Green
    $reportPath = New-SecurityReport -AnalysisResults $analysisResults
    
    Write-Host "`n" + ("=" * 70) -ForegroundColor Cyan
    Write-Host "✅ DEMONSTRATION COMPLETE" -ForegroundColor Green
    Write-Host "=" * 70 -ForegroundColor Cyan
    
    Write-Host "`nSummary of demonstrated capabilities:" -ForegroundColor White
    Write-Host "• PowerShell scripting for security automation" -ForegroundColor Gray
    Write-Host "• Data analysis and pattern detection" -ForegroundColor Gray
    Write-Host "• Professional HTML report generation" -ForegroundColor Gray
    Write-Host "• Event simulation and processing" -ForegroundColor Gray
    Write-Host "• Console and file output management" -ForegroundColor Gray
    
    Write-Host "`nReport saved to: $reportPath" -ForegroundColor Yellow
    Write-Host "`nNote: All data is simulated for portfolio demonstration purposes." -ForegroundColor DarkYellow
    
    Write-Host "`n" + ("=" * 70) -ForegroundColor Cyan
}

# ============================================================================
# SCRIPT EXECUTION
# ============================================================================

# Display warning for first-time users
if ($MyInvocation.MyCommand.Path -eq $null) {
    Write-Host "`n" -NoNewline
    Write-Host "⚠️  IMPORTANT: This script uses SIMULATED DATA only" -ForegroundColor Yellow
    Write-Host "   No real production information is processed or stored" -ForegroundColor Gray
    Write-Host "   Press any key to continue or Ctrl+C to cancel..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Run the demonstration
try {
    Start-SecurityAutomationDemo
}
catch {
    Write-Host "`n❌ Error during demonstration: $_" -ForegroundColor Red
    Write-Host "This is a demonstration script. In production, errors would be handled differently." -ForegroundColor Gray
}
finally {
    Write-Host "`nScript execution completed." -ForegroundColor Gray
}
