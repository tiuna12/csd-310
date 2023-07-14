from pymongo import MongoClient

url = "mongodb+srv://admin:admin@cluster0.mulcekd.mongodb.net/?retryWrites=true&w=majority"

client = MongoClient(url)

db = client.pytech

print(db.list_collection_names())

records = [
    {
        "student_id": "1007",
        "first_name": "Timothy",
        "last_name": "Baller"
    },
    {
        "student_id": "1008",
        "first_name": "Carlos",
        "last_name": "Miller"
    },
    {
        "student_id": "1009",
        "first_name": "Ashley",
        "last_name": "Williams"
    }
]

for record in records:
    new_student_Id = pytech.insert_one(record).inserted_id
    print(new_student_Id)
    

docs = pytech.find()

for doc in docs:
    print(doc)
    

print(pytech.find_one({"student_id": "1008"}))
