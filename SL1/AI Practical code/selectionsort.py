def selection_sort(arr):
    n = len(arr)
    for i in range(n):
        # Assume the minimum element is the first element of the unsorted part
        min_index = i
        
        # Greedy choice: find the smallest element in the remaining unsorted array
        for j in range(i + 1, n):
            if arr[j] < arr[min_index]:
                min_index = j
        
        # Swap the found minimum element with the first element of the unsorted part
        arr[i], arr[min_index] = arr[min_index], arr[i]
        
        # Print current status of array after each pass (for understanding)
        print(f"Step {i+1}: {arr}")
    
    return arr


# Example usage
arr = [64, 25, 12, 22, 11]
print("Original Array:", arr)
sorted_arr = selection_sort(arr)
print("Sorted Array:", sorted_arr)
