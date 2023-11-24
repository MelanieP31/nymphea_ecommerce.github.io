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
        public typePeau : string,
        public ingredients : string,
        public poids : number,
        public active : boolean, 
        public unitsInStock : number,
        public dateCreated : Date,
        public lastUpdated : Date
    ) {}
}
