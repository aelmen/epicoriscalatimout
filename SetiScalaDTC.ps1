#####################################################################
# NAME: SetiScalaDTC
# DESC: Configuring the MSDTC for Epicor iScala Components
# DATE: 2019-06-24
# AUTH: Anders Elmén, Need2Code AB.
# HIST: 2019-06-24     CREATED
#       2023-09-03     UPDATE
#####################################################################

# Prompt for entering timeout value and pool size
$timeout = Read-Host "Enter timeout (default: $defaultTimeout)"
if ([string]::IsNullOrWhiteSpace($timeout)) {
    $timeout = $defaultTimeout
}

$poolSize = Read-Host "Enter pool size (default: $defaultPoolSize)"
if ([string]::IsNullOrWhiteSpace($poolSize)) {
    $poolSize = $defaultPoolSize
}

# DEFAULT VALUES
$defaultTimeout = 3600
$defaultPoolSize = 1

# Configure DTC Server
Set-DtcNetworkSetting -DtcName "Local" -AuthenticationLevel Mutual -InboundTransactionsEnabled $true -OutboundTransactionsEnabled $true -RemoteClientAccessEnabled $true -RemoteAdministrationAccessEnabled $true -XATransactionsEnabled $true -LUTransactionsEnabled $true -Confirm

# Connect to COMAdmin
$comAdmin = New-Object -com ("COMAdmin.COMAdminCatalog.1")
$LocalColl = $comAdmin.Connect("localhost")
$LocalComputer = $LocalColl.GetCollection("LocalComputer",$LocalColl.Name)
$LocalComputer.Populate()
$Applications =  $LocalColl.GetCollection("Applications", $LocalColl.Name)
$Applications.Populate()

# Iterate through applications
foreach ($Application in $Applications)
{
    switch ($Application.Name)
    {
        "Scala Long Calls Host", "Scala Shared State Objects", "Scala Web Components", "Scala Managers", "Scala Database Components", "Scala Business Components", "Scala Short Calls Host"
        {
            $Components = $applications.GetCollection("Components", $Application.Key);
            $Components.Populate();

            foreach ($Component in $Components)
            {
                Write-Host $Application.Name, $Component.Name, $Component.Value("ComponentTransactionTimeout")
                $Component.Value("ComponentTransactionTimeout") = $defaultTimeout;
                Write-Host $Application.Name, $Component.Name, $Component.Value("ComponentTransactionTimeout")
            }

            $Components.SaveChanges()
        }
    }
}

# Set ConcurrentApps value after component loop
foreach ($Application in $Applications)
{
    switch ($Application.Name)
    {
        "Scala Long Calls Host", "Scala Shared State Objects", "Scala Web Components", "Scala Managers", "Scala Database Components", "Scala Business Components", "Scala Short Calls Host"
        {
            $Application.Value("ConcurrentApps") = $defaultPoolSize;
            $Applications.SaveChanges();
        }
    }
}

$LocalComputerItem = $LocalComputer.Item(0)
$CurrVal = $LocalComputerItem.Value("TransactionTimeout")
Write-Host "Transaction Timeout = $CurrVal"
$LocalComputerItem.Value("TransactionTimeout") = $timeout
$result = $LocalComputer.SaveChanges()
if ($result.Equals(1))
{
    $CurrVal = $LocalComputerItem.Value("TransactionTimeout")
    Write-Host "Transaction Timeout = $CurrVal"
}

# Log success message
Log-Message "Script executed without errors."

# Display message for buying coffee
$phoneNumber = "0735191031"
$coffeeMessage = "If this script helped you and you'd like to buy me a coffee, feel free to send a Swish to $phoneNumber"
Write-Host $coffeeMessage -ForegroundColor Green
