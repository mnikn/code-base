class Entry:
    def __init__(self,key,value):
        self.key = key
        self.value = value

class AvlTree:
    def __init__(self):
        self.__tree = []
    def __get__(self,tree,key):
        if tree == []:
            return None
        if key < tree[0].key:
            return self.__get__(tree[1],key)
        if key > tree[0].key:
            return self.__get__(tree[2],key)
        if key == tree[0].key:
            return tree[0].value
    def __put__(self,tree,entry):
        if tree == []:
            return [entry,[],[]]
        if entry.key < tree[0].key:
            tree[1] = self.__put__(tree[1],entry)
            return tree
        if entry.key > tree[0].key:
            tree[2] = self.__put__(tree[2],entry)
            return tree
        if entry.key == tree[0].key:
            tree[0] = entry
            return tree
    def get(self,key):
        return self.__get__(self.__tree,key)
    def put(self,entry):
        self.__tree = self.__put__(self.__tree,entry)

class Table:
    def __init__(self):
        self.__table = AvlTree()
    def get(self,key):
        return self.__table.get(key)
    def put(self,entry):
        self.__table.put(entry)


    
