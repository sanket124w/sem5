""" 
Implements the Minimax algorithm with Alpha-Beta pruning. 
Args: 
node: The current node in the game tree. 
depth: The current depth of the search. 
alpha: The best (highest) value that the maximizing player can guarantee so far. 
beta: The best (lowest) value that the minimizing player can guarantee so far. 
maximizing_player: A boolean indicating if it's the maximizing player's turn. 
Returns: 
The optimal value for the current node. 
"""
import math

def minimax_alpha_beta(node, depth, alpha, beta, maximizing_player):
    if depth == 0 or not node.children:
        return node.value if node.value is not None else 0

    if maximizing_player:
        max_eval = -math.inf
        for child in node.children:
            eval = minimax_alpha_beta(child, depth - 1, alpha, beta, False)
            max_eval = max(max_eval, eval)
            alpha = max(alpha, eval)
            if beta <= alpha:
                break
        return max_eval
    else:
        min_eval = math.inf
        for child in node.children:
            eval = minimax_alpha_beta(child, depth - 1, alpha, beta, True)
            min_eval = min(min_eval, eval)
            beta = min(beta, eval)
            if beta <= alpha:
                break
        return min_eval

class Node:
    def __init__(self, value=None, children=None):
        self.value = value
        self.children = children if children is not None else []

# Terminal nodes
node_g = Node(value=3)
node_h = Node(value=12)
node_i = Node(value=8)
node_j = Node(value=2)
node_k = Node(value=4)
node_l = Node(value=6)

# Intermediate nodes with default value
node_d = Node(value=0, children=[node_g, node_h])
node_e = Node(value=0, children=[node_i, node_j])
node_f = Node(value=0, children=[node_k, node_l])

# Root node
root = Node(value=0, children=[node_d, node_e, node_f])

# Run minimax
optimal_value = minimax_alpha_beta(root, 2, -math.inf, math.inf, True)
print(f"The optimal value is: {optimal_value}")

