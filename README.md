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

## How to Use the Script

1. Clone or download this repository to your local machine.
2. Open a PowerShell console and navigate to the directory containing the script (`SetiScalaDTC.ps1`).
3. Run the script by entering `.\SetiScalaDTC.ps1` and follow the prompts.
   - The script will prompt you to enter the desired timeout value (in seconds) and pool size.
   - If you press Enter without entering a value, the script will use default values.
4. The script will configure the MSDTC settings and application pools for Epicor iScala components.
5. Upon completion, the script will display a message indicating success and a note about showing appreciation through Swish.

## Note

Please exercise caution when running PowerShell scripts, especially those that make changes to system settings. Review the script thoroughly before execution.

## Contributions and Feedback

Contributions to enhance and improve this script are welcome! If you have suggestions, bug reports, or ideas for further development, please feel free to create an issue or submit a pull request.

## Support and Consultation

For support related to this script or other issues with Epicor iScala, you can reach out to **hello@need2code.se** for consultation. Please note that a fee may be charged for more extensive troubleshooting.


---

If you found this script helpful and would like to show your appreciation, consider sending a coffee via Swish to Anders Elmén at the following number: 0735191031 (for users located in Sweden with Swish).
