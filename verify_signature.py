import argparse

from Crypto.Hash import SHA256
from Crypto.PublicKey import RSA
from Crypto.Signature import pkcs1_15


def verify_signature(file_name, signature, pubkey):
    # Получаете хэш файла
    file_hash = SHA256.new()
    with open(file_name, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            file_hash.update(chunk)
    # Отличающийся хэш не должен проходить проверку
    try:
        pkcs1_15.new(pubkey).verify(file_hash, signature)
        print("Проверка пройдена успешно")
    except ValueError:
        print("Файл не прошел проверку")


def read_files(sign_filename, pubkey_filename):
    with open(sign_filename, 'rb') as f:
        sign = f.read()
    f.close()

    with open(pubkey_filename, 'rb') as f:
        key_data = f.read()
        pubkey = RSA.import_key(key_data)
    return sign, pubkey


def parse_arguments():
    ap = argparse.ArgumentParser()
    ap.add_argument("-f", "--file", required=True, help="Путь к файлу")
    ap.add_argument("-s", "--sign", required=True, help="Путь к подписи")
    ap.add_argument("-k", "--key", required=True, help="Путь к публичному ключу")
    args = vars(ap.parse_args())
    return args


if __name__ == '__main__':
    arguments = parse_arguments()
    s, p = read_files(arguments['sign'], arguments['key'])
    verify_signature(arguments['file'], s, p)


def verify_signature_temp():

    with open("Подпись.txt", 'rb') as f:
        sign = f.read()
    f.close()

    with open("Ключ.pem", 'rb') as f:
        key_data = f.read()
        pubkey = RSA.import_key(key_data)

    # Получаете хэш файла
    file_hash = SHA256.new()
    with open("Отчет.docx", "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            file_hash.update(chunk)
    # Отличающийся хэш не должен проходить проверку
    try:
        pkcs1_15.new(pubkey).verify(file_hash, sign)
        return "Проверка пройдена успешно"
    except ValueError:
        return "Файл не прошел проверку"
