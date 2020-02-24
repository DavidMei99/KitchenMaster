# recipe_scrap_meat.py
# scrap recipes of meat and poultry
from recipe_scrapers import scrape_me
import json

# module download: https://github.com/hhursev/recipe-scrapers
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
    return text_split[6]

meat_and_poultry = ["https://www.allrecipes.com/recipes/200/meat-and-poultry/beef/", \
                    "https://www.allrecipes.com/recipes/201/meat-and-poultry/chicken/", \
                    "https://www.allrecipes.com/recipes/202/meat-and-poultry/game-meats/", \
                    "https://www.allrecipes.com/recipes/203/meat-and-poultry/lamb/", \
                    "https://www.allrecipes.com/recipes/205/meat-and-poultry/pork/", \
                    "https://www.allrecipes.com/recipes/16546/meat-and-poultry/sausage/", \
                    "https://www.allrecipes.com/recipes/22479/meat-and-poultry/goat/", \
                    "https://www.allrecipes.com/recipes/206/meat-and-poultry/turkey/"]

raw_urls, url_list, pure_url_list = [], [], []
url_pattern = "https://www.allrecipes.com/recipe/"
for item in meat_and_poultry:
    scraper = scrape_me(item)
    raw_url = scraper.links()
    raw_urls.append(raw_url)

# for raw_url_dict in raw_urls:
for i in range(len(raw_urls)):
    tag = findTag(meat_and_poultry[i])
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

with open('meat_and_poultry.json', 'w') as json_file:
    json.dump(recipe_list, json_file)