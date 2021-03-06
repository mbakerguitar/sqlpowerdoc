# Code obtained from http://gallery.technet.microsoft.com/ScriptCenter/e8c3af96-db10-45b0-88e3-328f087a8700/

# Type definition for interop

$WTSTypes = @"
using System;
using System.Text;
using System.Runtime.InteropServices;

namespace RDSManager.PowerShell
{
    [StructLayout(LayoutKind.Sequential)]
    public struct WTSSessionInfo
    {
        public Int32 SessionID;
        [MarshalAs(UnmanagedType.LPStr)]
        public String WinStationName;
        public WTSConnectState State;
    }

    public struct WTSSessionInfoEx
    {
        public Int32 ExecEnvId;
        public WTSConnectState State;
        public Int32 SessionID;

        [MarshalAs(UnmanagedType.LPStr)]
        public String SessionName;

        [MarshalAs(UnmanagedType.LPStr)]
        public String HostName;

        [MarshalAs(UnmanagedType.LPStr)]
        public String UserName;

        [MarshalAs(UnmanagedType.LPStr)]
        public String DomainName;

        [MarshalAs(UnmanagedType.LPStr)]
        public String FarmName;
    }

    public enum WTSConnectState
    {
        WTSActive,
        WTSConnected,
        WTSConnectQuery,
        WTSShadow,
        WTSDisconnected,
        WTSIdle,
        WTSListen,
        WTSReset,
        WTSDown,
        WTSInit
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct WTSClient
    {
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 21)]
        public String ClientName;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 18)]
        public String Domain;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 21)]
        public String UserName;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 261)]
        public String WorkDirectory;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 261)]
        public String InitialProgram;
        public byte EncryptionLevel;
        public UInt32 ClientAddressFamily;
        [MarshalAs(UnmanagedType.ByValArray, SizeConst = 31)]
        public UInt16[] ClientAddress;
        public UInt16 HRes;
        public UInt16 VRes;
        public UInt16 ColorDepth;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 261)]
        public String ClientDirectory;
        public UInt32 BuildNumber;
        public UInt32 HardwareId;
        public UInt16 ProductId;
        public UInt16 OutBufCountHost;
        public UInt16 OutBufCountClient;
        public UInt16 OutBufLengh;
    }

    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
    public struct WTSSessionStatus
    {
        public WTSConnectState State;
        public Int32 SessionId;
        public Int32 IncomingBytes;
        public Int32 OutgoingBytes;
        public Int32 IncomingFrames;
        public Int32 OutgoingFrames;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)]
        public String WinStationName;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 17)]
        public String Domain;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 21)]
        public String User;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 56)]
        public String ConnectTime;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 56)]
        public String DisconnectTime;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 56)]
        public String LastInputTime;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 56)]
        public String LogonTime;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 56)]
        public String CurrentTime;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 56)]
        public String IdleTime;
    }

    public enum WTSInfoType
    {
        WTSInitialProgram = 0,
        WTSApplicationName = 1,
        WTSWorkingDirectory = 2,
        WTSOEMId = 3,
        WTSSessionId = 4,
        WTSUserName = 5,
        WTSWinStationName = 6,
        WTSDomainName = 7,
        WTSConnectState = 8,
        WTSClientBuildNumber = 9,
        WTSClientName = 10,
        WTSClientDirectory = 11,
        WTSClientProductId = 12,
        WTSClientHardwareId = 13,
        WTSClientAddress = 14,
        WTSClientDisplay = 15,
        WTSClientProtocolType = 16,
        WTSIdleTime = 17,
        WTSLogonTime = 18,
        WTSIncomingBytes = 19,
        WTSOutgoingBytes = 20,
        WTSIncomingFrames = 21,
        WTSOutgoingFrames = 22,
        WTSClientInfo = 23,
        WTSSessionInfo = 24
    }

    public class RDSession
    {
        public string Server;
        public string Session;
        public string User;
        public int SessionID;
        public WTSConnectState State;
        public string ProtocolType;
        public string Client;
        public string IdleTime;
        public string LogonTime;
        public string Host;
    }
    
    public class RDProcess
    {
        public string Server;
        public string Host;
        public string User;
        public string Session;
        public int SessionID;
        public int ProcessID;
        public string Name;
    }

    public class RDSessionStatus
    {
        public string Server;
        public string Host;
        public Int32 SessionID;
        public string User;
        public string ClientName;
        public string ClientAddress;
        public string ClientBuildNumber;
        public string ClientDirectory;
        public int ClientProductID;
        public string ClientColorDepth;
        public int ClientHardwareID;
        public string ClientResolution;
        public string EncryptionLevel;
        public int InputBytes;
        public int OutputBytes;
        public int InputFrames;
        public int OutputFrames;
    }

    public class RDSManager
    {
        [DllImport("wtsapi32.dll")]
        public static extern IntPtr WTSOpenServer(
            [MarshalAs(UnmanagedType.LPStr)] String pServerName
        );

        [DllImport("wtsapi32.dll")]
        public static extern IntPtr WTSOpenServerEx(
            [MarshalAs(UnmanagedType.LPStr)] String pServerName
        );

        [DllImport("wtsapi32.dll")]
        public static extern void WTSCloseServer(
            IntPtr hServer
        );

        [DllImport("wtsapi32.dll")]
        public static extern Int32 WTSEnumerateSessions(
            IntPtr hServer,
            [MarshalAs(UnmanagedType.U4)] Int32 Reserved,
            [MarshalAs(UnmanagedType.U4)] Int32 Version,
            ref IntPtr ppSessionInfo,
            [MarshalAs(UnmanagedType.U4)] ref Int32 pCount
        );

        [DllImport("wtsapi32.dll")]
        public static extern Int32 WTSEnumerateSessionsEx(
            IntPtr hServer,
            [MarshalAs(UnmanagedType.U4)] ref Int32 pLevel,
            [MarshalAs(UnmanagedType.U4)] Int32 Filter,
            ref IntPtr ppSessionInfo,
            [MarshalAs(UnmanagedType.U4)] ref Int32 pCount
        );

        [DllImport("wtsapi32.dll")]
        public static extern void WTSFreeMemory(
            IntPtr pMemory
        );

        [DllImport("wtsapi32.dll")]
        public static extern Int32 WTSQuerySessionInformation(
            IntPtr hServer,
            [MarshalAs(UnmanagedType.U4)] Int32 SessionId,
            [MarshalAs(UnmanagedType.U4)] Int32 WTSInfoClass,
            ref IntPtr ppBuffer,
            [MarshalAs(UnmanagedType.U4)] ref Int32 BytesReturned
        );

        [DllImport("Wts.dll", SetLastError = true, CharSet = CharSet.Auto)]
        public static extern bool QueryAllSessionInformation(
            IntPtr hServer,
            Int32 SessionId,
            ref WTSSessionStatus pSessionInfo
        );

        [DllImport("certpick.dll", SetLastError = false, CharSet = CharSet.Auto)]
        public static extern int TSEnumerateProcessInitialize(
            IntPtr hServer,
            ref int NumberOfProcesses
        );

        [DllImport("certpick.dll", SetLastError = false, CharSet = CharSet.Auto)]
        public static extern int TSGetNextProcessInfo(
            int Index,
            string ServerName,
            ref int SessionId,
            ref int ProcessId,
            StringBuilder ProcessName,
            int ProcessNameSize,
            StringBuilder UserName,
            int UserNameSize
        );

        [DllImport("certpick.dll", SetLastError = false, CharSet = CharSet.Auto)]
        public static extern int TSEnumerateProcessRelease();

        [DllImport("Wtsapi32.dll", SetLastError = false, CharSet = CharSet.Auto)]
        public static extern bool WTSTerminateProcess(
            IntPtr hServer,
            Int32 ProcessId,
            Int32 ExitCode
        );

        [DllImport("kernel32.dll", SetLastError = false, CharSet = CharSet.Auto)]
        public static extern int WTSGetActiveConsoleSessionId();

        [DllImport("kernel32.dll")]
        public static extern int GetCurrentProcessId();

        [DllImport("kernel32.dll", SetLastError = false, CharSet = CharSet.Auto)]
        public static extern bool ProcessIdToSessionId(
            Int32 ProcessId,
            ref Int32 SessionId
        );

        [DllImport("Wtsapi32.dll", SetLastError = true, CharSet = CharSet.Auto)]
        public static extern bool WTSSendMessage(
            IntPtr hServer,
            Int32 SessionId,
            string Title,
            Int32 TitleLength,
            string Message,
            Int32 MessageLength,
            Int32 Style,
            Int32 Timeout,
            ref IntPtr Response,
            bool Wait
        );

        [DllImport("wtsapi32.dll", SetLastError = true, CharSet = CharSet.Auto)]
        public static extern bool WTSConnectSession(
            UInt32 LogonId,
            UInt32 TargetLogonId,
            string Password,
            bool Wait
        );

        [DllImport("Wtsapi32.dll", SetLastError = false, CharSet = CharSet.Auto)]
        public static extern bool WTSDisconnectSession(
            IntPtr hServer,
            int SessionId,
            bool Wait
        );

        [DllImport("Wtsapi32.dll", SetLastError = false, CharSet = CharSet.Auto)]
        public static extern bool WTSLogoffSession(
            IntPtr hServer,
            int SessionId,
            bool Wait
        );

        [DllImport("wtsapi32.dll")]
        public static extern bool WTSStartRemoteControlSession(
            [MarshalAs(UnmanagedType.LPStr)] String pServerName,
            UInt32 TargetLogonId,
            Byte HotkeyVk,
            UInt16 HotkeyModifiers
        );
    }
}
"@

