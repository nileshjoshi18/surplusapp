export let cart = [{id: "e43638ce-6aa0-4b85-b27f-e1d07eb678c6",
    image: "products/athletic-cotton-socks-6-pairs.jpg",
    name: "Black and Gray Athletic Cotton Socks - 6 Pairs",
    rating: {
      stars: 4.5,
      count: 87
    },
    priceCents: 1090,
    keywords: [
      "socks",
      "sports",
      "apparel"],
    quantity: 3},
    {
      id: "83d4ca15-0f35-48f5-b7a3-1ea210004f2e",
      image: "products/adults-plain-cotton-tshirt-2-pack-teal.jpg",
      name: "Adults Plain Cotton T-Shirt - 2 Pack",
      rating: {
        stars: 4.5,
        count: 56
      },
      priceCents: 799,
      keywords: [
        "tshirts",
        "apparel",
        "mens"
      ],
      type: "clothing",
      sizeChartLink: "clothing-size-chart.png",
      quantity : 5
    }];
export function  addtoCart(productId){
    let matchingItem;
    cart.forEach((item) => {
        if(productId === item.productId){
            matchingItem = item;
        }
    });
    if (matchingItem){
        matchingItem.quantity += 1;
    }else{
        cart.push({productId: productId,
                  quantity: 1
        });
    }

}
export function removeFromcart(productId){
    const newCart = [];
    cart.forEach((cartItem) => {
        if (cartItem.id !== productId){
          newCart.push(cartItem);
        }
    })
    cart = newCart;
}