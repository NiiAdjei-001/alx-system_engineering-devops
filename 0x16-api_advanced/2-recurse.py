#!/usr/bin/python3
"""Reddit Top Post GET Module
"""


import requests


def recurse(subreddit, hot_list=[], after=None):
    """Get list containing the titles of hot articles for a given subreddit
    """
    headers = {'User-Agent': 'ALX Client'}
    url = 'https://www.reddit.com/r/{}/hot.json'.format(subreddit)

    if after:
        url += '?after={}'.format(after)

    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code == 200:
        for articles in response.json().get('data').get('children'):
            hot_list.append(articles.get('data').get('title'))
        after = response.json().get('data').get('after')

        if after:
            # print(after)
            return recurse(subreddit=subreddit, hot_list=hot_list, after=after)
        else:
            return hot_list
    else:
        return None


if __name__ == '__main__':
    pass
