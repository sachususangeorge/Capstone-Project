import requests
import boto3
import json
import os

cancer_url ='https://api.gdc.cancer.gov/cases'
table_name=os.environ["DATA_TABLE_NAME"]

dynamodb_resource = boto3.resource("dynamodb")
cancer_data_table= dynamodb_resource.Table(table_name)

def fetch_data():
    response = requests.get(cancer_url)
    params = {
          'from':0, 'size':4000}
    response = requests.get(cancer_url, params = params)
    return response.json()


def map_data(cancer_api_data):
    cancer_data = []
    
    for item in cancer_api_data["data"]["hits"]:
         cancer_data.append({
            "id": item["id"],
            "primary_site": item["primary_site"],
            "case_id": item["case_id"],
            "disease_type": item["disease_type"],
            "updated_datetime": item["updated_datetime"]
            
        })
    return cancer_data


def save_data(cancer_data):
    for data in cancer_data:
      cancer_data_table.put_item(Item = data)
    
         

def handler(event,context):
    fetch_cancer_api = fetch_data()
    cancer_data = map_data(fetch_cancer_api)
    save_data(cancer_data)

if __name__ == "__main__":
    handler({},{})
