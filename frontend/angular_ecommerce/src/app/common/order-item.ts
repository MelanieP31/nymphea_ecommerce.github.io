import { CartItem } from "./cart-item";

export class OrderItem {
    imageUrl:string;
    unitPrice:number;
    quantity:number;
    productId:string;

//constructor pour populate le order-item based on CartItem (il faut juste les assigner)
    constructor(cartItem: CartItem){
        this.imageUrl=cartItem.imageUrl;
        this.quantity=cartItem.quantity;
        this.unitPrice=cartItem.unitPrice;
        this.productId=cartItem.id;
    }
}
