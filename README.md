・やること

MPR121_demo.inoで使う関数をruby化する

touchsensor.rbのMpr121クラスにSeeed_MPR121_driver.cppの関数を入れる
(Seeed_MPR121_driver.hのMpr121クラスの中身は全部プロトタイプ宣言)

touchsensor.rbのtypedef enum(sensor_mode_t)もどうにかして置き換え

MPR121_demo.inoをmaster.rbに置き換える
MPR121_demo.inoのSerial.printlnはマイコンの画面出力に変えれればOK

Wire.nantokaは全部i2Cに変えればいいんだけどやり方わからん、データシートとにらみ合う必要がありそう
IICが頭につく関数がI2C関連の関数なので、これのruby仕様のものを書く、アドレスは基本的にSeeed_MPR121_driver.hの#defineを参照

参考にするリアルタイムクロックをrubyにしたやつ
https://github.com/gfd-dennou-club/mrubyc-gem-rx8035sa/tree/master

データシート
https://files.seeedstudio.com/wiki/Grove-12_Key_Capacitive_I2C_Touch_Sensor_V2-MPR121/res/MPR121.pdf

タッチセンサwiki
https://wiki.seeedstudio.com/Grove-12_Key_Capacitive_I2C_Touch_Sensor_V2-MPR121/

大体mrubyc-gem-系のコードを参考にするといいらしい、センサ系のコードがgemって名前付いてるらしい

プロトタイプ宣言をrubyでやる場合requireで定義用別ファイルを読み込ませるのがよさそう
https://www.gfd-dennou.org/arch/iotex/es/mrubyc_2020/lecture_arduino_04-I2C.htm　
↑Wire関数の使い方
