************************************************************
      StarPRNT SDK Ver 5.16.0  20230331
         Readme_Jp.txt                  スター精密（株）
************************************************************

    1. 概要
    2. 変更点
    3. 内容
    4. 適用
    5. 制限事項
    6. 著作権

==========
 1. 概要
==========

    本パッケージはStarプリンタを使用するアプリケーションの開発を容易にするためのSDKです。
    詳細な説明は、ドキュメント(documents/UsersManual.url)を参照ください。

===========
 2. 変更点
===========

    [StarIO]
        - 機能追加
            * mC-Label3に対応
            * SMBluetoothManager : SMBluetoothSecurityにSMBluetoothSecuritySSPNumericComparisonを追加
        - Static LibraryからEmbedded Frameworkに変更


    [StarIO_Extension]
        - 機能追加
            * mC-Label3に対応
        - Static LibraryからEmbedded Frameworkに変更
        - Frameworkがbitcodeを含まないよう変更

==========
 3. 内容
==========

    StarPRNT_iOS_SDK_V5.16.0_20230331
    |- Readme_En.txt                          // リリースノート (英語)
    |- Readme_Jp.txt                          // リリースノート (日本語)
    |- Changelog_En.txt                       // 変更履歴 (英語)
    |- Changelog_Jp.txt                       // 変更履歴 (日本語)
    |- SoftwareLicenseAgreement_En.pdf        // ソフトウエア使用許諾書 (英語)
    |- SoftwareLicenseAgreement_Jp.pdf        // ソフトウエア使用許諾書 (日本語)
    |
    +- documents
    |  +- UsersManual.url                     // StarPRNT SDK ドキュメントへのリンク
    |
    +- software
    |  +- examples
    |  |  |- 0_StarPRNT                       // 印刷やプリンターの検索などのサンプルプログラム (Ver 5.16.0)
    |  |  +- 1_StarIODeviceSetting            // SteadyLAN設定サンプルプログラム (Ver 1.0.0)
    |  |
    |  |- libs
    |  |  |- StarIO.xcframework               // StarIO.xcframework (Ver 2.10.0)
    |  |  |- StarIO_Extension.xcframework     // StarIO_Extension.xcframework (Ver 1.17.0)
    |  |  +- StarIODeviceSetting.xcframework  // StarIODeviceSetting.xcframework (Ver 1.0.1)
    |  |
    |
    +- tools
       +- StarSoundConverter                  // メロディスピーカー向け音声変換ツール (Ver 1.0.0)

==========
 4. 適用
==========

   対応OS・開発環境・対応プリンターについては、
　　ドキュメント(documents/UsersManual.url)を参照ください。

===============
 5. 制限事項
===============

    1. Bluetooth Low Energyモデルは、プリンターとの接続に時間がかかることがあります。
        詳しくはStarPRNT SDKドキュメントのgetPort API項を参照ください。

    2. Bluetoothでご利用の場合、メモリスイッチの"ASB機能"は、デフォルト設定(無効)のまま
        ご利用ください。(バンク7/ビットC)

    3. Bluetoothプリンタにて、iOS 10.0 - 10.2.1 および iOS 11.0 - 11.2.2において、getPort、begin/endCheckedBlockで
        エラーが発生し、その後searchPrinter APIで発見できなくなる事があります。
        iOS設定画面を見ると、『接続済み』と表示されますが、「一般」-「情報」に当該デバイス情報が
        表示されなくなります。

        [復帰方法]
        一旦プリンタ電源を切るか、iOS設定画面機能を使い、Bluetoothコネクションを切断し
        再接続します。

    4. 下記モデルにおいて、“writePort”を使用して大量のデータをプリンタに送信した後、データを送りきる前に
        ”releasePort”が実行されますと、アプリからプリンタを認識できず使用不能となる現象が確認されています。

        - SM-S210i (ファームウェア 3.1以降)
        - SM-S230i (ファームウェア 1.3)
        - SM-T300i (ファームウェア 3.1以降)
        - SM-T400i (ファームウェア 3.1以降)

        また、以下のモデルにおいて同様の処理が実行されますと、Bluetooth接続が切断される事があります。

        - mPOP

        (本現象はApple社へ報告済みです)

        StarPRNT SDKの場合、Communicationクラス内のsendCommandsメソッドでデータを送りきるまで
        writePortをループしていますが、指定時間内にデータを送りきれなかった場合は
        releasePortするようになっており、上記の現象が発生する事があります。

        本現象を防止するため、アプリで同様の処理を行う場合は、印刷データを送りきるのに十分な長さの時間を
        指定するようにしてください。

        なお、プリンタが使用不能な状態になった場合は"設定"の"Bluetooth"画面にてプリンタとの接続を一旦切断し
        再度接続することで再び使用可能となります。
        Bluetooth接続が切断された場合は、Auto Connection機能が有効であれば自動的に再接続されます。
        Auto Connectionが無効の場合はiOSの"設定"画面から手動で再接続を行ってください。

    5. 本SDKではiOS 11 にて稀にBluetoothプリンタと通信できなくなる現象を回避するため、getPort後に
        スリープを行っています。
        弊社の評価では、0.2秒のスリープを行うことで本現象が発生しないことを確認できましたが
        実際にお客様のアプリケーションで使用する際は十分に動作確認を行い、必要に応じて
        スリープ時間を適宜変更してください。

    6. readPort メソッドの一部の振る舞いの変更
        - StarPRNT SDK 5.6.0より、EthernetインターフェイスでreadPortメソッドを実行した際に
        受信すべきデータがなかった場合の挙動を変更しました。
        - 変更前 : 例外をスロー
        - 変更後 : 成功を返す

        * SDK V5.5.0以前をご利用の際に、変更前の例外発生をキャッチする実装をされている
        　場合には、本修正に合わせたアプリ側の修正をお願いいたします。

    7. プリンターの電源をONした後にプリンターにmC-Soundを接続した場合、メロディスピーカーのAPIは正常に動作しません。
        プリンターにmC-Soundを接続した後にプリンターの電源をONしてください。

    8. mC-Print2/3のLANインターフェイス、TSP100LAN、TSP100IIILAN/Wを使用する場合、
        ネットワーク環境とホストデバイスによっては、稀にgetPortに失敗することがございます。
        弊社の評価では、portSettingsの引数に";l1000"を設定することで本現象が発生しなくなることを確認できましたが、
        実際にお客様のアプリケーションで使用する際には十分に動作確認を行い、必要に応じて適宜変更してください。

===========
 6. 著作権
===========

    スター精密（株）Copyright 2016 - 2023
