"""
Shodan REST API Documentation
https://developer.shodan.io/api
"""
import json
from flask import Flask,request, jsonify



base_url = 'https://api.shodan.io' 
search = '/shodan/host/{ip}'
URL='https://developer.shodan.io/api'

# Flask api examples
# https://pythonbasics.org/flask-rest-api/


full_url = base_url+search
# Commonly used HTTP request methods
methods = ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'HEAD']

#flask_requests = "@app.route('/', methods=['POST'])"

get_method = {'GET':"@app.route('/', methods=['GET'])"}
#http_method.update(methods[0]:flask_requests)

print(get_method)
print(request.args.get('name'))

app = Flask('jsonify')
@app.route('/')
def index():
    return jsonify({'name':'user', 'email':'user.email'})

@app.route('/', methods=['GET'])
def query_records():
    name = requests.args.get('name')
    print(name)


#app.run(debug=True)


def shodan_api():
    """Access shodan API"""
    pass


