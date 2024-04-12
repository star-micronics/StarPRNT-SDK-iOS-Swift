# V5.17.1

## StarIO
- Support Privacy Manifest
   * Added privacy manifest file according to Apple's guidelines. (It uses User Defaults APIs.)

## StarIO_Extension
- Support Privacy Manifest
   * Added privacy manifest file according to Apple's guidelines. (It uses User Defaults APIs.)

## SDK
- Support Privacy Manifest
   * Added privacy manifest file according to Apple's guidelines. (It uses User Defaults APIs.)

StarIO (Ver. 2.11.1)
StarIO_Extension (Ver. 1.17.1)


# V5.17.0

## StarIO
- Minor fixes that do not affect operation.

## SDK
- Added Sample Codes
   * Supported TSP100IV SK.

StarIO (Ver. 2.11.0)
StarIO_Extension (Ver. 1.17.0)

# V5.16.2

## StarIO
- Fixed Bugs
  * Fixed a probrem that application may crash when using SMFileLogger.
- Updated Bluetooth module information for SM-L200.

StarIO (Ver. 2.10.2)
StarIO_Extension (Ver. 1.17.0)


# V5.16.1

## StarIO
- Fixed Bugs
  * Fixed application crash when using SMFileLogger.

StarIO (Ver. 2.10.1)
StarIO_Extension (Ver. 1.17.0)


# V5.16.0

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

StarIO (Ver. 2.10.0)
StarIO_Extension (Ver. 1.17.0)


# V5.15.1

## StarIO
- Added new Bluetooth module information for SM-L200.
- Fixed an issue that a file is sometimes not overwritten in time order when `SMFileLogger` class outputs more than the number of log files that can be output.

StarIO (Ver. 2.9.1)
StarIO_Extension (Ver. 1.16.0)


# V5.15.0

## StarIO
- Added features
  * Added TSP100IV.
- Changed file format from framework to xcframework.
- Supported for iOS simulator running on Apple Silicon.
        
## StarIOExtension
- Changed file format from framework to xcframework.
- Supported for iOS simulator running on Apple Silicon.
- Fixed an issue where data from peripheral devices (e.g. barcode reader) could not be got after disconnecting and reconnecting a printer to a host device via USB/Bluetooth interfaces.

## SMCloudServices
- End of support.

## SDK
- Added Sample Codes
  * Added TSP100IV.

StarIO (Ver. 2.9.0)
StarIO_Extension (Ver. 1.16.0)


# V5.14.2

## StarIO
- Improvement of getport method for Ethernet printer
- Fixed a bug that executing getFirmwareInformation to Bluetooth mobile printers (SM-S210i, SM-220i, SM-S230i, SM-T300i, SM-T400i) could cause an application to be crashed.

StarIO (Ver. 2.8.2)
StarIO_Extension (Ver. 1.15.0)
SMCloudServices (Ver. 1.5.1)


# V5.14.1

## StarIO
- Improved searchPrinter method performance for the ethernet printer.

## SDK
- Added iOS 14 Support.

StarIO (Ver. 2.8.1)
StarIO_Extension (Ver. 1.15.0)
SMCloudServices (Ver. 1.5.1)


# V5.14.0

Initial release for GitHub

StarIO (Ver. 2.8.0)
StarIO_Extension (Ver. 1.15.0)
SMCloudServices (Ver. 1.5.1)
