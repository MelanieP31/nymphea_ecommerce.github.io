import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Country } from 'src/app/common/country';
import { State } from 'src/app/common/state';
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

  //remplir les Pays et les regions
  countries : Country[] = [];

  shippingAdressStates : State[] = [];
  billingAdressStates : State[] = [];


  

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

    //les pays
    this.creditcardService.getCountries().subscribe(
      data => {
        console.log("Retrieved countries :" + JSON.stringify(data));
        this.countries = data;
      }
    )

  }

  //Recupérer les régions en fonctions du pays selectionner
  getStates(formGroupName : string){
    const formGroup = this.checkoutFormGroup.get(formGroupName)!;
    const countryCode = formGroup.value.country.code;
    const countryName = formGroup.value.country.name;

    console.log(`${formGroupName} country code: ${countryCode}`);
    console.log(`${formGroupName} country name: ${countryName}`);

    this.creditcardService.getStates(countryCode).subscribe(
      data =>{
        if(formGroupName ==='shippingAddress'){
            this.shippingAdressStates =data;
        }else{
          this.billingAdressStates = data;
        }

        //select forst items by default
        formGroup.get('state')!.setValue(data[0]);
      }
    )

  }
  
  copyShippingAddressToBillingAddress(event:any) {

    if (event.target.checked) {
      this.checkoutFormGroup.controls['billingAddress']
            .setValue(this.checkoutFormGroup.controls['shippingAddress'].value);

      //bug code selection regions ne se copie pas
      this.billingAdressStates = this.shippingAdressStates;
    }
    else {
      this.checkoutFormGroup.controls['billingAddress'].reset();

      //clear out, reset
      this.billingAdressStates = [];
    }
    
  }


  onSubmit(){
    console.log("submit button");
    console.log(this.checkoutFormGroup.get('customer')!.value);
    console.log("shipping adress country :" +this.checkoutFormGroup.get('shippingAdress')!.value.country.name);
    console.log("shipping adress state :" +this.checkoutFormGroup.get('shippingAdress')!.value.state.name);
  }

  handleMonthsAndYears(){
    const creditCardFormGroup = this.checkoutFormGroup.get('creditCard');

    const currentYear : number = new Date().getFullYear();
    const selectedYear : number = Number(creditCardFormGroup?.value.expirationYear);

    let startMonth:number;

    if(currentYear == selectedYear){
      startMonth = new Date().getMonth() + 1;
    }else{
      startMonth =1;
    }

    this.creditcardService.getCreditCardMonths(startMonth).subscribe(
      data => {
        console.log("Retrieved credit card months : " + JSON.stringify(data));
        this.creditCardMonths = data;
      }
    )
  }

}
