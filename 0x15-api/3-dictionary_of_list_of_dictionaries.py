#!/usr/bin/python3
"""Export gathered Data from an API into CSV file
"""


import json
from urllib import request


def run():
    """ run script
    """
    try:
        req_url_users = "https://jsonplaceholder.typicode.com/users"
        res = request.urlopen(req_url_users)
        users = json.loads(res.read())

        req_url_todos = "https://jsonplaceholder.typicode.com/todos"
        res = request.urlopen(req_url_todos)
        todos = json.loads(res.read())

        with open("todo_all_employees.json", "w") as jsfile:
            all_dic = dict()
            for user in users:
                all_dic[user['id']] = list()
                user_list = list(
                    filter(
                        lambda x: x['userId'] == user['id'], todos))
                for item in user_list:
                    all_dic[user['id']].append(
                        {"username": user['username'],
                            "task": item['title'],
                            "completed": item['completed']}
                        )
            json.dump(all_dic, jsfile)
    except Exception as e:
        print(str(e))


if __name__ == '__main__':
    run()
