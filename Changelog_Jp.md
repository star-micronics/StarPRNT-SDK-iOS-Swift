# Ver 5.20.1 (2025/07/14)

## StarIO
- SMPortクラスの一部プロパティの属性を適切に修正

## StarIOExtension
- 動作に影響しない軽微な修正

StarIO (Ver. 2.12.1)<br>
StarIO_Extension (Ver. 1.19.1)<br>
stariodevicesetting (Ver. 1.0.2)

# Ver 5.20.0 (2025/05/19)

## StarIOExtension
- 機能追加
    * ISCBBuilderクラス : appendTextBaseMagnificationメソッドを追加
    * ISCBBuilderクラス : SCBBarcodeWidthの列挙型を拡張
    * ISCBBuilderクラス : appendCutPaperメソッドの出力に改行コードの付与を選択可能に変更

## SDK
- サンプルコードの追加
    * mC-Label2に対応

StarIO (Ver. 2.12.0)<br>
StarIO_Extension (Ver. 1.19.0)<br>
stariodevicesetting (Ver. 1.0.2)


# Ver.5.19.0 (2024/11/01)

## StarIO
- 機能追加
    * TSP100IV-UEWB, TSP100IV-UEWB SKに対応
- SMFileLogger: ログ保存先フォルダに.log以外の拡張子ファイルが存在するとき、そのファイルをログファイルの最大サイズに含めず計算するように修正

## SDK
- Swift6へのアップデート準備
- サンプルコードの追加
    * TSP100IV-UEWB, TSP100IV-UEWB SKに対応

StarIO (Ver. 2.12.0)<br>
StarIO_Extension (Ver. 1.18.0)<br>
stariodevicesetting (Ver. 1.0.2)


# Ver.5.18.0 (2024/06/24)

## StarIO
- 動作に影響しない軽微な修正

## StarIO_Extension
- 機能追加
    * ISCBBuilderクラス : SCBCutPaperAction.tearOff
    * ISCBBuilderクラス : SCBInternationalType.india

## SDK
- サンプルコードの追加
    * BSC10IIに対応（日本国内では販売しておりません）

StarIO (Ver. 2.11.2)<br>
StarIO_Extension (Ver. 1.18.0)<br>
stariodevicesetting (Ver. 1.0.1)


# Ver.5.17.1 (2024/02/02)

## StarIO
- プライバシーマニフェスト対応  
    * Apple社の指針に従い、プライバシーマニフェストファイルを追加。(User Defaults APIsを使用しています。)

## StarIO_Extension
- プライバシーマニフェスト対応  
    * Apple社の指針に従い、プライバシーマニフェストファイルを追加。(User Defaults APIsを使用しています。)

## StarIODeviceSetting
- プライバシーマニフェスト対応  
    * Apple社の指針に従い、プライバシーマニフェストファイルを追加。(Required Reason APIを使用していません。)
    * Static LibraryからEmbedded Frameworkに変更

## SDK
- プライバシーマニフェスト対応  
    * Apple社の指針に従い、プライバシーマニフェストファイルを追加。(User Defaults APIsを使用しています。)

StarIO (Ver. 2.11.1)<br>
StarIO_Extension (Ver. 1.17.1)<br>
stariodevicesetting (Ver. 1.0.1)


# Ver.5.17.0 (2023/09/08)

## StarIO
- 動作に影響しない軽微な修正

## SDK
- サンプルコードの追加
    * TSP100IV SKに対応

StarIO (Ver. 2.11.0)<br>
StarIO_Extension (Ver. 1.17.0)
stariodevicesetting (Ver. 1.0.1)


# Ver.5.16.2 (2023/08/09)

## StarIO
- バグ修正
    * SMFileLoggerを使用するとアプリケーションがクラッシュすることがある問題を修正
- SM-L200のBluetoothモジュール情報を更新

StarIO (Ver. 2.10.2)<br>
StarIO_Extension (Ver. 1.17.0)<br>
stariodevicesetting (Ver. 1.0.1)


# Ver.5.16.1 (2023/05/30)

## StarIO
- バグ修正
    * SMFileLoggerを使用するとアプリケーションがクラッシュする問題を修正

