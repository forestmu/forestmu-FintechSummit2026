


import os
import base64
from cryptography.fernet import Fernet
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import padding

from xrpl.wallet import Wallet

from crypto.constants import SEED_FOLDER

# 1. Encrypt/Decrypt for accessing wallet seed stored locally
def _get_key(password: str, salt: bytes) -> bytes:
    """Helper to derive a cryptographic key from a password and salt."""
    kdf = PBKDF2HMAC(
        algorithm=hashes.SHA256(),
        length=32,
        salt=salt,
        iterations=480000,
    )
    return base64.urlsafe_b64encode(kdf.derive(password.encode()))

def save_seed_to_file(name: str, seed: str, password: str):
    salt = os.urandom(16) 
    
    key = _get_key(password, salt)
    f = Fernet(key)
    encrypted_data = f.encrypt(seed.encode())
    
    with open(SEED_FOLDER / f"{name}.txt", "wb") as file:
        file.write(salt + encrypted_data)

    print(f"Seed successfully encrypted and saved to", str(SEED_FOLDER / f"{name}.txt"))


def retrieve_seed(name: str, password: str) -> str:
    if not os.path.exists(SEED_FOLDER / f"{name}.txt"):
        raise FileNotFoundError("No seed file found.")

    with open(SEED_FOLDER / f"{name}.txt", "rb") as file:
        file_content = file.read()
        
    salt = file_content[:16]
    encrypted_data = file_content[16:]
    
    key = _get_key(password, salt)
    f = Fernet(key)
    
    try:
        decrypted_seed = f.decrypt(encrypted_data)
        return decrypted_seed.decode()
    except Exception:
        return "Error: Wrong password or corrupted file."



# 2. Encrypt/Decrypt with keys for fulfilment fields in DateDB
def decrypt_with_seed(seed, encrypted_secret):
    w = Wallet.from_seed(seed)

    private_key = serialization.load_pem_private_key(
        w.private_key,
        password=None  
    )

    try:
        decrypted_secret = private_key.decrypt(
            encrypted_secret,
            padding.OAEP(
                mgf=padding.MGF1(algorithm=hashes.SHA256()),
                algorithm=hashes.SHA256(),
                label=None
            )
        )
        print(f"The secret is: {decrypted_secret.decode('utf-8')}")
    except Exception as e:
        print("Failed to decrypt. Likely the wrong private key or corrupted data.")


def encrypt_with_pubkey(pubkey_bytes: bytes, secret):
    public_key = serialization.load_pem_public_key(pubkey_bytes)

    encrypted_blob = public_key.encrypt(
        secret,
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )

    return encrypted_blob

