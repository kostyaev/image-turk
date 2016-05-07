import urllib2
import json
from searchtools.engines import api_credentials


class InstagramSearcher:
    def __init__(self):
        self.url = 'https://api.instagram.com/v1/tags/{query}/media/recent/?access_token={key}&count={limit}'\
            .replace('{key}', api_credentials.INSTAGRAM_API_KEY)
        self.max_number_per_req = 20

    def preprocess(self, q):
        query = unicode(q, "utf-8") if type(q) != unicode else q
        return query.encode('utf-8')

    def query(self, query, num_results=20):
        query = urllib2.quote(self.preprocess(query))
        all_images = []
        next_url = self.url.replace("{query}", query).replace("{limit}", str(self.max_number_per_req))
        for i in range(0, num_results, self.max_number_per_req):
            response = urllib2.urlopen(next_url)
            data = json.load(response)
            images = [{'image_id': entry['id'], 'url': entry['images']['standard_resolution']['url']} for entry in data['data']]
            all_images.extend(images)
            next_url = data['pagination']['next_url']
        return all_images
