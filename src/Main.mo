// Main.mo
import Utils "Utils";
import Types "Types";

actor {
    stable var todoList: [Types.TodoItem] = [];
    stable var nextId: Nat = 0;

    public query func getItems() : async [Types.TodoItem] {
        return todoList;
    };

    public func addItem(description: Text) : async Types.TodoItem {
        let newItem = Utils.addItem(nextId, description);
        todoList := Array.append(todoList, [newItem]);
        nextId += 1;
        return newItem;
    };

    public func completeItem(id: Nat) : async ?Types.TodoItem {
        let updatedList = todoList.map(item -> 
            if (item.id == id) {
                Utils.completeItem(item);
            } else {
                item;
            }
        );
        todoList := updatedList;
        return todoList.find(item -> item.id == id);
    };

    public func removeItem(id: Nat) : async [Types.TodoItem] {
        todoList := Utils.removeItem(todoList, id);
        return todoList;
    };
};
