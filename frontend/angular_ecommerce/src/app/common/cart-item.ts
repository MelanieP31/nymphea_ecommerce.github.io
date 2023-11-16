import { Product } from "./product";

export class CartItem {

    id: number;
    name : string;
    subname:string;
    imageUrl : string;
    unitPrice : number;

    quantity : number;

    constructor(product : Product){ 
        this.id = product.id;
        this.name = product.name;
        this.imageUrl = product.imageUrl;
        this.unitPrice = product.unitPrice;
        this.subname = product.subname;

        this.quantity = 1;
    }
}
