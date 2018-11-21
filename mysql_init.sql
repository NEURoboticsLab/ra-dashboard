create database telemetry;
grant all privileges on telemetry.* TO 'core';
use telemetry;
create table telemetry
(epoch timestamp(3) default current_timestamp(3),
 battery_pack_voltage double not null,
 bus_voltage double not null,
 bus_current double not null,
 vehicle_velocity double not null,
 motor_velocity double not null,
 motor_temprature double not null,
 esc_temprature double not null,
 odometer  double not null,
 primary key (epoch));
