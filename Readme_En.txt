************************************************************
      StarPRNT SDK Ver 5.16.0  20230331
         Readme_En.txt             Star Micronics Co., Ltd.
************************************************************

    1. Overview
    2. Changes
    3. Contents
    4. Scope
    5. Limitation
    6. Copyright

=============
 1. Overview
=============

    This package contains StarPRNT SDK for supporting to develop applications for Star printers.
    Please refer to the document(documents/UsersManual.url) for details.

============
 2. Changes
============

    [StarIO]
        - Added features
            * Added mC-Label3.
            * SMBluetoothManager : Added SMBluetoothSecuritySSPNumericComparison to SMBluetoothSecurity.
        - Changed to Embedded Framework from Static Library.

    [StarIOExtension]
        - Added features
            * Added mC-Label3.
        - Changed to Embedded Framework from Static Library.
        - Framework changed to not include bitcode.

=============
 3. Contents
=============

    StarPRNT_iOS_SDK_V5.16.0_20230331
    |- Readme_En.txt                          // Release Notes (English)
    |- Readme_Jp.txt                          // Release Notes (Japanese)
    |- Changelog_En.txt                       // Changelog (English)
    |- Changelog_Jp.txt                       // Changelog (Japanese)
    |- SoftwareLicenseAgreement_En.pdf        // Software License Agreement (English)
    |- SoftwareLicenseAgreement_Jp.pdf        // Software License Agreement (Japanese)
    |
    +- documents
    |  +- UsersManual.url                     // Link to StarPRNT SDK document
    |
    +- software
    |  |- examples
    |  |  |- 0_StarPRNT                       // Sample program for printing and searching (Ver 5.16.0)
    |  |  +- 1_StarIODeviceSetting            // Sample program for SteadyLAN settings (Ver 1.0.0)
    |  |
    |  +- libs
    |     |- StarIO.xcframework               // StarIO.xcframework (Ver 2.10.0)
    |     |- StarIO_Extension.xcframework     // StarIO_Extension.xcframework (Ver 1.17.0)
    |     +- StarIODeviceSetting.xcframework  // StarIODeviceSetting.xcframework (Ver 1.0.1)
    |
    +- tools
       +- StarSoundConverter                  // Tools for converting sound format for melody speaker (Ver 1.0.0)

==========
 4. Scope
==========

    Please refer to UsersManual.url for supported OS, development environment, and supported printers.

===============
 5. Limitation
===============

    1. Notification in case of SM-L Series
        It could take some time when an iOS device tries to connect to a printer via "Bluetooth Low Energy".
        Refer to the "getPort API" section on the StarPRNT SDK document for details.

    2. When using printer with Bluetooth Interface, please do not change the memory switch setting of "ASB Status"
        from default value(invalid). (Bank 7/Bit C)

    3. In iOS 10.0 - 10.2.1 and 11.0 - 11.2.2, when using a Bluetooth printer, in rare cases, an error occurs
        when getPort, begin / endCheckedBlock is called, and thereafter the printer can not be discovered by
        the searchPrinter API. At this time, "Connected" is displayed in "Settings" - "Bluetooth", but the
        printer will not be displayed in "General" - "Information".

            [Restoration Method]
            Power off the printer once, or disconnect and reconnect Bluetooth from "Setting" app.

    4. It has been reported that the following models go out of service after getting unable to be
        recognized by applications when "releasePort" is executed before all of a large volume data using
        "writePort" is completely sent to the printer:

        - SM-S210i (Firmware 3.1 or higher)
        - SM-S230i (Firmware 1.3)
        - SM-T300i (Firmware 3.1 or higher)
        - SM-T400i (Firmware 3.1 or higher)

        The following product also may lose Bluetooth connection in the same condition.

        - mPOP

        (the issue is already reported to Apple)

        StarPRNT SDK loops writePort until the data is completely sent in sendCommands method included in
        the Communication class but it is designed to make releasePort in case that it fails to send all
        the data within the designated time and in the result the above issue can happen.

        In order to eliminate the issue, please designate a proper length of time enough to complete the
        print data sending, if you prefer your application to make the above procedure.

        For your information, if the printer goes out of service, you can shut down the connection on
        the "Bluetooth" window of the setting screen and connect again, then the printer will come back.

        Even if Bluetooth loses connection, with the Auto Connection function enabled, the connection
        will be recovered automatically. Otherwise you will have to re-connect manually on the iOS "setting" window.

    5. In iOS 11, set sleep to avoid a problem which sometimes cannot communicate with Bluetooth.
        Under our test environment, 0.2 sec sleep time is enough to avoid this problem.
        The appropriate sleep time is different depending on the environment.
        Please check under your own environment and set appropriate time for each environment.

    6. Precaution related to compatibility
        Beginning from StarPRNT SDK v5.6.0, the readPort behavior when a
        LAN printer is used has been changed as shown below.
        When the data that should be received when readPort is executed does not exist

        - v5.5.0 and before: Throws a PortException.
        - v5.6.0 and later: Returns 0.

        If your application uses “Throws a PortException”, change it to “Returns 0”.

    7. If mC-Sound was connected after the printer power was turned ON, melody speaker API does not work properly.
        Please turn on the printer after connecting mC-Sound to it.

    8. For users of Ethernet/Wireless LAN interface with mC-Print2/3, TSP100LAN, and TSP100IIILAN/W:
        To avoid a problem which sometimes fail getPort with Ethernet interface, the appropriate
        portSettings argument of getPort method is required.
        Under our test environment, the setting of argument to ";l1000" can avoid this problem.
        The appropriate argument is different depending on the environment.
        Please check under your own environment and set the appropriate argument.

==============
 6. Copyright
==============

    Copyright 2016 - 2023 Star Micronics Co., Ltd. All rights reserved.

