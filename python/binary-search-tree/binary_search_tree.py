class TreeNode:
    def __init__(self, data, left=None, right=None):
        self.data = data
        self.left = left
        self.right = right

    def __str__(self):
        return f'TreeNode(data={self.data}, left={self.left}, right={self.right})'

    def insert(self, d):
        if d <= self.data:
            if self.left:
                self.left.insert(d)
            else:
                self.left = TreeNode(d)
        else:
            if self.right:
                self.right.insert(d)
            else:
                self.right = TreeNode(d)


class BinarySearchTree:
    def __init__(self, tree_data):
        self.tree_data = tree_data

    def data(self):
        tree = TreeNode(self.tree_data[0])
        for d in self.tree_data[1:]:
            tree.insert(d)
        return tree

    def sorted_data(self):
        return sorted(self.tree_data)
