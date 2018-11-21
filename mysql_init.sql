use logs;
create table logs
(t_insert timestamp default current_timestamp,
 battery_pack_voltage double not null,
 bus_voltage double not null,
 bus_current double not null,
 vehicle_velocity double not null,
 motor_velocity double not null,
 motor_temprature double not null,
 esc_temprature double not null,
 odometer  double not null,
 primary key (t_insert));
