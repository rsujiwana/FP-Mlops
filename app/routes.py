from flask import Flask, request, jsonify, render_template, current_app as app
from model.labeling_model import label_text

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/label', methods=['POST'])
def label_data_route():
    data = request.json['data']
    labeled_data = label_text(data)
    return jsonify(labeled_data)

if __name__ == '__main__':
    app.run()
