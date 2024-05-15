#!/usr/bin/env python3
""" Caching request module """

import redis
import requests
from functools import wraps
from typing import Callable


def track_get_page(fn: Callable) -> Callable:
    """ Decorator for get_page
    """
    @wraps(fn)
    def wrapper(url: str) -> str:
        """ Wrapper that:
            - checks whether a url's data is cached
            - tracks how many times get_page is called
        """
        # Initialize Redis client
        client = redis.Redis()

        # Track the number of times the URL was accessed
        client.incr(f'count:{url}')

        # Check if the page content is cached
        cached_page = client.get(url)
        if cached_page:
            return cached_page.decode('utf-8')

        # Call the original function if content is not cached
        response = fn(url)

        # Cache the page content with expiration time of 10 seconds
        client.setex(url, 10, response)

        return response
    return wrapper


@track_get_page
def get_page(url: str) -> str:
    """ Makes an HTTP request to a given endpoint
    """
    response = requests.get(url)
    return response.text