# Create new types as per the definition above.
Add-Type -TypeDefinition $WTSTypes

# Valid states(values) for various operations(keys). Valid states are represented by the values of the Keys.
$StateOperations = @{
    "Send-Message" = @( "WTSActive" )
    "Get-RDSessionStatus" = @( "WTSActive" )
    "Connect-RDSession" = @( "WTSActive", "WTSDisconnected" )
    "Disconnect-RDSession" = @( "WTSActive" )
    "Start-RDRemoteControlSession" = @( "WTSActive" )
}

function Ping-Computer
{

param(    
    [Parameter(Mandatory=$TRUE, Position=0, ValueFromPipeline=$TRUE)]
    [string]
    $ComputerName
)

	Get-WmiObject -ComputerName $ComputerName Win32_ComputerSystem -ErrorVariable exp -ErrorAction SilentlyContinue | Out-Null
	return ((-not $exp) -OR ($exp[0].Exception.ErrorCode -ne -2147023174))

}

function IsConsoleSession
{

param(    
    [Parameter(Mandatory=$FALSE, Position=0, ValueFromPipeline=$TRUE, ValueFromPipelineByPropertyName=$TRUE)]
    [int]
    $SessionID = -1
)

    if ($SessionID -eq -1)
    {
        [RDSManager.PowerShell.RDSManager]::ProcessIdToSessionId([RDSManager.PowerShell.RDSManager]::GetCurrentProcessId(), [ref] $SessionID) | Out-Null
    }

    return ([RDSManager.PowerShell.RDSManager]::WTSGetActiveConsoleSessionId() -eq $SessionID)
}

function IsCurrentSession
{

param(    
    [Parameter(Mandatory=$TRUE, Position=0, ValueFromPipeline=$TRUE, ValueFromPipelineByPropertyName=$TRUE)]
    [int]
    $SessionID
)

    $CurrentSessionID = -1
    [RDSManager.PowerShell.RDSManager]::ProcessIdToSessionId([RDSManager.PowerShell.RDSManager]::GetCurrentProcessId(), [ref] $CurrentSessionID) | Out-Null

    return ($CurrentSessionID -eq $SessionID)
}

function Handle-Error
{

param(
    [Parameter(Mandatory=$TRUE, Position=0, ValueFromPipelineByPropertyName=$TRUE)]
    [int]
    $ErrorID,
	
	[Parameter(Mandatory=$TRUE, Position=1)]
    [string]
    $Message
)

Write-Warning ">>> $ErrorID : $Message"

    switch ($ErrorID)
    {
        5   {Write-Error "$Message : Access is denied.";break}
    }
}

function Get-RDSessionInfoEntry
{

param(    
    [Parameter(Mandatory=$TRUE, Position=0)]
    [System.IntPtr]
    $ServerPtr,

    [Parameter(Mandatory=$TRUE, Position=1)]
    [int]
    $SessionID,
    
    [Parameter(Mandatory=$TRUE, Position=2)]
    [RDSManager.PowerShell.WTSInfoType]
    $Entry
)

    if ($ServerPtr -eq [System.IntPtr]::Zero)
    {
        return
    }
    
    $entryInfo = [System.IntPtr]::Zero
    $bytes = 0
    
    $retval = [RDSManager.PowerShell.RDSManager]::WTSQuerySessionInformation($ServerPtr, $SessionID, $Entry, [ref] $entryInfo, [ref] $bytes)
    $returnObj = $NULL
    
    if($retval -ne 0)
    {
        switch ($Entry)
        {
            "WTSClientName"             {$returnObj = [System.Runtime.InteropServices.Marshal]::PtrToStringAnsi($entryInfo, $bytes); break}
            "WTSClientProtocolType"     {$returnObj = [System.Runtime.InteropServices.Marshal]::ReadInt16($entryInfo); break}
            "WTSIdleTime"               {$returnObj = [System.Runtime.InteropServices.Marshal]::ReadInt32($entryInfo); break}
            "WTSLogonTime"              {$returnObj = [System.Runtime.InteropServices.Marshal]::ReadInt32($entryInfo); break}
            "WTSClientDirectory"        {$returnObj = [System.Runtime.InteropServices.Marshal]::PtrToStringAnsi($entryInfo, $bytes); break}
            "WTSClientInfo"             {$returnObj = [RDSManager.PowerShell.WTSClient][System.Runtime.InteropServices.Marshal]::PtrToStructure($entryInfo, [RDSManager.PowerShell.WTSClient]); break}
            "WTSSessionInfo"            {$returnObj = [RDSManager.PowerShell.WTSSessionStatus][System.Runtime.InteropServices.Marshal]::PtrToStructure($entryInfo, [RDSManager.PowerShell.WTSSessionStatus]); break}
        }
        
        [RDSManager.PowerShell.RDSManager]::WTSFreeMemory($entryInfo);
        $entryInfo = [System.IntPtr]::Zero
    }
    
    return $returnObj
}

function Get-ProtocolName
{

param(    
    [Parameter(Mandatory=$TRUE, Position=0)]
    [int]
    $ProtocolID
)

    $protocolType = "Unknown"

    switch ($ProtocolID)
    {
        0   {$protocolType = "Console"; break}
        1   {$protocolType = "Citrix ICA"; break}
        2   {$protocolType = "Microsoft RDP"; break}
    }
    
    return $protocolType
}

function Get-ClientAddress
{

param(    
    [Parameter(Mandatory=$TRUE, Position=0)]
    [System.UInt32]
    $ClientAddressFamily,
    
    [Parameter(Mandatory=$TRUE, Position=1)]
    [System.UInt16[]]
    $ClientAddress
)
    $address = "Unknown"

    switch ($ClientAddressFamily)
    {
        23  {
                if (($ClientAddress[6] -eq 0) -AND ($ClientAddress[7] -eq 0))
                {
                    $address = [string]::Join(":", ($ClientAddress[0..5] | %{$_.ToString("X")}))                    
                }
                else
                {
                    $address = [string]::Join(":", ($ClientAddress[0..7] | %{$_.ToString("X")}))                    
                }                
                break
            }
        2   {
                $address = [string]::Join(".", $ClientAddress[0..3])
                break
            }
    }

    return $address
}

