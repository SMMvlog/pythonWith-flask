from flask import Flask, render_template, request, session,redirect
from werkzeug.utils import secure_filename
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from flask_mail import Mail
import math
import json
import os




Blog = Flask(__name__)

with open('config.json','r') as c:
    params = json.load(c)["params"]
local_server = True
Blog.secret_key='super-secret-key'
Blog.config['UPLOAD_FOLDER'] = params['upload_location']

Blog.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail-user'],
    MAIL_PASSWORD = params['gmail-password']

)

mail = Mail(Blog)
if(local_server):
    Blog.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    Blog.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

# Blog.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@localhost/myfirstblog'

# Blog.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root@localhost/myfirstblog'
db = SQLAlchemy(Blog)

class Contacts(db.Model):

    srNo = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    phone = db.Column(db.String(15), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    email = db.Column(db.String(20), nullable=False)

class post(db.Model):

    srNo = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(30), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    tagline = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(12), nullable=True)



@Blog.route("/")
def home():
    posts = post.query.filter_by().all()
    last =math.ceil(len(posts)/int(params['no_of_post']))
    # [0:params['no_of_post']]
    page = request.args.get('page')
    if(not str(page).isnumeric()):
        page = 1
    page = int(page)
    posts = posts[(page-1)*int(params['no_of_post']): (page-1)*int(params['no_of_post'])+int(params['no_of_post'])]

    if page==1:
        prev ='#'
        next = "/?page="+ str(page+1)
    elif (page == last):
        prev = "/?page=" + str(page - 1)
        next = '#'
    else:
        prev = "/?page=" + str(page - 1)
        next = "/?page=" + str(page + 1)

    return render_template('home.html',params=params, posts=posts, prev=prev, next=next)

@Blog.route("/uploader", methods = ['GET', 'POST'])
def uploader():
    if ('user' in session and session['user']== params['admin_user']):
        if(request.method == 'POST'):
            f = request.files['file1']
            f.save(os.path.join(Blog.config['UPLOAD_FOLDER'],secure_filename(f.filename)))
            return "Uploaded Successfully"



@Blog.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')

@Blog.route("/delete/<string:srNo>",methods=['GET','POST'])
def delete(srNo):
    if ('user' in session and session['user']== params['admin_user']):
        posts =post.query.filter_by(srNo=srNo).first()
        db.session.delete(posts)
        db.session.commit()
    return redirect('/dashboard')

@Blog.route("/contact", methods = ['GET', 'POST'])
def contact():
    if(request.method=='POST'):
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        '''srNo, name, phone, msg, date, email
            '''
        entry = Contacts(name = name, phone = phone, msg = message, date=datetime.now(), email=email)
        db.session.add(entry)
        db.session.commit()
        mail.send_message('New Message From'+name, sender=email,
                          recipients=[params['gmail-user']],
                          body=message + "\n" +phone)

    return render_template('contact.html',params=params)

@Blog.route("/about")
def about():
    return render_template('about.html',params=params)


@Blog.route("/dashboard",methods=['GET','POST'])
def dashboard():
    if ('user' in session and session['user']== params['admin_user']):
        posts = post.query.all()
        return render_template('dashboard.html',params=params,posts=posts)


    if request.method=='POST':
        username = request.form.get('uname')
        userpass = request.form.get('pass')
        if (username==params['admin_user'] and userpass==params['admin_password']):
            session['user'] =username
            posts = post.query.all()
            return render_template('dashboard.html',params=params,posts=posts)


    return render_template('login.html',params=params)

@Blog.route("/post/<string:post_slug>",methods=['GET'])
def post_route(post_slug):
    posts=post.query.filter_by(slug=post_slug).first()
    return render_template('post.html',params=params,post=posts)

@Blog.route("/edit/<string:srNo>",methods=['GET','POST'])
def edit(srNo):
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method == 'POST':
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()

            if srNo == '0':
                posts = post(title=box_title, slug=slug, content=content, tagline=tline, img_file=img_file, date=date)
                db.session.add(posts)
                db.session.commit()
            else:
                posts = post.query.filter_by(srNo=srNo).first()
                posts.title = box_title
                posts.slug = slug
                posts.content = content
                posts.tagline = tline
                posts.img_file= img_file
                posts.date = date
                db.session.commit()
                return redirect('/edit/'+srNo)
        posts = post.query.filter_by(srNo=srNo).first()


        return render_template('edit.html',params=params,posts=posts,srNo=srNo)




Blog.run(debug=True)