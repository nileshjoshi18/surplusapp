let cartNumber = 0;
function cartAddition(){
    cartNumber ++;
    console.log(cartNumber);
    document.querySelector('.cartNumber1').innerHTML = cartNumber;
    return cartNumber;
}
