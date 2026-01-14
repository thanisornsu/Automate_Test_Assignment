# 1. Check duplicate items from list A and list B and append to a new list. Using your 
# preferred programming language. 
# List A : [1,2,3,5,6,8,9] 
# List B : [3,2,1,5,6,0] 

# lists
list_a = [1, 2, 3, 5, 6, 8, 9]
list_b = [3, 2, 1, 5, 6, 0]


# Simple loop approach Easy to understand and debug for team members
duplicates_loop = []
for item in list_a:
    if item in list_b and item not in duplicates_loop:
        duplicates_loop.append(item)
print(f"Method 3 (Loop): {duplicates_loop}")


