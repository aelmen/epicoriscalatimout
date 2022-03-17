# NAME: SetiScalaDTC
# DESC: Configuring the MSDTC for Epicor iScala Components
# DATE: 2019-06-24
# AUTH: Anders Elmén, Need2Code AB.
# HIST: 2019-06-24 CREATED


# DEFAULT VALUES
$defaultTimeout = 3600
$defaultPoolSize = 1

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
        "Scala Long Calls Host"{
            $Application.Value("ConcurrentApps") = $defaultPoolSize;
            $Applications.SaveChanges();
            break;
        }
        "Scala Shared State Objects"{
            $Application.Value("ConcurrentApps") = $defaultPoolSize;
            $Applications.SaveChanges();
            break;
        }
        "Scala Web Components"{
            $Application.Value("ConcurrentApps") = $defaultPoolSize;
            $Applications.SaveChanges();
            break;
        }
        "Scala Managers"
        {
            $Application.Value("ConcurrentApps") = $defaultPoolSize;
            $Applications.SaveChanges();
            $Components =  $applications.GetCollection("Components", $Application.Key);
            $Components.Populate();
            foreach($Component in $Components){
                Write-Host $Application.Name, $Component.Name,$Component.Value("ComponentTransactionTimeout")
                $Component.Value("ComponentTransactionTimeout") = $defaultTimeout;
                Write-Host $Application.Name, $Component.Name,$Component.Value("ComponentTransactionTimeout")
            }
            $Components.SaveChanges()
            break;
        }
        "Scala Database Components"{
            $Components =  $applications.GetCollection("Components", $Application.Key);
            $Components.Populate();
            foreach($Component in $Components){
                Write-Host $Application.Name, $Component.Name,$Component.Value("ComponentTransactionTimeout")
                $Component.Value("ComponentTransactionTimeout") = $defaultTimeout;
                Write-Host $Application.Name, $Component.Name,$Component.Value("ComponentTransactionTimeout")
            }
            $Components.SaveChanges()
            break;
        }
        "Scala Business Components"{
            $Components =  $applications.GetCollection("Components", $Application.Key);
            $Components.Populate();
            foreach($Component in $Components){
                Write-Host $Application.Name, $Component.Name,$Component.Value("ComponentTransactionTimeout")
                $Component.Value("ComponentTransactionTimeout") = $defaultTimeout;
                Write-Host $Application.Name, $Component.Name,$Component.Value("ComponentTransactionTimeout")
            }
            $Components.SaveChanges()
        }
        "Scala Short Calls Host"{
            $Application.Value("ConcurrentApps") = $defaultPoolSize;
            $Applications.SaveChanges();
            $Components =  $applications.GetCollection("Components", $Application.Key);
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
$LocalComputerItem.Value("TransactionTimeout") = $defaultTimeout
$result = $LocalComputer.SaveChanges()
if($result.Equals(1)){
    $CurrVal = $LocalComputerItem.Value("TransactionTimeout")
    Write-Host "Transaction Timeout = $CurrVal"
}
