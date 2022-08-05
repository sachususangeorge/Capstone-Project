mkdir ../infrastructure/build
# build fetch function
cd fetch_data_lambda
zip -r ../../infrastructure/build/fetch_data_lambda.zip .
cd ..
# build requests layer
cd requests_layer
pip install -r requirement.txt -t python/lib/python3.9/site-packages
zip -r ../../infrastructure/build/requests_layer.zip .
cd ..