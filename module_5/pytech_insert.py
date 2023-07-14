from pymongo import MongoClient

url = "mongodb+srv://admin:admin@cluster0.mulcekd.mongodb.net/?retryWrites=true&w=majority"

client = MongoClient(url)

db = client.pytech


timothy = {
        "student_id": "1007",
        "first_name": "Timothy",
        "last_name": "Baller"
        }

carlos = {
        "student_id": "1008",
        "first_name": "Carlos",
        "last_name": "Miller"
        }

ashley = {
        "student_id": "1009",
        "first_name": "Ashley",
        "last_name": "Williams"
        }


students = db.students

print("\n  -- INSERT STATEMENTS --")
timothy_student_id = students.insert_one(timothy).inserted_id
print("  Inserted student record Timothy Baller into the students collection with document_id " + str(timothy_student_id))

carlos_student_id = students.insert_one(carlos).inserted_id
print("  Inserted student record Carlos Miller into the students collection with document_id " + str(carlos_student_id))

ashley_student_id = students.insert_one(ashley).inserted_id
print("  Inserted student record Ashley William into the students collection with document_id " + str(ashley_student_id))

input("\n\n  End of program, press any key to exit... ")