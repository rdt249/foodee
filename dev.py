from pprint import pprint
import requests

def get_product(barcode):
    # https://world.openfoodfacts.org/data
    product = requests.get(f'https://world.openfoodfacts.org/api/v0/product/{barcode}.json').json()
    if product['status'] == 1: return product
    product = requests.get(f'https://world.openbeautyfacts.org/api/v0/product/{barcode}.json').json()
    if product['status'] == 1: return product
    product = requests.get(f'https://world.openpetfoodfacts.org/api/v0/product/{barcode}.json').json()
    if product['status'] == 1: return product
    product = requests.get(f'https://world.openproductsfacts.org/api/v0/product/{barcode}.json').json()
    if product['status'] == 1: return product

pprint(get_product('011110914477'))

# 011110914477 -- kroger raisins
# 3606000537514 -- cerave lotion
# 8712113563175 -- skyler dog treats
# 0096619236763 -- kirkland car battery