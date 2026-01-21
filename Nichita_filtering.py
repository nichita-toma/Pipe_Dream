import json
all_countries = [
    "Afghanistan", "Albania", "Algeria", "Andorra", "Angola",
    "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria",
    "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados",
    "Belarus", "Belgium", "Belize", "Benin", "Bhutan",
    "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei",
    "Bulgaria", "Burkina Faso", "Burundi", "Cabo Verde", "Cambodia",
    "Cameroon", "Canada", "Central African Republic", "Chad", "Chile",
    "China", "Colombia", "Comoros", "Congo (Congo-Brazzaville)", "Costa Rica",
    "Croatia", "Cuba", "Cyprus", "Czechia (Czech Republic)", "Denmark",
    "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt",
    "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Eswatini",
    "Ethiopia", "Fiji", "Finland", "France", "Gabon",
    "Gambia", "Georgia", "Germany", "Ghana", "Greece",
    "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana",
    "Haiti", "Honduras", "Hungary", "Iceland", "India",
    "Indonesia", "Iran", "Iraq", "Ireland", "Israel",
    "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan",
    "Kenya", "Kiribati", "Kuwait", "Kyrgyzstan", "Laos",
    "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya",
    "Liechtenstein", "Lithuania", "Luxembourg", "Madagascar", "Malawi",
    "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands",
    "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova",
    "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique",
    "Myanmar (Burma)", "Namibia", "Nauru", "Nepal", "Netherlands",
    "New Zealand", "Nicaragua", "Niger", "Nigeria", "North Korea",
    "North Macedonia", "Norway", "Oman", "Pakistan", "Palau",
    "Palestine", "Panama", "Papua New Guinea", "Paraguay", "Peru",
    "Philippines", "Poland", "Portugal", "Qatar", "Romania",
    "Russia", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines",
    "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal",
    "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia",
    "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Korea",
    "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname",
    "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan",
    "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga",
    "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu",
    "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States",
    "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City", "Venezuela",
    "Vietnam", "Yemen", "Zambia", "Zimbabwe"
]

all_nationalities = [
    "Afghan", "Albanian", "Algerian", "Andorran", "Angolan",
    "Antiguan and Barbudan", "Argentinian", "Armenian", "Australian", "Austrian",
    "Azerbaijani", "Bahamian", "Bahraini", "Bangladeshi", "Barbadian",
    "Belarusian", "Belgian", "Belizean", "Beninese", "Bhutanese",
    "Bolivian", "Bosnian and Herzegovinian", "Botswanan", "Brazilian", "Bruneian",
    "Bulgarian", "Burkinabe", "Burundian", "Cabo Verdean", "Cambodian",
    "Cameroonian", "Canadian", "Central African", "Chadian", "Chilean",
    "Chinese", "Colombian", "Comoran", "Congolese", "Costa Rican",
    "Croatian", "Cuban", "Cypriot", "Czech", "Danish",
    "Djiboutian", "Dominican", "Dominican", "Ecuadorian", "Egyptian",
    "Salvadoran", "Equatorial Guinean", "Eritrean", "Estonian", "Swazi",
    "Ethiopian", "Fijian", "Finnish", "French", "Gabonese",
    "Gambian", "Georgian", "German", "Ghanaian", "Greek",
    "Grenadian", "Guatemalan", "Guinean", "Guinea-Bissauan", "Guyanese",
    "Haitian", "Honduran", "Hungarian", "Icelandic", "Indian",
    "Indonesian", "Iranian", "Iraqi", "Irish", "Israeli",
    "Italian", "Jamaican", "Japanese", "Jordanian", "Kazakhstani",
    "Kenyan", "I-Kiribati", "Kuwaiti", "Kyrgyzstani", "Laotian",
    "Latvian", "Lebanese", "Basotho", "Liberian", "Libyan",
    "Liechtensteiner", "Lithuanian", "Luxembourger", "Malagasy", "Malawian",
    "Malaysian", "Maldivian", "Malian", "Maltese", "Marshallese",
    "Mauritanian", "Mauritian", "Mexican", "Micronesian", "Moldovan",
    "Monégasque", "Mongolian", "Montenegrin", "Moroccan", "Mozambican",
    "Burmese", "Namibian", "Nauruan", "Nepali", "Dutch",
    "New Zealander", "Nicaraguan", "Nigerien", "Nigerian", "North Korean",
    "North Macedonian", "Norwegian", "Omani", "Pakistani", "Palauan",
    "Palestinian", "Panamanian", "Papua New Guinean", "Paraguayan", "Peruvian",
    "Filipino", "Polish", "Portuguese", "Qatari", "Romanian",
    "Russian", "Rwandan", "Kittitian and Nevisian", "Saint Lucian", "Vincentian",
    "Samoan", "Sammarinese", "São Toméan", "Saudi Arabian", "Senegalese",
    "Serbian", "Seychellois", "Sierra Leonean", "Singaporean", "Slovak",
    "Slovenian", "Solomon Islander", "Somali", "South African", "South Korean",
    "South Sudanese", "Spanish", "Sri Lankan", "Sudanese", "Surinamese",
    "Swedish", "Swiss", "Syrian", "Taiwanese", "Tajikistani",
    "Tanzanian", "Thai", "Timorese", "Togolese", "Tongan",
    "Trinidadian and Tobagonian", "Tunisian", "Turkish", "Turkmen", "Tuvaluan",
    "Ugandan", "Ukrainian", "Emirati", "British", "American",
    "Uruguayan", "Uzbekistani", "Vanuatuan", "Vatican", "Venezuelan",
    "Vietnamese", "Yemeni", "Zambian", "Zimbabwean"
]

