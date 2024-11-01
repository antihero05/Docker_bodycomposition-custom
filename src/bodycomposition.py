#!/usr/bin/python2

import os
import requests
import json
import sys
from garth.exc import GarthHTTPError
from garminconnect import Garmin, GarminConnectAuthenticationError

tokenstore = os.getenv("GARMINTOKENS")
email = os.getenv("GARMINUSER")
password = os.getenv("GARMINPASSWORD")

def init_api():
    try:
        # Using Oauth1 and OAuth2 token files from directory
        print(
        f"Trying to login to Garmin Connect using token data from directory '{tokenstore}'...\n"
        )
        garmin = Garmin()
        garmin.login(tokenstore)

    except (FileNotFoundError, GarthHTTPError, GarminConnectAuthenticationError):
        # Session is expired. You'll need to log in again
        print(
        "Login tokens not present, login with your Garmin Connect credentials to generate them.\n"
        f"They will be stored in '{tokenstore}' for future use.\n"
        )
        try:
            garmin = Garmin(email=email, password=password, is_cn=False)
            garmin.login()
            # Save Oauth1 and Oauth2 token files to directory for next login
            garmin.garth.dump(tokenstore)
        
        except (FileNotFoundError, GarthHTTPError, GarminConnectAuthenticationError, requests.exceptions.HTTPError) as err:
            print(err)
            return None
    finally:
        return garmin

# Main program loop
if __name__ == "__main__":

    try:
        data = sys.stdin.read()
        json_data = json.loads(data)
        weight = json_data["weight"]
        percent_fat = json_data["body_fat"]
        percent_hydration = json_data["water"]
        body_type={
            'Obese': 1,
            'Overweight': 2,
            'Thick-set': 3,
            'Lack-exercise': 4,
            'Balanced': 5,
            'Balanced-muscular': 6,
            'Skinny': 7,
            'Balanced-skinny': 8,
            'Skinny-muscular': 9
        }
        physique_rating=body_type.get(str(json_data["body_type"]), None)
        bone_mass = json_data["bone_mass"]
        muscle_mass = json_data["muscle_mass"]
        basal_met = json_data["basal_metabolism"]
        metabolic_age = json_data["metabolic_age"]
        visceral_fat_rating = json_data["visceral_fat"]
        bmi = json_data["bmi"]

    except Exception as err:
        print(err)

    else:
        try:
            api = init_api()
            print(api)
            if api:
                api.add_body_composition(
                json_data["timestamp"],
                weight=(weight),
                percent_fat=percent_fat,
                percent_hydration=percent_hydration,
                physique_rating=physique_rating,
                bone_mass=bone_mass,
                muscle_mass=muscle_mass,
                basal_met=basal_met,
                metabolic_age=metabolic_age,
                visceral_fat_rating=visceral_fat_rating,
                bmi=bmi
                )
        except (FileNotFoundError, GarthHTTPError, GarminConnectAuthenticationError, requests.exceptions.HTTPError) as err:
            print(err)
