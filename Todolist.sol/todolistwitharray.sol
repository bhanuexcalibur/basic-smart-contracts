// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ToDoList{
    //add a todo function
    mapping(address => string[]) todos;

    function addTodo(string memory task) public {
        todos[msg.sender].push(task);
        //arr.push(task);
    } 

    
    //get todo list
    function getTodo() public view returns(string[] memory) {
        return todos[msg.sender];
    }

    //get todos length function
    function TodoLength() public view returns (uint){
        return todos[msg.sender].length;
    }

    //delete todo function
    function deleteTask(uint _index) public {
        require(_index < todos[msg.sender].length);
        todos[msg.sender][_index] = todos[msg.sender][TodoLength()-1];
        todos[msg.sender].pop();

    }
}