function Get-ColorDepth
{

param(    
    [Parameter(Mandatory=$TRUE, Position=0)]
    [int]
    $ColorDepth
)

    $colorDepthString = "Unknown"

    switch ($ColorDepth)
    {
        2   {$colorDepthString = "8 bit"; break}
        16  {$colorDepthString = "15 bit"; break}
        4   {$colorDepthString = "16 bit"; break}
        8   {$colorDepthString = "24 bit"; break}
        32  {$colorDepthString = "32 bit"; break}
    }
    
    return $colorDepthString
}

function Get-EncryptionLevel
{

param(    
    [Parameter(Mandatory=$TRUE, Position=0)]
    [int]
    $EncryptionLevel
)

    $encryptionLevelString = ""

    switch ($EncryptionLevel)
    {
        1   {$encryptionLevelString = "Low"; break}
        2   {$encryptionLevelString = "Client Compatible"; break}
        3   {$encryptionLevelString = "High"; break}
        4   {$encryptionLevelString = "FIPS Compliant"; break}
    }
    
    return $colorDepthString
}

function Get-RDSHSession
{

param(    
    [Parameter(Mandatory=$FALSE, Position=0, ValueFromPipeline=$TRUE, ValueFromPipelineByPropertyName=$TRUE)]
    [string]
    $Server = "localhost",
    
    [Parameter(Mandatory=$FALSE, HelpMessage="List all sessions, including services, listener etc")]
    [Switch]
    $ListAll
)

	if (($Server -ne "localhost") -AND (!(Ping-Computer $Server))) {
        Write-Error ("'{0}' is not reachable." -f $Server)
	    return
    }

    $ServerPtr = [RDSManager.PowerShell.RDSManager]::WTSOpenServer($Server)

    if ($ServerPtr -eq [System.IntPtr]::Zero) {
        Write-Error ("Failed to connect to {0}" -f $Server)
	    return
    }
    
    $sessInfo = [System.IntPtr]::Zero 
    $count = 0

    $result = [RDSManager.PowerShell.RDSManager]::WTSEnumerateSessions($ServerPtr, 0, 1, [ref] $sessInfo, [ref] $count)
    
	if (($result -eq 0) -and ($count -eq 0))
	{
		Write-Warning "You might not have permissions to enumerate sessions on server $Server"
		return
	}
	
    if(($result -ne 0) -AND ($sessInfo -ne [System.IntPtr]::Zero))
    {
        $structSize = [System.Runtime.InteropServices.Marshal]::sizeof([RDSManager.PowerShell.WTSSessionInfo])

        for ($ind = 0; $ind -lt $count; $ind++)
        {
            $sessionInfo = ([RDSManager.PowerShell.WTSSessionInfo]([System.Runtime.InteropServices.Marshal]::PtrToStructure([int]$sessInfo + $ind * $structSize, [RDSManager.PowerShell.WTSSessionInfo])))
            
            $sessionDetails = New-Object RDSManager.PowerShell.WTSSessionStatus
            $result = [RDSManager.PowerShell.RDSManager]::QueryAllSessionInformation($ServerPtr, $sessionInfo.SessionId, [ref] $sessionDetails)
            
            if ((!$ListAll) -AND ([string]::IsNullOrEmpty($sessionDetails.User)))
            {
                continue;
            }
            
            $sessionObj = New-Object RDSManager.PowerShell.RDSession # Can use with -Set
            
            $sessionObj.Session = $sessionInfo.WinStationName
            $sessionObj.User = $sessionDetails.User
            $sessionObj.SessionID = $sessionInfo.SessionId
            $sessionObj.State = $sessionInfo.State
            $sessionObj.ProtocolType = (Get-ProtocolName (Get-RDSessionInfoEntry $ServerPtr $sessionInfo.SessionId WTSClientProtocolType))
            $sessionObj.Client = (Get-RDSessionInfoEntry $ServerPtr $sessionInfo.SessionId WTSClientName)
            $sessionObj.IdleTime = $sessionDetails.IdleTime.Replace('+','.').Trim('.')
            $sessionObj.LogonTime = $sessionDetails.LogonTime
            $sessionObj.Server = $Server
            
            $sessionObj
        }

        [RDSManager.PowerShell.RDSManager]::WTSFreeMemory($sessInfo);
        $sessInfo = [System.IntPtr]::Zero
    }
    
    [RDSManager.PowerShell.RDSManager]::WTSCloseServer($ServerPtr)
}

function Get-RDSHProcess
{

param(    
    [Parameter(Mandatory=$FALSE, Position=0, ValueFromPipeline=$TRUE, ValueFromPipelineByPropertyName=$TRUE)]
    [string]
    $Server = "localhost",
    
    [Parameter(Mandatory=$FALSE,
        HelpMessage="List all process, from all sessions")]
    [Switch]
    $ListAll
)

	if (($Server -ne "localhost") -AND (!(Ping-Computer $Server))) {
        Write-Error ("'{0}' is not reachable." -f $Server)
	    return
    }

    $ServerPtr = [RDSManager.PowerShell.RDSManager]::WTSOpenServer($Server)
    
    if ($ServerPtr -eq [System.IntPtr]::Zero)
    {
        Write-Error ("Failed to connect to {0}" -f $Server)
	    return
    }

    $processCount = 0
    $result = [RDSManager.PowerShell.RDSManager]::TSEnumerateProcessInitialize($ServerPtr, [ref] $processCount)
	
	switch($result)
	{
		-2147024891 {Write-Error "Access denied. Cannot enumerate processes on: $Server."; return}
		0			{break}
		default		{Write-Error "Error! Cannot list Processes on: $Server."; return}
	}
    
    $sessions = @{}
    foreach ($session in (Get-RDSHSession $Server -ListAll:$ListAll))
    {
        $sessions[$session.SessionId] = $session
    }
    
    foreach ($i in 1..$processCount)
    {
        $userName       = New-Object System.Text.StringBuilder 260
        $processName    = New-Object System.Text.StringBuilder 260
        $sessionId = 0
        $processId = 0
        
        $result = [RDSManager.PowerShell.RDSManager]::TSGetNextProcessInfo($i, $Server, [ref] $sessionId, [ref] $processId, $processName, $processName.Capacity, $userName, $userName.Capacity)
        
        if (($result -ne 0) -OR (!$sessions.ContainsKey($sessionId))) { continue }
        
        $processObj = New-Object RDSManager.PowerShell.RDProcess
        
        $processObj.ProcessID = $processId
        $processObj.SessionId = $sessionId
        $processObj.Name = $processName
        $processObj.User = $userName
        $processObj.Session = $sessions[$sessionId].Session
        $processObj.Server = $Server
        
        $processObj
    }
    
    [RDSManager.PowerShell.RDSManager]::TSEnumerateProcessRelease() | Out-Null    
    [RDSManager.PowerShell.RDSManager]::WTSCloseServer($ServerPtr)
}

