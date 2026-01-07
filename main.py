from crypto.wallet import create_and_store_test_wallet, get_wallet_balance, recreate_wallet_from_seed_file


if __name__ == "__main__":
    # print("Creating Alice wallet...")
    # alice_wallet = create_and_store_test_wallet("Alice", password="Alice")
    # print("Done!\n")
    
    # Example: Recreate Alice's wallet
    print("Recreating Alice's wallet from saved seed...")
    alice_recreated = recreate_wallet_from_seed_file("Alice", password="Alice")
    print(get_wallet_balance(alice_recreated.classic_address))
    print(f"Recreated Alice Address: {alice_recreated.classic_address}")