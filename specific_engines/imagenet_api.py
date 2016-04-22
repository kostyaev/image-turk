import urllib2


class ImagenetSearcher:
    def __init__(self):
        self.wnid_to_word = {}
        self.word_to_wnid = {}
        for line in open('data/words.txt'):
            a = line.rstrip('\n').split('\t')
            word = a[1].lower()
            self.wnid_to_word[a[0]] = word
            self.word_to_wnid[word] = a[0]
            self.wnid_url = "http://image-net.org/api/text/imagenet.synset.geturls?wnid={}"

    def perform_text_search(self, query):
        for key in self.word_to_wnid.keys():
            if query in key:
                yield self.word_to_wnid[key]

    def preprocess(self, q):
        query = unicode(q, "utf-8") if type(q) != unicode else q
        return query

    def query(self, query, num_results=100):
        wnid = query if query in self.wnid_to_word else None
        wnid = self.word_to_wnid[query] if wnid is None and query in self.word_to_wnid else wnid
        wnid_gen = self.perform_text_search(query) if wnid is None else [wnid]
        for wnid in wnid_gen:
            response = self.preprocess(urllib2.urlopen(self.wnid_url.format(wnid)).read()).split('\r\n')
            if len(response) < 5:
                continue
            result = [{u'image_id': wnid + '_' + str(idx), u'url': self.preprocess(url)}
                      for idx, url in enumerate(response) if len(url) > 10]
            return result[:num_results]
        return []