filter Get-RDSessionStatus
{
<# 
.Synopsis 
    Gets additional information about a user session on a Remote Desktop server.
    
.Description 
    This function retrieves additional information about a user session on a Remote Desktop server. The information can be queried through either the session ID of the session or the session object.
    
    Considerations : 
        1. To view status information for a session other than the logged in user's session, the script is to be executed with "full control" or "query information" special access permissions.
        2. The script does not fetch status information for the console or listener sessions.
    
.Parameter Server
    Optional parameter to specify the name of the Remote Desktop server for which the session information is to be enumerated. If not specified, the value is defaulted to localhost. The parameter accepts either the NETBIOS name or the fully-qualified domain name of the Remote Desktop server.
	
.Parameter SessionID
    Session ID of the session for which the information is to be retrieved. To find the session ID of a session, type "Get-RDSession".
    
.Example 
    PS C:\> Get-RDSessionStatus -SessionID 2
    
    Gets additional details for the session with session ID 2.
    
.Example 
    PS C:\> Get-RDUser -Server RDServer01 -SessionID 3
    
    Gets additional details for the session with session ID 3, on the Remote Desktop server named RDServer01.
    
.Inputs
    Session object with "Server" and "SessionID" property specified.
    
.Outputs 
    Status Object.
    RDSManager.PowerShell.RDSessionStatus object is returned. This object contains following information of a session:
    
    Property            Description 
    ----------------------------------------------------
    Server              The name of the Remote Desktop server to which the user is logged on.
    Host                The name of the RD virtualization host server on which the VM is running.
    SessionID           The numeric ID that identifies the session to the Remote Desktop server.
    User                The name of the user account that is logged on to the session on the Remote Desktop server.
    ClientName          The name of the client computer.
    ClientAddress       The IP address of the client.
    ClientBuildNumber   The version of the software installed on the client computer.    
    ClientDirectory     The directory in which the client is installed.
    ClientProductID     The product identifier of the client computer.
    ClientColorDepth    The number of colors in the color palette used for the remote session.
    ClientHardwareID    The specific hardware identifier of the client computer.
    ClientResolution    The video resolution of the remote session.
    EncryptionLevel     The encryption level being used for this session.
    InputBytes          The uncompressed Remote Desktop Protocol (RDP) data from the client to the server.
    OutputBytes         The uncompressed Remote Desktop Protocol (RDP) data from the server to the client.
    InputFrames         The Remote Desktop Protocol (RDP) frames from the client to the server.
    OutputFrames        The Remote Desktop Protocol (RDP) frames from the server to the client.
    

.Link 
    Get-RDSession
#>

param(    
    [Parameter(Mandatory=$FALSE, Position=0, ValueFromPipelineByPropertyName=$TRUE)]
    [string]
    $Server = "localhost",
    
    [Parameter(Mandatory=$TRUE, Position=1, ValueFromPipelineByPropertyName=$TRUE)]
    [int]
    $SessionID
)

    $ServerPtr = [RDSManager.PowerShell.RDSManager]::WTSOpenServer($Server)
    
    if ($ServerPtr -eq [System.IntPtr]::Zero) {
        Write-Error ("Failed to connect to: {0}" -f $Server)
	    return
    }

    $session = Get-RDSHSession $Server -ListAll | ? {$_.SessionID -eq $SessionID}
    if ($session -eq $NULL)
    {
        Write-Error ("Failed to get status of session: {0} on server: {1}. Check if the server and session ID are valid." -f $SessionID, $Server)
        return
    }

    if ($session.Session -eq "Console")
    {
        Write-Error ("The session {0} on server {1} is a console session. The script does not fetch status information for the console or listener sessions." -f $SessionID, $Server)
        return    
    }

    if ($StateOperations['Get-RDSessionStatus'] -notcontains $session.State)
    {
        Write-Error ("Failed to get status of session {0} on server {1}. The session is not active." -f $SessionID, $Server)
        return
    }

    $clientInfo = Get-RDSessionInfoEntry $ServerPtr $SessionID WTSClientInfo
    $sessionInfo = Get-RDSessionInfoEntry $ServerPtr $SessionID WTSSessionInfo
    
    $sessionStatus = New-Object RDSManager.PowerShell.RDSessionStatus
    
	$sessionStatus.Server = $Server
    $sessionStatus.Host = $session.Host
	$sessionStatus.SessionID = $SessionID
    $sessionStatus.User = $session.User
    $sessionStatus.ClientName = $clientInfo.ClientName
    $sessionStatus.ClientAddress = (Get-ClientAddress $clientInfo.ClientAddressFamily $clientInfo.ClientAddress)
    $sessionStatus.ClientBuildNumber = $clientInfo.BuildNumber
    $sessionStatus.ClientDirectory = (Get-RDSessionInfoEntry $ServerPtr $SessionID WTSClientDirectory)
    $sessionStatus.ClientProductID = $clientInfo.ProductId
    $sessionStatus.ClientColorDepth = (Get-ColorDepth $clientInfo.ColorDepth)
    $sessionStatus.ClientHardwareID = $clientInfo.HardwareId
    $sessionStatus.ClientResolution = ("{0} x {1}" -f $clientInfo.HRes, $clientInfo.VRes)
    $sessionStatus.EncryptionLevel = (Get-EncryptionLevel $clientInfo.EncryptionLevel)
    $sessionStatus.InputBytes = $sessionInfo.IncomingBytes
    $sessionStatus.OutputBytes = $sessionInfo.OutgoingBytes
    $sessionStatus.InputFrames = $sessionInfo.IncomingFrames
    $sessionStatus.OutputFrames = $sessionInfo.OutgoingFrames    
    
    [RDSManager.PowerShell.RDSManager]::WTSCloseServer($ServerPtr)
    
    return $sessionStatus
}

filter Stop-RDProcess
{
<# 
.Synopsis 
    Stops a process running in the specified user session.
    
.Description 
    This function kills a process in the specified user session. You can specify a process by process ID or pass a RDProcess object to the Stop-RDProcess function. 
    Note: Killing a process running in a user session without warning the user can result in potential loss of data.

    Considerations : 
        1. The script is expected to be executed with Full Control permission to kill a process running in the specified user session.        
        2. When all processes running in a session end, the session also ends.
    
.Parameter Server
    Optional parameter to specify the name of the Remote Desktop server on which the process is running. If not specified, the value is defaulted to localhost. The parameter accepts either the NETBIOS name or the fully-qualified domain name of the Remote Desktop server.

.Parameter ProcessID
    Process ID of the process to be killed. To find the process ID of a process, execute "Get-RDProcess" function.
    
.Example 
    PS C:\> Stop-RDProcess -ProcessID 1234
    
    Kills the process identified by the process ID 1234, on local server.
    
.Example 
    PS C:\> Stop-RDProcess -Server RDServer01 -ProcessID 1234
    
    Kills the process identified by process ID 1234, on Remote Desktop server named RDServer01.
    
.Inputs
    Objects with the "Server" and "ProcessID" property specified.
    
.Outputs
    None.

.Link 
    Get-RDProcess
#>

param(
    [Parameter(Mandatory=$FALSE, Position=0, ValueFromPipelineByPropertyName=$TRUE)]
    [string]
    $Server = "localhost",
    
    [Parameter(Mandatory=$TRUE, Position=1, ValueFromPipelineByPropertyName=$TRUE)]
    [int]
    $ProcessID
)

    $ServerPtr = [RDSManager.PowerShell.RDSManager]::WTSOpenServer($Server)
    
    if ($ServerPtr -eq [System.IntPtr]::Zero)
    {
        Write-Error ("Failed to connect to server: {0}." -f $Server)
        return
    }
    
    if (![RDSManager.PowerShell.RDSManager]::WTSTerminateProcess($ServerPtr, $ProcessID, 0))
    {
        Write-Error ("Failed to terminate the process: {0} on server: {1}." -f $ProcessID, $Server)
    }
    
    [RDSManager.PowerShell.RDSManager]::WTSCloseServer($ServerPtr)
}

