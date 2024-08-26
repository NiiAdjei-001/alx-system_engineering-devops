#!/usr/bin/python3
"""Reddit Top Post GET Module
"""


import requests


def top_ten(subreddit):
    """Get the titles of the top ten post list for a give subreddit
    """
    headers = {'User-Agent': 'ALX Client'}
    time_filter = 'day'
    limit = 10
    url = 'https://www.reddit.com/r/{}/top.json?t={}&limit={}'.format(
        subreddit,
        time_filter,
        limit
    )
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code == 200:
        for post in response.json().get('data').get('children'):
            print(post.get('data').get('title'))
    else:
        print('None')


if __name__ == '__main__':
    pass
