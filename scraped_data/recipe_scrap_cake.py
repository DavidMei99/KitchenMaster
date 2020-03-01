# recipe_scrap_cake.py
# scrap recipes of cakes
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

cakes = ["https://www.allrecipes.com/recipes/15828/desserts/cakes/apple-cake/", \
            "https://www.allrecipes.com/recipes/15827/desserts/cakes/banana-cake/", \
            "https://www.allrecipes.com/recipes/17263/desserts/cakes/blueberry-cake/", \
            "https://www.allrecipes.com/recipes/860/desserts/cakes/carrot-cake/", \
            "https://www.allrecipes.com/recipes/387/desserts/cakes/cheesecake/", \
            "https://www.allrecipes.com/recipes/835/desserts/cakes/chocolate-cake/", \
            "https://www.allrecipes.com/recipes/1377/desserts/cakes/coconut-cake/", \
            "https://www.allrecipes.com/recipes/389/desserts/cakes/coffee-cake/", \
            "https://www.allrecipes.com/recipes/15838/desserts/cakes/peach-cake/", \
            "https://www.allrecipes.com/recipes/380/desserts/cakes/lemon-cake/", \
            "https://www.allrecipes.com/recipes/16761/desserts/cakes/pineapple-cake/", \
            "https://www.allrecipes.com/recipes/15917/desserts/cakes/pumpkin-cake/"]

raw_urls, url_list, pure_url_list = [], [], []
url_pattern = "https://www.allrecipes.com/recipe/"
for item in cakes:
    scraper = scrape_me(item)
    raw_url = scraper.links()
    raw_urls.append(raw_url)

# for raw_url_dict in raw_urls:
for i in range(len(raw_urls)):
    tag = findTag(cakes[i])
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

with open('cakes.json', 'w') as json_file:
    json.dump(recipe_list, json_file)