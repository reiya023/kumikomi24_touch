# class SEEED_MPR121_DRIVER_H
#   #ifndef SEEED_MPR121_DRIVER_H
#   #define


#   #include <Wire.h>
#   #include <Arduino.h>

#   DEFUALT_MPR121_ADDR = 0X5B

#   TOUCH_THRESHOLD_MAX = 0X50

#   # /****************************************************Sensor register address!!***********************************************/
#   # /****************************************************************************************************************************/

#   CHANNEL_NUM = 12

#   # /*These two registers indicate the detected touch/release status of all of the 12 sensing input channels*/
#   TOUCH_STATUS_REG_ADDR_L = 0X00
#   TOUCH_STATUS_REG_ADDR_H = 0X01

#   # /*The MPR121 provides filtered electrode output data for all 12 channels*/
#   # /*Total 26 registers,for 12 channel dlectrode out put data.Each channel corresponding two registers:high byte and low byte*/
#   # /*0x04~0x1d*/
#   FILTERED_DATA_REG_START_ADDR_L = 0X04
#   FILTERED_DATA_REG_START_ADDR_H = 0X05

#   # /*Along with the 10-bit electrode filtered data output, each channel also has a 10-bit baseline value*/
#   # /*0X1E~0X2A*/
#   BASELINE_VALUE_REG_START_ADDR = 0X1E


#   # /*All12 of the electrode baseline values are controlled by the same set of filtering control registers, 0x2B ~ 0x35*/
#   # /*The 13th channel ELEPROX is controlled by registers 0x36 ~ 0x40*/
#   BASELINE_FILTERING_CONTROL_REG_START_ADDR = 0X2B


#   # /*Each of the 12 channels can be set with its own set of touch and release thresholds. Touch and release are detected by
#   # comparing the electrode filtered data to the baseline value. typically in the range 0x04~0x10*/
#   # /*Touch condition: Baseline - Electrode filtered data > Touch threshold
#   #   Release condition: Baseline - Electrode filtered data < Release threshold*/
#   THRESHOLD_REG_START_ADDR = 0X41

#   # /*All 12 channels use the same set of touch and release debounce numbers.*/
#   DEBOUNCE_REG_ADDR = 0X5B

#   # /*These two registers set the global AFE settings. This includes global electrode charge/discharge current CDC, global charge/
#   # discharge time CDT, as well as a common filtering setting (FFI, SFI, ESI) for all 12 channels, including the 13th Eleprox channel*/
#   FILTER_AND_GLOBAL_CDC_CFG_ADDR = 0X5C
#   FILTER_AND_GLOBAL_CDT_CFG_ADDR = 0X5D

#   # /*0X5F-0X6B*/
#   ELEC_CHARGE_CURRENT_REG_START_ADDR = 0X5F

#   # /*0X6C-0X72*/
#   ELEC_CHARGE_TIME_REG_START_ADDR =  0X6C

#   # /*The Electrode Configuration Register (ECR) determines if the MPR121 is in Run Mode or Stop Mode*/
#   # /*Default is 0 to stop mode*/
#   LEC_CFG_REG_ADDR = 0X5E

class Mpr121
  def initialize(i2c)
      @i2c = i2c
#      @i2c.write(0x5B, [0x80,0x63]) #タッチセンサーの初期化
      @i2c.write(0x5B, [0x80, 0x63]) #タッチセンサーの初期化
      # @i2c.write(0x00,0x00)
      # @i2c.write(0x01,0x00)
  end

  def sensor_stop
    @i2c.write(0X5E, 0)
  end

  def sensor_eneble
    @i2c.write(0X5E, 0X3C)
  end

  def sensor_disable
    @i2c.write(0X5E, 0X3C)
  end

  def read(reg)
    @i2c.write(0x5B, reg)
    byte = @i2c.readfrom(0x5B, 1)
    #puts "#{reg.to_s(16)}: byte #{byte}"

    return byte[0]
  end

  def check_status_register
    val = 0;
    val_l = read(0x00)
    val_h = read(0x01)
    val = val_h << 8 | val_l

    puts "val #{val} val_l #{val_l} val_h #{val_h}"

    return val
  end

  def get_filtered_reg_data(elecs_stat, elecs_filtered_data)
    value = 0
    channel_num = 12
    for i in 0...channel_num
      if
        data_l = read(0x04+2*i)
        data_h = read(0x04+2*i+1)
        puts "data_l #{read(0x04+2*i)} data_h #{read(0x04+2*i+1)}"
        elecs_filtered_data[i] = (data_h << 8) | data_l
        if 0x50 < elecs_filtered_data[i]
          elecs_stat &= ~(1<<i)
        end
      end
    end

    return elecs_stat
  end

end
