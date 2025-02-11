export class Product {
    constructor(
        public id : string, 
        public sku : string,
        public name: string,
        public subname :string,
        public introduction : string,
        public description : string,
        public unitPrice : number,
        public imageUrl : string, 
        public ingredients : string,
        public active : boolean, 
        public unitsInStock : number,
        public dateCreated : Date,
        public lastUpdated : Date
    ) {}
}
