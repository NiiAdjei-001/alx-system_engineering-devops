#!/usr/bin/python3
"""Export gathered Data from an API into CSV file
"""


import json
from sys import argv
from urllib import request, parse


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

            with open("{}.json".format(userId), "w") as json_file:
                record = {user['id']: []}
                for item in todos:
                    record[user['id']].append({"task": item['title'],
                                               "completed": item['completed'],
                                               "username": user['username']})
                json.dump(record, json_file)

        except Exception as e:
            print(str(e))


if __name__ == '__main__':
    run()
