let toList = []; 
function todolist(){
    let todolistHTML = '';
    for(let i = 0; i<toList.length; i++)
        {
            let todoObject = toList[i];
            let name3 = todoObject.name;
            let dueDate = todoObject.dueDate;
            let html = `<div>
                <div class="task1">${name3}</div> 
                <div class="task2">${dueDate}</div>
                <button onclick = "
                    toList.splice(${i},1);
                    todolist();
                " class="delButton">Delete</button>
                </div>
            `;
            todolistHTML += html;
            document.querySelector('.showTask').innerHTML = todolistHTML;
        }
    }
function addtoList(){
    let inputElelment = document.querySelector('.Task');
    let inputElelment1 = document.querySelector('.dateRecord');
    let name = inputElelment.value;
    let dueDate = inputElelment1.value;
    let information = {name, dueDate};
    toList.push(information);
    inputElelment.value = '';
    inputElelment1.value = '';
    todolist();
}
