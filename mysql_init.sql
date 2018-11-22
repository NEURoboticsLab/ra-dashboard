create database telemetry;
grant all privileges on telemetry.* TO 'core';
use telemetry;
create table telemetry
(epoch timestamp(3) default current_timestamp(3),
 battery_pack_voltage double not null default 0,
 bus_voltage double not null default 0,
 bus_current double not null default 0,
 vehicle_velocity double not null default 0,
 motor_velocity double not null default 0,
 motor_temprature double not null default 0,
 esc_temprature double not null default 0,
 odometer  double not null default 0,
 primary key (epoch));
