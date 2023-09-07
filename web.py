from flask import Flask, render_template, request


app = Flask(__name__)

@app.route("/")
def index():
    r_list = []
    remotes = request.args.get('remote','')
    if remotes:
        for remote in remotes.split(','):
            r_list.append(remote.split(':'))
        
    return render_template('index.html',remotes=r_list)

if __name__ == '__main__':
    app.run('0.0.0.0')