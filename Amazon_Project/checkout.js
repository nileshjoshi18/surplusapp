import { products } from './product.js';
import{ cart,removeFromcart,addtoCart } from './cart.js';
import dayjs from 'https://unpkg.com/dayjs@1.11.10/esm/index.js'; 
import {deliveryOptions} from './delivery.js';
let cartHTML = '';
cart.forEach((cartProduct) => {
    const productId = cartProduct.productId;
    let matchingItem;
    products.forEach((product) =>{

    if (product.id === productId){
            matchingItem = product;
    }    
      });
    const deliveryOptionId = cartProduct.deliveryOptionId;
    let deliveryOption;
    deliveryOptions.forEach((option)=>{
      if(deliveryOptionId === option.id){
        deliveryOption = option;
      }
    });
    const today = dayjs();
    const deliveryDate = today.add(deliveryOption.deliveryDays, 'days');
    const dateString = deliveryDate.format('dddd, MMMM D');
    cartHTML += `<div class="checkout-grid">
        <div class="order-summary ">
          <div class="cart-item-container js-cart-item-container-${matchingItem.id}">
            <div class="delivery-date">
              Delivery Date : ${dateString}
            </div>

            <div class="cart-item-details-grid">
              <img class="product-image"
                src="${matchingItem.image}"> 
              <div class="cart-item-details">
                <div class="product-name">
                ${matchingItem.name}
                </div>
                <div class="product-price">
                   ₹${matchingItem.priceCents}
                </div>
                <div class="product-quantity">
                  <span>
                    Quantity: <span class="quantity-label">${cartProduct.quantity}</span>
                  </span>
                  <span class="update-quantity-link link-primary">
                    Update
                  </span>
                  <span class="delete-quantity-link link-primary js-delete-link" data-product-id="${matchingItem.id}">
                    Delete
                  </span>
                <div class="delivery-options">
                <div class="delivery-options-title">
                  Choose a delivery option:
                </div>
                <div>
                ${deliveryOptionsHTML(matchingItem)}
                </div>
              </div>
            </div>
        </div>
    </div>`;    
    });
  function deliveryOptionsHTML(matchingItem){
    let html = '';
    deliveryOptions.forEach((delivery) => {
      console.log(matchingItem);
      const today = dayjs();
      const deliveryDate = today.add(delivery.deliveryDays, 'days');
      const dateString = deliveryDate.format('dddd, MMMM D');
      const priceString = delivery.priceCents === 0
      ? 'Free'
      : `₹${delivery.priceCents} -`;
      html += `<div class="delivery-option">
                  <input type="radio" checked
                    class="delivery-option-input"
                    name="delivery-option-${matchingItem.id}">
                  <div>
                    <div class="delivery-option-date">
                      ${dateString}
                    </div>
                    <div class="delivery-option-price">
                      ${priceString} Delivery
                    </div>
                  </div>
               </div>`;
    });
    return html;  
  };
document.querySelector('.js-order-summary').innerHTML = cartHTML;
document.querySelectorAll('.js-delete-link').forEach((link) => {
  link.addEventListener('click', () => {
    let productId = link.dataset.productId;
    removeFromcart(productId);
    const container = document.querySelector(`.js-cart-item-container-${productId}`);
    container.remove();
  })
});