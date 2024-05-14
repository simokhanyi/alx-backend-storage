#!/usr/bin/env python3
""" Top students """


def top_students(mongo_collection):
    """
    Return all students sorted by average score.

    Args:
        mongo_collection: A pymongo collection object representing the
        students collection.

    Returns:
        A list of student documents sorted by average score in descending
        order.
    """
    pipeline = [
        {"$unwind": "$topics"},
        {"$group": {"_id": "$_id", "averageScore": {"$avg": "$topics.score"},
                                   "name": {"$first": "$name"}}},
        {"$sort": {"averageScore": -1}}
    ]
    return list(mongo_collection.aggregate(pipeline))
