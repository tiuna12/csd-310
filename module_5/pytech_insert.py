from pymongo import MongoClient

url = "mongodb+srv://admin:admin@cluster0.mulcekd.mongodb.net/?retryWrites=true&w=majority"

client = MongoClient(url)

db = client.pytech


Timothy = {
        "student_id": "1007",
        "first_name": "Timothy",
        "last_name": "Baller"
    },


Carlos = {
        "student_id": "1008",
        "first_name": "Carlos",
        "last_name": "Miller"
    },


Ashley = {
        "student_id": "1009",
        "first_name": "Ashley",
        "last_name": "Williams"
    }

Timothy_student_id = students.insert_one(Timothy).inserted_id
 
print(Timothy_student_id)
 