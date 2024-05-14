#!/usr/bin/env python3
""" Insert a document in Python """


def insert_school(mongo_collection, **kwargs):
    """
    Insert a new document into a MongoDB collection based on keyword
    arguments.

    Args:
        mongo_collection: A pymongo collection object.
        **kwargs: Keyword arguments representing fields and their values for
        the new document.

    Returns:
        The _id of the newly inserted document.
    """
    return mongo_collection.insert_one(kwargs).inserted_id
