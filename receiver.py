#!/usr/bin/env python3

import pymysql
import sys
import serial
import json
import signal

db = pymysql.connect("127.0.0.1", "core", "esn95384", "telemetry")

cur = db.cursor()

dev = serial.Serial(sys.argv[1])

state = {}

def cleanup(signal, frame):
    print("You pressed Ctrl+C!")
    dev.close()
    sys.exit(0)

signal.signal(signal.SIGINT, cleanup)

def insert(d):
    cols = d.keys()
    vals = [str(x) for x in d.values()]
    sql = "INSERT INTO telemetry (%s) VALUES(%s);" % (",".join(cols), ",".join(vals))
    cur.execute(sql)
    db.commit()

while True :
    line = dev.readline()
    line = line.strip()
    try:
        state.update(json.loads(line))
        insert(state)
        print(json.dumps(state))
    except:
        pass
