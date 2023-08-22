import { FormControl, ValidationErrors } from "@angular/forms";

export class SiteValidators {

    //whitespace
    static notOnlyWhitespace(control : FormControl) : ValidationErrors {

        if((control.value != null) && (control.value.trim().lenght===0)){
            return {'notOnlyWhitespace':true};
        }else{
            return null;
        }


        
        
    }
}
