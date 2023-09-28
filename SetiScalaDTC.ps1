#####################################################################
# NAME: SetiScalaDTC
# DESC: Configuring the MSDTC for Epicor iScala Components
# DATE: 2019-06-24
# AUTH: Anders Elmén, Need2Code AB.
# HIST: 2019-06-24      CREATED
#       2023-09-03      UPDATE
#       2023-09-28      UPDATE
#                       Extended Logging and bug fixes
#####################################################################

# Log-Message Function
function Log-Message ($message, $color = "White") {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host -ForegroundColor $color "$timestamp : $message"
}

Log-Message "Starting the script..." Yellow

# DEFAULT VALUES
$defaultTimeout = 3600
$defaultPoolSize = 1

# Prompt for entering timeout value and pool size
$timeout = Read-Host "Enter timeout (default: $defaultTimeout)"
if ([string]::IsNullOrWhiteSpace($timeout)) {
    $timeout = $defaultTimeout
}

$poolSize = Read-Host "Enter pool size (default: $defaultPoolSize)"
if ([string]::IsNullOrWhiteSpace($poolSize)) {
    $poolSize = $defaultPoolSize
}

Log-Message "Timeout value entered: $timeout" Green
Log-Message "Pool size value entered: $poolSize" Green

# Configure DTC Server
Log-Message "Configuring DTC Server..." Yellow
Set-DtcNetworkSetting -DtcName "Local" -AuthenticationLevel Mutual -InboundTransactionsEnabled $true -OutboundTransactionsEnabled $true -RemoteClientAccessEnabled $true -RemoteAdministrationAccessEnabled $true -XATransactionsEnabled $true -LUTransactionsEnabled $true -Confirm

# Connect to COMAdmin
Log-Message "Connecting to COMAdmin..." Yellow
$comAdmin = New-Object -com ("COMAdmin.COMAdminCatalog.1")
$LocalColl = $comAdmin.Connect("localhost")
$LocalComputer = $LocalColl.GetCollection("LocalComputer",$LocalColl.Name)
$LocalComputer.Populate()
$Applications =  $LocalColl.GetCollection("Applications", $LocalColl.Name)
$Applications.Populate()

# Iterate through applications
Log-Message "Iterating through applications..." Yellow
$targetApplicationNames = @(
    "Scala Long Calls Host", 
    "Scala Shared State Objects", 
    "Scala Web Components", 
    "Scala Managers", 
    "Scala Database Components", 
    "Scala Short Calls Host"
)

foreach ($Application in $Applications)
{
    if ($targetApplicationNames -contains $Application.Name)
    {
        Log-Message "Found target application: $($Application.Name)" Green
        $Components = $Applications.GetCollection("Components", $Application.Key)
        $Components.Populate()

        foreach ($Component in $Components)
        {
            Log-Message "$($Application.Name), $($Component.Name), $($Component.Value('ComponentTransactionTimeout'))" Cyan
            $Component.Value("ComponentTransactionTimeout") = $defaultTimeout
            Log-Message "$($Application.Name), $($Component.Name), $($Component.Value('ComponentTransactionTimeout'))" Green
        }

        $Components.SaveChanges()
    }
}

$LocalComputerItem = $LocalComputer.Item(0)
$CurrVal = $LocalComputerItem.Value("TransactionTimeout")
Log-Message "Transaction Timeout = $CurrVal" Green
$LocalComputerItem.Value("TransactionTimeout") = $timeout
$result = $LocalComputer.SaveChanges()
if ($result.Equals(1))
{
    $CurrVal = $LocalComputerItem.Value("TransactionTimeout")
    Log-Message "Transaction Timeout = $CurrVal" Green
}

# Log success message
Log-Message "Script executed without errors." Green

# Display message for buying coffee
$phoneNumber = "0735191031"
$coffeeMessage = "If this script helped you and you'd like to buy me a coffee, feel free to send a Swish to $phoneNumber"
Log-Message $coffeeMessage Green
