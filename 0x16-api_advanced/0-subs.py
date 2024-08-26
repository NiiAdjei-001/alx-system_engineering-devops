#!/usr/bin/python3
"""Reddit Subscriber GET Module
"""


import requests


def number_of_subscribers(subreddit):
    """ Get number of Subscribers of a subreddit
    """
    headers = {'User-Agent': 'ALX Client'}
    url = 'https://www.reddit.com/r/{}/about.json'.format(subreddit)
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        return response.json()['data']['subscribers']
    else:
        return 0


if __name__ == '__main__':
    pass
