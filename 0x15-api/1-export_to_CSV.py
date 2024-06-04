#!/usr/bin/python3
"""Export gathered Data from an API into CSV file
"""


import csv
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

            username = user['username']

            with open("{}.csv".format(userId), "w") as csv_file:
                writer = csv.writer(csv_file,
                                    delimiter=',',
                                    quoting=csv.QUOTE_ALL,
                                    quotechar='"')
                for item in todos:
                    writer.writerow([userId, username,
                                     item['completed'], item['title']])
        except Exception as e:
            print(str(e))


if __name__ == '__main__':
    run()
