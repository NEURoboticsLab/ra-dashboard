#!/usr/bin/python
import MySQLdb
import random
from time import sleep, time, mktime
from datetime import datetime

def now():
    dt = datetime.utcnow()
    sec_since_epoch = mktime(dt.timetuple()) + dt.microsecond/1000000.0
    millis_since_epoch = sec_since_epoch * 1000
    return int(millis_since_epoch)

db = MySQLdb.connect(host="127.0.0.1",
                     user="core",
                     passwd="esn95384",
                     db="telemetry")

cur = db.cursor()

def data():
    d = {}
    d["battery_pack_voltage"] = 100 + random.randint(-10,10)
    d["bus_voltage"] = 110 + random.randint(-10,10)
    d["bus_current"] = 10 + random.randint(-1,1)
    d["vehicle_velocity"] = 30 + random.randint(-5,5)
    d["motor_velocity"] = 100  + random.randint(-100,100)
    d["motor_temprature"] = 30 + random.randint(-5,5)
    d["esc_temprature"] = 25 + random.randint(-5,5)
    d["odometer"] = 1
    return d;

def insert(d):
    cols = d.keys()
    vals = [str(x) for x in d.values()]
    sql = "INSERT INTO telemetry (%s) VALUES(%s);" % (",".join(cols), ",".join(vals))
    cur.execute(sql)
    db.commit()

while True:
    d = data()
    print(d)
    insert(d)
    sleep(0.1)

db.close()
