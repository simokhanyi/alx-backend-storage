#!/usr/bin/env python3
""" Log stats """


from pymongo import MongoClient


def log_stats():
    """
    Retrieve statistics about Nginx logs stored in MongoDB.

    Connects to the MongoDB database and collection storing Nginx logs,
    retrieves various statistics, and prints them.

    Returns:
        None
    """
    # Connect to MongoDB
    client = MongoClient('mongodb://localhost:27017')
    db = client.logs
    collection = db.nginx

    # Total number of documents
    total_logs = collection.count_documents({})

    print(f"{total_logs} logs")

    # Counting methods
    methods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
    for method in methods:
        count = collection.count_documents({"method": method})
        print(f"    method {method}: {count}")

    # Counting status check
    status_check_count = collection.count_documents({"method": "GET",
                                                     "path": "/status"})
    print(f"{status_check_count} status check")


if __name__ == "__main__":
    log_stats()
