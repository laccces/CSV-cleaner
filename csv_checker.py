import csv
import sqlite3

data = []
clean =[]

with open('MOCK_DATA.csv', 'r') as file:
  reader = csv.reader(file)
  for row in reader:
    data.append(row)

def clean_data(data):
  for list in data:
    for d in data:
      if d[0] != "" and d[1] != "" and d[2] != "":
        clean.append(d)
    return clean

clean_data(data)

#export to CSV
with open('output.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerows(clean)

# Add to sqlite
conn = sqlite3.connect('cleandata.db')
c = conn.cursor()

c.execute("""CREATE TABLE IF NOT EXISTS contacts (
       firstname text, 
       lastname text, 
       email text, 
       phone integer
  )""")

c.executemany("""INSERT INTO contacts ('firstname', 'lastname', 'email', 'phone') VALUES (?, ?, ?, ?)""", clean)

conn.commit()

conn.close()
