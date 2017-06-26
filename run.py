from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/proposal.html')
def proposal():
    return render_template('proposal.html')

@app.route('/love.html')
def love():
    return render_template('love.html')



if __name__ == '__main__':
    app.run()


