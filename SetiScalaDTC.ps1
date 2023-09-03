# NAME: SetiScalaDTC
# DESC: Configuring the MSDTC for Epicor iScala Components
# DATE: 2019-06-24
# AUTH: Anders Elmén, Need2Code AB.
# HIST: 2019-06-24 CREATED

# Promptar för att ange timeout-värde och poolstorlek
$timeout = Read-Host "Ange timeout (standard: $defaultTimeout)"
if ([string]::IsNullOrWhiteSpace($timeout)) {
    $timeout = $defaultTimeout
}

$poolSize = Read-Host "Ange poolstorlek (standard: $defaultPoolSize)"
if ([string]::IsNullOrWhiteSpace($poolSize)) {
    $poolSize = $defaultPoolSize
}

# DEFAULT VALUES
$defaultTimeout = 3600
$defaultPoolSize = 1

# Ange sökvägen till loggfilen
$logFilePath = "C:\Path\To\Log\File.log"

# Skriv ut till loggfilen
function Log-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $message"
    $logMessage | Out-File -Append -FilePath $logFilePath
}

try {
    # CONFIGURE DTC Server
    Set-DtcNetworkSetting -DtcName "Local" -AuthenticationLevel Mutual -InboundTransactionsEnabled $true -OutboundTransactionsEnabled $true -RemoteClientAccessEnabled $true -RemoteAdministrationAccessEnabled $true -XATransactionsEnabled $true -LUTransactionsEnabled $true -Confirm

    # CONNECT TO ADMIN
    $comAdmin = New-Object -com ("COMAdmin.COMAdminCatalog.1")
    $LocalColl = $comAdmin.Connect("localhost")
    $LocalComputer = $LocalColl.GetCollection("LocalComputer",$LocalColl.Name)
    $LocalComputer.Populate()
    $Applications =  $LocalColl.GetCollection("Applications", $LocalColl.Name)
    $Applications.Populate()

    foreach($Application in $Applications)
    {
        switch($Application.Name){
            "Scala Long Calls Host", "Scala Shared State Objects", "Scala Web Components", "Scala Managers", "Scala Database Components", "Scala Business Components", "Scala Short Calls Host" {
                $Application.Value("ConcurrentApps") = $defaultPoolSize;
                $Applications.SaveChanges();

                $Components = $applications.GetCollection("Components", $Application.Key);
                $Components.Populate();

                foreach($Component in $Components){
                    Write-Host $Application.Name, $Component.Name,$Component.Value("ComponentTransactionTimeout")
                    $Component.Value("ComponentTransactionTimeout") = $defaultTimeout;
                    Write-Host $Application.Name, $Component.Name,$Component.Value("ComponentTransactionTimeout")
                }

                $Components.SaveChanges()
            }
        }
    }

    $LocalComputerItem = $LocalComputer.Item(0)
    $CurrVal = $LocalComputerItem.Value("TransactionTimeout")
    Write-Host "Transaction Timeout = $CurrVal"
    $LocalComputerItem.Value("TransactionTimeout") = $timeout
    $result = $LocalComputer.SaveChanges()
    if($result.Equals(1)){
        $CurrVal = $LocalComputerItem.Value("TransactionTimeout")
        Write-Host "Transaction Timeout = $CurrVal"
    }

    Log-Message "Scriptet kördes utan fel."
} catch {
    $errorMessage = "Ett fel inträffade: $($_.Exception.Message)"
    Write-Host $errorMessage -ForegroundColor Red
    Log-Message $errorMessage
}

# Visa meddelande om att bjuda på kaffe
$phoneNumber = "0735191031"
$coffeeMessage = "Om detta script har hjälpt dig och du vill bjuda på en kaffe, swisha gärna till $phoneNumber"
Write-Host $coffeeMessage -ForegroundColor Green