filter Send-RDMessage
{
<# 
.Synopsis 
    Sends a message to a user session on the Remote Desktop Server.
    
.Description 
    This function sends a message to a user session on the Remote Desktop Server. The user session is identified by session ID or Session or user object.
    
    Considerations : 
        1. The script is to be executed with "message special access permission" to send a message to a user.
        2. The script can be used only to send messages to users whose sessions are in the active or connected state.        
		3. The script cannot be used to send messages to services or listener sessions.
    
.Parameter Server
    Optional parameter to specify the name of the Remote Desktop server on which the process is running. If not specified, the value is defaulted to localhost. The parameter accepts either the NETBIOS name or the fully-qualified domain name of the Remote Desktop server.

.Parameter SessionID
    Session ID of the session. To find the session ID of a session, execute "Get-RDSession" function.

.Parameter Message
    Message that needs to be sent to the user.

.Parameter Title 
 	Optional parameter to specify title of the message box. If not specified the value defaults to the sender's name and the time when the message is being sent.    
    
.Example 
    PS C:\> Send-RDMessage -SessionID 2 -Message "Welcome!!!"
    
    Sends the message, "Welcome!!!", to session identified by session ID 2, on local server.
    
.Example 
    PS C:\> Send-RDMessage -Server RDServer01 -SessionID 3 -Message "Please save your work and log out... the system needs a reboot." -Title "Urgent..."
    
    Sends the specified message "Please save your work and log out... the system needs a reboot." with title "Urgent..." to session identified by session ID 3, on the Remote Desktop server named RDServer01.
    
.Inputs
    Objects with the "Server" and "SessionID" property specified.
    
.Outputs 
    None.

.Link 
    Get-RDSession
#>

param(
    [Parameter(Mandatory=$FALSE, Position=0, ValueFromPipelineByPropertyName=$TRUE)]
    [string]
    $Server = "localhost",
    
    [Parameter(Mandatory=$TRUE, Position=1, ValueFromPipelineByPropertyName=$TRUE)]
    [int]
    $SessionID,
    
    [Parameter(Mandatory=$TRUE, Position=2)]
    [string]
    $Message,

    [Parameter(Mandatory=$FALSE)]
    [string]
    $Title = ("Message from: {0}, Sent: {1}" -f $Env:USERNAME, (Get-Date))
)

    $ServerPtr = [RDSManager.PowerShell.RDSManager]::WTSOpenServer($Server)
    
    if ($ServerPtr -eq [System.IntPtr]::Zero)
    {
        Write-Error ("Failed to connect to {0}" -f $Server)
        return
    }
    
    $session = Get-RDSHSession $Server | ? {$_.SessionID -eq $SessionID}
    if ($session -eq $NULL)
    {
        Write-Error ("Failed to send message to session {0} on server {1}. Check if the server and session id are valid." -f $SessionID, $Server)
        return
    }

    if (($StateOperations['Send-Message'] -notcontains $session.State) -AND !(IsConsoleSession $SessionID))
    {
        Write-Error ("Failed to send message to session {0} on server {1}. Session is not active." -f $SessionID, $Server)
        return
    }
    
    $Response = [System.IntPtr]::Zero    
    if (![RDSManager.PowerShell.RDSManager]::WTSSendMessage($ServerPtr, $SessionID, $Title, $Title.Length * 2, $Message, $Message.Length * 2, 0, 0, [ref] $Response, $FALSE)) {
        Handle-Error ([System.Runtime.InteropServices.Marshal]::GetLastWin32Error())
    }
    
    [RDSManager.PowerShell.RDSManager]::WTSCloseServer($ServerPtr)
}

