#!/usr/bin/env python3
""" List all documents in Python """


def list_all(mongo_collection):
    """
    List all documents in a MongoDB collection.

    Args:
        mongo_collection: A pymongo collection object.

    Returns:
        A list of documents in the collection. Returns an empty list if no
        documents are found.
    """
    return mongo_collection.find()
