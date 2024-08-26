#!/usr/bin/python3
"""Reddit Subscriber GET Module
"""


import requests


def number_of_subscribers(subreddit):
    """ Get number of Subscribers of a subreddit
    """
    headers = {'User-Agent': 'ALX Client', }
    url = 'https://www.reddit.com/r/{}/about.json'.format(subreddit)
    
    response = requests.get(url, headers=headers, allow_redirects=False)
    
    if response.status_code == 200:
        try:
            data = response.json().get('data', {})
            return data.get('subscribers', 0)
        except (ValueError, KeyError):
            return 0
        # return response.json()['data']['subscribers']
    elif response.status_code == 404:
        return 0
    else:
        return 0

if __name__ == '__main__':
    pass