function Connect-RDSession
{
<# 
.Synopsis 
    Connects to a user session on the local Server.
    
.Description 
    This function connects to a user session, on the local server. The user session is identified by session ID or Session or user object.
    
    Considerations :         
        1. To connect to the session of a user other than the logged in user, the script must be executed with "full control" or "connect special" access permission.
        3. The script can be used to connect to a user session only if the user session is either in active or disconnected state.
        4. The script can be used to connect to a user session only when executed from an existing remote session on the same RD Session Host server.
        5. The script cannot be used to connect to services or console or listener sessions.
    
.Parameter SessionID
    Session ID of the session. To get the session ID of a session, execute "Get-RDSession" function.

.Parameter Password
    Password to authorize the connection.

.Example 
    PS C:\> Connect-RDSession -SessionID 2 -Password $pwd
    
    Connects to the session identified by session ID 2, on local server.
    
.Inputs
    Objects with "SessionID" property specified.
    
.Outputs 
    None.

.Link 
    Disconnect-RDSession
    Start-RDRemoteControlSession
    Get-RDSession    
#>

param(    
    [Parameter(Mandatory=$TRUE, Position=0, ValueFromPipelineByPropertyName=$TRUE)]
    [int]
    $SessionID,
    
    [Parameter(Mandatory=$TRUE)]
    [System.Security.SecureString]
    $Password = (Read-Host -AsSecureString -Prompt "Password")
)

    if (IsConsoleSession)
    {
        Write-Error "The script cannot connect to a session from a console session. To connect to a user session please excute the script from an existing remote session on the same RD Session Host server."
        return
    }
    
    $Server = "localhost"

    $session = Get-RDSHSession $Server | ? {$_.SessionID -eq $SessionID}

    if ($session -eq $NULL)
    {
        Write-Error ("Failed to connect to session: {0}. Please verify that the session ID is valid." -f $SessionID)
        return
    }

    if ($StateOperations['Connect-RDSession'] -notcontains $session.State)
    {
        Write-Error ("Failed to connect to session: {0}. The target session is not active or not disconnected." -f $SessionID)
        return
    }

    $ServerPtr = [RDSManager.PowerShell.RDSManager]::WTSOpenServer($Server)
    
    if ($ServerPtr -eq [System.IntPtr]::Zero)
    {
        Write-Error ("Failed to connect to: {0}" -f $Server)
	    return
    }

    $pwdString = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($Password)
    $result = [RDSManager.PowerShell.RDSManager]::WTSConnectSession($SessionID, [System.UInt32]::MaxValue, [System.Runtime.InteropServices.Marshal]::PtrToStringUni($pwdString), $TRUE)
    if (!$result)    
    {
        Write-Error ("Failed to connect to session: {0}. Please verify that the credentials are valid." -f $SessionID)
	    return
    }
    
    Handle-Error ([System.Runtime.InteropServices.Marshal]::GetLastWin32Error())
    [System.Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($pwdString)

    [RDSManager.PowerShell.RDSManager]::WTSCloseServer($ServerPtr)
}

filter Disconnect-RDSession
{
<# 
.Synopsis 
    Disconnects or Logs off a user session on a Remote Desktop Server.
    
.Description 
    This function disconnects or Logs off a user session on a Remote Desktop Server. The user session is identified by session ID or Session or user object.
    
    Considerations :         
        1. To disconnect a user other than the logged user from a session, the script must be executed with "full control" or "disconnect" special access permission.
        2. All processes running in the session, including applications, will continue to run even after the session is disconnected.        
        3. To log off a user other than the logged user from a session, the script must be executed with "full control" access permission.
        4. All processes end, and the session is deleted from the RD Session Host server when the session is logged off.        
		5. The script cannot be used to disconnect services or listener sessions.

.Parameter Server
    Optional parameter to specify the name of the Remote Desktop server on which the process is running. If not specified, the value is defaulted to localhost. The parameter accepts either the NETBIOS name or the fully-qualified domain name of the Remote Desktop server.

.Parameter SessionID
    Session ID of the session. To get the session ID of a session, execute "Get-RDSession" function.

.Parameter Logoff
    Switch: If specified, user is logged off from his session. Defaults to disconnecting the session if not specified.

.Example 
    PS C:\> Disconnect-RDSession -SessionID 2
    
    Disconnects user from the session identified by session ID 2, on local server.
    
.Example 
    PS C:\> Disconnect-RDSession -Server RDServer01 -SessionID 3 -Logoff
    
    Logs off user from the session identified by session ID 3, on the Remote Desktop server named RDServer01.

.Inputs
    Objects with "Server" and "SessionID" property specified.
    
.Outputs 
    None.

.Link 
    Connect-RDSession
    Start-RDRemoteControlSession
    Get-RDSession
#>

param(    
    [Parameter(Mandatory=$FALSE, Position=0, ValueFromPipelineByPropertyName=$TRUE)]
    [string]
    $Server = "localhost",
    
    [Parameter(Mandatory=$TRUE, Position=1, ValueFromPipelineByPropertyName=$TRUE)]
    [int]
    $SessionID,
    
    [switch]
    $Logoff
)

    $session = Get-RDSHSession $Server | ? {$_.SessionID -eq $SessionID}
    $action = if ($Logoff) {"log-off"} else {"disconnect"}
    
    if ($session -eq $NULL)
    {
        Write-Error ("Failed to $action session {0} on server {1}. Check if the server and session id are valid." -f $SessionID, $Server)
        return
    }
    
    if (!$Logoff -AND ($StateOperations['Disconnect-RDSession'] -notcontains $session.State))
    {
        Write-Error ("Failed to disconnect session {0} on server {1}. Session is not active." -f $SessionID, $Server)
        return
    }

    $ServerPtr = [RDSManager.PowerShell.RDSManager]::WTSOpenServer($Server)
    
    $result = $TRUE
    if ($Logoff)
    {
        $result = [RDSManager.PowerShell.RDSManager]::WTSLogoffSession($ServerPtr, $SessionID, $FALSE)
    }
    else
    {
        $result = [RDSManager.PowerShell.RDSManager]::WTSDisconnectSession($ServerPtr, $SessionID, $FALSE)
    }
    
    if (!$result)
    {
        Write-Error ("Failed to $action session {0} on server {1}. Check if you have required permissions." -f $SessionID, $Server)
        return
    }
    Handle-Error ([System.Runtime.InteropServices.Marshal]::GetLastWin32Error())
    
    [RDSManager.PowerShell.RDSManager]::WTSCloseServer($ServerPtr)
}

function Start-RDRemoteControlSession
{
<# 
.Synopsis 
    Mirrors a user session to be controlled remotely.
    
.Description 
    This function facilitates remote control of a user session. The user session is identified by session ID or Session or user object.
    To end the remote control session, hit Control<Ctrl> key along with product<*> sign.
    
    Considerations :         
        1. A session other than the logged in user session can be remotely controled only from within a remote session.
        2. The script can be used to remotely control a session other than the logged in user's session, only when executed with "full control" or "remote control" special access permission.                
        3. Before monitoring begins, the server warns the user that the session is about to be remotely controlled, unless this warning is disabled, the granted session might appear to be frozen for a few seconds while it waits for a response from the user.
        4. The logged in session must be capable of supporting the video resolution used at the session that you are remotely controlling, or the operation fails.
		5. Remotely controling services or listener sessions is not supported.

.Parameter Server
    Optional parameter to specify the name of the Remote Desktop server on which the process is running. If not specified, the value is defaulted to localhost. The parameter accepts either the NETBIOS name or the fully-qualified domain name of the Remote Desktop server.

.Parameter SessionID
    Session ID of the session. To get the session ID of a session, execute "Get-RDSession" function.

.Example 
    PS C:\> Start-RDRemoteControlSession -SessionID 2
    
    Facilitates remotely controling session with ID 2, on local server.
    
.Example 
    PS C:\> Start-RDRemoteControlSession -Server RDServer01 -SessionID 3 -Logoff
    
    Facilitates remotely controling session with ID 3, on the Remote Desktop server named RDServer01.

.Inputs
    Objects with "Server" and "SessionID" property specified.
    
.Outputs 
    None.

.Link 
    Connect-RDSession
    Disconnect-RDSession
    Get-RDSession
#>

param(    
    [Parameter(Mandatory=$FALSE, Position=0, ValueFromPipelineByPropertyName=$TRUE)]
    [string]
    $Server = "localhost",
    
    [Parameter(Mandatory=$TRUE, Position=1, ValueFromPipelineByPropertyName=$TRUE)]
    [int]
    $SessionID
)

    $session = Get-RDSHSession $Server | ? {$_.SessionID -eq $SessionID}

    if ($session -eq $NULL)
    {
        Write-Error ("Failed to connect to session: {0} on server: {1}. Please check if the server and session id are valid." -f $SessionID, $Server)
        return
    }
    
    if ($StateOperations['Start-RDRemoteControlSession'] -notcontains $session.State)
    {
        Write-Error ("Failed to connect to session {0} on server {1}. The target session is not active or disconnected." -f $SessionID, $Server)
        return
    }

	$localHostname = hostname
	$localMachineFQDN = "{0}.{1}" -f $localHostname, (Get-WmiObject Win32_ComputerSystem).Domain
	if (($localMachineFQDN, $localHostname, "localhost" -contains $Server) -and (IsCurrentSession $SessionID))
	{
		Write-Error "Failed to remote control the session: $SessionID on server: $Server. You cannot remote control the session you are connected to."
        return
	}

    $VK_MULTIPLY = [System.Byte]106
    $VK_LCONTROL = [System.UInt16]0x2

    $result = [RDSManager.PowerShell.RDSManager]::WTSStartRemoteControlSession($Server, $SessionID, $VK_MULTIPLY, $VK_LCONTROL)
    if (!$result)
    {
        Write-Error ("Failed to connect to session: {0} on server: {1}. Please check if you have the required permissions." -f $SessionID, $Server)
        return
    }
    Handle-Error ([System.Runtime.InteropServices.Marshal]::GetLastWin32Error())
}

function Get-VMFQDN()
{
param(
    [string]
    $Server = "localhost"
)
    $tmpObj = Get-Service -ComputerName $Server -Name vmms -EA SilentlyContinue
    if ($tmpObj.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running)
    {
        Write-Error "Hyper-V service is not running on server: $Server"
        return
    }
    
    $VMs = @(Get-WmiObject -Computer $Server -Namespace root\virtualization -Query "Select * From Msvm_ComputerSystem Where Caption='Virtual Machine'" -EA Stop)
	$VMs | % {
        $Kvp = Get-WmiObject -Computer $Server -Namespace root\virtualization -Query "Associators of {$_} Where AssocClass=Msvm_SystemDevice ResultClass=Msvm_KvpExchangeComponent"  -EA Stop
        $xml = [xml]($Kvp.GuestIntrinsicExchangeItems | ? {$_ -match "FullyQualifiedDomainName"})
        $entry = $xml.Instance.Property | ?{$_.Name -eq "Data"}
        Write-Output $entry.Value
    }
}

function Get-RDVHSession
{
param(
    [string]
    $Server = "localhost",
    
    [Parameter(Mandatory=$FALSE)]
    [Switch]
    $Force,
    
    [Parameter(Mandatory=$FALSE, HelpMessage="Lists all sessions, including services, listener etc")]
    [Switch]
    $ListAll
)

    if ($Force)
    {
        Get-RDVHSessionEx $Server -ListAll:$ListAll
    }
    else
    {
        Get-RDSHSession $Server -ListAll:$ListAll
        Get-VMFQDN $Server | %{Get-RDSHSession $_ -ListAll:$ListAll} | %{$_.Host = $Server; Write-Output $_}
    }
    
}

function Get-RDVHSessionEx
{
param(    
    [string]
    $Server = "localhost",
    
    [Parameter(Mandatory=$FALSE, HelpMessage="Lists all sessions, including services, listener etc")]
    [Switch]
    $ListAll
)

	if (($Server -ne "localhost") -AND (!(Ping-Computer $Server))) {
        Write-Error ("'{0}' is not reachable." -f $Server)
	    return
    }
	
    $ServerPtr = [RDSManager.PowerShell.RDSManager]::WTSOpenServerEx($Server)
    
    if ($ServerPtr -eq [System.IntPtr]::Zero) {
        Write-Error ("Failed to connect to {0}" -f $Server)
	    return
    }
    
    $sessInfo = [System.IntPtr]::Zero 
    $count = 0
    $level = 1

    $result = [RDSManager.PowerShell.RDSManager]::WTSEnumerateSessionsEx($ServerPtr, [ref] $level, 2, [ref] $sessInfo, [ref] $count)
	
	if (($result -eq 0) -and ($count -eq 0))
	{
		Write-Warning "You might not have permissions to enumerate sessions on the Remote Desktop server: $Server"
		return
	}
	
    if(($result -ne 0) -AND ($sessInfo -ne [System.IntPtr]::Zero))
    {
        $structSize = [System.Runtime.InteropServices.Marshal]::sizeof([RDSManager.PowerShell.WTSSessionInfoEx])

        for ($ind = 0; $ind -lt $count; $ind++)
        {
            $sessionInfo = ([RDSManager.PowerShell.WTSSessionInfoEx]([System.Runtime.InteropServices.Marshal]::PtrToStructure([int]$sessInfo + $ind * $structSize, [RDSManager.PowerShell.WTSSessionInfoEx])))

            if ((!$ListAll) -AND ([string]::IsNullOrEmpty($sessionInfo.UserName)))
            {
                continue;
            }
            
            $sessObj = New-Object RDSManager.PowerShell.RDSession
                       
            $sessObj.Session = $sessionInfo.SessionName
            $sessObj.User = $sessionInfo.UserName
            $sessObj.SessionID = $sessionInfo.SessionId
            $sessObj.State = $sessionInfo.State
            if ([string]::IsNullOrEmpty($sessionInfo.HostName)) 
            {
                $sessObj.Server = $Server
            }
            else
            {
                $sessObj.Server = $sessionInfo.HostName 
                $sessObj.Host = $Server
            }            
            
            Write-Output $sessObj
        }

        [RDSManager.PowerShell.RDSManager]::WTSFreeMemory($sessInfo);
        $sessInfo = [System.IntPtr]::Zero
    }
    
    [RDSManager.PowerShell.RDSManager]::WTSCloseServer($ServerPtr)
    
}

function Get-RDVHProcess
{
param(    
    [string]
    $Server = "localhost",
    
    [Parameter(Mandatory=$FALSE,
        HelpMessage="Lists all process, from all sessions")]
    [Switch]
    $ListAll
)

    Get-RDSHProcess $Server -ListAll:$ListAll
    Get-VMFQDN $Server | %{Get-RDSHProcess $_ -ListAll:$ListAll} | %{$_.Host = $Server; Write-Output $_}
    
}

function Get-FarmMember
{
param(
    [String]
    $ConnectionBroker,

    [String]
    $FarmName
)

    $tmpObj = Get-Service -ComputerName $ConnectionBroker -Name tssdis -EA SilentlyContinue
    if ($tmpObj.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running)
    {
        Write-Error "Either you do not have the required privileges or the Connection Broker service is not running on RD Connection Broker server: $ConnectionBroker"
        return
    }
    
    if (-not (Get-WMIObject -ComputerName $ConnectionBroker -Class Win32_SessionDirectoryCluster -Filter "ClusterName='$FarmName'"))
    {
        Write-Error "Either you do not have the required privileges or the specified farm: $FarmName does not exist on the RD Connection Broker server: $ConnectionBroker."
        return
    }

    $RDSHServers = @(Get-WMIObject -ComputerName $ConnectionBroker -Class Win32_SessionDirectoryServer -Filter "ClusterName='$FarmName'" | Select-Object ServerName)
    return $RDSHServers
}

function Get-PoolMember
{
param(
    [String]
    $ConnectionBroker,

    [String]
    $PoolName
)

    $tmpObj = Get-Service -ComputerName $ConnectionBroker -Name tssdis -EA SilentlyContinue
    if ($tmpObj.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running)
    {
        Write-Error "Either you do not have the required privileges or the Connection Broker service is not running on the RD Connection Broker server: $ConnectionBroker"
        return
    }

    $pool = Get-WMIObject -ComputerName $ConnectionBroker -Namespace root\cimv2\terminalservices -Class Win32_TSRemoteDesktop -Filter "Name='$PoolName'" -Authentication PacketPrivacy
    if (-not $pool)
    {
        Write-Error "Specified VM pool $PoolName does not exist on the RD Connection Broker server: $ConnectionBroker"
        return
    }
    
    $hosts = @(Get-WmiObject -ComputerName $ConnectionBroker -Class Win32_SessionBrokerTarget -Filter "pluginname='VmResource' AND FarmName='$($pool.Alias)'" | Select-Object TargetName, Environment)
    return $hosts
}

function Get-RDSession
{
<# 
.Synopsis 
    Gets the sessions for the specified Remote Desktop resource. The Remote Desktop resource can be the RD Session Host server, RD Virtualization Host Server, RD Farm or VM Pool.
    
.Description 
    This function gets sessions for the specified Remote Desktop resource. The Remote Desktop resource can be the RD Session Host server, RD Virtualization Host Server, RD Farm or VM Pool.
    
    By default, it returns only user sessions. Use the parameter ListAll to list all sessions. Non-users sessions include:
    1. Services : The session that contains various system processes on the Remote Desktop server.
    2. Listener : The session that listens for and accepts new Remote Desktop Protocol (RDP) client connections, thereby creating new sessions on the Remote Desktop server.
    3. Console  : The session that you connect to if you log on to the physical console of the computer, instead of connecting remotely.

    Considerations : 
        1. To query sessions other than the logged on, execute the script with "query information" special access permission.
		
	Note : Using Force parameter will return objects with values set only for following properties : Server, Session, User, SessionID and State.

.Parameter Farm
    Name of the farm whose sessions are to be listed.

.Parameter Pool
    Name of the pool whose sessions are to be listed.

.Parameter ConnectionBroker
    Name of the RD Connection Broker server to get the details of pool or farm.

.Parameter RDVHost
    Name of the RD Virtualization Host Server to get the sessions from.

.Parameter RDSHost
    Name of the RD Session Host Server whose sessions are to be listed.

.Parameter Force
    Enumerates sessions from RD Virtualization host, as reported by the VMHostAgent service. By default, sessions are queried from VMs. This is helpful when the script is beinge executed with permissions that are not adquate to enumerate sessions on the Virtual Machiness.

.Parameter ListAll
    Lists all sessions.

.Example 
    PS C:\> Get-RDSession
    
    Gets the user sessions on local machine.
    
.Example 
    PS C:\> Get-RDSession -RDSHost RDServer01
    
    Gets the user sessions on server named RDServer01.
    
.Example 
    PS C:\> Get-RDSession -RDVHost RDVServer01
    
    Gets the user sessions on server named RDVServer01 and user sessions on all Virtual Machines hosted by the server.

.Example 
    PS C:\> Get-RDSession -RDVHost RDVServer01 -Force
    
    Gets the user sessions on Remote Desktop server named RDVServer01 and user sessions on all Virtual Machines hosted by the server, as reported by the VMHostAgent service. This is helpful when the script is beinge executed with permissions that are not adquate to enumerate sessions on the Virtual Machiness.

.Example 
    PS C:\> Get-RDSession -Farm RDFarm -ConnectionBroker CB01
    
    Gets the user sessions on all servers belonging to farm RDFarm, managed by the RD Connection Broker Server CB01.

.Example 
    PS C:\> Get-RDSession -Pool RDPool -ConnectionBroker CB01
    
    Gets the user sessions on all Virtual Machines belonging to VM Pool RDPool, managed by the RD Connection Broker Server CB01.

.Example 
    PS C:\> Get-RDSession -Pool RDPool -ConnectionBroker CB01 -ListAll
    
    Gets all sessions(user and non-user) on all Virtual Machines belonging to VM Pool RDPool, managed by the RD Connection Broker Server CB01.

.Inputs
    Remote Desktop resource name. Defaults to local machine if not specified.
    
.Outputs 
    Session Object(s).
    RDSManager.PowerShell.RDSession objects are returned. Returns the following information of a session:
    
    Property        Description 
    -----------------------------------------------------------------
    Server          The Remote Desktop server with which the session is associated.
    Session         The session running on the Remote Desktop server.
    User            The user account that is associated with the session.
    SessionID       The numeric ID that identifies the session to the Remote Desktop server.
    State           The status of a session. For more information, see Session States.
    ProtocolType    The type of remote desktop client using the session.
    Client          The name of the client computer using the session, if applicable.
    IdleTime        The number of minutes that have elapsed since the last keyboard or mouse input to a session.
    LogOnTime       The date and time at which the user logged on, if applicable.
    Host            The name of the remote desktop virtualization host server on which the VM is running.
    
.Link 
    Get-RDSessionStatus
    Send-RDMessage
    Connect-RDSession
    Disconnect-RDSession
    Start-RDRemoteControlSession
#>

[CmdletBinding(DefaultParametersetName="RDSHost")]
param(
    [Parameter(Mandatory=$TRUE, 
        ParameterSetName="RDSHFarm", 
        ValueFromPipeline=$TRUE, 
        HelpMessage="Remote Desktop farm name.")]
    [ValidateNotNullOrEmpty()]
    [System.String]
    $Farm,
    
    [Parameter(Mandatory=$TRUE, 
        ParameterSetName="RDVFarm", 
        ValueFromPipeline=$TRUE,
        HelpMessage="Remote Desktop Virtualization pool name.")]
    [ValidateNotNullOrEmpty()]
    [System.String]
    $Pool,
    
    [Parameter(Mandatory=$FALSE, 
        ParameterSetName="RDSHFarm",
        HelpMessage="Connection Broker managing the farm or pool.")]
    [Parameter(Mandatory=$FALSE, 
        ParameterSetName="RDVFarm",
        HelpMessage="Connection Broker managing the farm or pool.")]
    [ValidateNotNullOrEmpty()]
    [System.String]
    $ConnectionBroker = "localhost",

    [Parameter(Mandatory=$FALSE, 
        ParameterSetName="RDSHost", 
        ValueFromPipeline=$TRUE,
        HelpMessage="Remote Desktop Session Host server or client name")]
    [ValidateNotNullOrEmpty()]
    [System.String]
    $RDSHost = "localhost",

    [Parameter(Mandatory=$TRUE, 
        ParameterSetName="RDVHost", 
        ValueFromPipeline=$TRUE,
        HelpMessage="Remote Desktop Virtualization Host server")]
    [ValidateNotNullOrEmpty()]
    [System.String]
    $RDVHost,
        
    [Parameter(Mandatory=$FALSE, 
        ParameterSetName="RDVHost",
        HelpMessage="List sessions from information maintained by VM host agent")]
    [Switch]
    $Force,
    
    [Parameter(Mandatory=$FALSE,
        HelpMessage="List all sessions, including services, listener etc")]
    [Switch]
    $ListAll
)

    switch ($PsCmdlet.ParameterSetName)
    {
        "RDSHFarm"  {
                        Get-FarmMember $ConnectionBroker $Farm -ListAll:$ListAll | %{Get-RDSHSession $_.ServerName}
                        break
                    }
        "RDVFarm"   {
                        Get-PoolMember $ConnectionBroker $Pool | %{
                            foreach ($session in (Get-RDSHSession $_.TargetName -ListAll:$ListAll)) 
                            {
                                $session.Host = $_.Environment
                                Write-Output $session
                            } 
                        } 
                        break
                    }
        "RDSHost"   { Get-RDSHSession $RDSHost -ListAll:$ListAll; break}
        "RDVHost"   { Get-RDVHSession $RDVHost -Force:$Force -ListAll:$ListAll; break}
    }

}

function Get-RDProcess
{
<# 
.Synopsis 
    Gets the processes that are running on a Remote Desktop resource. The Remote Desktop resource can be a RD Session Host server, RD Virtualization Host Server, RD Farm or VM Pool.
    
.Description 
    This function gets processes running on a Remote Desktop resource. The Remote Desktop resource can be a RD Session Host server, RD Virtualization Host Server, RD Farm or VM Pool.
    The script by default, only lists the processes from user sessions. Please specify the ListAll switch to list processes from all sessions.

    Considerations : 
        1. To query processes of sessions other than the logged on session, the script is to be executed with "query information" or "full access" special permission.

.Parameter Farm
    Name of the farm whose sessions are to be listed.

.Parameter Pool
    Name of the pool whose sessions are to be listed.

.Parameter ConnectionBroker
    Name of the RD Connection Broker server to get the details of pool or farm.

.Parameter RDVHost
    Name of the RD Virtualization Host Server to get the sessions from.

.Parameter RDSHost
    Name of the RD Session Host Server whose sessions are to be listed.

.Parameter ListAll
    List all processes from all sessions.

.Example 
    PS C:\> Get-RDProcess
    
    Gets the processes running in user sessions on local machine.
    
.Example 
    PS C:\> Get-RDProcess -RDSHost RDServer01
    
    Gets the processes running in user sessions on Remote Desktop server named RDServer01.
    
.Example 
    PS C:\> Get-RDProcess -RDVHost RDVServer01
    
    Gets the processes running in user sessions on Remote Desktop server named RDVServer01 and on all virtual machines hosted by the server.

.Example 
    PS C:\> Get-RDProcess -Farm RDFarm -ConnectionBroker CB01
    
    Gets the processes running in user sessions on all Remote Desktop servers belonging to farm RDFarm, managed by the RD Connection Broker server CB01.

.Example 
    PS C:\> Get-RDProcess -Pool RDPool -ConnectionBroker CB01
    
    This command gets the processes running in user sessions on all VMs belonging to VM Pool RDPool, managed by the RD Connection Broker server CB01.

.Example 
    PS C:\> Get-RDProcess -Pool RDPool -ConnectionBroker CB01 -ListAll
    
    This command gets the processes running in all sessions on all virtual machines belonging to VM Pool RDPool,  managed by the RD Connection Broker server CB01.

.Inputs
    Remote Desktop resource name. Defaults to local machine if not specified.
    
.Outputs 
    Process Object(s).
    RDSManager.PowerShell.RDProcess objects are returned. These objects contain following information of a process:
    
    Property    Description 
    ----------------------------------------------
    Server      The Remote Desktop server with which the process is associated.
    Host        The name of the RD Virtualization Host server on which the VM is running.
    User        The user account that is associated with the process.
    Session     The session on the Remote Desktop server that is associated with the process.
    SessionID   The numeric ID that identifies the session on the Remote Desktop server.
    ProcessID   The numeric ID that identifies the process on the Remote Desktop server.
    Name        The name of the executable that created the process on the Remote Desktop server.
    
.Link 
    Get-RDSession
    Stop-RDProcess
#>

[CmdletBinding(DefaultParametersetName="RDSHost")]
param(
    [Parameter(Mandatory=$TRUE, 
        ParameterSetName="RDSHFarm", 
        ValueFromPipeline=$TRUE, 
        HelpMessage="Remote Desktop farm name.")]
    [ValidateNotNullOrEmpty()]
    [System.String]
    $Farm,
    
    [Parameter(Mandatory=$TRUE, 
        ParameterSetName="RDVFarm", 
        ValueFromPipeline=$TRUE,
        HelpMessage="Remote Desktop Virtualization pool name.")]
    [ValidateNotNullOrEmpty()]
    [System.String]
    $Pool,
    
    [Parameter(Mandatory=$FALSE, 
        ParameterSetName="RDSHFarm",
        HelpMessage="RD Connection Broker server managing the farm or pool.")]
    [Parameter(Mandatory=$FALSE, 
        ParameterSetName="RDVFarm",
        HelpMessage="RD Connection Broker server managing the farm or pool.")]
    [ValidateNotNullOrEmpty()]
    [System.String]
    $ConnectionBroker = "localhost",

    [Parameter(Mandatory=$FALSE, 
        ParameterSetName="RDSHost", 
        ValueFromPipeline=$TRUE,
        HelpMessage="RD Session Host server")]
    [ValidateNotNullOrEmpty()]
    [System.String]
    $RDSHost = "localhost",

    [Parameter(Mandatory=$TRUE, 
        ParameterSetName="RDVHost", 
        ValueFromPipeline=$TRUE,
        HelpMessage="RD Virtualization Host server")]
    [ValidateNotNullOrEmpty()]
    [System.String]
    $RDVHost,
    
    [Parameter(Mandatory=$FALSE,
        HelpMessage="Lists all process, from all sessions")]
    [Switch]
    $ListAll
)

    switch ($PsCmdlet.ParameterSetName)
    {
        "RDSHFarm"  {
                        Get-FarmMember $ConnectionBroker $Farm | %{Get-RDSHProcess $_.ServerName -ListAll:$ListAll}
                        break
                    }
        "RDVFarm"   {
                        Get-PoolMember $ConnectionBroker $Pool | %{
                            foreach ($process in (Get-RDSHProcess $_.TargetName -ListAll:$ListAll)) 
                            {
                                $process.Host = $_.Environment
                                Write-Output $process
                            } 
                        } 
                        break
                    }
        "RDSHost"   { Get-RDSHProcess $RDSHost -ListAll:$ListAll; break}
        "RDVHost"   { Get-RDVHProcess $RDVHost -ListAll:$ListAll; break}
    }

}

Export-ModuleMember -Function Get-RDSession, Get-RDProcess, Get-RDSessionStatus, Stop-RDProcess, Send-RDMessage, Connect-RDSession, Disconnect-RDSession, Start-RDRemoteControlSession