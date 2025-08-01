from sqlalchemy_serializer import SerializerMixin

from internet_application.ext.database import db


class Product(db.Model, SerializerMixin):        # type: ignore
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(140))
    price = db.Column(db.Numeric())
    description = db.Column(db.Text)


class User(db.Model, SerializerMixin):           # type: ignore
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(140))
    password = db.Column(db.String(512))
