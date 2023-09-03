# Configuring MSDTC for Epicor iScala Components

This script is designed to configure the Microsoft Distributed Transaction Coordinator (MSDTC) settings for Epicor iScala components. The script sets specific values for transaction timeouts and concurrent application pool sizes to optimize the performance and reliability of Epicor iScala within the Distributed COM (DCOM) architecture.

## Compatibility

Please note that this script is designed for Epicor iScala version 3.3 or later. It's important to ensure compatibility with your specific version before running the script.

## About Epicor iScala

Epicor iScala is an enterprise resource planning (ERP) software suite designed for businesses to manage various aspects of their operations, including finance, inventory, production, and more.

## COM (Component Object Model) and DCOM (Distributed COM)

COM is a Microsoft technology that enables software components to communicate and interact with each other within a Windows environment. DCOM extends this concept to distributed systems, allowing components to communicate across network boundaries.

## Application Pools and Performance

In the context of Epicor iScala, "application pools" refer to the groups of components and services managed by the ERP system. Properly configured application pools can have a significant impact on the performance and efficiency of Epicor iScala. By setting appropriate values for concurrent application pool sizes, you can ensure optimal resource allocation and response times, leading to a smoother user experience and improved overall system performance.

## Getting Started

## Important Considerations

- **DTC Restart**: When running the script, be aware that changing DTC settings can cause the Distributed Transaction Coordinator to restart. As a result, active transactions might be affected, potentially leading to the disruption of services or user sessions. It is recommended to schedule the script execution during maintenance windows or periods of low user activity to minimize impact.
- **User Logout**: If the script is executed while users are logged in, there is a possibility that users might be logged out due to DTC restarts or other system changes. Inform users and plan accordingly to avoid inconvenience.

### Prerequisites

Before you begin, make sure you have Git installed on your system. If not, you can download and install it from [here](https://git-scm.com/downloads).

### Cloning the Project

1. Open a terminal or command prompt.
2. Navigate to the directory where you want to clone the project.
3. Run the following command to clone the project repository:

git clone https://github.com/aelmen/epicoriscalatimout.git

## Running the Script

**Important:** To ensure that the script has the necessary administrative privileges to modify system settings, please run PowerShell as an administrator before executing the script.

1. Open a PowerShell console as an administrator.
2. Navigate to the directory containing the script (`SetiScalaDTC.ps1`).
3. Run the script by entering `.\SetiScalaDTC.ps1` and follow the prompts.
- The script will prompt you to enter the desired timeout value (in seconds) and pool size.
- If you press Enter without entering a value, the script will use default values.
4. The script will configure the MSDTC settings and application pools for Epicor iScala components.
5. Upon completion, the script will display a message indicating success.

## Restoring Settings

In case any issues arise after running the script, you can always restore the default settings by initiating the repair process in the Epicor iScala setup.

## Support and Consultation

For support related to this script or other issues with Epicor iScala, you can reach out to **hello@need2code.se** for consultation. Please note that a fee may be charged for more extensive troubleshooting.

## Contributions and Feedback

Contributions to enhance and improve this script are welcome! If you have suggestions, bug reports, or ideas for further development, please feel free to create an issue or submit a pull request.

## Note

Please exercise caution when running PowerShell scripts, especially those that make changes to system settings. Review the script thoroughly before execution.

For any inquiries, you can also contact the script author, Anders Elmén, at the provided email address or phone number.

---

If you found this script helpful and would like to show your appreciation, consider sending a coffee via Swish to Anders Elmén at the following number: 0735191031 (for users located in Sweden with Swish).
