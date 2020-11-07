from aito.schema import AitoTableSchema
import pandas as pd

def main():
    rest_accepts = pd.read_csv("restaurants_data/chefmozaccepts.csv")
    rest_cuisine = pd.read_csv("restaurants_data/chefmozcuisine.csv")
    rest_hours4 = pd.read_csv("restaurants_data/chefmozhours4.csv")
    rest_parking = pd.read_csv("restaurants_data/chefmozparking.csv")
    print(rest_parking.head())


if __name__ == "__main__":
    main()
