#!/usr/bin/python3
"""Gather Data from an API
"""


from urllib import request, parse
from sys import argv
import json


def run():
    """ run script
    """
    if argv.__len__() == 2:
        userId = argv[1]
        try:
            req_url_user = "https://jsonplaceholder.typicode.com/users"
            res = request.urlopen("{}/{}".format(req_url_user, userId))
            user = json.loads(res.read())

            req_url_todos = "https://jsonplaceholder.typicode.com/todos"
            query_params = {'userId': userId}
            query_string = parse.urlencode(query_params)
            res = request.urlopen("{}?{}".format(req_url_todos, query_string))
            todos = json.loads(res.read())

            username = user['name']
            completed_list = list(filter(lambda x: x['completed'], todos))
            completed = len(completed_list)
            total = len(todos)
            print("Employee {} is done with tasks({}/{}):".format(username,
                                                                  completed,
                                                                  total))
            for item in completed_list:
                print("\t {}".format(item['title']))
        except Exception as e:
            print(str(e))


if __name__ == '__main__':
    run()
