# Magic Card API

A small Rails API that consumes data related to cards from a [Magic The Gather API](https://magicthegathering.io/) and allows search functionality.

## Dependencies
```
ruby >= 2.5
rails >= 5
```

## Setting Up Locally
After cloning the repository, run
```bash
$ rails db:{create,migrate}
$ rails server
```

and the endpoints will be accessible at `localhost:3000/api/v1/...`

## Hosted Instance
This API is hosted on a free Heroku instance that can be accessed [here](https://magic-card-api-test.herokuapp.com/api/v1/cards)

## Endpoints
There is currently no authentication with this API

### API/V1/CARDS
Verb: **GET**
An endpoint returning a collection of cards that is filterable and sortable

#### Parameters

---

|Parameter|Description|
|---|---|
|name|The name of the card, can be partial searched|
|colors|The colors of the card. Can be searched with comma delineated params. values: `[white,blue,red,green,black]`|
|cmc| A card's converted mana cost. Always a number|
|power| The card's power (basically damage potential). Only present for creatures.|
|toughness|The card's toughness (basically survivability). Only present for creatures.|
|types| The card's different types as an array|
|rarity| The rarity of the card|
|orderBy|The field that the results will be ordered by|
|page|The page of results to request|
|pageSize|The amount of cards to return in a single request. Defaults to the maximum of 100|

#### Response
```JSON
{
  "data": [
    {
      "id": "6b0e48c0-441d-5a62-a558-3c99473e4387",
      "type": "card",
      "attributes": {
        "name": "Coalition Victory",
        "manaCost": "{3}{W}{U}{B}{R}{G}",
        "convertedManaCost": 8,
        "types": ["Sorcery"],
        "power": null,
        "toughness": null,
        "rarity": "Rare",
        "colors": ["Black","Green","Red","Blue","White"]
      }
    },
    {...},
    {...}
  ]
}
```
