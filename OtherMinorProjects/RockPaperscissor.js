
let score = JSON.parse(localStorage.getItem('score')) || {
    wins:0,
    loses:0,
    ties:0
};
document.querySelector('.rock1').addEventListener('click',() => {
    playGame('rock');
});
function resetScore(){
    score.wins = 0;
    score.loses = 0;
    score.ties = 0;
    alert(`Score Resetted`);
    localStorage.removeItem('score');
    updatescore();
}
document.body.addEventListener('keydown',(event) =>{
    if(event.key === 'r'){
        playGame('rock');
    }else if(event.key === 'p'){
        playGame('paper');
    }else if(event.key === 's'){
        playGame('scissors');
    }else if(event.key === 'x'){
        resetScore();
    }
});
function playGame(playerMove)
{
    const computerMove = pickComputerMove();

    let result = '';

    if (playerMove === 'scissors') {
        if (computerMove === 'rock') {
            result = 'You lose.';
        } else if (computerMove === 'paper') {
            result = 'You win.';
        } else if (computerMove === 'scissors') {
            result = 'Tie.';
    }

    } else if (playerMove === 'paper') 
    {
        
        if (computerMove === 'rock') {
            result = 'You win.';
        } else if (computerMove === 'paper') {
            result = 'Tie.';
        } else if (computerMove === 'scissors') {
            result = 'You lose.';
        }
    
    } else if (playerMove === 'rock') {
        if (computerMove === 'rock') {
            result = 'Tie.';
        } else if (computerMove === 'paper') {
            result = 'You lose.';
        } else if (computerMove === 'scissors') {
            result = 'You win.';
        }
    }
    if(result === 'You win.'){
        score.wins+=1;
    }
    else if(result === 'You lose.'){
        score.loses+=1;
    }
    else if(result === 'Tie.'){
        score.ties+=1;
    }

    localStorage.setItem('score',JSON.stringify(score));

    updatescore();

    document.querySelector('.js-result').innerHTML = result;

    document.querySelector('.js-moves').innerHTML = `You  <img src="${playerMove}-emoji.png" class="rock2">   <img src="${computerMove}-emoji.png" class = "rock2">  Computer`;

     
}

function updatescore(){
    document.querySelector('.js-score').innerHTML = `Wins: ${score.wins}, Loses: ${score.loses}, Ties: ${score.ties}`
}

function pickComputerMove() {
    const randomNumber = Math.random();

    let computerMove = '';

    if (randomNumber >= 0 && randomNumber < 1 / 3) {
    computerMove = 'rock';
    } else if (randomNumber >= 1 / 3 && randomNumber < 2 / 3) {
    computerMove = 'paper';
    } else if (randomNumber >= 2 / 3 && randomNumber < 1) {
    computerMove = 'scissors';
    }

    return computerMove;
}
let isAutoplaying = false;
let intervalId;

function autoplay(){
    if (!isAutoplaying){
    intervalId = setInterval(function(){
        const playerMove = pickComputerMove();
        playGame(playerMove);
    }, 1000);
    isAutoplaying = true;

    }else{
        clearInterval(intervalId);
        isAutoplaying = false;
    }
}