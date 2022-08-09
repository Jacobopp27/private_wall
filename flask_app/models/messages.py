from flask_app.config.mysqlconnection import connectToMySQL
from datetime import datetime
import math


class Message:
    def __init__(self, data):
        self.id = data['id']
        self.mensaje = data['mensaje']
        self.created_at = data['created_at']
        self.updated_at = data['updated_at']
        self.sender_id = data['sender_id']
        self.receiver_id = data['receiver_id']
        self.sender_name = data['sender_name']
        self.receiver_name = data['receiver_name']

    def time_span(self):
        now = datetime.now()
        delta = now - self.created_at
        print(delta.days)
        print(delta.total_seconds())
        if delta.days > 0:
            return f"Hace {delta.days} dia(s)"
        elif (math.floor(delta.total_seconds() / 60)) >= 60:
            return f"Hace {math.floor(math.floor(delta.total_seconds() / 60)/60)} hora(s)"
        elif delta.total_seconds() >= 60:
            return f"Hace {math.floor(delta.total_seconds() / 60)} minuto(s)"
        else:
            return f"Hace {math.floor(delta.total_seconds())} segundo(s)"


    @classmethod
    def save(cls, formulario):
        query = "INSERT INTO mesagges (mensaje, sender_id, receiver_id) VALUES (%(mensaje)s, %(sender_id)s, %(receiver_id)s)"
        result= connectToMySQL('muro_privado').query_db(query, formulario)
        return result

    @classmethod
    def get_user_messages(cls, formulario):
        query = "SELECT mesagges.*, senders.first_name as sender_name, receivers.first_name as receiver_name FROM mesagges LEFT JOIN users as senders ON senders.id = sender_id LEFT JOIN users as receivers ON receivers.id = receiver_id WHERE receiver_id = %(id)s;"
        results= connectToMySQL('muro_privado').query_db(query, formulario)
        
        messages=[]
        for message in results:
            messages.append(cls(message))
        return messages

    @classmethod
    def destroy(cls, formulario):
        query = "DELETE FROM mesagges WHERE id= %(id)s"
        result= connectToMySQL('muro_privado').query_db(query, formulario)
        return result
