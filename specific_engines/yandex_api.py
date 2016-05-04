import cookielib, urllib2
import lxml.html as html
import re
import json
import time

class YandexSearcher:
    def __init__(self):
        self.max_number_per_req = 30
        self.base_url = 'https://yandex.ru/images/search?text={query}&isize=medium&type=photo&itype=jpg&p={page}'
        self.img_url_pattern = re.compile(r'img_url=(.*?)&pos')
        cj = cookielib.CookieJar()
        self.opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cj))
        self.opener.addheaders = [
            ('User-agent', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36'),
            ('Cookie', 'fuid01=5592920f65512893.HRFHUGAQ7nA-P04Caa0ZzpABhTyxmJQlryxa_l5JO-3vr05i0H5bEaRGh36ang2DunL3AuLLtf4d_rC2T8bh_N1ZvyosdrhX4nwhkHieA9lyvyg126SL_DbCGH1TYV8J; yandexuid=2328750601434968215; yandex_gid=213; zm=m-white_bender.flex.webp.css-https%3Awww_U409l8EMelCe6LLXJwN-QUZhS2s%3Al; ys=wprid.1462363542629115-1388988397728073139706627-myt1-1657; yabs-frequency=/4/0G000C3bALS00000/; _ym_uid=1462371845883239030; _ym_isad=2; yp=1467030606.ww.1#1478139842.szm.1:2560x1440:1335x1266#1464944543.ygu.1#1462439502.nps.4613309697:close#1467537102.cnps.461458243:max#1493467549.dsws.1#1493467549.dswa.0#1493467549.dwys.1')

        ]

    def preprocess(self, q):
        query = unicode(q, "utf-8") if type(q) != unicode else q
        return query

    def query(self, query, num_results=30):
        query = self.preprocess(query)
        p = 0
        next_url = self.base_url.replace("{query}", query).replace("{page}", str(p))
        all_images = []
        for i in range(0, num_results, self.max_number_per_req):
            page = html.fromstring(self.opener.open(next_url).read())
            elements = page.find_class('serp-list')
            e = elements[0].getchildren()
            images = [json.loads(el.get('data-bem'))['serp-item'] for el in e]
            for image in images:
                all_images.append({'image_id': image['id'], 'url': image['img_href']})
            p += 1
            next_url = self.base_url.replace("{query}", query).replace("{page}", str(p))
            time.sleep(0.25)
        return all_images[:num_results]
