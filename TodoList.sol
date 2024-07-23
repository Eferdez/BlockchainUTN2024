// SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

contract TodoList {

    //tasks (texto, ToDo,Doing,Done)
    // Es buena practica usar enum para referencias estados
    // Por fuera los enum 
    enum TaskStatus {
        ToDo,
        Doing,
        Done
    }

    struct Task {
        string text;
        TaskStatus status;
    }

// array de Tasks sea solo para la account que crea la tarea
// mapping(address => uint) balances;
 mapping(address => Task[]) tasks;
    //0x1...Task[]
    //0x2...Task[]
   

    function create(string memory text) public {
        tasks[msg.sender].push(Task(text, TaskStatus.ToDo));
        //tasks.push(Task(text,TaskStatus.ToDo));
    }
    
    function taskComplete(uint index) public {
        tasks[msg.sender][index].status = TaskStatus.Done;
        //tasks[index].status = TaskStatus.Done;
    }

    function taskInProgress(uint index) public {
        tasks[msg.sender][index].status = TaskStatus.Doing;
        //tasks[index].status = TaskStatus.Doing;
    }

    function taskToDo(uint index) public {
        tasks[msg.sender][index].status = TaskStatus.ToDo;
        //tasks[index].status = TaskStatus.ToDo;
    }



 }