all_letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"


for letter in all_letters:    
    with open(f"People/{letter}_people.json") as file:
        data = json.load(file)
    for item in data: 
        if "http://purl.org/dc/elements/1.1/description" in item:
            if "activist " in item["http://purl.org/dc/elements/1.1/description"]:
                    if "ontology/birthYear" in item and "ontology/deathYear" in item: 
                            if type(item["ontology/deathYear"]) is str and type(item["ontology/birthYear"]) is str:
                        
                                if int(item["ontology/birthYear"])> 1800:
                                    age = int(item["ontology/deathYear"]) - int(item["ontology/birthYear"])
                                    print(age)
                                    print(item["title"], item["http://purl.org/dc/elements/1.1/description"])
                                    nationality = 'blabla'
                                    if any(char.isupper()for char in item["http://purl.org/dc/elements/1.1/description"]):
                                        description = item["http://purl.org/dc/elements/1.1/description"].split()
                                        for word in description:
                                            if word[0].isupper() and  word in all_nationalities:
                                                
                                                number = all_nationalities.index(word)
                                                print(all_countries[number])
                                                
                                            elif "ontology/deathPlace_label" in item:
                                                 if type(item["ontology/deathPlace_label"]) is list:
                                                     for tara in item["ontology/deathPlace_label"]:
                                                         if tara in all_countries:
                                                                 print(tara)
                                                
                                            elif "ontology/birthPlace_label" in item:
                                                 if type(item["ontology/birthPlace_label"]) is list:
                                                     for teritoriu in item["ontology/birthPlace_label"]:
                                                         if teritoriu in all_countries:
                                                             print(teritoriu)


                                    if nationality not in all_nationalities:
                                         if "ontology/deathPlace_label" in item:
                                            if type(item["ontology/deathPlace_label"]) is list:
                                                for pays in item["ontology/deathPlace_label"]:
                                                    if pays in all_countries:
                                                      print(pays)
                                         
                                         elif "ontology/birthPlace_label" in item:
                                            if type(item["ontology/birthPlace_label"]) is list:
                                                for pays2 in item["ontology/birthPlace_label"]:
                                                    if pays2 in all_countries:
                                                      print(pays2)


                       

                        
                                            
                                               

                                
            # elif  "journalist" in item["http://purl.org/dc/elements/1.1/description"]:   
            #       if "ontology/birthYear" in item:
            #             if type(item["ontology/deathYear"] == str) and type(item["ontology/birthYear"] == str):
            #                 if int(item["ontology/birthYear"])> 1800:
            #                     if   "ontology/deathYear" in item:               
            #                 # if "ontology/deathPlace" in item:
            #                             # if "ontology/deathPlace_label" in item:
            #                                     if any(char.isupper()for char in item["http://purl.org/dc/elements/1.1/description"]):
            #                                         description = item["http://purl.org/dc/elements/1.1/description"].split(" ")
            #                                         nationality = description[0]
            #                                         if  nationality != "Model" and nationality != "Political":
            #                                                     print(nationality)
            #                                     elif "ontology/deathPlace_label" in item:
            #                                         print(item["ontology/deathPlace_label"])
            #                                     elif "ontology/birthPlace_label" in item:
            #                                         print(item["ontology/birthPlace_label"])
            #                 #  if "ontology/deathCause_label" in item:
                        
            #                                     if type(item["ontology/deathYear"] == str):
            #                                         age = int(item["ontology/deathYear"]) - int(item["ontology/birthYear"])
            #                                         print(age)
            #                                     print(item["title"], item["http://purl.org/dc/elements/1.1/description"])
                                
                                                    
                                                
                                    #item["ontology/deathCause_label"]
                                    #item["ontology/deathPlace_label"]
                                    #new comment

                                # checks if the word starts with a big letter and then princt that word 
                        #  if any(char.isupper()for char in item["http://purl.org/dc/elements/1.1/description"]):
                        #                         description = item["http://purl.org/dc/elements/1.1/description"].split(" ")
                        #                         for word in description:
                        #                              if word and word[0].isupper():
                        #                                   nationality = word
                        #                                   if  nationality != "Model" and nationality != "Political":
                        #                                      print(nationality)