i2c = I2C.new(22, 21)
mpr121 = Mpr121.new(i2c)

channel_num = 12
touch_status_flag = Array.new(channel_num, 0)

mpr121.sensor_eneble()

while true
  result = 0
  filtered_data_buf = Array.new(channel_num, 0)
  # baseline_buf = Array.new(channel_num, 0)

  result = mpr121.check_status_register()
  result = mpr121.get_filtered_reg_data(result, filtered_data_buf)

  for i in 0...channel_num
    if result&(1<<i)
      if 0 == touch_status_flag[i]
        touch_status_flag[i] = 1
        puts "key #{i} pressed"
      end
    else
      if 1 == touch_status_flag[i]
        touch_status_flag[i] = 0
        puts "key #{i} release"
      end
    end
  end

end
