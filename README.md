# Configuring MSDTC for Epicor iScala Components

This script is designed to configure the Microsoft Distributed Transaction Coordinator (MSDTC) settings for Epicor iScala components. The script sets specific values for transaction timeouts and concurrent application pool sizes to optimize the performance and reliability of Epicor iScala within the Distributed COM (DCOM) architecture.

## About Epicor iScala

Epicor iScala is an enterprise resource planning (ERP) software suite designed for businesses to manage various aspects of their operations, including finance, inventory, production, and more.

## COM (Component Object Model) and DCOM (Distributed COM)

COM is a Microsoft technology that enables software components to communicate and interact with each other within a Windows environment. DCOM extends this concept to distributed systems, allowing components to communicate across network boundaries.

## Application Pools

In the context of this script, "application pools" refer to the groups of components and services managed by Epicor iScala. These pools handle various tasks within the ERP system.

## How to Use the Script

1. Clone or download this repository to your local machine.
2. Open a PowerShell console and navigate to the directory containing the script (`SetiScalaDTC.ps1`).
3. Run the script by entering `.\SetiScalaDTC.ps1` and follow the prompts.
   - The script will prompt you to enter the desired timeout value (in seconds) and pool size.
   - If you press Enter without entering a value, the script will use default values.
4. The script will configure the MSDTC settings and application pools for Epicor iScala components.
5. Upon completion, the script will display a message indicating success and a note about buying coffee to support the creator.

## Note

Please exercise caution when running PowerShell scripts, especially those that make changes to system settings. Review the script thoroughly before execution.

For support or inquiries, you can contact the script author, Anders Elmén, at the provided email address or phone number.

---

If you found this script helpful and would like to show your appreciation, consider sending a coffee via Swish to the following number: 0735191031.
