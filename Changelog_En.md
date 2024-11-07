# V5.19.0 (2024/11/01)

## StarIO
- Added Features
    * Supported TSP100IV-UEWB, TSP100IV-UEWB SK.
-  SMFileLogger: Modified to calculate the maximum size of log files when files with extensions other than .log exit in the log storage folder, instead of including them in the maximum size of log files.

## SDK
- Preparing to update to Swift6
- Added Sample Codes
    * Supported TSP100IV-UEWB, TSP100IV-UEWB SK.

StarIO (Ver. 2.12.0)<br>
StarIO_Extension (Ver. 1.18.0)<br>
stariodevicesetting (Ver. 1.0.2)


# V5.18.0 (2024/06/24)

## StarIO
- Minor Fixes that do not affect operation.

## StarIO_Extension
- Added features
    * ISCBBuilder Class : SCBCutPaperAction.tearOff
    * ISCBBuilder Class : SCBInternationalType.india

## SDK
- Added Sample Codes
    * Supported BSC10II (Limited region model).

StarIO (Ver. 2.11.2)<br>
StarIO_Extension (Ver. 1.18.0)<br>
stariodevicesetting (Ver. 1.0.1)


# V5.17.1 (2024/02/02)

## StarIO
- Support Privacy Manifest
    * Added privacy manifest file according to Apple's guidelines. (It uses User Defaults APIs.)

## StarIO_Extension
- Support Privacy Manifest
    * Added privacy manifest file according to Apple's guidelines. (It uses User Defaults APIs.)

## StarIODeviceSetting
- Support Privacy Manifest
    * Added privacy manifest file accroding to Apple's guidelines. (It uses User Defaults APIs.)
    * Changed to Embedded Framework from Static Library.

## SDK
- Support Privacy Manifest
   * Added privacy manifest file according to Apple's guidelines. (It uses User Defaults APIs.)

StarIO (Ver. 2.11.1)<br>
StarIO_Extension (Ver. 1.17.1)<br>
stariodevicesetting (Ver. 1.0.1)


# V5.17.0 (2023/09/08)

## StarIO
- Minor fixes that do not affect operation.

## SDK
- Added Sample Codes
    * Supported TSP100IV SK.

StarIO (Ver. 2.11.0)<br>
StarIO_Extension (Ver. 1.17.0)<br>
stariodevicesetting (Ver. 1.0.1)


# V5.16.2 (2023/08/09)

## StarIO
- Fixed Bugs
    * Fixed a probrem that application may crash when using SMFileLogger.
- Updated Bluetooth module information for SM-L200.

StarIO (Ver. 2.10.2)<br>
StarIO_Extension (Ver. 1.17.0)<br>
stariodevicesetting (Ver. 1.0.1)


# V5.16.1 (2023/05/30)

## StarIO
- Fixed Bugs
    * Fixed application crash when using SMFileLogger.

StarIO (Ver. 2.10.1)<br>
StarIO_Extension (Ver. 1.17.0)<br>
stariodevicesetting (Ver. 1.0.1)


# V5.16.0 (2023/03/31)

## StarIO
- Added features
    * Added mC-Label3.
    * `SMBluetoothManager` : Added `SMBluetoothSecuritySSPNumericComparison` to `SMBluetoothSecurity`.
- Changed to Embedded Framework from Static Library.

## StarIOExtension
- Added features
    * Added mC-Label3.
- Changed to Embedded Framework from Static Library.
- Framework changed to not include bitcode.

StarIO (Ver. 2.10.0)<br>
StarIO_Extension (Ver. 1.17.0)<br>
stariodevicesetting (Ver. 1.0.1)


# V5.15.1 (2022/05/10)

## StarIO
- Added new Bluetooth module information for SM-L200.
- Fixed an issue that a file is sometimes not overwritten in time order when `SMFileLogger` class outputs more than the number of log files that can be output.

StarIO (Ver. 2.9.1)<br>
StarIO_Extension (Ver. 1.16.0)<br>
stariodevicesetting (Ver. 1.0.1)


# V5.15.0 (2021/10/29)

## StarIO
- Added features
    * Added TSP100IV.
- Changed file format from framework to xcframework.
- Supported for iOS simulator running on Apple Silicon.
        
## StarIO_Extension
- Changed file format from framework to xcframework.
- Supported for iOS simulator running on Apple Silicon.
- Fixed an issue where data from peripheral devices (e.g. barcode reader) could not be got after disconnecting and reconnecting a printer to a host device via USB/Bluetooth interfaces.

## StarIODeviceSetting
- Changed file format from framework to xcframework.
- Supported for iOS simulator running on Apple Silicon.

## SMCloudServices
- End of support.

## SDK
- Added Sample Codes
    * Added TSP100IV.

StarIO (Ver. 2.9.0)<br>
StarIO_Extension (Ver. 1.16.0)<br>
stariodevicesetting (Ver. 1.0.1)


# V5.14.2 (2020/12/09)

## StarIODeviceSetting example
- New 

## StarIODeviceSetting
- New

## StarIO
- Improvement of getport method for Ethernet printer
- Fixed a bug that executing getFirmwareInformation to Bluetooth mobile printers (SM-S210i, SM-220i, SM-S230i, SM-T300i, SM-T400i) could cause an application to be crashed.

StarIO (Ver. 2.8.2)<br>
StarIO_Extension (Ver. 1.15.0)<br>
SMCloudServices (Ver. 1.5.1)<br>
stariodevicesetting (Ver. 1.0.0)


# V5.14.1 (2020/09/17)

## StarIO
- Improved searchPrinter method performance for the ethernet printer.

## SDK
- Added iOS 14 Support.

StarIO (Ver. 2.8.1)<br>
StarIO_Extension (Ver. 1.15.0)<br>
SMCloudServices (Ver. 1.5.1)


# V5.14.0 (2020/06/17)

## StarIO
- Added features
    * Added MCP31C and TSP650IISK.
    * Added Auto Interface Select function.
    * Added Hold Print Control function.

## StarIOExtension
- Added features
    * Added MCP31C and TSP650IISK.
    * Added Auto Interface Select function.
    * Added Hold Print Control function.
    * USB HID class (Keyboard mode) support for StarIoExtManager and ISCPParser.

## SDK
- Added Sample Codes
    * Added sample codes for Auto Interface Select function.
    * Added sample codes for Hold Print Control function.

StarIO (Ver. 2.8.0)<br>
StarIO_Extension (Ver. 1.15.0)<br>
SMCloudServices (Ver. 1.5.1)
