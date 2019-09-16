import os

from Crypto.Hash import SHA256
from Crypto.PublicKey import RSA
from Crypto.Signature import pkcs1_15

fname = "demo.docx"

# Генерируете новый ключ (или берете ранее сгенерированный)
key = RSA.generate(1024, os.urandom)
# Получаете хэш файла
h = SHA256.new()
with open(fname, "rb") as f:
    for chunk in iter(lambda: f.read(4096), b""):
        h.update(chunk)

# Подписываете хэш
signature = pkcs1_15.new(key).sign(h)

# Получаете открытый ключ из закрытого
pubkey = key.publickey()

# Пересылаете пользователю файл, публичный ключ и подпись
# На стороне пользователя заново вычисляете хэш файла (опущено) и сверяете подпись
pkcs1_15.new(pubkey).verify(h, signature)

fname = 'demo1.docx'
h = SHA256.new()
with open(fname, "rb") as f:
    for chunk in iter(lambda: f.read(4096), b""):
        h.update(chunk)
# Отличающийся хэш не должен проходить проверку
pkcs1_15.new(pubkey).verify(h, signature)
