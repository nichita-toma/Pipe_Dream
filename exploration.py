import json
presidents = {}


with open("People/L_people.json") as file:
    data = json.load(file)

 
for item in data: 
    if "http://purl.org/dc/elements/1.1/description" in item:
        if "activist " in item["http://purl.org/dc/elements/1.1/description"]:
                if   "ontology/birthYear" in item:
                    if int(item["ontology/birthYear"])> 1800:
                        if "ontology/deathYear" in item:
                      #  if "ontology/deathCause_label" in item:
                 
          
                                    life_expectancy = int(item["ontology/deathYear"]) - int(item["ontology/birthYear"])
                                    print(item["title"], item["http://purl.org/dc/elements/1.1/description"] , life_expectancy)
                                #item["ontology/deathCause_label"]
                                #new comment
                    