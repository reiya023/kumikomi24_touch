・やること

touchsensor.rbのMpr121クラスにSeeed_MPR121_driver.cppの関数を全部入れる
(Seeed_MPR121_driver.hのMpr121クラスの中身は全部プロトタイプ宣言)

touchsensor.rbのtypedef enum(sensor_mode_t)もどうにかして置き換え

MPR121_demo.inoのSerial.printlnはマイコンの画面出力に変えれればOK

Wire.nantokaは全部i2Cに変えればいいんだけどやり方わからん、データシートとにらみ合う必要がありそう

最悪MPR121_demo.inoで使う関数ruby化できればどうにかるかもしれない

参考にするリアルタイムクロックをrubyにしたやつ
https://github.com/gfd-dennou-club/mrubyc-gem-rx8035sa/tree/master

データシート
https://files.seeedstudio.com/wiki/Grove-12_Key_Capacitive_I2C_Touch_Sensor_V2-MPR121/res/MPR121.pdf

タッチセンサwiki
https://wiki.seeedstudio.com/Grove-12_Key_Capacitive_I2C_Touch_Sensor_V2-MPR121/
