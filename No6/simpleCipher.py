# Solution with detailed step-by-step explanation
def simpleCipher_explained(encrypted, k):
    decrypted = ""
    alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    
    print(f"Decrypting '{encrypted}' with k={k}")
    print("=" * 50)
    
    for char in encrypted:
        # Find index in alphabet (0-25)
        index = alphabet.index(char)
        print(f"\nCharacter '{char}' is at index {index}")
        
        # Move counterclockwise by k positions
        new_index = (index - k) % 26
        print(f"After shifting by -{k}: new index is {new_index}")
        
        # Get character at new position
        new_char = alphabet[new_index]
        print(f"New character: '{new_char}'")
        
        decrypted += new_char
    
    print("\n" + "=" * 50)
    print(f"Final decrypted string: {decrypted}")
    return decrypted

# simpleCipher_explained("KHOOR", 3)
simpleCipher_explained("VTAOG", 2)