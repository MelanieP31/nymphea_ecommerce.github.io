import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { CreditcardService } from 'src/app/services/creditcard.service';

@Component({
  selector: 'app-checkout',
  templateUrl: './checkout.component.html',
  styleUrls: ['./checkout.component.css']
})
export class CheckoutComponent implements OnInit {

  checkoutFormGroup !: FormGroup;

  //order details
  totalPrice : number = 0;
  totalQuantity : number = 0;

  //Remplir mois et années
  creditCardYears : number[] = [];
  creditCardMonths : number[] = [];
  

  constructor(private formBuilder : FormBuilder, private creditcardService : CreditcardService) { }

  ngOnInit(): void {
    this.checkoutFormGroup = this.formBuilder.group({
      customer:this.formBuilder.group({
        firstName : [''],
        lastName: [''],
        email:['']
      }),

      shippingAddress:this.formBuilder.group({
        country:[''],
        street:[''],
        city:[''],
        state:[''],
        zipCode:['']
      }),

      billingAddress:this.formBuilder.group({
        country:[''],
        street:[''],
        city:[''],
        state:[''],
        zipCode:['']
      }),

      creditCard:this.formBuilder.group({
        cardType:[''],
        nameOnCard:[''],
        cardNumber:[''],
        securityCode:[''],
        expirationMonth:[''],
        expirationYear:['']
      })
    });

    //remplir les mois
    const startMonth : number = new Date().getMonth() + 1;
    console.log("start Month =" + startMonth);

    this.creditcardService.getCreditCardMonths(startMonth).subscribe(
      data => {
        console.log("Retrieved credit card months :" + JSON.stringify(data));
        this.creditCardMonths = data;
      }
    )

    //les années
    this.creditcardService.getCreditCardYears().subscribe(
      data => {
        console.log("Retrieved credit card years :" + JSON.stringify(data));
        this.creditCardYears = data;
      }
    )



  }
  
  copyShippingAddressToBillingAddress(event:any) {

    if (event.target.checked) {
      this.checkoutFormGroup.controls['billingAddress']
            .setValue(this.checkoutFormGroup.controls['shippingAddress'].value);
    }
    else {
      this.checkoutFormGroup.controls['billingAddress'].reset();
    }
    
  }


  onSubmit(){
    console.log("submit button");
    console.log(this.checkoutFormGroup.get('customer')!.value);
  }

}
