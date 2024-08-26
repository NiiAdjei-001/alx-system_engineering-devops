#!/usr/bin/python3
"""Reddit Top Post GET Module
"""


import requests


def top_ten(subreddit):
    """Get the titles of the top ten post list for a give subreddit
    """
    headers = {'User-Agent': 'ALX Client'}
    limit = 10
    url = "https://www.reddit.com/r/{}/top.json?limit={}".format(
        subreddit,
        limit
    )

    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code == 200:
        try:
            data = response.json().get('data', {})
            posts = data.get('children', [])

            if not posts:
                print(None)
                return

            for post in posts:
                print(post.get('data').get('title'))

        except(ValueError, KeyError):
            print(None)

    elif response.status_code == 404:
        print('None')

    else:
        print('None')


if __name__ == '__main__':
    pass
