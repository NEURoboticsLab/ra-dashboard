#!/usr/bin/python
import MySQLdb

db = MySQLdb.connect(host="127.0.0.1",
                     user="core",
                     passwd="esn95384",
                         db="logs")

cur = db.cursor()

cur.execute("show tables")

for row in cur.fetchall():
    print row[0]

db.close()
