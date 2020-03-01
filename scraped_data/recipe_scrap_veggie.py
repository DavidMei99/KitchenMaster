# recipe_scrap_veggie.py
# scrap recipes of vegetables
from recipe_scrapers import scrape_me
import json

# recipe_scrapers module download: https://github.com/hhursev/recipe-scrapers
# give the url as a string, it can be url from any site listed below
# e.g. scraper = scrape_me('http://allrecipes.com/Recipe/Apple-Cake-Iv/Detail.aspx')

# scraper.title()
# scraper.total_time()
# scraper.yields()
# scraper.ingredients()
# scraper.instructions()
# scraper.image()

def findTag(url):
    text_split = url.split('/')
    return text_split[len(text_split)-2]

vegetables = ["https://www.allrecipes.com/recipes/918/side-dish/vegetables/asparagus/", \
            "https://www.allrecipes.com/recipes/919/side-dish/vegetables/broccoli/", \
            "https://www.allrecipes.com/recipes/920/side-dish/vegetables/brussels-sprouts/", \
            "https://www.allrecipes.com/recipes/921/side-dish/vegetables/cabbage/", \
            "https://www.allrecipes.com/recipes/922/side-dish/vegetables/carrots/", \
            "https://www.allrecipes.com/recipes/17749/side-dish/vegetables/cauliflower/", \
            "https://www.allrecipes.com/recipes/923/side-dish/vegetables/corn/", \
            "https://www.allrecipes.com/recipes/924/side-dish/vegetables/eggplant/", \
            "https://www.allrecipes.com/recipes/925/side-dish/vegetables/green-beans/", \
            "https://www.allrecipes.com/recipes/2018/side-dish/vegetables/green-peas/", \
            "https://www.allrecipes.com/recipes/16882/side-dish/vegetables/onion/", \
            "https://www.allrecipes.com/recipes/917/side-dish/potatoes/", \
            "https://www.allrecipes.com/recipes/16881/side-dish/vegetables/squash/", \
            "https://www.allrecipes.com/recipes/927/side-dish/vegetables/sweet-potatoes/", \
            "https://www.allrecipes.com/recipes/928/side-dish/vegetables/tomatoes/"]

raw_urls, url_list, pure_url_list = [], [], []
url_pattern = "https://www.allrecipes.com/recipe/"
for item in vegetables:
    scraper = scrape_me(item)
    raw_url = scraper.links()
    raw_urls.append(raw_url)

# for raw_url_dict in raw_urls:
for i in range(len(raw_urls)):
    tag = findTag(vegetables[i])
    for raw_url in raw_urls[i]:
        if url_pattern in raw_url['href'] and len(raw_url['href']) > len(url_pattern) \
            and raw_url['href'] not in pure_url_list:
            pure_url_list.append(raw_url['href'])
            url_list.append(([raw_url['href'], tag]))

print(str(len(url_list)) + " webpages scraped!")

recipe_list, pure_title_list = [], []
for url in url_list:
    scraper = scrape_me(url[0])
    if scraper.title() in pure_title_list:
        continue

    recipe_item = {}
    recipe_item["title"] = scraper.title()
    pure_title_list.append(scraper.title())

    recipe_item["tag"] = url[1]
    # print(recipe_item["tag"])
    
    ing_list = scraper.ingredients()
    if (ing_list != []):
        ing_str = ing_list[0]
    else:
        continue
    for i in range(1, len(ing_list)):
        ing_str += (", " + ing_list[i])
    recipe_item["ingredients"] = ing_str

    recipe_item["instruction"] = scraper.instructions()
    recipe_list.append(recipe_item)

print(str(len(recipe_list)) + " recipes scraped!")

with open('vegetables.json', 'w') as json_file:
    json.dump(recipe_list, json_file)