StarIO (Ver. 2.10.1)<br>
StarIO_Extension (Ver. 1.17.0)<br>
stariodevicesetting (Ver. 1.0.1)


# Ver.5.16.0 (2023/03/31)

## StarIO
- 機能追加
    * mC-Label3に対応
    * `SMBluetoothManager` : `SMBluetoothSecurity`に`SMBluetoothSecuritySSPNumericComparison`を追加
- Static LibraryからEmbedded Frameworkに変更

## StarIO_Extension
- 機能追加
    * mC-Label3に対応
- Static LibraryからEmbedded Frameworkに変更
- Frameworkがbitcodeを含まないよう変更

StarIO (Ver. 2.10.0)<br>
StarIO_Extension (Ver. 1.17.0)<br>
stariodevicesetting (Ver. 1.0.1)


# Ver.5.15.1 (2022/05/10)

## StarIO
- SM-L200のBluetoothモジュール情報を新規追加
- SMFileLoggerクラスが出力可能なログファイル数以上を出力する場合、ファイルが時系列順に上書きされないことがある問題を修正

StarIO (Ver. 2.9.1)<br>
StarIO_Extension (Ver. 1.16.0)<br>
stariodevicesetting (Ver. 1.0.1)


# Ver.5.15.0 (2021/10/29)

## StarIO
- 機能追加
    * TSP100IVに対応
- ファイル形式をframeworkからxcframeworkに変更
- Apple Silicon上で動作するiOSシミュレータに対応

## StarIO_Extension
- ファイル形式をframeworkからxcframeworkに変更
- Apple Silicon上で動作するiOSシミュレータに対応
- Bluetooth/USBインターフェイスでプリンターとホストデバイスを切断/再接続した後に周辺機器(バーコードリーダー等)からのデータを取得できなくなることがある問題を修正

## StarIODeviceSetting
- ファイル形式をframeworkからxcframeworkに変更
- Apple Silicon上で動作するiOSシミュレータに対応

## SMCloudServices
- サポート終了

## SDK
- サンプルコードの追加
    * TSP100IVに対応

StarIO (Ver. 2.9.0)<br>
StarIO_Extension (Ver. 1.16.0)<br>
stariodevicesetting (Ver. 1.0.1)


# Ver.5.14.2 (2020/12/09)

## StarIODeviceSetting example
- 新規作成

## StarIODeviceSetting
- 新規作成

## StarIO
- Ethernet printerに対するgetportメソッドの性能改善
- Bluetoothモバイルプリンター(SM-S210i, SM-S230i, SM-T300i, SM-T400i)に対しgetFirmwareInformation:を実行するとアプリケーションがクラッシュする場合がある問題を修正

StarIO (Ver. 2.8.2)<br>
StarIO_Extension (Ver. 1.15.0)<br>
SMCloudServices (Ver. 1.5.1)<br>
stariodevicesetting (Ver. 1.0.0)


# Ver.5.14.1 (2020/09/17)

## StarIO
- Ethernet printerに対するsearchPrinterメソッドの性能改善

## SDK
- iOS 14をサポート

StarIO (Ver. 2.8.1)<br>
StarIO_Extension (Ver. 1.15.0)<br>
SMCloudServices (Ver. 1.5.1)


# Ver.5.14.0 (2020/06/17)

## StarIO
- 機能追加
    * MCP31C, TSP650IISKに対応
    * インターフェイス自動切り替え機能の追加
    * 用紙保持制御機能の追加

## StarIOExtension
- 機能追加
    * MCP31C, TSP650IISKに対応
    * インターフェイス自動切り替え機能の追加
    * 用紙保持制御機能の追加
    * StarIoExtManager, ISCPParserのUSB HIDクラス（キーボードモード）対応

## SDK
- サンプルコードの追加(SK1シリーズに対応)
    * インターフェイス自動切り替えの実装例
    * 用紙保持制御の実装例


StarIO (Ver. 2.8.0)<br>
StarIO_Extension (Ver. 1.15.0)<br>
SMCloudServices (Ver. 1.5.1)