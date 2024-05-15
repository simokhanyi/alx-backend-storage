#!/usr/bin/env python3
""" Redis client module
"""

import redis
import uuid
import functools
from typing import Callable, Optional, Union


class Cache:
    def __init__(self):
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: 'Union[str, bytes, int, float]') -> str:
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

    def get(self, key: str, fn: Optional[Callable] = None) -> Union[
            str, bytes, int, float]:
        data = self._redis.get(key)
        if data is None:
            return None
        if fn is not None:
            return fn(data)
        return data

    def get_str(self, key: str) -> str:
        return self.get(key, fn=lambda d: d.decode("utf-8"))

    def get_int(self, key: str) -> int:
        return self.get(key, fn=int)

    def count_calls(method: Callable) -> Callable:
        key = method.__qualname__

        @functools.wraps(method)
        def wrapper(self, *args, **kwargs):
            self._redis.incr(key)
            return method(self, *args, **kwargs)

        return wrapper

    def call_history(method: Callable) -> Callable:
        input_key = f"{method.__qualname__}:inputs"
        output_key = f"{method.__qualname__}:outputs"

        @functools.wraps(method)
        def wrapper(self, *args, **kwargs):
            self._redis.rpush(input_key, str(args))
            result = method(self, *args, **kwargs)
            self._redis.rpush(output_key, str(result))
            return result

        return wrapper

    @count_calls
    @call_history
    def store(self, data: 'Union[str, bytes, int, float]') -> str:
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

    @staticmethod
    def replay(func: Callable):
        input_key = f"{func.__qualname__}:inputs"
        output_key = f"{func.__qualname__}:outputs"

        inputs = Cache()._redis.lrange(input_key, 0, -1)
        outputs = Cache()._redis.lrange(output_key, 0, -1)

        print(f"{func.__qualname__} was called {len(inputs)} times:")
        for args, result in zip(inputs, outputs):
            print(
                f"{func.__qualname__}(*{args.decode()}) "
                f"-> {result.decode()}"
            )


if __name__ == "__main__":
    cache = Cache()

    # Test count_calls decorator
    cache.store(b"first")
    print(cache.get(cache.store.__qualname__))

    cache.store(b"second")
    cache.store(b"third")
    print(cache.get(cache.store.__qualname__))

    # Test call_history decorator
    s1 = cache.store("first")
    print(s1)
    s2 = cache.store("secont")
    print(s2)
    s3 = cache.store("third")
    print(s3)

    inputs = cache._redis.lrange(f"{cache.store.__qualname__}:inputs", 0, -1)
    outputs = cache._redis.lrange(f"{cache.store.__qualname__}:outputs", 0, -1)

    print("inputs:", [inp.decode() for inp in inputs])
    print("outputs:", [out.decode() for out in outputs])

    # Test replay function
    Cache.replay(cache.store)
