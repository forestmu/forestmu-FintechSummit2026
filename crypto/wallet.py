
from xrpl.wallet import generate_faucet_wallet, Wallet
from xrpl.models.requests import AccountInfo

from crypto.constants import CLIENT
from crypto.encryption import save_seed_to_file, retrieve_seed


# Initialize XRPL testnet CLIENT

# Folder to store seeds


def create_and_store_test_wallet(name: str, password: str) -> Wallet:
    wallet = generate_faucet_wallet(CLIENT)
    save_seed_to_file(name, wallet.seed, password)
    
    print(f"\n=== {name} Wallet ===")
    print(f"Classic Address: {wallet.classic_address}")
    print(f"Public Key: {wallet.public_key}")
    print(f"Private Key: {wallet.private_key}")
    print(f"Seed: {wallet.seed}")
    print(f"Password: {password}")
    print("====================\n")
    
    return wallet

def recreate_wallet_from_seed_file(name: str, password: str) -> Wallet:
    seed = retrieve_seed(name, password)
    return Wallet.from_seed(seed)


def get_wallet_balance(address: str) -> float:
    """
    Retrieves the XRP balance of an account.
    Returns balance in XRP (float), not drops.
    """
    acct_info = AccountInfo(
        account=address,
        ledger_index="validated",
        strict=True
    )
    response = CLIENT.request(acct_info)
    drops = response.result["account_data"]["Balance"]  # in drops (1 XRP = 1,000,000 drops)
    return int(drops) / 1_000_000



if __name__ == "__main__":
    print("Creating Alice and Bob wallets...")
    alice_wallet = create_and_store_test_wallet("Alice", "Alice")
    # bob_wallet = create_and_store_test_wallet("Bob")
    print("Done!\n")
    
    # Example: Recreate Alice's wallet
    print("Recreating Alice's wallet from saved seed...")
    alice_recreated = recreate_wallet_from_seed_file("Alice")
    print(f"Recreated Alice Address: {alice_recreated.classic_address}")
