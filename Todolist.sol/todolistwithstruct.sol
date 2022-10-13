// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract ToDoListWithStruct{
    struct Todo{
        string desc;
        bool status;
    }

    Todo[] public todo;

    function create(string calldata _desc) external {
        todo.push(Todo({desc: _desc, status: false}));
    }

    function updateText(uint _index, string calldata _text) external {
        todo[_index].desc = _text;
    }
    
    function toggleCompleted(uint _index) public {
        Todo storage todos = todo[_index];
        todos.status = !todos.status;
    }


}